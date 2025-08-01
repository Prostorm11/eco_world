import 'package:flutter/material.dart';

class DropdownListIcon extends StatelessWidget {
  final List<Map> myActions;
  final Icon icon;
  final Color? color;
  final Function? onpresses;

  const DropdownListIcon(
      {super.key,
      required this.icon,
      this.color,
      required this.myActions,
      this.onpresses});

  void dropList(BuildContext context, Offset offset) {
    showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
            items: myActions.map((element) {
              return PopupMenuItem<String>(
                value: element["value"],
                child: ListTile(
                  leading: element["icon"],
                  title: Text('${element["title"]}'),
                ),
              );
            }).toList())
        .then((value) async {
      if (onpresses != null) {
        onpresses!(value); // ✅ Call the parent-supplied function
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: icon,
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          final Offset offset = button
              .localToGlobal(Offset(0, button.size.height), ancestor: overlay);

          dropList(context, offset);
        },
      );
    });
  }
}

class DropdownListButton extends StatelessWidget {
  final String text;
  final List<Map> myActions;
  final Function? onpresses;
  const DropdownListButton({
    super.key,
    required this.text,
    this.onpresses,
    required this.myActions
  });

  void dropList(BuildContext context, Offset offset) {
    showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
            items: myActions.map((element) {
              return PopupMenuItem<String>(
                value: element["value"],
                child: ListTile(
                  leading: element["icon"],
                  title: Text('${element["title"]}'),
                ),
              );
            }).toList())
        .then((value) async {
      if (onpresses != null) {
        onpresses!(value); // ✅ Call the parent-supplied function
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          final Offset offset = button
              .localToGlobal(Offset(0, button.size.height), ancestor: overlay);

          dropList(context, offset);
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child:  Text(text),
      );
    });
  }
}
