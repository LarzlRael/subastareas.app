part of '../widgets.dart';

class SquareLoading extends StatelessWidget {
  const SquareLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Center(
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: theme.getDarkTheme ? Colors.white70 : Colors.black45,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              SimpleText(
                text: 'Cargando ...',
                lightThemeColor: Colors.black38,
                darkThemeColor: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
