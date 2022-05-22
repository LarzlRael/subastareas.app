part of 'widgets.dart';

class BellIconNotification extends StatefulWidget {
  const BellIconNotification({
    Key? key,
  }) : super(key: key);

  @override
  State<BellIconNotification> createState() => _BellIconNotificationState();
}

class _BellIconNotificationState extends State<BellIconNotification> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
              setState(() {
                counter++;
              });
            }),
        if (counter != 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                counter > 9 ? '9+' : '$counter',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          Container()
      ],
    );
  }
}
