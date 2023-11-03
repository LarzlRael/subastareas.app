part of '../pages.dart';

class ShowHomework extends StatefulWidget {
  const ShowHomework({
    Key? key,
    required this.homework,
  }) : super(key: key);
  final Homework homework;

  @override
  _ShowHomeworkState createState() => _ShowHomeworkState();
}

class _ShowHomeworkState extends State<ShowHomework> {
  late String sampleUrl;
  @override
  void initState() {
    loadPdf();
    super.initState();
    sampleUrl = widget.homework.fileUrl!;
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
          appBar: AppBar(), title: widget.homework.title.toCapitalized()),
      body: widget.homework.fileType == 'pdf'
          ? PdfType(
              pdfFlePath: pdfFlePath!,
            )
          : widget.homework.fileType.contains('image')
              ? ImageType(imagePath: widget.homework.fileUrl)
              : const Text('Error al cargar el archivo'),
      floatingActionButton: pdfFlePath != null
          ? FloatingActionButton(
              onPressed: () {
                //TODO dowloader function here

                context.push('/homeworks');
              },
              child: const Icon(Icons.download),
            )
          : null,
    );
  }
}

class PdfType extends StatelessWidget {
  const PdfType({
    Key? key,
    required this.pdfFlePath,
  }) : super(key: key);

  final String? pdfFlePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          /* ElevatedButton(
            child: Text("Descargar pdf"),
            onPressed: () async {
              final taskId = await FlutterDownloader.enqueue(
                url: sampleUrl,
                savedDir:
                    'the path of directory where you want to save downloaded files',
                showNotification:
                    true, // show download progress in status bar (for Android)
                openFileFromNotification:
                    true, // click on notification to open downloaded file (for Android)
              );
            },
          ), */
          if (pdfFlePath != null)
            Expanded(
              child: PdfView(path: pdfFlePath!),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class ImageType extends StatelessWidget {
  const ImageType({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          if (imagePath != null)
            Expanded(
                child: FadeInImage.assetNetwork(
              placeholder: 'assets/icon.png',
              fit: BoxFit.contain,
              image: imagePath!,
            ))
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
