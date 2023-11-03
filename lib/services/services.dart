import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/enviroments/enviroments_variables.dart'
    as environment;
import 'package:subastareaspp/pages/pages.dart';
import 'package:subastareaspp/utils/utils.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:subastareaspp/widgets/widgets.dart';

part 'request.dart';
part 'request_dio.dart';
part 'offers_services.dart';

part 'auth_services.dart';
part 'user_services.dart';
part 'comment_services.dart';
part 'push_notification_service.dart';
part 'sockets/socket_service.dart';
part 'sockets/socket_utils.dart';
part 'trade_services.dart';
part 'mail_services.dart';
part 'notification_service.dart';
part 'transaction_service.dart';
part 'supervise_services.dart';
part 'key_value/key_value_storage_service.dart';
part 'key_value/key_value_storage_service_impl.dart';
