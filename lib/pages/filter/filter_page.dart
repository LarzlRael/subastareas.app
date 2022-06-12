part of '../pages.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterProvider>(context, listen: false);
    final oneHomeworkBloc = OneHomeworkBloc();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            /* mainAxisAlignment: MainAxisAlignment.start, */
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nivel"),
              FilterItem(title: 'Pre universitario', type: 'level'),
              FilterItem(title: 'Universitario', type: 'level'),
              Text("Asignatura"),
              FilterItem(title: 'matematica', type: 'category'),
              FilterItem(title: 'fisica', type: 'category'),
              FilterItem(title: 'quimica', type: 'category'),
              FilterItem(title: 'algebra', type: 'category'),
              FilterItem(title: 'programacion', type: 'category'),
              FillButton(
                text: 'Filtrar',
                borderRadius: 100,
                onPressed: () {
                  /*  final homeworkServices = HomeworkServices();
                homeworkServices.getHomeworksByCategoryAndLevel(
                    state.getListCategorySelected, state.getListLevelSelected); */
                  oneHomeworkBloc.getHomeworksByCategory(
                      state.getListCategorySelected,
                      state.getListLevelSelected);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
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
