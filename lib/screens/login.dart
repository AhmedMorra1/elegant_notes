import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:elegant_notes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:elegant_notes/screens/forgot_alert.dart';
import 'package:elegant_notes/size_config.dart';

class LoginPage extends StatefulWidget {
  static String email;
  static String password;
  static String uid;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _action = false;

  void _submit() {
    setState(() {
      _action = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _action = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _action,
        child: SafeArea(
          child: Padding(
            padding: new EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Welcome!',
                    style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 7, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                Text('Email'),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 1,
                ),
                TextField(
                  controller: emailController,
                  maxLines: 1,
                  autofocus: true,
                  showCursor: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  textAlign: TextAlign.start,
                ),
                //Text('Password'),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                Text('Password'),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 1,
                ),
                TextField(
                  controller: passwordController,
                  maxLines: 1,
                  autofocus: true,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 1,
                ),
                GestureDetector(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    print('forgot password clicked');
                    ForgotAlert(context: context).showDialogNow();
                  },
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RaisedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                        ),
                        onPressed: () {
                          print('Login button pressed');
                          _signInWithEmailAndPassword(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(child: Text('Or')),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 3,
                      child: RaisedButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                        ),
                        onPressed: () {
                          print('Sign Up button pressed');
                          _register(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register(BuildContext context) async {
    User user;
    try {
      _submit();
      final User user = (await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      ))
          .user;
      print('Signed Up');
      LoginPage.uid = auth.currentUser.uid;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(
          uid: LoginPage.uid,
        );
      }));
      // if (user != null) {
      //   print('SIGN UP SUCCESS');
      //   uid = auth.currentUser.uid;
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return HomePage(
      //       uid: uid,
      //     );
      //   }));
      // } else {
      //   print('SING UP FAILURE');
      //   Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text('Sign Up Failed, Try Again!'),
      //   ));
      // }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      Fluttertoast.showToast(
          msg: "This Email is registered!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Failed with error code: ${e.code}')));
    }
  }

  void _signInWithEmailAndPassword(
    BuildContext context,
  ) async {
    try {
      _submit();
      final User user = (await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      ))
          .user;
      print('Signed In');
      LoginPage.uid = auth.currentUser.uid;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(
          uid: LoginPage.uid,
        );
      }));
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      Fluttertoast.showToast(
          msg: "Email or Password are Wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: SizeConfig.safeBlockVertical * 2.5);
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Failed with error code: ${e.code}')));
    }
  }
}
