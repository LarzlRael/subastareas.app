import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:subastareaspp/bloc/notificacion_bloc.dart';
import 'package:subastareaspp/bloc/one_homework_bloc.dart';
import 'package:subastareaspp/dialogs/dialogs.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/provider/filter_provider.dart';
import 'package:subastareaspp/services/services.dart';

import 'package:subastareaspp/utils/utils.dart';
import 'package:subastareaspp/widgets/slideshows/slideshow.dart';
import 'package:subastareaspp/widgets/text/text.dart';
import 'package:subastareaspp/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../widgets/buttons/buttons.dart';

part 'initialPresentation/welcome_page.dart';

part 'auth_pages/login_page.dart';
part 'auth_pages/register_page.dart';
part 'auth_pages/forgot_password_page.dart';
part 'auth_pages/verify_email_page.dart';

part 'auction_pages/auction_page.dart';
part 'auction_pages/auction_with_offer_page.dart';
part 'auction_pages/upload_homework_offered_page.dart';

part 'home_pages/upload_homework_page.dart';

part 'homeworks/list_open_homeworks_page.dart';
part 'homeworks/show_homework.dart';
part 'homeworks/show_homework_uploaded.dart';
part 'homeworks/verify_homework_resolved.dart';

part 'offers_pages/make_offer_page.dart';

part 'home_pages/bottom_navigation.dart';
part 'home_pages/categories_page.dart';

part 'user_pages/my_offers.dart';
part 'user_pages/my_homeworks_page.dart';

part 'user_pages/notification_page.dart';
part 'user_pages/my_profile_page.dart';
part 'user_pages/profile_page.dart';
part 'user_pages/settings_page.dart';
part 'user_pages/public_profile_page.dart';
part 'user_pages/pending_homeworks_offers_accepts.dart';
part 'user_pages/change_password.dart';

part 'filter/filter_page.dart';
part 'loading_page.dart';
part 'loading_page_parameters.dart';

part 'store_pages/store_page.dart';

part 'user_pages/homeworks/pending_offered_pending_homework.dart';
part 'user_pages/homeworks/uploaded_homework_user.dart';
part 'user_pages/homeworks/resolved_homework_user.dart';

part 'wallet/wallet_page.dart';
part 'wallet/withdraw_page.dart';
part 'wallet/withdraw_method_selected_page.dart';

part 'admin/select_option.dart';
part 'admin/supervisor_list_homeworks.dart';
part 'admin/homework_to_supervise_detail_page.dart';
part 'admin/list_withdraw_request.dart';
part 'admin/withdraw_request_detail_page.dart';
