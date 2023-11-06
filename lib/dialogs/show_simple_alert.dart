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
            onPressed: context.pop,
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

void showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  Function()? onAccept,
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
            context.pop();
            if (onAccept != null) onAccept();
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
  int idHomework,
  CommentProvider commentProvider,
  AuthServices auth, {
  int? idComment,
  String currentEditing = '',
}) {
  TextEditingController controller = TextEditingController();

  if (idComment != null) {
    controller.text = currentEditing;
  }

  bool showSendIcon = false;
  bool loading = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
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
                        showSendIcon = true;
                      });
                    } else {
                      setState(() {
                        showSendIcon = false;
                      });
                    }
                  },
                )),
                showSendIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });

                          commentProvider
                              .edirOrNewComment(
                            idHomework,
                            controller.text,
                            idComment: idComment,
                          )
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            if (value) {
                              context.pop();
                              controller.clear();
                              GlobalSnackBar.show(
                                context,
                                idComment == null
                                    ? 'Comentario editado'
                                    : 'Comentario enviado',
                                backgroundColor: Colors.green,
                              );
                            }
                          });
                        },
                        icon: loading
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
