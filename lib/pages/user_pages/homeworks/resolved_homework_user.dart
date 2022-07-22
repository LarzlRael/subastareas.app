part of '../../pages.dart';

class ResolvedHomeworkUser extends StatelessWidget {
  final HomeworkServices homeworkServices;
  const ResolvedHomeworkUser({Key? key, required this.homeworkServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final getOffers = homeworkServices.getHomeworksResolvedByUser();
    /* print('getOffers: $getOffers'); */
    inspect(getOffers);
    return Scaffold(
      body: Center(
        child: Text('ResolvedHomeworkUser'),
      ),
    );
  }
}
