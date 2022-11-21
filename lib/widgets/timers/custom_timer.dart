import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subastareaspp/provider/providers.dart';
import 'package:subastareaspp/utils/utils.dart';

class CustomTimer extends StatelessWidget {
  final DateTime resolutionTime;

  const CustomTimer({
    Key? key,
    required this.resolutionTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CountdownProvider with parameters

    /*   final countDownProvider = Provider.of<CountdownProvider>(context);
    /* Datetime to duration */

    print('final;: ' + getDateDiff(resolutionTime).inSeconds.toString());
    /* countDownProvider.setCountdownDuration(getDateDiff(resolutionTime)); */

    /* countDownProvider.startStopTimer(); */
    return Text(context
        .select((CountdownProvider countDown) => countDown.timeLeftString)); */
    return ChangeNotifierProvider(
      create: (_) => CountdownProvider(),
      child: Builder(
        builder: (context) {
          Provider.of<CountdownProvider>(context).setCountdownDuration(
            getDateDiff(resolutionTime),
          );
          /* Provider.of<CountdownProvider>(context).startStopTimer(); */
          return Text(Provider.of<CountdownProvider>(context).timeLeftString);
        },
      ),
    );
  }

  int isEnd() {
    return DateTime.now().millisecondsSinceEpoch +
        getDateDiff(resolutionTime).inMilliseconds;
  }
}
