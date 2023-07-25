import 'dart:io';
import 'package:anaam/components/InputBox.dart';
import 'package:anaam/components/MyButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../components/snackbar.dart';
import '../resources/PostService.dart';
import '../resources/UploadStorage.dart';
import '../utils/ImageLoder.dart';
import '../utils/constents.dart';

class EditProfilePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userData;
  const EditProfilePage({super.key, this.userData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isFileselect = false;
  bool loading = false;
  String? uploadingProc;
  FilePickerResult? fileInfo;
  final UploadStorage _uploadStorage = UploadStorage();
  String authID = FirebaseAuth.instance.currentUser!.uid;

  PostService addPost = PostService();
  final _formKey = GlobalKey<FormState>();
  final fbDB = FirebaseFirestore.instance;
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  uploadTheFile() async {
    setState(() {
      loading = true;
    });

    if (isFileselect == false) {
      await fbDB.collection('users').doc(authID).update({
        "pic": widget.userData['pic'],
        "name": name.text,
        'bio': bio.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return false;
    }

    try {
      String uploadPathset =
          "post/photos/$authID/profile/${"${idGenerator()}$authID.${fileInfo!.files.first.extension}"}";
      UploadTask uploadfile = _uploadStorage.uploadFile(
        file: File(fileInfo!.files.first.path.toString()),
        fileFullpath: uploadPathset,
      );
      uploadfile.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            setState(() {
              uploadingProc = progress.toStringAsFixed(0).toString();
            });
            break;
          case TaskState.paused:
            showSnackbar(context, text: "Uploading Paused", color: Colors.red);
            break;
          case TaskState.canceled:
            showSnackbar(context,
                text: "Uploading Canceled", color: Colors.red);
            break;
          case TaskState.error:
            showSnackbar(context,
                text: "File Not Uploaded Error!", color: Colors.red);
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            String getUrl = await taskSnapshot.ref.getDownloadURL();
            await fbDB.collection('users').doc(authID).update({
              "name": name.text,
              'bio': bio.text,
              "pic": getUrl,
              "setprofile": true,
            });

            if (widget.userData['setprofile']) {
              Reference ref = FirebaseStorage.instance
                  .refFromURL(widget.userData['pic'].toString());
              await ref.delete();
            }
            Navigator.of(context).pop();
            break;
        }
      });
    } catch (e) {
      showSnackbar(context, text: "Sumthing Want Wrong!", color: Colors.red);
      setState(() {
        loading = false;
      });
    }
  }

  setFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: alowFileType,
    );

    if (result == null) {
      setState(() {
        isFileselect = false;
      });
      return false;
    } else if (result.files.first.size > 10862177) {
      // ignore: use_build_context_synchronously
      showSnackbar(context,
          text: "File Size Too Large.. Max 10 MB", color: Colors.red);
      return false;
    } else if (!alowFileType.contains(result.files.first.extension)) {
      // ignore: use_build_context_synchronously
      showSnackbar(context,
          text: "Please Select A Image File", color: Colors.red);
      return false;
    }
    setState(() {
      fileInfo = result;
      isFileselect = true;
    });
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.userData['name'];
    bio.text = widget.userData['bio'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: GestureDetector(
                  onTap: setFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: isFileselect
                        ? Image.file(
                            File(fileInfo!.files.first.path.toString()),
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          )
                        : ImageLoder(
                            imgurl: widget.userData['pic'].toString(),
                            imgWidget: 90,
                            imgHeight: 90,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                    hint: "Name",
                    controller: name,
                    validate: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Your Name";
                      } else if (val.length <= 3) {
                        return "Name Is Too Short";
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                    hint: "Bio",
                    maxline: 3,
                    maxlen: 120,
                    controller: bio,
                    validate: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Your Bio";
                      } else if (val.length <= 10) {
                        return "Bio Is Too Short";
                      }
                    }),
              ),
              MyButton(
                text: uploadingProc != null && isFileselect && loading
                    ? "Uplaoding $uploadingProc%"
                    : loading
                        ? "Updateing.."
                        : "Update",
                disable: loading,
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                    uploadTheFile();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
