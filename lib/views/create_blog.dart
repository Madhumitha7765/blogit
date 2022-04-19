// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, unused_local_variable, unnecessary_string_interpolations, prefer_final_fields, unused_field, avoid_print, use_key_in_widget_constructors

import 'dart:io';
import 'package:blogg_app/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateBlog extends StatefulWidget {
  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;

  XFile selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    ImagePicker imgPicker = ImagePicker();
    var image = await imgPicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
    // print("Get Image Called");
  }

  uploadBlog() async {
    // print("Upload blog called");
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      // upload image to firebase storage
      File selectedFile = File(selectedImage.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      UploadTask task = ref.putFile(selectedFile);
      var downloadUrl = await (await task).ref.getDownloadURL();
      print("The url is: $downloadUrl");

      Map<String, dynamic> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "description": desc
      };

      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {
      print("Error Razeen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: "BlogIt".text.xl3.white.make().shimmer(
                primaryColor: Color(0xFFabbaab),
                secondaryColor: Color(0xFFffffff),
              ),
          actions: [
            GestureDetector(
              onTap: () {
                uploadBlog();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.only(
                  top: 60,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFe96443),
                      Color(0xFF904e95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  File(selectedImage.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          TextField(
                            cursorColor: Colors.tealAccent,
                            decoration: InputDecoration(
                              hintText: "Author Name",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.tealAccent,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          TextField(
                            cursorColor: Colors.tealAccent,
                            decoration: InputDecoration(
                              hintText: "Title",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.tealAccent,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          TextField(
                            cursorColor: Colors.tealAccent,
                            decoration: InputDecoration(
                              hintText: "Description",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.tealAccent,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              desc = val;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
