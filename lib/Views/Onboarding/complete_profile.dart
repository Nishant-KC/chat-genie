import 'dart:io';
import 'package:chat_genie/Views/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../Model/user_model.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);

    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  void uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepicture")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String imageUrl = await snapshot.ref.getDownloadURL();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();

    widget.userModel.firstName = firstName;
    widget.userModel.secondName = lastName;
    widget.userModel.profilePic = imageUrl;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap());
    Navigator.popUntil(this.context, (route) => route.isFirst);
    Navigator.pushReplacement(this.context,
        MaterialPageRoute(builder: (context) {
      return HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // Profile Picture
    final profilePicture = CupertinoButton(
      onPressed: () {
        showPhotoOptions();
      },
      padding: const EdgeInsets.all(0),
      child: CircleAvatar(
        radius: 80,
        backgroundImage: (imageFile != null) ? FileImage(imageFile!) : null,
        child: (imageFile == null)
            ? const Icon(
                Icons.person,
                size: 80,
              )
            : null,
      ),
    );

    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //last name field
    final lastNameField = TextFormField(
        autofocus: false,
        controller: lastNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          lastNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // submit Button
    final submitButton = CupertinoButton(
      onPressed: () {
        uploadData();
      },
      color: Theme.of(context).colorScheme.secondary,
      child: const Text("Submit"),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Complete Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                profilePicture,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                firstNameField,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                lastNameField,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                submitButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
