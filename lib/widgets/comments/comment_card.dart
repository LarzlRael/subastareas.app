part of '../widgets.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final Homework homework;
  final bool isExpanded;
  final AuthProvider auth;
  final CommentProvider commentProvider;
  const CommentCard({
    Key? key,
    this.isExpanded = false,
    required this.comment,
    required this.commentProvider,
    required this.homework,
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
                  isOwner: widget.comment.user.id == widget.homework.user.id,
                  isCommentWritter:
                      widget.comment.user.id == widget.auth.user.id,
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
                      widget.homework.id,
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

  showBottomMenuSheet(AuthProvider auth, Comment comment, int idHomework) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return auth.user.id == comment.user.id
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar comentario'),
                    onTap: () {
                      showBottomMenuSheetAddOrEditComment(
                        context,
                        widget.homework.id,
                        widget.commentProvider,
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
                      showConfirmDialog(
                        context,
                        'Eliminar comentario',
                        '¿Estás seguro de eliminar este comentario?',
                        () => widget.commentProvider
                            .deleteComment(comment.id)
                            .then((value) {
                          if (value) {
                            context.pop();
                            GlobalSnackBar.show(
                                context, 'Comentario eliminado');
                          } else {
                            GlobalSnackBar.show(
                                context, 'No se pudo eliminar el comentario');
                          }
                        }),
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
                    onTap: context.pop,
                  ),
                ],
              );
      },
    );
  }
}
