part of 'pages.dart';

class ListOpenHomeworks extends StatefulWidget {
  const ListOpenHomeworks({Key? key}) : super(key: key);

  @override
  State<ListOpenHomeworks> createState() => _ListOpenHomeworksState();
}

class _ListOpenHomeworksState extends State<ListOpenHomeworks> {
  late int defaultChoiceIndex;
  final List<String> _choicesList = [
    'Matematica',
    'Programación',
    'Fisica',
    'Quimica',
    'Algebra',
    'Trigonometria',
    'Geometria',
  ];
  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChipChoice(
              elementsList: _choicesList,
              onClickAction: () {
                print('Selected: ${_choicesList[defaultChoiceIndex]}');
              },
            ),
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
