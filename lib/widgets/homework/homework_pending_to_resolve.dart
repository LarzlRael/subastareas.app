part of '../widgets.dart';

class HomeworkPendingToResolve extends StatelessWidget {
  final TradeUserModel tradeUserModel;

  const HomeworkPendingToResolve({
    Key? key,
    required this.tradeUserModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          '/verify_homework_resolved',
          extra: tradeUserModel,
        );
      },
      child: SizedBox(
        /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Column(
                      children: [
                        /* NameAndTimeAgo(
                              isOwner: true,
                              userName: homeworkToSupervise.user.username,
                              createdAt: homeworkToSupervise.createdAt,
                              isRow: false,
                            ), */
                      ],
                    ),
                    const SizedBox(height: 10),
                    SimpleText(
                      top: 10,
                      text: tradeUserModel.title.length > 25
                          ? '${tradeUserModel.title.substring(0, 25)}...'
                              .toCapitalized()
                          : tradeUserModel.title.toCapitalized(),
                      bottom: 10,
                    ),
                    tradeUserModel.status == 'pending_to_accept'
                        ? Column(
                            children: [
                              const SimpleText(
                                top: 3,
                                text: 'Tiempo restante: ',
                                lightThemeColor: Colors.black,
                                bottom: 3,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              Timer(
                                endTime: tradeUserModel.resolutionTime,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SimpleText(
                      text: tradeUserModel.category.toUpperCase(),
                      lightThemeColor: Colors.black,
                      bottom: 10,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/public_profile_page/${tradeUserModel.id}');
                  },
                  child: Column(
                    children: [
                      const SimpleText(
                        text: 'Resuelto por: ',
                        bottom: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ShowProfileImage(
                          profileImage: tradeUserModel.profileImageUrl,
                          userName: tradeUserModel.username,
                          radius: 18,
                        ),
                      ),
                      SimpleText(
                        top: 5,
                        text: tradeUserModel.username.toCapitalized(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
