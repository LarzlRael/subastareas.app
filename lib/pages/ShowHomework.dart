import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class ShowHomework extends StatefulWidget {
  const ShowHomework({Key? key}) : super(key: key);

  @override
  _ShowHomeworkState createState() => _ShowHomeworkState();
}

class _ShowHomeworkState extends State<ShowHomework> {
  @override
  void initState() {
    loadPdf();
    super.initState();
  }

  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
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
      appBar: AppBar(
        title: Text('Esta es mi tarea ayuda plox'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
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
            ),
            if (pdfFlePath != null)
              Expanded(
                child: PdfView(path: pdfFlePath!),
              )
            else
              Text("Pdf is not Loaded"),
          ],
        ),
      ),
    );
  }
}
