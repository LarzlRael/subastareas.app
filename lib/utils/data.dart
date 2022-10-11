part of 'utils.dart';

List<Widget> categoryList = [
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
      color: Colors.blue,
      icon: Icons.food_bank,
      text: 'Matematica',
      onPressed: () {}),
  CircleButton(
    color: Colors.purpleAccent,
    icon: Icons.directions_bike,
    text: 'Programación',
    onPressed: () {},
  ),
  CircleButton(
    color: Colors.purpleAccent,
    icon: Icons.directions_bike,
    text: 'Programación',
    onPressed: () {},
  ),
];

final List<Widget> bottomItemsWithoutLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const ProfilePage(),
];

final List<Widget> bottomItemsWithLogin = <Widget>[
  const ListOpenHomeworksPage(),
  const UploadHomeworkPage(),
  const ProfilePage(),
];

final List<BottomNavigationBarItem> bottonItemsWithLogin = [
  const BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.circleDollarToSlot),
    label: 'Aportar',
  ),
  const BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.comment),
    label: 'Preguntar',
  ),
  BottomNavigationBarItem(
    icon: Badge(
      child: const Icon(FontAwesomeIcons.user),
      badgeContent: null,
    ),
    label: 'Perfil',
  ),
];
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
List<StatelessWidget> menuProfileOptions(AuthServices authService) {
  final menuProfileOptions = [
    const MenuProfileOption(
      icon: Icon(
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
    const MenuProfileOption(
      icon: Icon(Icons.message_rounded),
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
    const MenuProfileOption(
      icon: Icon(Icons.exit_to_app, color: Colors.white),
      title: "Cerrar sesión",
      page: WalletPage(),
      showTrailingIcon: false,
      closeSession: true,
    ),
  ];
  return menuProfileOptions;
}

const sizeTabIcon = 35.0;
const colorTab = Colors.grey;
List<Widget> tabsOptions = const [
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
