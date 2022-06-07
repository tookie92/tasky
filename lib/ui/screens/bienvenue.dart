import 'package:flutter/material.dart';
import 'package:tasky/ui/widgets/my_text.dart';
import 'package:tasky/ui/widgets/my_text_button.dart';

class BienVenuePage extends StatelessWidget {
  const BienVenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(color: Colors.deepPurple),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .6,
            ),
            const MyText(
              label: "Welcome to the",
              fontWeight: FontWeight.w600,
              colors: Colors.white,
              fontSize: 15.0,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const MyText(
              label: "Tasky",
              letterSpacing: 5.0,
              fontWeight: FontWeight.w900,
              colors: Colors.white,
              fontSize: 48.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
            MyTextButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              primary: Colors.deepPurpleAccent,
              vertical: 15.0,
              horizontal: 80.0,
              label: "Get Started",
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyText(
                  label: "Already have account ?",
                  colors: Colors.white,
                  fontSize: 12.0,
                ),
                MyTextButton(
                  horizontal: 0.0,
                  onPressed: () {},
                  primary: Colors.white,
                  label: "Sign in",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
