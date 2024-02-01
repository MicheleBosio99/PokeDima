import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageServices {

  final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: "gs://pokedexdima-new.appspot.com");
  final String _userCollectionsFolder = 'cards_collection';
  final String _userProfilePicturesFolder = 'profile_picture';


  // HANDLE USER CARDS COLLECTIONS

  Future<String> uploadImageToUserFolder(String username, File imageFile, String imageName) async {
    try {
      final Reference storageRef = _storage.ref().child('$username/$_userCollectionsFolder/$imageName');
      final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
      print(uploadTask.ref.getDownloadURL());
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return "";
    }
  }

  Future<List<String>> getImageUrlsForUser(String username) async {
    try {
      final Reference storageRef = _storage.ref().child('$_userCollectionsFolder/$username');
      final ListResult result = await storageRef.list();
      final List<String> imageUrls = result.items.map((item) => item.fullPath).toList();
      return imageUrls;
    } catch (e) {
      print('Error getting image URLs: $e');
      return [];
    }
  }



  // HANDLE PROFILE PICTURES

  Future<bool> uploadProfilePicture(String username, File imageFile) async {
    try {
      final Reference storageRef = _storage.ref().child('$username/$_userProfilePicturesFolder/profile_pic.png');
      await storageRef.putFile(imageFile);
      return true;
    } catch (e) {
      print('Error uploading profile picture: $e');
      return false;
    }
  }

  Future<void> changeProfilePicture(String username, File newImageFile) async {
    try {
      await removeProfilePicture(username);
      await uploadProfilePicture(username, newImageFile);
    } catch (e) {
      print('Error changing profile picture: $e');
    }
  }

  Future<bool> doesProfilePictureExist(String username) async {
    try {
      final Reference storageRef = _storage.ref().child('$username/$_userProfilePicturesFolder/profile_pic.png');
      final FullMetadata metadata = await storageRef.getMetadata();
      return true;
    } catch (e) {
      print('Error checking if profile picture exists: $e');
      return false;
    }
  }

  Future<String?> getProfilePictureUrl(String username) async {
    try {
      final Reference storageRef = _storage.ref().child('$username/$_userProfilePicturesFolder/profile_pic.png');
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Profile image not found: $e');
      return null;
    }
  }

  Future<void> removeProfilePicture(String username) async {
    try {
      final Reference storageRef = _storage.ref().child('$username/$_userProfilePicturesFolder/profile_pic.png');
      await storageRef.delete();
    } catch (e) {
      print('Error removing profile picture: $e');
    }
  }

  Future<void> renameStorageFolder(String oldFolderName, String newFolderName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      ListResult listResult = await storage.ref(oldFolderName).listAll();

      await Future.forEach(listResult.items, (Reference item) async {
        String newItemPath = item.fullPath.replaceFirst(oldFolderName, newFolderName);
        await storage.ref(newItemPath).putData((await item.getData())!);
      });
      await storage.ref(oldFolderName).delete();
      return;

    } catch (e) {
      print('Error renaming folder: $e');
    }
  }
}