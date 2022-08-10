part of '../widgets.dart';

class CircularCenter extends StatelessWidget {
  const CircularCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
