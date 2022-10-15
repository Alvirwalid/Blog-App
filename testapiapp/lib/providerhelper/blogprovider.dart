import 'package:flutter/foundation.dart';
import 'package:testapiapp/model/blog_model.dart';
import 'package:testapiapp/service/custom_http.dart';

class BlogProvider with ChangeNotifier {
  List<Data> blogData = [];

  Future getBlogData() async {
    blogData = await CustomHttp().fetchBlogdata();
    notifyListeners();
  }
}
