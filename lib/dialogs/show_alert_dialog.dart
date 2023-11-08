part of 'dialogs.dart';

showAlertDialog(
  BuildContext context,
  String title,
  VoidCallback confirmOnTap, {
  Widget? content,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    onPressed: context.pop,
    child: const Text("Cancelar"),
  );
  Widget continueButton = TextButton(
    child: const Text("Continuar"),
    onPressed: () {
      confirmOnTap();
      context.pop();
    },
  );
  // set up the AlertDialog
  final alert = AlertDialog(
    title: Text(
      title,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    ),
    content: content,
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
