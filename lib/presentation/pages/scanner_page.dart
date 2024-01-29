import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/data/firebase_storage_services/firebase_storage_services.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/pokemon_card_info_page.dart';
import 'package:provider/provider.dart';

class Scanner extends StatefulWidget {

  final Function changeBodyWidget;
  const Scanner({ super.key, required this.changeBodyWidget });

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed && _cameraController != null && _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemonList = pokemonProvider.pokemonList;

    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Container(
          color: Colors.black,
          child: Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);
                      return Center(
                          child: CameraPreview(
                              _cameraController!,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () { _scanImage(pokemonList) ;},
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 55),
                                          foregroundColor: Colors.grey[300],
                                          backgroundColor: Colors.grey[850],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: const Text(
                                            'Scan Text',
                                            style: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          )
                      );
                    } else {
                      return const LinearProgressIndicator();
                    }
                  },
                ),

              if(!_isPermissionGranted)
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: const Text(
                      'Camera permission denied.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) { return; }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage(List<Pokemon> pokemonList) async {
    final storageServices = FirebaseStorageServices();
    final authServices = AuthServices();
    final cloudServices = FirebaseCloudServices();


    if (_cameraController == null) { return; }

    try {
      final pictureFile = await _cameraController!.takePicture();
      final imageFile = File(pictureFile.path);
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await textRecognizer.processImage(inputImage);

      // TODO: Create new card and show it inside the card_collection_info.dart

      var _recognizedPokemon;
      for (int i = 0; i < pokemonList.length; i ++) {
        if(recognizedText.text.contains(pokemonList[i].name)) {
          _recognizedPokemon = pokemonList[i];
          break;
        }
      }

      if(_recognizedPokemon == null) {
        throw PokemonNotFoundException("Pokemon not found");
      }

      // TODO: try to get more information about the card

      // final tfLiteMethods = TFLiteMethods();
      // tfLiteMethods.loadTFLiteModel();
      // tfLiteMethods.runTFLiteOnImage(imageFile);

      final user = Provider.of<UserAuthInfo?>(context, listen: false);
      final username = await authServices.getUsernameUsingEmail(user!.email);
      final imageName = _recognizedPokemon.name;
      final imageUrl = await storageServices.uploadImageToUserFolder(username!, imageFile, imageName);
      final cardsProvider = Provider.of<PokemonCardsProvider?>(context, listen: false);
      if(cardsProvider == null) { throw Exception("No cards provider found."); }

      final newPokemonCard = PokemonCard(
        id: getNextId(cardsProvider.pokemonCardsList.isEmpty ? "#000" : cardsProvider.pokemonCardsList.last.id),
        pokemonName: _recognizedPokemon.name,
        numInBatch: getRandomBatchNumber(),
        imageUrl: imageUrl,
        stillOwned: true,
      );

      cardsProvider.addPokemonCard(newPokemonCard);

      await cloudServices.addPokemonCardToFirestore(username, newPokemonCard);

      widget.changeBodyWidget(PokemonCardInfoPage(pokemonCard: newPokemonCard, changeBodyWidget: widget.changeBodyWidget,));

    } on PokemonNotFoundException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Something went wrong, retry...")),
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  String getRandomBatchNumber() {
    final random = Random();
    final num = random.nextInt(128);
    return "${random.nextInt(num)}/$num";
  }

  getNextId(String? id) {
    if(id == null) { return "#999"; }
    int originalNumber = int.parse(id.substring(1));
    int incrementedNumber = originalNumber + 1;
    return "#${incrementedNumber.toString().padLeft(3, '0')}";
  }
}

class PokemonNotFoundException implements Exception {
  String text;
  PokemonNotFoundException(this.text);
}
