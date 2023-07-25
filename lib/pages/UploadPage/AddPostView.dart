import 'dart:io';
import 'package:anaam/components/appbars/TitleBar.dart';
import 'package:anaam/components/snackbar.dart';
import 'package:anaam/utils/constents.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../resources/PostService.dart';
import '../../resources/UploadStorage.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

class _AddPostViewState extends State<AddPostView> {
  bool isFileselect = false;
  bool loading = false;
  String? uploadingProc;
  FilePickerResult? fileInfo;
  TextEditingController caption = TextEditingController();
  final UploadStorage _uploadStorage = UploadStorage();
  String authID = FirebaseAuth.instance.currentUser!.uid;

  PostService addPost = PostService();

  uploadTheFile() {
    setState(() {
      loading = true;
    });
    try {
      String uploadPathset =
          "post/photos/$authID/${"${idGenerator()}$authID.${fileInfo!.files.first.extension}"}";
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
            var uploadDB = await addPost.addNewPost(
                id: authID, desc: caption.text, url: getUrl);
            if (uploadDB == true) {
              // ignore: use_build_context_synchronously
              showSnackbar(context,
                  text: "Your Post is Uploaded", color: Colors.green);
              setState(() {
                loading = false;
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            } else {
              // ignore: use_build_context_synchronously
              showSnackbar(context,
                  text: "Sumthing Want Wrong!", color: Colors.red);
              setState(() {
                loading = false;
              });
            }

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

  pickFile() async {
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
    // pickFile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (loading) {
          showSnackbar(
            context,
            text: "Please Wait Your Post IS Uploading...",
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TitleBar(
            title: "New Post",
            onback: () => loading ? null : Navigator.of(context).pop()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: TextField(
                  maxLines: 5,
                  maxLength: 250,
                  controller: caption,
                  decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 248, 248, 248),
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Write Sumthing...."),
                ),
              ),
              GestureDetector(
                onTap: loading ? null : pickFile,
                child: Container(
                  height: 400,
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: Builder(
                    builder: (context) {
                      if (isFileselect) {
                        return Image.file(
                          File(
                            fileInfo!.files.first.path.toString(),
                          ),
                        );
                      } else {
                        return const Icon(
                          Icons.upload_rounded,
                          size: 40,
                          color: Color.fromARGB(255, 37, 37, 37),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: isFileselect
            ? FloatingActionButton(
                onPressed: loading ? null : uploadTheFile,
                backgroundColor: Colors.black,
                child: Builder(
                  builder: (context) {
                    if (!loading) {
                      return const Icon(
                        Ionicons.send,
                        color: Colors.white,
                      );
                    }
                    if (uploadingProc != null && uploadingProc != "100") {
                      return Text(
                        uploadingProc.toString() + "%",
                        style: const TextStyle(color: Colors.white),
                      );
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                  },
                ),
              )
            : null,
      ),
    );
  }
}
