import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/pages.dart';

final pageRoutes = <_Route>[
  _Route(
    icon: FontAwesomeIcons.wallet,
    titulo: 'Mi billetera',
    page: WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.gear,
    titulo: 'Configuraciones',
    page: WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.heading,
    titulo: 'Encabezados',
    page: WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.fileContract,
    titulo: 'Terminos de uso',
    page: WalletPage(),
  ),
];

class _Route {
  final IconData icon;
  final String titulo;
  final Widget page;

  _Route({
    required this.icon,
    required this.titulo,
    required this.page,
  });
}
