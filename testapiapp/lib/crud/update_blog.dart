import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:testapiapp/const/customtext-style.dart';
import 'package:testapiapp/model/blog_model.dart';
import 'package:testapiapp/service/custom_http.dart';
import 'package:testapiapp/toast/toast_message.dart';

class updatePage extends StatefulWidget {
  updatePage({super.key, required this.data});

  Data data;

  @override
  State<updatePage> createState() => _EditcategoryState();
}

class _EditcategoryState extends State<updatePage> {
  TextEditingController? titleController;
  TextEditingController? subtitleController;
  TextEditingController? slugController;
  TextEditingController? desController;
  TextEditingController? categoryidController;
  TextEditingController? dateController;

  final _formkey = GlobalKey<FormState>();

  String? fild;

  File? image;

  final _picker = ImagePicker();

  Future getImageFromgallary() async {
    final pickimage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickimage != null) {
      print('Image loaded');

      setState(() {
        image = File(pickimage.path);
        // isImage = true;
      });
      print('$image');
    } else {
      print('Image not found');
    }
  }

  bool isImage = false;
  bool isProgress = false;

  @override
  void initState() {
    // TODO: implement initState

    titleController = TextEditingController(text: widget.data.title);
    subtitleController = TextEditingController(text: widget.data.subTitle);
    slugController = TextEditingController(text: widget.data.slug);
    desController = TextEditingController(text: widget.data.description);
    categoryidController = TextEditingController(text: widget.data.categoryId);
    dateController = TextEditingController(text: widget.data.date);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Categories'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        progressIndicator: spinkit,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          width: double.infinity,
          child: SingleChildScrollView(
              child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titleController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write title name';
                    }
                  },
                  decoration: Customdeco(hint: 'Title'),
                ),
                Text(
                  'sub title',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: subtitleController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write sub title ';
                    }
                  },
                  decoration: Customdeco(hint: 'Sub title'),
                ),
                Text(
                  'Slug',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: slugController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write slug id';
                    }
                  },
                  decoration: Customdeco(hint: 'Slug'),
                ),
                Text(
                  'Description',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: desController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write description';
                    }
                  },
                  decoration: Customdeco(hint: 'Description'),
                ),
                Text(
                  'Category Id',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: categoryidController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write category id';
                    }
                  },
                  decoration: Customdeco(hint: 'ID'),
                ),
                Text(
                  'Date',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write date';
                    }
                  },
                  decoration: Customdeco(hint: 'Date'),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  ' Image',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        getImageFromgallary();
                      },
                      child: Container(
                        width: double.infinity,
                        height: height * 0.3,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(8)),
                        child: image == null
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            './asset/image/mountain.jpg'))),
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: FileImage(image!))),
                              ),
                      ),
                    ),
                    Positioned(
                        bottom: -30,
                        left: width * 0.35,
                        child: Visibility(
                          visible: isImage,
                          child: TextButton(
                              onPressed: () {
                                getImageFromgallary();
                              },
                              child: Icon(Icons.add_a_photo_outlined,
                                  size: 50, color: Colors.teal)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                      //  border: Border.all(color: aTextColor, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        updateCategory();
                      },
                      child: Text(
                        'Update category',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  InputDecoration Customdeco({required String hint}) {
    return InputDecoration(
        hintText: hint,
        hintStyle: myStyle(clr: Colors.grey, fs: 16),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }

  Future updateCategory() async {
    try {
      var uri = Uri.parse(
          'https://apitest.hotelsetting.com/api/admin/blog-news/update/${widget.data.id}');

      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(await CustomHttp().getheadersWithToken());

      request.fields['title'] = titleController!.text.toString();

      if (image != null) {
        var photoImage =
            await http.MultipartFile.fromPath('image', image!.path);
        setState(() {});

        request.files.add(photoImage);
      }

      setState(() {
        isProgress = true;
      });

      var respons = await request.send();

      print('status code ${respons.statusCode}');
      var responseData = await respons.stream.toBytes();

      var responsString = String.fromCharCodes(responseData);
      print('respons Stringgggggg $responsString');

      var data = jsonDecode(responsString);

      print("jsondata isssssssss${data['message']}");

      if (respons.statusCode == 200) {
        print('Repons okkkkkkkkkkkk code is  ${respons.statusCode}');

        showIntoast('${data['message']}');
        Navigator.of(context).pop();
      }
    } catch (e) {
      showIntoast('Try again');
      setState(() {
        isProgress = false;
      });
    }
  }
}
