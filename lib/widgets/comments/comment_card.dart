part of '../widgets.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final int idHomework;
  final bool isExpanded;
  final AuthServices auth;
  const CommentCard({
    Key? key,
    this.isExpanded = false,
    required this.comment,
    required this.idHomework,
    required this.auth,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard>
    with TickerProviderStateMixin<CommentCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ShowProfileImage(
            profileImage: widget.comment.user.profileImageUrl,
            userName: widget.comment.user.username,
            radius: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameAndTimeAgo(
                  isOwner: widget.auth.user.id == widget.comment.user.id,
                  userName: widget.comment.user.username,
                  createdAt: widget.comment.createdAt,
                ),
                DropdownComment(
                  commentContent: widget.comment.content.toCapitalized(),
                  isExpanded: widget.isExpanded,
                  limit: 75,
                ),
                widget.comment.edited
                    ? Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const SimpleText(
                              text: 'Editado',
                              lightThemeColor: Colors.grey,
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          widget.auth.isLogged
              ? IconButton(
                  onPressed: () {
                    showBottomMenuSheet(
                      widget.auth,
                      widget.comment,
                      widget.idHomework,
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  showBottomMenuSheet(AuthServices auth, Comment comment, int idHomework) {
    final homeworkBloc = OneHomeworkBloc();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return auth.user.id == comment.user.id
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar comentario'),
                    onTap: () {
                      context.pop();
                      showBottomMenuSheetAddOrEditComment(
                        context,
                        widget.idHomework,
                        auth,
                        idComment: widget.comment.id,
                        currentEditing: widget.comment.content,
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Eliminar'),
                    onTap: () async {
                      context.pop();
                      showConfirmDialog(
                        context,
                        'Eliminar comentario',
                        '¿Estás seguro de eliminar este comentario?',
                        () =>
                            homeworkBloc.deleteComment(comment.id, idHomework),
                      );
                    },
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text('Denunciar comentario'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
      },
    );
  }
}
