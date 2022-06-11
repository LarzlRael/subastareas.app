part of '../pages.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          /* mainAxisAlignment: MainAxisAlignment.start, */
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nivel"),
            FilterItem(title: 'Secundaria', type: 'level'),
            FilterItem(title: 'Pre universitario', type: 'level'),
            FilterItem(title: 'Universitario', type: 'level'),
            Text("Asignatura"),
            FilterItem(title: 'matematica', type: 'category'),
            FilterItem(title: 'fisica', type: 'category'),
            FilterItem(title: 'quimica', type: 'category'),
            ElevatedButton(
              child: Text('Filtrar'),
              onPressed: () {
                /*  final homeworkServices = HomeworkServices();
                homeworkServices.getHomeworksByCategoryAndLevel(
                    state.getListCategorySelected, state.getListLevelSelected); */
                Navigator.of(context).pop();
              },
            ),
          ],
        )),
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  final String title;
  final String type;
  const FilterItem({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);
  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: false);
    /* isSelected = provider..contains(widget.title); */
    isSelected = provider.getListAllSelected.contains(widget.title);
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 2.5, color: Colors.blue),
      ),
      title: Text(widget.title),
      value: isSelected,
      onChanged: (value) {
        setState(() {
          if (widget.type == 'level') {
            provider.setAddListLevelSelected = widget.title;
          } else {
            provider.setAddListCategorySelected = widget.title;
          }
          isSelected = value!;
        });
      },
      secondary: const CircleAvatar(),
    );
  }
}

/* class _FilterStateModel with ChangeNotifier {
  final List<String> _listLevelSelected = [];
  final List<String> _listCategorySelected = [];

  List<String> get getListLevelSelected => _listLevelSelected;
  set setAddListLevelSelected(String value) {
    if (_listLevelSelected.contains(value)) {
      _listLevelSelected.remove(value);
    } else {
      _listLevelSelected.add(value);
    }
    notifyListeners();
  }

  List<String> get getListCategorySelected => _listCategorySelected;
  set setAddListCategorySelected(String value) {
    if (_listCategorySelected.contains(value)) {
      _listCategorySelected.remove(value);
    } else {
      _listCategorySelected.add(value);
    }
    notifyListeners();
  }
}
 */