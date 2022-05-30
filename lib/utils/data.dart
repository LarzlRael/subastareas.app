import 'package:flutter/material.dart';
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

final List<BottomNavigationBarItem> bottonItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_work),
    label: 'Preguntar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Perfil',
  ),
];

List<MenuProfileOption> getMenuProfileOptions() {
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
      icon: Icons.settings,
      title: "Ajustes",
      page: SettingsPage(),
    ),
    MenuProfileOption(
      icon: Icons.question_answer,
      title: "Cerrar sesión",
      page: WalletPage(),
    ),
  ];
}
