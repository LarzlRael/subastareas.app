part of 'widgets.dart';

class MenuButton {
  final IconData icon;
  final Function onPressed;
  MenuButton({
    required this.icon,
    required this.onPressed,
  });
}

class FloatMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MenuButton> items = [
      MenuButton(icon: Icons.home, onPressed: () {}),
      MenuButton(icon: Icons.search, onPressed: () {}),
      MenuButton(icon: Icons.notification_add, onPressed: () {}),
      MenuButton(icon: Icons.supervised_user_circle, onPressed: () {}),
    ];
    return Center(
      child: ChangeNotifierProvider(
        create: (_) => _MenuModel(),
        child: _MenuBackground(
          child: _MenuItem(menuItems: items),
        ),
      ),
    );
  }
}

class _MenuBackground extends StatelessWidget {
  final Widget child;
  const _MenuBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xFF333446),
          borderRadius: BorderRadius.circular(100),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5),
          ]),
      /* child: Text('Hola mundo desde el menu'), */
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.menuItems,
  }) : super(key: key);
  final List<MenuButton> menuItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (i) => _MenuPinterestMenuButton(
          index: i,
          item: menuItems[i],
        ),
      ),
    );
  }
}

class _MenuPinterestMenuButton extends StatelessWidget {
  const _MenuPinterestMenuButton({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);
  final int index;
  final MenuButton item;

  @override
  Widget build(BuildContext context) {
    final itemSelected = Provider.of<_MenuModel>(context).getItemSelected;
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).setItemSelected = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (itemSelected == index) ? 30 : 25,
          color: (itemSelected == index) ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSelected = 0;

  int get getItemSelected => _itemSelected;

  set setItemSelected(int index) {
    _itemSelected = index;
    notifyListeners();
  }
}
