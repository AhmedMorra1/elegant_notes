import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static int count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(count != null ? count.toString() : '0'),
              Text(auth.currentUser.uid != null ? auth.currentUser.uid : 'No user id'),
            ],
          ),
        ),
      ),
    );
  }
}
