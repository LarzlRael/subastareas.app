part of '../pages.dart';

class ListOpenHomeworksPage extends StatefulWidget {
  const ListOpenHomeworksPage({Key? key}) : super(key: key);

  @override
  State<ListOpenHomeworksPage> createState() => _ListOpenHomeworksPageState();
}

class _ListOpenHomeworksPageState extends State<ListOpenHomeworksPage> {
  late int defaultChoiceIndex;
  OneHomeworkBloc homeworksBloc = OneHomeworkBloc();
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
  void dispose() {
    /* homeworksBloc.dispose(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    final filter = Provider.of<FilterProvider>(context, listen: true);

    homeworksBloc.getHomeworks();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo_with_letters.png',
          height: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChipChoice(
              elementsList: filter.getListAllSelected,
              onClickAction: (String value) {
                filter.removeItemFromList(value);
                homeworksBloc.getHomeworksByCategory(
                  filter.getListCategorySelected,
                );
              },
            ),
            GestureDetector(
              onTap: () {
                showFilterBottomMenuShet(context);
              },
              child: Row(
                children: const [
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
            StreamBuilder(
              stream: homeworksBloc.homeworksStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HomeworksModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return NoInformation(
                      message: 'No se encontraron resultados',
                      icon: Icons.search_off,
                      showButton: false,
                      iconButton: Icons.abc,
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeworkCard(
                          isLogged:
                              auth.isLogged == null ? false : auth.isLogged,
                          homework: snapshot.data![index],

                          /* homework: snapshot.data[index], */
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
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
      return const SafeArea(child: FilterPage());
    },
  );
}
