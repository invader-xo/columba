import 'package:columba/screens/messages/view/messages_view.dart';
import 'package:columba/shared/widgets/keep_alive/keep_alive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../find/view/find_view.dart';

class NavBarAndRail extends StatefulWidget {
  const NavBarAndRail({super.key});

  @override
  State<NavBarAndRail> createState() => _NavBarAndRailState();
}

class _NavBarAndRailState extends State<NavBarAndRail> {
  List<Widget> destinations = const [
    KeepAliveWidget(child: MessagesScreenView()),
    KeepAliveWidget(child: FindScreenView()),
    Center(child: Text('Contacts')),
    Center(child: Text('Settings')),
  ];

  int selectedIndex = 0;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
              ? NavigationRail(
                  selectedIndex: selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (int index) {
                    setState(() {
                      selectedIndex = index;
                      pageController.jumpToPage(index);
                    });
                  },
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  // elevation: 0.0,
                  groupAlignment: 0.0,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.message_outlined),
                      selectedIcon: Icon(Icons.message),
                      label: Text("Messages"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: Text("Find"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text("Contacts"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text("Settings"),
                    ),
                  ],
                )
              : Container(),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: destinations,
              onPageChanged: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ]),
      ),
      bottomNavigationBar:
          MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
              ? NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      selectedIndex = index;
                      pageController.jumpToPage(index);
                    });
                  },
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 0.0,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.message_outlined),
                      selectedIcon: Icon(Icons.message, color: Colors.white),
                      label: 'Messages',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search, color: Colors.white),
                      label: 'Find',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person, color: Colors.white),
                      label: 'Contacts',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings, color: Colors.white),
                      label: 'Settings',
                    ),
                  ],
                )
              : null,
    );
  }
}
