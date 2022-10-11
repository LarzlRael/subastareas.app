part of '../pages.dart';

class ListOpenHomeworksPage extends StatefulWidget {
  const ListOpenHomeworksPage({Key? key}) : super(key: key);

  @override
  State<ListOpenHomeworksPage> createState() => _ListOpenHomeworksPageState();
}

class _ListOpenHomeworksPageState extends State<ListOpenHomeworksPage> {
  late int defaultChoiceIndex;
  OneHomeworkBloc homeworksBloc = OneHomeworkBloc();

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
    final theme = Provider.of<ThemeChanger>(context, listen: true);

    homeworksBloc.getHomeworksByCategory(
      filter.getListLevelSelected,
    );
    return Scaffold(
      appBar: AppBarTitle(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChipChoice(
              elementsList: filter.getListLevelSelected,
              onClickAction: (String value) {
                filter.removeItemFromList(value);
                homeworksBloc.getHomeworksByCategory(
                  filter.getListLevelSelected,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                child: GestureDetector(
                  onTap: () {
                    showFilterBottomMenuSheet(context);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                      ),
                      SimpleText(
                        text: 'Filtrar busqueda',
                        lightThemeColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: homeworksBloc.homeworksStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HomeworksModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      /* color: Colors.green, */
                      child: const NoInformation(
                        message: 'No se encontraron resultados',
                        icon: Icons.search_off,
                        showButton: false,
                        iconButton: Icons.abc,
                      ),
                    );
                  }
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeworkCard(
                      isLogged: auth.isLogged == null ? false : auth.isLogged,
                      homework: snapshot.data![index],
                      goTo: 'auctionPage',
                      /* homework: snapshot.data[index], */
                    );
                  },
                );
              },
            ),
            /* HomeworkCard(isLogged: auth.isLogged),
            HomeworkCard(isLogged: auth.isLogged), */
          ],
        ),
      ),
    );
  }
}

showFilterBottomMenuSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const SafeArea(child: FilterPage());
    },
  );
}
