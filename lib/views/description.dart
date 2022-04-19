// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, unused_local_variable, unnecessary_string_interpolations, prefer_final_fields, unused_field, avoid_print, use_key_in_widget_constructors, sized_box_for_whitespace, missing_required_param

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:velocity_x/velocity_x.dart';

class DescriptionPage extends StatefulWidget {
  String description, title, authorName, imgUrl;
  DescriptionPage({
    this.description,
    this.imgUrl,
    this.title,
    this.authorName,
  });
  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}



class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: "BlogIt".text.xl3.white.make().shimmer(
              primaryColor: Color(0xFFabbaab),
              secondaryColor: Color(0xFFffffff),
            ),
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFe96443),
                  Color(0xFF904e95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 120,
                  left: 0,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 153,
                  left: 20,
                  child: GradientText(
                    widget.title,
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ltr,
                    colors: [
                      Color(0xFF355c7d),
                      Color(0xFF6c657b),
                      Color(0xFFc06c84),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 35),
                  // height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      widget.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    // top: 25,
                  ),
                  height: 170,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFe96443),
                          Color(0xFF904e95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF904e95).withOpacity(0.3),
                          offset: Offset(-10, 0),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                      left: 32,
                      top: 50,
                      bottom: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AUTHOR NAME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.authorName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    top: 15,
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFe96443),
                          Color(0xFF904e95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF904e95).withOpacity(0.3),
                          offset: Offset(-10, 0),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                      left: 32,
                      right: 25,
                      top: 50,
                      bottom: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DESCRIPTION",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//         padding: EdgeInsets.only(top: 60),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Vx.orange400,
//               Vx.purple500,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 100,
//               ),
//               Text(widget.description),
//               SizedBox(
//                 height: 100,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("Go Back"),
//               ),
//             ],
//           ),
//         ),
//       ),
