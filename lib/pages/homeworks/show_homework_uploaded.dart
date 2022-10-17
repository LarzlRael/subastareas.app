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
      body: widget.showHomeworkParams.fileType == 'pdf'
          ? PdfType(
              pdfFlePath: pdfFlePath!,
            )
          : widget.showHomeworkParams.fileType.contains('image')
              ? ImageType(imagePath: widget.showHomeworkParams.fileUrl)
              : const Text('Error al cargar el archivo'),
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
}

/* class PdfType extends StatelessWidget {
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
 */