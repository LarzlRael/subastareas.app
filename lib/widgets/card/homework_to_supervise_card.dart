part of '../widgets.dart';

class HomeworkToSuperviseCard extends StatelessWidget {
  final String userName;
  final DateTime createdAt;
  final String? profileImageUrl;
  final String title;
  const HomeworkToSuperviseCard({
    Key? key,
    required this.userName,
    required this.createdAt,
    required this.title,
    this.profileImageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  showProfileImage(
                    null,
                    userName,
                    radius: 20,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      NameAndTimeAgo(
                        circle: true,
                        userName: userName,
                        createdAt: createdAt,
                        isRow: false,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SimpleText(
                text: title,
                lightThemeColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
