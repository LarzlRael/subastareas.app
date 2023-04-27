part of 'utils.dart';

List<Widget> adminOptions(BuildContext context) {
  return [
    CircleButton(
      color: Colors.blue,
      icon: Icons.home_work,
      text: 'Supervisar tarea',
      onPressed: () {
        Navigator.pushNamed(context, 'supervisor_list_homeworks');
      },
    ),
    CircleButton(
      color: Colors.purple,
      icon: FontAwesomeIcons.moneyBillTransfer,
      text: 'Solicitudes de retiro',
      onPressed: () {
        Navigator.pushNamed(context, 'list_withdraw_request');
      },
    ),
    CircleButton(
      color: Colors.green,
      icon: Icons.person_search,
      text: 'Usuarios',
      onPressed: () {
        Navigator.pushNamed(context, 'supervisor_list_homeworks');
      },
    ),
  ];
}

final List<Widget> bottomItemsWithoutLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const ProfilePage(),
];

final List<Widget> bottomItemsWithLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const UploadHomeworkPage(),
  const ProfilePage(),
];

List<BottomNavigationBarItem> bottonItemsWithLogin(bool isThereNotifications) {
  const iconSize = 18.0;
  return [
    const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.circleDollarToSlot,
        size: iconSize,
      ),
      label: 'Aportar',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.comment,
        size: iconSize,
      ),
      label: 'Preguntar',
    ),
    BottomNavigationBarItem(
      /* icon: Badge(
      child: const Icon(FontAwesomeIcons.user),
      badgeContent: null,
    ), */
      icon: isThereNotifications
          ? const badges.Badge(
              child: Icon(FontAwesomeIcons.user, size: iconSize),
              badgeContent: null,
            )
          : const Icon(
              FontAwesomeIcons.user,
              size: iconSize,
            ),
      label: 'Perfil',
    ),
  ];
}

final List<BottomNavigationBarItem> bottonItemsWithoutLogin = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.user),
    label: 'Perfil',
  ),
];

final homeworkServices = HomeworkServices();
/* final notificationServices = NotificationService(); */
List<StatelessWidget> menuProfileOptions(AuthServices authService) {
  final menuProfileOptions = [
    MenuProfileOption(
      icon: const Icon(
        Ionicons.wallet,
      ),
      title: "Billetera",
      page: WalletPage(),
    ),
    MenuProfileOption(
      icon: const BellIconNotification(),
      title: "Notificaciones",
      page: const NotificationPage(),
      callback: () => homeworkServices.clearNotifications(),
    ),
    MenuProfileOption(
      icon: const Icon(Icons.message_rounded),
      title: "Mensajes",
      showTrailing: true,
      page: WalletPage(),
    ),
    const MenuProfileOption(
      icon: Icon(Icons.task),
      title: "Mis tareas",
      page: MyHomeworksPage(),
    ),
    const MenuProfileOption(
      icon: Icon(Icons.currency_exchange_sharp),
      title: "Mis ofertas",
      page: MyOffers(),
    ),
    const MenuProfileOption(
      icon: Icon(Icons.task),
      title: "Tareas pendientes",
      page: PendingHomeworksOffersAccepts(),
    ),
    const MenuProfileOption(
      icon: Icon(Icons.settings),
      title: "Configuraciones",
      page: SettingsPage(),
    ),
    isAdmin(authService.user.userRols)
        ? const MenuProfileOption(
            icon: Icon(
              Icons.admin_panel_settings,
              color: Colors.green,
            ),
            title: "Administracion",
            page: SelectOption(),
          )
        : Container(),
    MenuProfileOption(
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
      title: "Cerrar sesión",
      page: WalletPage(),
      showTrailingIcon: false,
      closeSession: true,
    ),
  ];
  return menuProfileOptions;
}

List<Widget> tabsOptions() {
  const sizeTabIcon = 30.0;
  const colorTab = Colors.grey;
  return const [
    Tab(
      icon: Icon(Icons.image, size: sizeTabIcon, color: colorTab),
    ),
    Tab(
      icon: Icon(Icons.mic, size: sizeTabIcon, color: colorTab),
    ),
    Tab(
      icon: Icon(Icons.video_label_rounded, size: sizeTabIcon, color: colorTab),
    ),
  ];
}
