part of '../widgets.dart';

class ShowProfileImage extends StatelessWidget {
  final String? profileImage;
  final String userName;
  final double radius;

  const ShowProfileImage({
    Key? key,
    this.profileImage,
    this.radius = 30,
    required this.userName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage:
          profileImage == null ? null : NetworkImage(profileImage!),
      backgroundColor: Colors.grey,
      child: profileImage != null
          ? null
          : SimpleText(
              text: convertName(userName),
              fontSize: radius * 0.65,
              lightThemeColor: Colors.white,
            ),
    );
  }
}
