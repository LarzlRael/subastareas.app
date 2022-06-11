import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:subastareaspp/enviroments/enviroments_variables.dart'
    as Enviroments;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:subastareaspp/models/homeworks_model.dart';
import 'package:subastareaspp/models/one_homework_model.dart';
import 'package:subastareaspp/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:subastareaspp/utils/validation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

part 'request.dart';
part 'offers_services.dart';
part 'homework_services.dart';
part 'auth_services.dart';
part 'comment_services.dart';
part 'google_services.dart';
part 'push_notification_service.dart';
