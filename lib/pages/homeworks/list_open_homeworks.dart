part of '../pages.dart';

class ListOpenHomeworks extends StatefulWidget {
  const ListOpenHomeworks({Key? key}) : super(key: key);

  @override
  State<ListOpenHomeworks> createState() => _ListOpenHomeworksState();
}

class _ListOpenHomeworksState extends State<ListOpenHomeworks> {
  late int defaultChoiceIndex;
  /* final List<String> _choicesList = [
    'Matematica',
    'Programación',
    'Fisica',
    'Quimica',
    'Algebra',
    'Trigonometria',
    'Geometria',
  ]; */
  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    final filter = Provider.of<FilterProvider>(context, listen: true);
    final homework = HomeworkServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                ChipChoice(
                  elementsList: filter.getListAllSelected,
                  onClickAction: (String value) {
                    filter.removeItemFromList(value);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    showFilterBottomMenuShet(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                      ),
                      SimpleText(
                        text: 'Filtrar busqueda',
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),

                /* HomeworkCard(isLogged: auth.isLogged),
                HomeworkCard(isLogged: auth.isLogged), */
                FutureBuilder(
                  future: homework.gethomeworks(),
                  /* initialData: InitialData, */
                  builder: (BuildContext context,
                      AsyncSnapshot<List<HomeworkModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeworkCard(
                            isLogged: auth.isLogged,
                            homework: snapshot.data![index],

                            /* homework: snapshot.data[index], */
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showFilterBottomMenuShet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SafeArea(child: FilterPage());
    },
  );
}
