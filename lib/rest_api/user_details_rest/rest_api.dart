import 'package:api_sqflite/common/constant/string.dart';
import 'package:api_sqflite/model/usermodel.dart';
import 'package:http/http.dart' as http;

getUserDetails(item) async {
  String url = '${ApiResources.HttpBaseUrl}/albums/$item';
  print('Url --> $url');

  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Response --> ${response.body}');
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  } catch (e) {
    print('catch error in Get UserDetails --> $e');
  }
}
