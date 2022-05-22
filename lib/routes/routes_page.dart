import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageRoutes = <_Route>[
  _Route(
    icon: FontAwesomeIcons.slideshare,
    titulo: 'Slideshow',
  ),
  _Route(
    icon: FontAwesomeIcons.truckMedical,
    titulo: 'Emergencia',
  ),
  _Route(
    icon: FontAwesomeIcons.heading,
    titulo: 'Encabezados',
  ),
];

class _Route {
  final IconData icon;
  final String titulo;
  /* final Widget page; */

  _Route({
    required this.icon,
    required this.titulo,
    /* required this.page, */
  });
}
