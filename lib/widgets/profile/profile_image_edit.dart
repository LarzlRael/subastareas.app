part of '../widgets.dart';

class ProfileImageEdit extends StatefulWidget {
  final String username;
  final String? profileImage;
  final bool editable;
  const ProfileImageEdit({
    Key? key,
    required this.username,
    this.profileImage,
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
        /* if (widget.editable) {
          null;
        } else {
          _selectGalleryPhoto();
        } */
        await showDialog(context: context, builder: (_) => PublicProfilePage());
      },
      child: Container(
        /* color: Colors.blue, */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          ? CircleAvatar(
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
                    backgroundImage:
                        widget.profileImage == null && _image == null
                            ? const NetworkImage(
                                'https://icon-library.com/images/no-profile-picture-icon-female/no-profile-picture-icon-female-24.jpg',
                              )
                            : _image == null
                                ? NetworkImage(widget.profileImage!)
                                : Image.file(_image!).image,
                  ),
                ),
              ),
            ),
            SimpleText(
              top: 5,
              text: widget.username,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _selectGalleryPhoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: origen,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
