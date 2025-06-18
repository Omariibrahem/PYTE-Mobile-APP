import 'package:MovmentTest/Services/FirebaseServices.dart';
import 'package:MovmentTest/Tools/MyColors.dart';
import 'package:MovmentTest/OptionsPage.dart';
import 'package:flutter/material.dart';
import 'Services/mqtt_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:MovmentTest/SplashScreen.dart';
import 'package:MovmentTest/StartSession/StartNewSessionPage.dart';
import 'package:MovmentTest/ViewReports/ViewReportsPage.dart';
import 'package:MovmentTest/PatientsPage.dart';
import 'package:MovmentTest/ManualControl/ManualControlPage.dart';
import 'package:MovmentTest/StartSession/AnklePage.dart';
import 'package:MovmentTest/StartSession/KneePage.dart';
import 'package:MovmentTest/StartSession/HipPage.dart';
import 'package:MovmentTest/StartSession/WristPage.dart';
import 'package:MovmentTest/StartSession/ElbowPage.dart';
import 'package:MovmentTest/StartSession/ShoulderPage.dart';
import 'package:MovmentTest/ViewReports/RealTimeMonitoringPage.dart';
import 'package:MovmentTest/ViewReports/ReportsHistoryPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => MqttService(),
      child: RemoteCarControlApp(),
    ),
  );
}

class RemoteCarControlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Physical Therapy',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen(),
      routes: {
        'OptionsPage': (context) => OptionsPage(),
        'StartNewSessionPage': (context) => StartNewSessionPage(),
        'ViewReportsPage': (context) => ViewReportsPage(),
        'ManualControlPage': (context) => ManualControlPage(),
        'PatientsPage': (context) => PatientsPage(),
        'AnklePage': (context) => AnklePage(),
        'KneePage': (context) => KneePage(),
        'HipPage': (context) => HipPage(),
        'WristPage': (context) => WristPage(),
        'ElbowPage': (context) => ElbowPage(),
        'ShoulderPage': (context) => ShoulderPage(),
        'RealTimeMonitoringPage': (context) => RealTimeMonitoringPage(),
        'ReportsHistoryPage': (context) => ReportsHistoryPage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseService? _firebaseService;

  final _loginFormKey = GlobalKey<FormState>(); // Added form key for validation

  String? _email;
  String? _password;

  // path to your background image
  final String backgroundImagePath = 'assets/images/BackGround.png';

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool success = await _firebaseService!.loginUser(email: _email!, password: _password!);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        Navigator.popAndPushNamed(context, 'OptionsPage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: LoginButtonColor,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              backgroundImagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Content above background
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  key: _loginFormKey, // Added Form widget with key
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 292),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LoginButtonColor,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
