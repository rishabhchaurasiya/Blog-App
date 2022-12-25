// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:blog_app/screens/add_post.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRef = FirebaseDatabase.instance.ref().child('Posts');
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('New Blogs'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPostScreen(),
                    ));
              },
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                });
              },
              child: Icon(Icons.logout),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Search with blog title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  search = value;
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  // print(snapshot.value);
                  // var v = snapshot.value;
                  // print(v);
                  // print('object');
                  // debugger();
                  // if (searchController.text.isEmpty) {
                  return Column(
                      //   children: [
                      //     FadeInImage.assetNetwork(
                      //       placeholder: 'images/blog.png',
                      //       image: snapshot.value!['pImage'],
                      //     )
                      //   ],
                      );
                  // }else if (){

                  // }else{
                  //   return Container();
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
