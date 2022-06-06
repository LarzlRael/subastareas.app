import 'package:flutter/material.dart';
import 'package:subastareaspp/provider/filter_provider.dart';
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
  const ListOpenHomeworks(),
  ProfilePage(),
];

final List<Widget> bottomItemsWithLogin = <Widget>[
  const ListOpenHomeworks(),
  const UploadHomework(),
  ProfilePage(),
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

List<MenuProfileOption> getMenuProfileOptions(
    Future<dynamic> Function() onPress) {
  return [
    MenuProfileOption(
      icon: Icons.wallet_giftcard_rounded,
      title: "Cartera",
      page: WalletPage(),
    ),
    MenuProfileOption(
      icon: Icons.notifications_rounded,
      title: "Notificaciones",
      page: NotificationPage(),
    ),
    MenuProfileOption(
      icon: Icons.message_rounded,
      title: "Mensajes",
      showTrailing: true,
      page: WalletPage(),
    ),
    MenuProfileOption(
      icon: Icons.question_answer,
      title: "Mis tareas",
      page: WalletPage(),
    ),
    MenuProfileOption(
      icon: Icons.question_answer,
      title: "Mis ofertas",
      page: MyOffers(),
    ),
    MenuProfileOption(
      icon: Icons.question_answer,
      title: "Tus marcadores",
      page: WalletPage(),
      showTrailing: true,
    ),
    MenuProfileOption(
      icon: Icons.question_answer,
      title: "Cerrar sesión",
      page: WalletPage(),
      showTrailingIcon: false,
      onPressed: () async {
        await onPress();
      },
    ),
  ];
}

/* final List<CategoryFilter> listCategories = [
  CategoryFilter('Secundaria', 'level'),
  CategoryFilter('Pre universitario', 'level'),
  CategoryFilter('Universitario', 'level'),
  CategoryFilter('matematica', 'category'),
  CategoryFilter('fisica', 'category'),
  CategoryFilter('quimica', 'category'),
]; */
