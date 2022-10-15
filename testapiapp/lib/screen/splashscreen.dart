import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapiapp/screen/home_page.dart';
import 'package:testapiapp/screen/login-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var token;

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    token = sharedPreferences.getString('token');
    print('token iss $token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin().whenComplete(() {
      Future.delayed(
          Duration(seconds: 2),
          (() => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return token != null ? HomePage() : LoginPage();
              }))));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
