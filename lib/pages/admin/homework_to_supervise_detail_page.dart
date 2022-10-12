part of '../pages.dart';

class HomeworkToSuperviseDetailPage extends StatelessWidget {
  final HomeworkToSupervise homeworkToSupervise;
  const HomeworkToSuperviseDetailPage({
    Key? key,
    required this.homeworkToSupervise,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomeworkToSuperviseDetailPage'),
      ),
    );
  }
}
