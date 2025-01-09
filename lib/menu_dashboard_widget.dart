import 'package:flutter/material.dart';

final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboardWidget extends StatefulWidget {
  const MenuDashboardWidget({super.key});

  @override
  State<MenuDashboardWidget> createState() => _MenuDashboardWidgetState();
}

class _MenuDashboardWidgetState extends State<MenuDashboardWidget>
    with SingleTickerProviderStateMixin {
  late double screenHeight, screeWidth;
  bool isMenuOpen = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final Duration _duration = Duration(milliseconds: 750);
   late Animation<Offset> _menuOffsetAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _menuOffsetAnimation=Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: Padding(
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
      ),
    );
  }

  buildDashboard(BuildContext context) {
    return AnimatedPositioned(
      top: isMenuOpen ? 0.02 * screenHeight : 0,
       bottom: isMenuOpen ? 0.02 * screenHeight : 0,
      left: isMenuOpen ? 0.18 * screeWidth : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
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
                      onTap: () {
                        setState(() {
                          if (isMenuOpen) {
                            _controller.reverse();
                          } else{
                            _controller.forward();
                          }
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
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 200,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        color: Colors.pink,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Center(child: Text("Container" , style: TextStyle(fontSize: 24),)),
                      ),
                      Container(
                        color: Colors.purple,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.tealAccent,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
