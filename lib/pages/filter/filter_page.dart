part of '../pages.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterProvider>(context, listen: false);
    final oneHomeworkBloc = OneHomeworkBloc();
    final homeworkServices = HomeworkServices();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 5),
          child: FutureBuilder(
            future: homeworkServices.getSubjectAndLevels(),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SimpleText(
                      text: "Asignatura",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FilterItem(
                                title: snapshot.data![index], type: 'level');
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: Colors.blue,
                            );
                          }),
                    ),
                    FillButton(
                      text: 'Filtrar',
                      borderRadius: 100,
                      onPressed: () {
                        /*  final homeworkServices = HomeworkServices();
                homeworkServices.getHomeworksByCategoryAndLevel(
                    state.getListCategorySelected, state.getListLevelSelected); */
                        oneHomeworkBloc.getHomeworksByCategory(
                          state.getListLevelSelected,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
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
    isSelected = provider.getListLevelSelected.contains(widget.title);
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
            provider.setAddListLevelSelected = widget.title;
          }
          isSelected = value!;
        });
      },
      secondary: const Icon(Icons.add),
    );
  }
}
