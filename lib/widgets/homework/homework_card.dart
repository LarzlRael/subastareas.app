part of '../widgets.dart';

class HomeworkArguments {
  int idHomework;
  int idUser;

  HomeworkArguments(
    this.idHomework,
    this.idUser,
  );
}

class HomeworkCard extends StatelessWidget {
  final bool isLogged;
  final HomeworksModel homework;
  final bool? isOwner;
  final void Function(HomeworksModel homework)? onSelected;
  const HomeworkCard({
    Key? key,
    required this.isLogged,
    required this.homework,
    this.isOwner = false,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (onSelected != null) {
          onSelected!(homework);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          /* color: Colors.white, */
          borderRadius: BorderRadius.circular(10),
          border: isOwner!
              ? Border.all(
                  color: Colors.green,
                  width: 2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.25,
              height: size.height * 0.15,
              child: Hero(
                tag: homework.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/category/${removeDiacritics(homework.category)}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: homework.title.length > 60
                        ? homework.title.toCapitalized().substring(0, 60) +
                            ' ...'
                        : homework.title.toCapitalized(),
                    fontSize: 16,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.w700,
                    lightThemeColor: Colors.black54,
                    darkThemeColor: Colors.white54,
                  ),
                  SimpleText(
                    top: 5,
                    bottom: 5,
                    text: homework.category,
                    fontSize: 16,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.bold,
                    lightThemeColor: Colors.black45,
                    darkThemeColor: Colors.white54,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: SimpleText(
                          text: getDateDiffString(homework.resolutionTime),
                          lightThemeColor: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /* const SizedBox(width: 10), */
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: '\$ ${homework.offeredAmount}',
                    lightThemeColor: Colors.lightGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 5),
                  homework.offers!.isNotEmpty
                      ? SimpleText(
                          text: '${homework.offers!.length} ofertas',
                          lightThemeColor: Colors.grey,
                          darkThemeColor: Colors.white54,
                          fontSize: 18,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
