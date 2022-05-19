part of '../widgets.dart';

class CommentCard extends StatefulWidget {
  final String text;
  bool isExpanded;
  CommentCard({Key? key, required this.text, this.isExpanded = false})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard>
    with TickerProviderStateMixin<CommentCard> {
  late String firstHalf;
  late String secondHalf;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    /* double c_width = MediaQuery.of(context).size.width * 0.8; */
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
            /* backgroundImage: AssetImage('assets/images/avatar.png'), */
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameAndTimeAgo(),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  child: ConstrainedBox(
                    constraints: widget.isExpanded
                        ? const BoxConstraints()
                        : const BoxConstraints(maxHeight: 45.0),
                    /*     child: Text(
                      widget.text,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ), */
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.text,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
                widget.text.length > 75
                    ? widget.isExpanded
                        ? /*  Column(
                            children: [
                              ConstrainedBox(constraints: const BoxConstraints()),
                              TextButton(
                                  child: const Text('Mostrar menos'),
                                  onPressed: () =>
                                      setState(() => widget.isExpanded = false))
                            ],
                          ) */
                        ConstrainedBox(constraints: const BoxConstraints())
                        : TextButton(
                            child: const Text('Mostrar más'),
                            onPressed: () =>
                                setState(() => widget.isExpanded = true))
                    : Container(),
                Row(
                  children: [
                    SimpleText(
                      text: 'Responder',
                      color: Colors.grey,
                    ),
                    SizedBox(width: 20),
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
          text: 'DonalRice',
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
