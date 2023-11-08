import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:subastareaspp/enviroments/enviroments_variables.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/theme/app_theme.dart';
/* import 'package:provider/provider.dart'; */
import 'package:subastareaspp/utils/utils.dart';
import 'package:http/http.dart' as http;
part 'filter_provider.dart'; // Filtros
part 'countdown_provider.dart'; // Countdown
part 'theme_provider.dart'; // Tema
part 'auth_provider.dart'; // Autenticación
part 'homeworks_provider.dart'; // Tareas
part 'notification_provider.dart'; // Notificaciones
part 'comment_provider.dart';
