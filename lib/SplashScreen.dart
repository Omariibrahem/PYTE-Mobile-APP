import 'package:MovmentTest/Tools/MyColors.dart';
import 'package:flutter/material.dart';
import 'main.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomePage();
  }

  _navigateToWelcomePage() async {
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashimage.jpeg'), // logo path
            SizedBox(height: 20),
            Text(
              'Welcome to Pyte',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MyBlue,
              ),
            ),
            Text(
              'We Got Your Back',
              style: TextStyle(
                fontSize: 24,
                color: LoginButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
