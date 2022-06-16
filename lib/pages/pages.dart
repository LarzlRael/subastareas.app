import 'dart:io';
import 'dart:math';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:provider/provider.dart';
import 'package:subastareaspp/bloc/one_homework_bloc.dart';
import 'package:subastareaspp/dialogs/dialogs.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/provider/filter_provider.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/data.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';
import 'package:subastareaspp/utils/text_util.dart';
import 'package:subastareaspp/utils/time_utils.dart';
import 'package:subastareaspp/utils/validation.dart';
import 'package:subastareaspp/widgets/slideshows/slideshow.dart';

import 'package:subastareaspp/widgets/text/text.dart';
import 'package:subastareaspp/widgets/widgets.dart';

import 'package:http/http.dart' as http;

import '../widgets/buttons/buttons.dart';

part 'auth_pages/login_page.dart';
part 'auth_pages/register_page.dart';
part 'auth_pages/forgot_password.dart';
part 'auction_pages/auction_page.dart';
part 'home_pages/upload_homework.dart';
part 'homeworks/list_open_homeworks_page.dart';
part 'loading_page.dart';
part 'offers_pages/make_offer_page.dart';
part 'homeworks/ShowHomework.dart';
part 'initialPresentation/welcome_page.dart';
part 'home_pages/bottom_navigation.dart';
part 'auction_pages/aution_with_offer_page.dart';
part 'user_pages/my_offers.dart';
part 'user_pages/my_homeworks_page.dart';
part 'user_pages/wallet_page.dart';
part 'home_pages/categories_page.dart';
part 'auth_pages/notification_page.dart';
part 'user_pages/my_profile_page.dart';
part 'user_pages/profile_page.dart';
part 'user_pages/settings_page.dart';
part 'user_pages/public_profile_page.dart';
part 'homeworks/my_homeworks.dart';
part 'filter/filter_page.dart';
part 'store_pages/store_page.dart';
