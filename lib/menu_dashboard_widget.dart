import 'package:flutter/material.dart';

// Theme and Styles
final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboardWidget extends StatefulWidget {
  const MenuDashboardWidget({super.key});

  @override
  State<MenuDashboardWidget> createState() => _MenuDashboardWidgetState();
}

class _MenuDashboardWidgetState extends State<MenuDashboardWidget>
    with SingleTickerProviderStateMixin {
  late double screenHeight, screenWidth;
  bool isMenuOpen = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            buildMenu(),
            buildDashboard(),
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    final menuItems = ["Dashboard", "Message", "Utility Bills", "Fund Transfer", "Branches"];
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menuItems
                .map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(item, style: menuFontStyle),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget buildDashboard() {
    return AnimatedPositioned(
      duration: _duration,
      top: isMenuOpen ? 0.05 * screenHeight : 0,
      bottom: isMenuOpen ? 0.05 * screenHeight : 0,
      left: isMenuOpen ? 0.2 * screenWidth : 0,
      right: isMenuOpen ? -0.2 * screenWidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: isMenuOpen ? BorderRadius.circular(40) : BorderRadius.zero,
          elevation: 8,
          color: backgroundColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                buildHeader(),
                SizedBox(height: 20),
                buildPageView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: toggleMenu,
          child: Icon(Icons.menu, color: Colors.white),
        ),
        Text(
          'My Card',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Icon(Icons.add_circle, color: Colors.white),
      ],
    );
  }

  Widget buildPageView() {
    final cardColors = [Colors.pink, Colors.purple, Colors.tealAccent];
    return SizedBox(
      height: 200,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: cardColors
            .map((color) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              "Container",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  void toggleMenu() {
    setState(() {
      if (isMenuOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isMenuOpen = !isMenuOpen;
    });
  }
}
