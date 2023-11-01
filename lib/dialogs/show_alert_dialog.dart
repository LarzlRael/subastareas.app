part of 'dialogs.dart';

showAlertDialog(BuildContext context, String title, Widget content,
    VoidCallback confirmOnTap) {
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
  AlertDialog alert = AlertDialog(
    title: Text(title),
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
