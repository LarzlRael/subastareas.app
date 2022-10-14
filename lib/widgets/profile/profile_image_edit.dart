part of '../widgets.dart';

class ProfileImageEdit extends StatefulWidget {
  final bool editable;
  final AuthServices auth;
  const ProfileImageEdit({
    Key? key,
    required this.auth,
    this.editable = true,
  }) : super(key: key);

  @override
  State<ProfileImageEdit> createState() => _ProfileImageEditState();
}

class _ProfileImageEditState extends State<ProfileImageEdit> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.editable) {
          _selectGalleryPhoto();
        } else {
          null;
        }
        /* await showDialog(context: context, builder: (_) => PublicProfilePage()); */
      },
      child: SizedBox(
        /* color: Colors.blue, */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40.0,
                  child: CircleAvatar(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: widget.editable
                          ? const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 15.0,
                                color: Color(0xFF404040),
                              ),
                            )
                          : null,
                    ),
                    radius: 38.0,
                    backgroundImage: widget.auth.user.profileImageUrl == null &&
                            _image == null
                        ? const NetworkImage(
                            'https://icon-library.com/images/no-profile-picture-icon-female/no-profile-picture-icon-female-24.jpg',
                          )
                        : _image == null
                            ? NetworkImage(widget.auth.user.profileImageUrl!)
                            : Image.file(_image!).image,
                  ),
                ),
              ),
            ),
            SimpleText(
              top: 5,
              text: widget.auth.user.username,
              lightThemeColor: Colors.white,
            ),
            SimpleText(
              top: 5,
              text: widget.auth.user.lastName,
              lightThemeColor: Colors.white,
            ),
            SimpleText(
              top: 5,
              text: widget.auth.user.nickName,
              lightThemeColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _selectGalleryPhoto() async {
    processImage(ImageSource.gallery);
  }

  processImage(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: origen,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.auth.updateProfileImage(_image!, widget.auth.user.id);
      } else {
        print('No image selected.');
      }
    });
  }
}
