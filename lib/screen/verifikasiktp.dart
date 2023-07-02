import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gorentcar/background/formverifikasibg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class VerifikasiKtpScreen extends StatefulWidget {
  const VerifikasiKtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifikasiKtpScreen> createState() => _VerifikasiKtpScreenScreenState();
}

class _VerifikasiKtpScreenScreenState extends State<VerifikasiKtpScreen> {
  File? _selectedImage;
  String? _uploadedImageUrl;

  Future<void> pickImageFromGallery() async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      final picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });

        // Upload image to Firebase Storage
        await uploadImageToFirebaseStorage();
      }
    } else {
      // Handle the case when permission is denied
    }
  }

  Future<void> uploadImageToFirebaseStorage() async {
    if (_selectedImage == null) return;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final destination = 'ktp/$fileName';

      final ref =
          firebase_storage.FirebaseStorage.instance.ref(destination);

      final uploadTask = ref.putFile(_selectedImage!);
      final snapshot = await uploadTask;

      if (snapshot.state == firebase_storage.TaskState.success) {
        final downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl.toString());
        setState(() {
          _uploadedImageUrl = downloadUrl;
        });
      } else {
        // Handle the case when the upload task fails
      }
    } catch (error) {
      // Handle any errors that occur during the upload process
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        formVerifikasiBg(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0, left: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/datareservasi');
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Verifikasi Ktp",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: 90.0),
                  child: Text(
                    "Upload Foto KTP",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    print("Tapped !!!");
                    pickImageFromGallery();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 100.0),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'images/pickimage.png',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: SizedBox(
                    width: 220.0, // Set the desired width
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFE9677),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Lanjut",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
