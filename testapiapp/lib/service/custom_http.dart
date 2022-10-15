import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapiapp/const/const_helper.dart';
import 'package:testapiapp/model/blog_model.dart';
import 'package:testapiapp/toast/toast_message.dart';

class CustomHttp {
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    Map<String, dynamic>? dataMap;
    try {
      var link = '${baseUrl}/login';
      Map<String, String> defualtheader = {'Accept': 'application/json'};
      Map<String, dynamic> map = {'email': email, 'password': password};

      var resonse =
          await http.post(Uri.parse(link), body: map, headers: defualtheader);

      // print(resonse.body);

      var data = jsonDecode(resonse.body);
      // print('data issssssss $data');

      dataMap = Map<String, dynamic>.from(data);

      //print('datamap issssssssssssss $dataMap');
      showIntoast('${dataMap['message']}');

      return dataMap;
    } catch (e) {
      print(e.toString());
    }

    return dataMap!;
  }

  Future<Map<String, String>> getheadersWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> map = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
    };

    print('${sharedPreferences.getString('token')}');

    print(map);

    return map;
  }

////// blog list data fetch
  Future<List<Data>> fetchBlogdata() async {
    List<Data> blogList = [];

    var link = 'https://apitest.hotelsetting.com/api/admin/blog-news';

    //Map<String, dynamic> blogData;

    var respons = await http.get(Uri.parse(link), headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer 428|mN0ttVLrVmXkI2GEL4Sqe4qqu5PHEqg4KmR7e3Er'
    });

    //print(respons.body);

    var data = jsonDecode(respons.body);
    // print(data);
    Data blogData;

    for (var i in data['data']['blogs']['data']) {
      blogData = Data.fromJson(i);

      blogList.add(blogData);
    }

    // print('blog model lllllllllllllllllllllllllllllllllll${blogList}');

    return blogList;
  }

  Future<bool> deleteBlog({required int id}) async {
    var uri = Uri.parse(
        'https://apitest.hotelsetting.com/api/admin/blog-news/delete/$id');

    var response = await http.delete(uri, headers: await getheadersWithToken());

    print(response.body);

    print('status code isssssssssss ${response.statusCode}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      showIntoast('${data['message']}');
      return true;
    } else {
      showIntoast('${data['message']}');
      return false;
    }
  }
}
