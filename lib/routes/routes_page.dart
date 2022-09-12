import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/pages.dart';

final pageRoutes = <_Route>[
  _Route(
    icon: FontAwesomeIcons.wallet,
    titulo: 'Mi billetera',
    page: const WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.gear,
    titulo: 'Configuraciones',
    page: const WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.heading,
    titulo: 'Encabezados',
    page: const WalletPage(),
  ),
  _Route(
    icon: FontAwesomeIcons.fileContract,
    titulo: 'Terminos de uso',
    page: const WalletPage(),
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
