part of 'dialogs.dart';

void showSimpleAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Informacion incorrecta'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              child: const Text('Ok'), onPressed: () => Navigator.pop(context)),
        ],
      );
    },
  );
}

void showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  Future<dynamic> Function()? onAccept,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'OK');
            await onAccept!();
            /* GlobalSnackBar.show(context, 'Comentario eliminado'); */
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

showBottomMenuSheetAddOrEditComment(
  BuildContext context,
  AuthServices auth,
  int idComment, {
  int? idHomework,
  bool editable = false,
  String currentEditing = '',
}) {
  TextEditingController controller = TextEditingController();
  if (editable) {
    controller.text = currentEditing;
  }

  bool _showSendIcon = false;
  bool _loading = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final homeworkBloc = OneHomeworkBloc();
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ShowProfileImage(
                  profileImage: auth.user.profileImageUrl,
                  userName: auth.user.username,
                  radius: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escribe un comentario',
                  ),
                  autofocus: true,
                  controller: controller,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _showSendIcon = true;
                      });
                    } else {
                      setState(() {
                        _showSendIcon = false;
                      });
                    }
                  },
                )),
                _showSendIcon
                    ? IconButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          if (!editable) {
                            await homeworkBloc.newComment(
                              idComment,
                              controller.text,
                            );
                            Navigator.pop(context);
                            setState(() {
                              _loading = false;
                            });
                            GlobalSnackBar.show(
                              context,
                              'Comentario enviado',
                              backgroundColor: Colors.green,
                            );
                            controller.clear();
                          } else {
                            setState(() {
                              _loading = true;
                            });
                            await homeworkBloc.editComment(
                              idComment,
                              idHomework!,
                              controller.text,
                            );
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pop(context);
                            GlobalSnackBar.show(
                              context,
                              'Comentario editado',
                              backgroundColor: Colors.green,
                            );

                            controller.clear();
                          }
                        },
                        icon: _loading
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.send),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      });
    },
  );
}