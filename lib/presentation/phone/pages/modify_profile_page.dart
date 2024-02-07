import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/data/firebase_storage_services/firebase_storage_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/user_profile_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/modify_info_text_field.dart';


class ModifyProfile extends StatefulWidget {

  final User user;
  final Function changeBodyWidget;
  const ModifyProfile({ required this.user, required this.changeBodyWidget });

  @override
  State<ModifyProfile> createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  final GlobalKey<FormState> _modifiesKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _realNameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15,),

                IconButton(
                  onPressed: () { widget.changeBodyWidget(UserProfile(changeBodyWidget: widget.changeBodyWidget), index: 3); },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    size: 32,
                    color: Colors.grey[800],
                  ),
                ),
                
                const SizedBox(width: 20,),
                
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Modify your profile:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Divider(
              color: Colors.grey[800],
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey[800]!,
                        width: 3,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () { _pickImage(); },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: _selectedImage != null ? Image.file(_selectedImage!).image : NetworkImage(widget.user.profilePictureUrl),
                        radius: 60,
                      ),
                    ),
                  ),

                  const SizedBox(width: 30,),

                  Text(
                    "Change your\nprofile picture.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Form(
              key: _modifiesKey,
              child: Column(
                children: [
                  // ModifyProfileFormField(
                  //   controller: _usernameController,
                  //   hintText: "Username: ${widget.user.username}",
                  // ),

                  ModifyProfileFormField(
                    controller: _realNameController,
                    hintText: "Real Name: ${widget.user.realName}",
                    obscureText: true,
                  ),

                  ModifyProfileFormField(
                    controller: _biographyController,
                    hintText: "Bio: ${widget.user.bio}",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              child: TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Center(
                        child: Text(
                          "User info successfully updated",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                  await _applyChanges(widget.user);
                  widget.changeBodyWidget(UserProfile(changeBodyWidget: widget.changeBodyWidget), index: 3);
                  },
                child: Container(
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Apply changes",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _applyChanges(User user) async {
    if(_selectedImage != null) {
      if(await FirebaseStorageServices().doesProfilePictureExist(user.username)) { FirebaseStorageServices().removeProfilePicture(user.username); }
      var done = await FirebaseStorageServices().uploadProfilePicture(user.username, _selectedImage!);
    }

    final oldProfileImage = user.profilePictureUrl;
    final profileImageUrl = (await FirebaseStorageServices().getProfilePictureUrl(user.username));

    var newUser = User(
      username: user.username,
      email: user.email,
      realName: _realNameController.text.isNotEmpty ? _realNameController.text : user.realName,
      profilePictureUrl: profileImageUrl ?? oldProfileImage,
      bio: _biographyController.text.isNotEmpty ? _biographyController.text : user.bio,
      favouriteColor: user.favouriteColor,
      friendsUsernames: user.friendsUsernames,
      accountCreationDate: user.accountCreationDate,
    );
    await FirebaseCloudServices().updateUserByUsername(user.username, newUser);
  }
}

