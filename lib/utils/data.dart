import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/buttons/buttons.dart';

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

final List<BottomNavigationBarItem> bottonItemsNotLogin = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_work),
    label: 'Tareas',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Categorias',
  ),
];
final List<BottomNavigationBarItem> bottonItemsLogin = [
  ...bottonItemsNotLogin,
  const BottomNavigationBarItem(
    icon: Icon(Icons.list),
    label: 'Ofertas',
  ),
];
