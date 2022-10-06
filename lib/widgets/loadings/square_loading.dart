part of '../widgets.dart';

class SquareLoading extends StatelessWidget {
  const SquareLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            /* color: Colors.black45, */
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Cargando ...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
