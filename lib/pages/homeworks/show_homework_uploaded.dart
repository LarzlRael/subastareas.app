part of '../pages.dart';

class ShowHomeworkUploaded extends StatefulWidget {
  ShowHomeworkUploaded({
    Key? key,
    required this.showHomeworkParams,
  }) : super(key: key);
  ShowHomeworkParams showHomeworkParams;

  @override
  _ShowHomeworkUploadedState createState() => _ShowHomeworkUploadedState();
}

class _ShowHomeworkUploadedState extends State<ShowHomeworkUploaded> {
  late String sampleUrl;
  @override
  void initState() {
    loadPdf();
    super.initState();
    sampleUrl = widget.showHomeworkParams.fileUrl;
  }

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    /* if (await file.exists()) {
      return file.path;
    } */
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
          appBar: AppBar(),
          title: widget.showHomeworkParams.title.toCapitalized()),
      body: showFile(
        widget.showHomeworkParams.fileType,
        widget.showHomeworkParams.fileUrl,
      ),
      floatingActionButton: pdfFlePath != null
          ? FloatingActionButton(
              onPressed: () {
                //TODO dowloader function here
                Navigator.pushNamed(context, '/homeworks');
              },
              child: const Icon(Icons.download),
            )
          : null,
    );
  }

  Widget showFile(String fileType, String fileUrl) {
    if (fileType == 'pdf') {
      return PdfType(
        pdfFlePath: pdfFlePath!,
      );
    } else if (fileType.contains('image')) {
      return ImageType(imagePath: fileUrl);
    } else {
      return const Text('Error al cargar el archivo');
    }
  }
}
