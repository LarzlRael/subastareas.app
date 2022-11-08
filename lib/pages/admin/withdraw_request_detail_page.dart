part of '../pages.dart';

class WithdrawRequestDetail extends StatefulWidget {
  const WithdrawRequestDetail({Key? key}) : super(key: key);

  @override
  State<WithdrawRequestDetail> createState() => _WithdrawRequestDetailState();
}

class _WithdrawRequestDetailState extends State<WithdrawRequestDetail> {
  String _selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Detalle de solicitud de retiro',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ButtonWithIcon(
              label: 'Contactar por whatsapp',
              icon: FontAwesomeIcons.whatsapp,
              backgroundColorButton: Colors.green,
              onPressed: () {
                startWhatsapp(context, '+59163116355',
                    'Hola, Solicitud de retiro de puntos en Subastareas');
              },
              verticalPadding: 10,
              horizontalPadding: 10,
            ),
          ),
          DropdownButton(
              value: _selectedValue,
              items: [
                DropdownMenuItem(
                  child: Text('Pendiente'),
                  value: 'Pendiente',
                ),
                DropdownMenuItem(
                  child: Text('Pendiente'),
                  value: 'Pendiente',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
              })
        ],
      ),
    );
  }

  void launchWhatsApp(String phone, String message) async {
    launchURL(url(phone, message));
  }

  String url(String phone, String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }

  startWhatsapp(BuildContext context, String whatsapp, String text) async {
    const noWhatsapp = "Whatsapp no instalado";
    final whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=";
    var whatsappUrlIOS = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatsappUrlIOS)) {
        await launch(whatsappUrlIOS, forceSafariVC: false);
      } else {
        GlobalSnackBar.show(context, noWhatsapp);
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        GlobalSnackBar.show(context, noWhatsapp);
      }
    }
  }
}
