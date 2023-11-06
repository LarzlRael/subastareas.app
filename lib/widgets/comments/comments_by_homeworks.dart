part of '../widgets.dart';

class CommentsByHomework extends StatefulWidget {
  final bool isLogged;
  /* final List<Comment> comments; */
  final Homework homework;
  final AuthServices auth;
  const CommentsByHomework({
    Key? key,
    required this.isLogged,
    required this.homework,
    required this.auth,
  }) : super(key: key);

  @override
  State<CommentsByHomework> createState() => _CommentsByHomeworkState();
}

class _CommentsByHomeworkState extends State<CommentsByHomework> {
  final myController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentProvider(),
      child: Builder(builder: (context) {
        final commentProvider = context.read<CommentProvider>()
          ..getComments(widget.homework.id);

        return Consumer<CommentProvider>(
          builder: (_, commentState, child) {
            final comments = commentState.state;
            final reverseComments = comments.comments.reversed.toList();
            return SizedBox(
              child: Column(
                children: [
                  widget.isLogged
                      ? GestureDetector(
                          onTap: () {
                            showBottomMenuSheetAddOrEditComment(
                              context,
                              widget.homework.user.id,
                              commentProvider,
                              widget.auth,
                            );
                          },
                          child: SizedBox(
                            /* color: Colors.brown, */
                            child: Row(
                              children: [
                                ShowProfileImage(
                                  profileImage:
                                      widget.auth.user.profileImageUrl,
                                  userName: widget.auth.user.username,
                                  radius: 25,
                                ),
                                const SizedBox(width: 15),
                                const SimpleText(
                                  text: 'Agregar un comentario...',
                                  fontSize: 12,
                                  lightThemeColor: Colors.blueGrey,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  comments.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                  reverseComments.isNotEmpty
                      ? SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reverseComments.length,
                            itemBuilder: (_, index) {
                              return CommentCard(
                                comment: reverseComments[index],
                                homework: widget.homework,
                                auth: widget.auth,
                                commentProvider: commentProvider,
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
