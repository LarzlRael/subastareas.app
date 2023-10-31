part of '../widgets.dart';

class CommentsByHomework extends StatefulWidget {
  final bool isLogged;
  final List<Comment> comments;
  final int idHomework;
  final AuthServices auth;
  const CommentsByHomework({
    Key? key,
    required this.isLogged,
    required this.comments,
    required this.idHomework,
    required this.auth,
  }) : super(key: key);

  @override
  State<CommentsByHomework> createState() => _CommentsByHomeworkState();
}

class _CommentsByHomeworkState extends State<CommentsByHomework> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reverseComments = widget.comments.reversed.toList();
    return Container(
      child: Column(
        children: [
          widget.isLogged
              ? GestureDetector(
                  onTap: () {
                    showBottomMenuSheetAddOrEditComment(
                      context,
                      widget.auth,
                      widget.idHomework,
                    );
                  },
                  child: Container(
                    /* color: Colors.brown, */
                    child: Row(
                      children: [
                        ShowProfileImage(
                          profileImage: widget.auth.user.profileImageUrl,
                          userName: widget.auth.user.username,
                          radius: 25,
                        ),
                        const SizedBox(width: 15),
                        const SimpleText(
                          text: 'Agregar un comentario...',
                          fontSize: 13,
                          lightThemeColor: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          reverseComments.isNotEmpty
              ? SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reverseComments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: reverseComments[index],
                        idHomework: widget.idHomework,
                        auth: widget.auth,
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
