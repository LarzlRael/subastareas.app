part of '../pages.dart';

class SelectOption extends StatelessWidget {
  const SelectOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: const Center(
        child: Text('Select Operation'),
      ),
    );
  }
}
