import 'package:flutter/material.dart';

final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboardWidget extends StatefulWidget {
  const MenuDashboardWidget({super.key});

  @override
  State<MenuDashboardWidget> createState() => _MenuDashboardWidgetState();
}

class _MenuDashboardWidgetState extends State<MenuDashboardWidget> {
  late double screenHeight, screeWidth;
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screeWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            buildMenu(context),
            buildDashboard(context),
          ],
        ),
      ),
    );
  }

  buildMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Message',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Utility Bills',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Fund Transfer',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Branches',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dashboard',
              style: menuFontStyle,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  buildDashboard(BuildContext context) {
    return AnimatedPositioned(
      top: isMenuOpen ? 0.07 * screenHeight : 0,
      bottom: isMenuOpen ? 0.07 * screenHeight : 0,
      left: isMenuOpen ? 0.18 * screeWidth : 0,
      duration: Duration(milliseconds: 500),
      child: Material(
        borderRadius: isMenuOpen ? BorderRadius.all(Radius.circular(40)) : null,
        elevation: 8,
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        isMenuOpen = !isMenuOpen;
                      });
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'My Card',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
