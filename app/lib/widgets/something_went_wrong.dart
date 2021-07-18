import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/sad_blob.svg',
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Oh no!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            Text(
              'Looks like something went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              'We notified our developers and will fix this as soon as humanly possible.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
  }
}
