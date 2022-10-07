part of 'utils.dart';

const Iterable<LocalizationsDelegate<dynamic>>? formBuildersDelegates = [
  FormBuilderLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

const Iterable<Locale> supportedLocales = [
  Locale('en', ''),
  Locale('es', ''),
  Locale('fr', ''),
  Locale('ja', ''),
  Locale('pt', ''),
];
final List<ChangeNotifierProvider<ChangeNotifier>> providers = [
  ChangeNotifierProvider(create: (_) => AuthServices()),
  ChangeNotifierProvider(create: (_) => SocketService()),
  ChangeNotifierProvider(create: (_) => FilterProvider()),
];
