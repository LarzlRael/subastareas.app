import 'package:flutter/material.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/widgets/buttons/buttons.dart';
import 'package:subastareaspp/widgets/widgets.dart';
import 'package:subastareaspp/pages/pages.dart';

List<Widget> categoryList = [
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
    color: Colors.purpleAccent,
    icon: Icons.directions_bike,
    text: 'Programación',
    onPressed: () {},
  ),
  CircleButton(
    color: Colors.purpleAccent,
    icon: Icons.directions_bike,
    text: 'Programación',
    onPressed: () {},
  ),
];

final List<Widget> bottomItemsWithoutLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const ProfilePage(),
];

final List<Widget> bottomItemsWithLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const UploadHomeworkPage(),
  const ProfilePage(),
];

final List<BottomNavigationBarItem> bottonItemsWithLogin = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.question_answer),
    label: 'Preguntar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Perfil',
  ),
];
final List<BottomNavigationBarItem> bottonItemsWithoutLogin = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Perfil',
  ),
];

final homeworServices = HomeworkServices();
List<MenuProfileOption> menuProfileOptions = [
  const MenuProfileOption(
    icon: Icon(Icons.wallet_giftcard_rounded),
    title: "Billetera",
    page: WalletPage(),
  ),
  MenuProfileOption(
    icon: BellIconNotification(),
    title: "Notificaciones",
    page: NotificationPage(),
    callback: () => homeworServices.clearNotifications(),
  ),
  const MenuProfileOption(
    icon: Icon(Icons.message_rounded),
    title: "Mensajes",
    showTrailing: true,
    page: WalletPage(),
  ),
  const MenuProfileOption(
    icon: Icon(Icons.task),
    title: "Mis tareas",
    page: MyHomeworksPage(),
  ),
  const MenuProfileOption(
    icon: Icon(Icons.currency_exchange_sharp),
    title: "Mis ofertas",
    page: MyOffers(),
  ),
  const MenuProfileOption(
    icon: Icon(Icons.question_answer),
    title: "Tus marcadores",
    page: WalletPage(),
    showTrailing: true,
  ),
  const MenuProfileOption(
    icon: Icon(Icons.exit_to_app),
    title: "Cerrar sesión",
    page: WalletPage(),
    showTrailingIcon: false,
    closeSession: true,
  ),
];


/* final List<CategoryFilter> listCategories = [
  CategoryFilter('Secundaria', 'level'),
  CategoryFilter('Pre universitario', 'level'),
  CategoryFilter('Universitario', 'level'),
  CategoryFilter('matematica', 'category'),
  CategoryFilter('fisica', 'category'),
  CategoryFilter('quimica', 'category'),
]; */
