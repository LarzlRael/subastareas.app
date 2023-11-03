import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:subastareaspp/bloc/homeworks_provider.dart';
import 'package:subastareaspp/dialogs/dialogs.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/provider/providers.dart';
import 'package:subastareaspp/routes/app_router.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/utils.dart';
import 'package:subastareaspp/widgets/buttons/buttons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:subastareaspp/widgets/text/text.dart';
import 'package:subastareaspp/pages/pages.dart';
import '../routes/routes_page.dart';

part 'text/description_text.dart';
part 'offers/person_offer_card.dart';
part 'offers/person_offer_horizontal.dart';
part 'menu/float_menu.dart';
part 'timers/timer_counter.dart';
part 'timers/timer.dart';
part 'comments/comment_card.dart';
part 'comments/comments_by_homeworks.dart';
part 'comments/desplegable_comment.dart';
part 'homework/homework_card.dart';
part 'circle_avatar_group.dart';
part 'forms/chip_choice.dart';
part 'notifications/bell_icon_notification.dart';
part 'menu/drawer_menu.dart';
part 'forms/custom_formbuilder_text_field.dart';
part 'forms/custom_row_formbuilder_text_field.dart';
part 'forms/custom_date_picker.dart';
part 'forms/input_container.dart';
part 'forms/custom_formbuilder_text_area.dart';
part 'forms/custom_formbuilder_fetch_dropdown.dart';
part 'forms/custom_dropdown.dart';
part 'login_register/label_login_register.dart';
part 'login_register/header_login_register.dart';
part 'login_register/app_bar_title.dart';
part 'slideshows/slide_item.dart';
part 'slideshows/slideshow.dart';
part 'menu/profile_menu.dart';
part 'filter/list_filter.dart';
part 'notifications/global_snack_bar.dart';
part 'wallet/transaction_card.dart';
part 'store/store_card.dart';
part 'no_information/no_information.dart';

part 'profile/profile_image_edit.dart';
part 'profile/profile_card_with_stars.dart';
part 'profile/profile_image.dart';
part 'profile/profile_circle_information.dart';

part 'notifications/notifications_card.dart';
part 'notifications/handle_notification_interactive.dart';

part 'forms/custom_file_field.dart';
part 'homework/homework_pending_to_resolve.dart';

/* Loading */
part 'loadings/circular_center.dart';
part 'loadings/square_loading.dart';

part 'list_tiles/generic_list_tile.dart';
/* Common */
part 'common/app_bar_with_back_icon.dart';
part 'common/show_profile_image.dart';

/* ListViews */
/* part 'listView/future_list_view_with_loading.dart'; */
part 'card/homework_to_supervise_card.dart';
part 'card/name_and_time_ago.dart';
part 'card/withdraw_request_card.dart';

/* Searches delegates */
part 'search/open_homework_search.dart';

/* Errors */
part 'errors/no_results.dart';
