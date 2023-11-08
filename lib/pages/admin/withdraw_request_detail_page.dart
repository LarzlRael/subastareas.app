part of '../pages.dart';

class WithDrawRequestBody {
  int idUser;
  int idTransaction;
  int idWithdraw;
  String paymentMethod;
  String status;
  WithDrawRequestBody(
    this.idUser,
    this.idTransaction,
    this.idWithdraw,
    this.paymentMethod,
    this.status,
  );
  Map<String, Object> bodyToJson() {
    return {
      'idUser': idUser,
      'idTransaction': idTransaction,
      'idWithdraw': idWithdraw,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}

class WithdrawRequestDetail extends StatefulWidget {
  final WithdrawalRequestsModel withdrawRequest;
  const WithdrawRequestDetail({Key? key, required this.withdrawRequest})
      : super(key: key);

  @override
  State<WithdrawRequestDetail> createState() => _WithdrawRequestDetailState();
}

class _WithdrawRequestDetailState extends State<WithdrawRequestDetail> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final withdrawRequest = widget.withdrawRequest;
    final transactionServices = TransactionServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Detalle de solicitud de retiro',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userInformation(withdrawRequest),
            Center(
              child: ButtonWithIcon(
                label: 'Contactar por whatsapp',
                icon: FontAwesomeIcons.whatsapp,
                backgroundColorButton: Colors.green,
                onPressed: () {
                  startWhatsapp(context, '+591  ${withdrawRequest.phone}',
                      'Hola, Solicitud de retiro de puntos en Subastareas');
                },
                verticalPadding: 10,
                horizontalPadding: 10,
              ),
            ),
            const SizedBox(height: 10),
            FormBuilder(
              key: _formKey,
              child: const Column(
                children: [
                  CustomDropdown(
                    title: 'Estado',
                    formFieldName: 'status',
                    placeholder: 'Seleccionar estado',
                    listItems: [
                      'Pendiente',
                      'Aprobado',
                      'Rechazado',
                    ],
                  ),
                  CustomDropdown(
                    title: 'Metodo de pago',
                    formFieldName: 'paymentMethod',
                    placeholder: 'Metodo de pago',
                    listItems: [
                      'Transferencia bancaria',
                      'Pago movil (Tigo money) ',
                      'Efectivo',
                    ],
                  ),
                ],
              ),
            ),
            ButtonWithIcon(
              marginVertical: 10,
              label: "Confirmar pago",
              backgroundColorButton: Colors.green,
              horizontalPadding: 20,
              verticalPadding: 10,
              icon: FontAwesomeIcons.check,
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  transactionServices.confirmWithDraw(
                    context,
                    WithDrawRequestBody(
                      withdrawRequest.idUser,
                      withdrawRequest.idTransaction,
                      withdrawRequest.idWithdraw,
                      _formKey.currentState!.value['paymentMethod'],
                      _formKey.currentState!.value['status'],
                    ),
                  );
                  /* _formKey.currentState!.value['status'],
                      _formKey.currentState!.value['paymentMethod']);
                      ); */
                }
              },
            ),
          ],
        ),
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
    final whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=";
    var whatsappUrlIOS = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    final Uri url =
        Uri.parse(Platform.isIOS ? whatsappUrlIOS : whatsappURlAndroid);
    launchUrl(url).then((value) {
      if (!value) {
        GlobalSnackBar.show(context, noWhatsapp, backgroundColor: Colors.red);
      }
    });
  }

  Widget userInformation(WithdrawalRequestsModel withdrawRequest) {
    return Column(
      children: [
        SimpleText(
          text: withdrawRequest.phone,
          fontSize: 16,
          bottom: 5,
        ),
        ShowProfileImage(
          profileImage: withdrawRequest.profileImageUrl,
          userName: withdrawRequest.username.toCapitalized(),
          radius: 30,
        ),
        SimpleText(
          text: withdrawRequest.username.toCapitalized(),
          fontSize: 18,
          top: 10,
          fontWeight: FontWeight.bold,
        ),
        SimpleText(
          top: 5,
          text: withdrawRequest.email.toCapitalized(),
          fontSize: 16,
          fontWeight: FontWeight.normal,
          bottom: 5,
        ),
        SimpleText(
          text:
              'Monto solicitado: ${withdrawRequest.withdrawalRequestAmount.toString()}',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          bottom: 5,
        ),
      ],
    );
  }
}
