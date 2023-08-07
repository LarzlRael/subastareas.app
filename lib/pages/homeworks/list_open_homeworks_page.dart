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

    homeworksBloc.getHomeworksByCategory(
      filter.getListLevelSelected,
    );
    return Scaffold(
      appBar: AppBarTitle(
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        showFilterBottomMenuSheet(context);
                      },
                      child: const Row(
                        children: [
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
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: OpenHomeworkSearch());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: homeworksBloc.homeworksStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HomeworksModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: NoInformation(
                      message: 'No se encontraron tareas',
                      icon: Icons.search_off,
                      showButton: false,
                      iconButton: Icons.task,
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final homework = snapshot.data![index];
                      return HomeworkCard(
                        isLogged: auth.isLogged ? auth.isLogged : false,
                        homework: homework,
                        goTo: 'auctionPage',
                        isOwner: homework.user.id == auth.user.id,
                        /* homework: snapshot.data[index], */
                      );
                    },
                  ),
                );
              },
            ),
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
