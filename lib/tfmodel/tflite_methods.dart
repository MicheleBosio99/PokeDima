// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';
//
//
// class TFLiteMethods {
//
//   Future<String?> loadTFLiteModel() async {
//     return await Tflite.loadModel(
//       model: 'assets/tflite/model.tflite',
//       labels: 'assets/tflite/labels.txt',
//     );
//   }
//
//   Future<Object?> runTFLiteOnImage(File file) async {
//     try {
//       var result = await Tflite.runModelOnImage(
//         path: file.path,
//         numResults: 1,
//         threshold: 0.5,
//         imageMean: 127.5,
//         imageStd: 127.5,
//       );
//       return Image.file(File(result as String));
//
//     } catch (e) {
//       print('Error running TFLite on Image: $e');
//       return null;
//     }
//   }
// }