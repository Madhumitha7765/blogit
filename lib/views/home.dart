// ignore_for_file:todo, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, missing_return, non_constant_identifier_names, unnecessary_new, avoid_print, unused_local_variable, await_only_futures

import 'dart:developer';

import 'package:blogg_app/services/crud.dart';
import 'package:blogg_app/views/create_blog.dart';
import 'package:blogg_app/views/description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  var blogsSnapshot, imgUrl, title, description, authorName;
  Widget BlogList() {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: blogsSnapshot != null
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("blogs").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  print("Snapshot has data");
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var snapData = snapshot.data.docs;
                      if (snapData == null) {
                        print("Snapdata has no data");
                      } else {
                        imgUrl = snapData[index]["imgUrl"];
                        title = snapData[index]["title"];
                        description = snapData[index]["description"];
                        authorName = snapData[index]["authorName"];
                        return BlogsTile(
                          imgUrl: imgUrl,
                          title: title,
                          description: description,
                          authorName: authorName,
                        );
                      }
                    },
                  );
                } else {
                  print("Razeen's Error");
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStream();
  }

  setStream() async {
    final snaps =
        await FirebaseFirestore.instance.collection("blogs").snapshots();
    setState(() {
      blogsSnapshot = snaps;
    });
    print(blogsSnapshot == null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldGradientBackground(
        extendBodyBehindAppBar: true,
        gradient: LinearGradient(
          colors: [
            Color(0xFFe96443),
            Color(0xFF904e95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: "BlogIt".text.xl3.white.make().shimmer(
               primaryColor: Color(0xFFabbaab),
              secondaryColor: Color(0xFFffffff),
              ),
        ),
        body: BlogList(),
        floatingActionButton: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 37),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFe96443),
                      Color(0xFF904e95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CreateBlog();
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.authorName,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Blog $title Tapped");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) {
            return DescriptionPage(
              description: description,
              title: title,
              authorName: authorName,
              imgUrl: imgUrl,
            );
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black45.withOpacity(0.3),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   description,
                  //   style: TextStyle(
                  //     fontSize: 17,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 4,
                  // ),
                  Text(authorName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Blog",
//                 style: TextStyle(fontSize: 22),
//               ),
//               Text(
//                 "It",
//                 style: TextStyle(fontSize: 22, color: Colors.tealAccent),
//               )
//             ],
//           ),
