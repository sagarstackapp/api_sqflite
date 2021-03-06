import 'package:api_sqflite/common/widget/widget.dart';
import 'package:api_sqflite/model/avtarusermodel.dart';
import 'package:api_sqflite/screen/home_screen/homescreen_viewmodel.dart';
import 'package:api_sqflite/main.dart';
import 'package:api_sqflite/model/usermodel.dart';
import 'package:api_sqflite/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomeScreenViewModel homeScreenViewModel;
  TextEditingController userIdController = TextEditingController();
  Future<List<UserModel>> dbUser;
  int userId;
  UserModel userModel;
  AvtarUserModel avtarUserModel;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabaseUserData();
  }

  getDatabaseUserData() {
    setState(() {
      dbUser = DBProvider.dbProvider.getAllUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    homeScreenViewModel ?? (homeScreenViewModel = HomeScreenViewModel(this));
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              getUserDetailsField(
                controller: userIdController,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: getUserDetailsButton(onTap: showDetails),
              ),
              SizedBox(height: 20),
              Divider(),
              userModel == null
                  ? userData()
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text('${userModel.id}'),
                        subtitle: Text('${userModel.title}'),
                        trailing: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: addUser,
                              icon: Icon(
                                Icons.post_add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey, thickness: 3),
                      itemCount: 1,
                    ),
            ],
          ),
          isLoading ? LoadingPage() : Container()
        ],
      ),
    );
  }

  showDetails() async {
    if (userIdController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Enter User Id to fetch records.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      userId = int.parse(userIdController.text);
      print('Print details of user --> $userId');
      setState(() {
        isLoading = true;
      });
      homeScreenViewModel.userData(userId);
    }
  }

  addUser() {
    var userData = DBProvider.dbProvider.addUser(userModel);
    print('UserData --> $userData');
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  deleteUser(id) {
    var userData = DBProvider.dbProvider.deleteUser(id);
    print('UserData --> $userData');
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  userData() {
    return FutureBuilder(
      future: dbUser,
      builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text('${snapshot.data[index].id}'),
                      subtitle: Text('${snapshot.data[index].title}'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () async {
                              await deleteUser(snapshot.data[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey, thickness: 3),
                  itemCount: snapshot.data.length,
                ),
              );
      },
    );
  }
}
