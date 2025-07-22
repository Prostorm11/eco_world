import 'package:flutter/material.dart';

class ProfileDropdownIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;

  const ProfileDropdownIcon({super.key, required this.icon, this.color});

  void _showMenu(BuildContext context, Offset offset) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        const PopupMenuItem<String>(
          value: 'recent',
          child: ListTile(
            leading: Icon(Icons.history),
            title: Text('See Recent Activities'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'logout') {
        print('Logging out...');
      } else if (value == 'recent') {
        print('Showing recent activities...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
          final Offset offset = button.localToGlobal(Offset(0, button.size.height), ancestor: overlay);

          _showMenu(context, offset);
        },
      );
    });
  }
}
