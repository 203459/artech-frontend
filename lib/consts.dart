import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const backGroundColor = Colors.white;
const backGroundColorBottom = Colors.white;
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const iconColor = Colors.white;
const primaryColor = Colors.black;
const secondaryColor = Colors.grey;
const darkGreyColor = Color.fromRGBO(97, 97, 97, 1);
const purpleColor = Color(0xFFAA5EB7);
final lightGreyColor = Color.fromRGBO(128, 128, 141, 1);

Widget sizeVer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

class PageConst {
  static const String editProfilePage = "editProfilePage";
  static const String updatePostPage = "updatePostPage";
  static const String commentPage = "commentPage";
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String updateCommentPage = "updateCommentPage";
  static const String updateReplayPage = "updateReplayPage";
  static const String postDetailPage = "postDetailPage";
  static const String singleUserProfilePage = "singleUserProfilePage";
  static const String followingPage = "followingPage";
  static const String followersPage = "followersPage";
}

class FirebaseConst {
  static const String users = "users";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
