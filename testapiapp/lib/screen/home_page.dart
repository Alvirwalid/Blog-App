import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapiapp/const/customtext-style.dart';
import 'package:testapiapp/crud/update_blog.dart';
import 'package:testapiapp/providerhelper/blogprovider.dart';
import 'package:testapiapp/screen/login-page.dart';
import 'package:testapiapp/service/custom_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email;

  ScrollController? _scrollController;
  bool buttonVisible = true;

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    email = sharedPreferences.getString('email');

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bprovider = Provider.of<BlogProvider>(context).getBlogData();
    var blogList = Provider.of<BlogProvider>(context).blogData;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, title: Text('Home')),
      drawer: Drawer(
        width: 220,
        backgroundColor: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('./asset/image/person.jpg'),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$email',
              style: myStyle(
                clr: Colors.white,
                fs: 20,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink, minimumSize: Size(150, 40)),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('token');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return LoginPage();
                  }));
                },
                child: Text(
                  'SignOut',
                  style: myStyle(clr: Colors.white, fs: 20),
                )),
          ],
        ),
      ),
      body: blogList.isNotEmpty
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      elevation: 20,
                      child: Container(
                        width: double.infinity,
                        height: 380,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              './asset/image/mountain.jpg'))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${blogList[index].date}',
                                        style:
                                            myStyle(clr: Colors.white, fs: 18),
                                      ),
                                      Text(
                                        '${blogList[index].slug}',
                                        style:
                                            myStyle(clr: Colors.white, fs: 18),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ListTile(
                                            title: Text(
                                              '${blogList[index].title}',
                                              style: myStyle(fs: 20),
                                            ),
                                            subtitle: Text(
                                                '${blogList[index].subTitle}'),
                                            trailing: Text(
                                                'ID: ${blogList[index].categoryId}')),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${blogList[index].description}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return updatePage(
                                                    data: blogList[index],
                                                  );
                                                })).then((value) {
                                                  Provider.of<BlogProvider>(
                                                    context,
                                                  ).getBlogData();
                                                });
                                              },
                                              child: Text(
                                                'Update',
                                                style: myStyle(
                                                    fs: 18, clr: Colors.white),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                              onPressed: () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        iconPadding:
                                                            EdgeInsets.all(8),
                                                        title: Text(
                                                          'Are you sure ?',
                                                          style: myStyle(
                                                              clr: Colors.red),
                                                        ),
                                                        content: Text(
                                                          'Once you delete,the item will gone permanently',
                                                          style: myStyle(
                                                              clr: Colors.red),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                          0.7),
                                                                  minimumSize:
                                                                      Size(60,
                                                                          40)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  'CANCEL')),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                          0.7),
                                                                  minimumSize:
                                                                      Size(
                                                                          60, 40)),
                                                              onPressed:
                                                                  () async {
                                                                await CustomHttp()
                                                                    .deleteBlog(
                                                                        id: blogList[index]
                                                                            .id!
                                                                            .toInt())
                                                                    .then(
                                                                        (value) {
                                                                  if (value ==
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();

                                                                      blogList.removeAt(
                                                                          index);
                                                                    });
                                                                  } else {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }
                                                                }).then((value) {
                                                                  Provider.of<BlogProvider>(
                                                                          context)
                                                                      .getBlogData();
                                                                });
                                                              },
                                                              child: Text(
                                                                  'Delete')),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                'Delete',
                                                style: myStyle(
                                                    fs: 18, clr: Colors.white),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 10,
                      )),
                  itemCount: blogList.length),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
                backgroundColor: Colors.red,
              ),
            ),
    ));
  }
}
