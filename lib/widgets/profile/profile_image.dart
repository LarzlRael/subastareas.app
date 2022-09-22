part of '../widgets.dart';

class ProfileImage extends StatelessWidget {
  final String? profileImage;
  final String userName;
  final double radius;
  final int index;
  final int id;
  const ProfileImage({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.index,
    required this.id,
    this.radius = 30,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: index * 80),
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(right: 3),
        child: CircleAvatar(
          radius: radius,
          child: profileImage != null
              ? null
              : SimpleText(
                  text: convertName(userName),
                  fontSize: radius * 0.65,
                  lightThemeColor: Colors.white,
                ),
          backgroundImage:
              profileImage == null ? null : NetworkImage(profileImage!),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
