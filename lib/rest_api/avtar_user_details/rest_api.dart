import 'package:api_sqflite/common/constant/string.dart';
import 'package:api_sqflite/model/avtarusermodel.dart';
import 'package:dio/dio.dart';

getUserAvtarDetails({int userId}) async {
  Dio dio = Dio();
  String url = '${ApiResources.DioBaseUrl}/users/$userId';
  print('Url --> $url');

  try {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      print('Response --> ${response.data}');
      return AvtarUserModel.fromJson(response.data);
    } else {
      return null;
    }
  } catch (e) {
    print('catch error in Get User Avatar Details --> $e');
  }
}
