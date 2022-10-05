part of '../widgets.dart';

class ProfileCircleInformation extends StatelessWidget {
  const ProfileCircleInformation({
    Key? key,
    required this.publicProfile,
  }) : super(key: key);
  final PublicProfile publicProfile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        /* color: Colors.blue, */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: showProfileImage(
                  publicProfile.profileImageUrl,
                  publicProfile.name,
                  radius: 25,
                ),
              ),
            ),
            SimpleText(
              top: 5,
              text: publicProfile.name,
              lightThemeColor: Colors.white,
            ),
            SimpleText(
              top: 5,
              text: publicProfile.lastName,
              lightThemeColor: Colors.white,
            ),
            SimpleText(
              top: 5,
              text: publicProfile.nickName != null
                  ? publicProfile.nickName
                  : publicProfile.nickName,
              lightThemeColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
