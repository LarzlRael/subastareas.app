part of '../pages.dart';

class UploadHomeworkOfferedPage extends StatelessWidget {
  const UploadHomeworkOfferedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SimpleText(
            text: 'Titulo de la tarea',
          ),
          const SimpleText(
            text: 'tiempo de resolucion',
          ),
          const SimpleText(
            text: 'precio final en que se acordo',
          ),
          Container(
            child: const Text('Subir archivo'),
          ),
          ButtonWithIcon(label: 'Enviar', onPressed: () {})
        ],
      ),
    );
  }
}
