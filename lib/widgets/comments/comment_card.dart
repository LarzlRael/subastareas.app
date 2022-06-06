part of '../widgets.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  bool isExpanded;
  CommentCard({Key? key, this.isExpanded = false, required this.comment})
      : super(key: key);

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
    /* double c_width = MediaQuery.of(context).size.width * 0.8; */
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            child: showProfileImage(widget.comment.user.profileImageUrl,
                widget.comment.user.username),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameAndTimeAgo(),
                DesplegableComment(
                  text: widget.comment.content,
                  isExpanded: widget.isExpanded,
                  limit: 75,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: SimpleText(
                        text: 'Me gusta',
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                showBottomMenuShet();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }

  Row _nameAndTimeAgo() {
    return Row(
      children: [
        SimpleText(
          text: widget.comment.user.username,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(width: 15),
        SimpleText(
          text: '5 min ago',
          color: Colors.grey,
        ),
      ],
    );
  }

  showBottomMenuShet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar comentario'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar'),
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
