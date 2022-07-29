import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
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
    icon: Icon(FontAwesomeIcons.circleDollarToSlot),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.comment),
    label: 'Preguntar',
  ),
  BottomNavigationBarItem(
    icon: Badge(
      child: Icon(FontAwesomeIcons.user),
      badgeContent: null,
    ),
    label: 'Perfil',
  ),
];
final List<BottomNavigationBarItem> bottonItemsWithoutLogin = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.user),
    label: 'Perfil',
  ),
];

final homeworkServices = HomeworkServices();
List<MenuProfileOption> menuProfileOptions = [
  const MenuProfileOption(
    icon: Icon(
      Ionicons.wallet,
    ),
    title: "Billetera",
    page: WalletPage(),
  ),
  MenuProfileOption(
    icon: BellIconNotification(),
    title: "Notificaciones",
    page: NotificationPage(),
    callback: () => homeworkServices.clearNotifications(),
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
  /* const MenuProfileOption(
    icon: Icon(Icons.task_alt),
    title: "Pendientes",
    page: PendingsHomeworksOffersAcepts(),
  ), */
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
