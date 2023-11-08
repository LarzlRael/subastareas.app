part of '../widgets.dart';

class OpenHomeworkSearch extends SearchDelegate {
  @override
  final String searchFieldLabel;
  final HomeworksProvider homeworksProvider;
  OpenHomeworkSearch({required this.homeworksProvider})
      : searchFieldLabel = 'Buscar tarea por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    homeworksProvider.getSearchedHomeworks(query);

    if (homeworksProvider.state.isLoadingSelected) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.75,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (homeworksProvider.state.homeworks.isEmpty) {
      return NoInformation(
        message: 'No se encontraron tareas con $query',
        icon: Icons.search_off,
        showButton: false,
        iconButton: Icons.task,
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: homeworksProvider.state.homeworks.length,
      itemBuilder: (BuildContext context, int index) {
        final homework = homeworksProvider.state.homeworks[index];
        return Builder(
            builder: (BuildContext context) => HomeworkCard(
                  isLogged: context.select((AuthProvider auth) =>
                      auth.isLogged ? auth.isLogged : false),
                  homework: homework,
                  isOwner: context.select(
                      (AuthProvider auth) => homework.user.id == auth.user.id),
                  onSelected: (homework) {
                    context.push('/homework_detail/${homework.id}');
                  },
                ));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /* historyBloc.getAllHistory();

    if (query.isEmpty) {
      return StreamBuilder(
        stream: historyBloc.scansStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<HistoryModel>> snapshot) {
          if (snapshot.hasData) {
            return listViewBlocHistory(snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      final suggestionList = shopData
          .where((element) =>
              element.shopName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return suggestionList.isEmpty
          ? NoResults(
              icon: Icons.search_off,
              message: 'No hay resultados para "$query"',
              showButton: false,
              iconButton: Icons.search_off,
            )
          : listViewItems(suggestionList);
    } */
    return const Text('build Suggestions');
  }

/* ListView listViewItems(List<ShopModel> suggestionList) {
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return renderItemList(context, suggestionList[i], true);
      },
    );
  }

  ListView listViewBlocHistory(List<HistoryModel> suggestionList) {
    final pinterHistory = suggestionList
        .map((e) => shopData.firstWhere(((shopData) {
              if (shopData.shopName == (e.querySearched)) {
                shopData.id = e.id;
              }
              return shopData.shopName == (e.querySearched);
            })))
        .toList();

    return ListView.builder(
      itemCount: pinterHistory.length,
      itemBuilder: (context, i) {
        return renderItemList(context, pinterHistory[i], false);
      },
    );
  }

  Widget renderItemList(
      BuildContext context, ShopModel suggestionItem, bool registerHistory) {
    final double sizeImage = 40;
    if (!registerHistory) {
      return ListTile(
          leading: const Icon(Icons.history),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(suggestionItem.imageAsset,
                width: sizeImage, height: sizeImage),
          ),
          title: Text(suggestionItem.shopName.toTitleCase()),
          onLongPress: () => showAlertDialog(
                  context,
                  "Eliminar de historial",
                  SimpleText(
                      text:
                          "¿Desea eliminar ${suggestionItem.shopName.toTitleCase()} de su historial?"),
                  () async {
                await historyBloc.deleteHistoryById(suggestionItem.id!);
                historyBloc.getAllHistory();
              }),
          onTap: () => launchURL(suggestionItem.goToUrl));
    }
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(suggestionItem.imageAsset,
            width: sizeImage, height: sizeImage),
      ),
      title: Text(suggestionItem.shopName.toTitleCase()),
      onTap: () {
        launchURL(suggestionItem.goToUrl);
        if (registerHistory) {
          historyBloc
              .newHistory(HistoryModel(querySearched: suggestionItem.shopName));
        }
      },
    );
  }
*/
}
