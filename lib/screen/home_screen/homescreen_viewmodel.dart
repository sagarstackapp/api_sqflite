import 'package:api_sqflite/rest_api/api_helper.dart';
import 'package:api_sqflite/screen/home_screen/home_screen.dart';
import 'package:api_sqflite/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreenViewModel {
  HomePageState state;

  HomeScreenViewModel(this.state);

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

  
}
