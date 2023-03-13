import 'package:barbershop/providers/auth_provider.dart';
import 'package:barbershop/screen/home/navbar_screen.dart';
import 'package:barbershop/screen/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<User?>(
      stream: auth.streamAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return (snapshot.data != null)
              ? const NavbarScreen()
              : const WelcomeScreen();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
