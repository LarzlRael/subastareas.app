import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:subastareaspp/models/homework_only_text.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/enviroments/enviroments_variables.dart'
    as Environment;
import 'package:subastareaspp/utils/text_util.dart';
import 'package:subastareaspp/utils/validation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'request.dart';
part 'offers_services.dart';
part 'homework_services.dart';
part 'auth_services.dart';
part 'comment_services.dart';
part 'push_notification_service.dart';
part 'sockets/socket_service.dart';
part 'sockets/socket_utils.dart';
part 'trade_services.dart';
part 'mail_services.dart';
part 'transaction_service.dart';
