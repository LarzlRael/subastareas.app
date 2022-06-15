part of '../widgets.dart';

class ProfileCardWithStars extends StatelessWidget {
  final Color backgroundColor;
  const ProfileCardWithStars({
    Key? key,
    required this.auth,
    this.backgroundColor = Colors.black45,
  }) : super(key: key);

  final AuthServices auth;

  @override
  Widget build(BuildContext context) {
    const double sizeStart = 25;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      width: double.infinity,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*   CircleAvatar(
                radius: 50,
                child: showProfileImage(
                  auth.usuario.profileImageUrl,
                  auth.usuario.username,
                ),
              ), */
              /* showProfileImage(auth.usuario.profileImageUrl,
                  auth.usuario.username, 50), 
                  */
              ProfileImageEdit(
                username: auth.usuario.username,
                profileImage: auth.usuario.profileImageUrl,
                editable: false,
              ),
              /*  const SizedBox(
                height: 10,
              ),
              */
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                /* crossAxisAlignment: CrossAxisAlignment.center, */
                children: const [
                  ProfileCard(amount: 20, title: 'Seguidores'),
                  ProfileCard(amount: 44, title: 'Seguidores'),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: sizeStart,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: sizeStart,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: sizeStart,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: sizeStart,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: sizeStart,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
