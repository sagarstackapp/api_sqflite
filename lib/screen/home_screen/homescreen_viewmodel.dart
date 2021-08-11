import 'package:api_sqflite/model/avtarusermodel.dart';
import 'package:api_sqflite/rest_api/avtar_user_details/rest_api.dart';
import 'package:api_sqflite/rest_api/user_details_rest/rest_api.dart';
import 'package:api_sqflite/screen/home_screen/home_screen.dart';
import 'package:api_sqflite/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreenViewModel {
  HomePageState state;

  HomeScreenViewModel(this.state) {
    userAvatar(userId: 1);
  }

  userData(int item) async {
    UserModel data = await getUserDetails(item);
    if (data != null) {
      Fluttertoast.showToast(
        msg: 'Current userId : ${data.id}',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      state.userModel = data;
      state.setState(() {
        state.isLoading = false;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'API not called',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      state.setState(() {
        state.isLoading = false;
      });
    }
  }

  userAvatar({int userId}) async {
    AvtarUserModel avtarUserModelData =
        await getUserAvtarDetails(userId: userId);
    if (avtarUserModelData != null) {
      Fluttertoast.showToast(
        msg: 'Current userId : ${avtarUserModelData.data.id}',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      state.avtarUserModel = avtarUserModelData;
      state.setState(() {
        state.isLoading = false;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'API not called',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      state.setState(() {
        state.isLoading = false;
      });
    }
  }
}
