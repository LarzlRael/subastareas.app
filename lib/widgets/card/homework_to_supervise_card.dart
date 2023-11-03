part of '../widgets.dart';

class HomeworkToSuperviseCard extends StatelessWidget {
  final HomeworkToSupervise homeworkToSupervise;
  const HomeworkToSuperviseCard({
    Key? key,
    required this.homeworkToSupervise,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/homework_detail/${homeworkToSupervise.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ShowProfileImage(
                      profileImage: homeworkToSupervise.user.profileImageUrl,
                      userName: homeworkToSupervise.user.username,
                      radius: 18,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        NameAndTimeAgo(
                          isOwner: true,
                          userName: homeworkToSupervise.user.username,
                          createdAt: homeworkToSupervise.createdAt,
                          isRow: false,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SimpleText(
                  text: homeworkToSupervise.title,
                  lightThemeColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
