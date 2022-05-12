import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subastareaspp/models/error_model.dart';
import 'package:subastareaspp/servives/services.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';
import 'package:subastareaspp/utils/validation.dart';
import 'package:subastareaspp/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    /*  final _services = Services();
    final data = {
      'username': 'gatomon2',
      'password': 'gatomon22',
      'idDevice': '123455'
    };
    _services.sendRequest('POST', 'auth/signin', data).then((value) {
      /* print(value!.body); */
      if ((validateStatus(value?.statusCode))) {
        print('ok');
      } else {

        print('error en la solicitud');
        print(value!.body);
        /* final error = errorModelFromJson(value!.body);
        print(error.message); */

      }
    }); */
    return Scaffold(
      body: Center(
        child: Slideshow(
          primaryColor: Colors.blue,
          secondaryColor: Colors.blueGrey,
          primaryBullet: 20.0,
          secondaryBullet: 10.0,
          slides: [
            SvgPicture.asset('assets/svg/slide-1.svg'),
            SvgPicture.asset('assets/svg/slide-2.svg'),
            SvgPicture.asset('assets/svg/slide-3.svg'),
            Container(
              child: Column(
                children: [
                  Expanded(child: SvgPicture.asset('assets/svg/slide-3.svg')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'welcome');
                        prefs.setShowInitialSlider = false;
                      },
                      child: Text('Ir al inicio')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
