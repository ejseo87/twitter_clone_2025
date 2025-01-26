import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/images/twitter-color-svgrepo-com.svg",
          width: 30,
          height: 30,
        ),
      ),
      body: Center(
        child: Text(
          "Login ...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
