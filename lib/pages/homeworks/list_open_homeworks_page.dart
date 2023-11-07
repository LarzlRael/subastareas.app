part of '../pages.dart';

class ListOpenHomeworksPage extends StatefulWidget {
  const ListOpenHomeworksPage({Key? key}) : super(key: key);

  @override
  State<ListOpenHomeworksPage> createState() => _ListOpenHomeworksPageState();
}

class _ListOpenHomeworksPageState extends State<ListOpenHomeworksPage> {
  late int defaultChoiceIndex;
  late HomeworksProvider homeworksProvider;
  @override
  void initState() {
    super.initState();
    homeworksProvider = context.read<HomeworksProvider>();
    homeworksProvider.getHomeworks();
    defaultChoiceIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    final filter = Provider.of<FilterProvider>(context, listen: true);

    homeworksProvider.getHomeworksByCategory(
      filter.getListLevelSelected,
    );

    return Scaffold(
      appBar: AppBarTitle(
        appBar: AppBar(),
      ),
      body: Consumer<HomeworksProvider>(
        builder: (_, oneHomeworkProviderC, child) {
          final homeworksConsumer = homeworksProvider.state.homeworks;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ChipChoice(
                  elementsList: filter.getListLevelSelected,
                  onClickAction: (String value) {
                    filter.removeItemFromList(value);
                    homeworksProvider.getHomeworksByCategory(
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
                            context: context,
                            delegate: OpenHomeworkSearch(
                              homeworksProvider: oneHomeworkProviderC,
                            ));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                oneHomeworkProviderC.state.isLoadingHomeworks
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : homeworksConsumer.isEmpty
                        ? const Expanded(
                            child: NoInformation(
                              message: 'No se encontraron tareas',
                              icon: Icons.search_off,
                              showButton: false,
                              iconButton: Icons.task,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: homeworksConsumer.length,
                              itemBuilder: (_, int index) {
                                final homework = homeworksConsumer[index];
                                return HomeworkCard(
                                  isLogged:
                                      auth.isLogged ? auth.isLogged : false,
                                  homework: homework,
                                  isOwner: homework.user.id == auth.user.id,
                                  onSelected: (HomeworksModel homework) {
                                    context.push(
                                      '/homework_detail/${homework.id}',
                                    );
                                  },
                                );
                              },
                            ),
                          )
              ],
            ),
          );
        },
      ),
    );
  }

  showFilterBottomMenuSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const SafeArea(child: FilterPage()),
    );
  }
}
