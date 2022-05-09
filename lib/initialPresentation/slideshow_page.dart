import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subastareaspp/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slideshow(
          primaryColor: Colors.blue,
          secondaryColor: Colors.green,
          slides: [
            SvgPicture.asset('assets/svg/slide-1.svg'),
            SvgPicture.asset('assets/svg/slide-2.svg'),
            SvgPicture.asset('assets/svg/slide-3.svg'),
            SvgPicture.asset('assets/svg/slide-3.svg'),
            SvgPicture.asset('assets/svg/slide-3.svg'),
            SvgPicture.asset('assets/svg/slide-3.svg'),
          ],
        ),
      ),
    );
  }
}
