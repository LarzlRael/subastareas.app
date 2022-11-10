part of 'buttons.dart';

class ButtonConfirm extends StatefulWidget {
  final String textConfirm;
  final String textCancel;
  final Future<bool> Function()? onAccept;
  final Future<bool> Function()? onReject;
  const ButtonConfirm({
    Key? key,
    this.textConfirm = 'Confirmar',
    this.textCancel = 'Cancelar',
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  State<ButtonConfirm> createState() => _ButtonConfirmState();
}

class _ButtonConfirmState extends State<ButtonConfirm> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FillButton(
            borderRadius: 5,
            label: "Rechazar",
            ghostButton: true,
            onPressed: () async {
              await widget.onReject!();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FillButton(
            borderRadius: 5,
            label: "Aceptar",
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              final success = await widget.onAccept!();
              setState(() {
                _loading = false;
              });
              if (success) {
                /* Navigator.pop(context);
                GlobalSnackBar.show(context, "Tarea aceptada y confirmada",
                    backgroundColor: Colors.green); */
              } else {
                /* GlobalSnackBar.show(context, "Hubo un error",
                    backgroundColor: Colors.red); */
              }
            },
          ),
        )
      ],
    );
  }
}
