import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/widgets.dart';

class ListOpenHomeworks extends StatelessWidget {
  const ListOpenHomeworks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
            HomeworkCard(),
          ],
        ),
      ),
    );
  }
}
