import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: destinations
            .map((e) => NavigationDestination(
                  label: e.title,
                  icon: e.icon,
                  selectedIcon: e.selectedIcon,
                ))
            .toList(),
        indicatorColor: Colors.transparent,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: destinations
                .map((e) => NavigationRailDestination(
                      label: Text(e.title),
                      icon: e.icon,
                      selectedIcon: e.selectedIcon,
                    ))
                .toList(),
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.grey,
          ),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}

List<BarInfo> destinations = [
  BarInfo('Home', const Icon(CupertinoIcons.home), const Icon(CupertinoIcons.house_fill)),
  BarInfo('Saved', const Icon(CupertinoIcons.bookmark), const Icon(CupertinoIcons.bookmark_fill)),
  BarInfo('Profile', const Icon(CupertinoIcons.person), const Icon(CupertinoIcons.person_fill)),
];

class BarInfo {
  BarInfo(this.title, this.icon, this.selectedIcon);
  final String title;
  final Widget icon;
  final Widget selectedIcon;
}

// class Layout extends StatefulWidget {
//   static const id = "/";
//   const Layout({Key? key}) : super(key: key);
//
//   @override
//   State<Layout> createState() => _LayoutState();
// }
//
// class _LayoutState extends State<Layout> with WidgetsBindingObserver {
//   final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {}
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         confineInSafeArea: true,
//         onItemSelected: (index) {},
//         backgroundColor: Colors.white, // Default is Colors.white.
//         handleAndroidBackButtonPress: true, // Default is true.
//         resizeToAvoidBottomInset:
//             true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//         stateManagement: true, // Default is true.
//         hideNavigationBarWhenKeyboardShows:
//             true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           colorBehindNavBar: Colors.white,
//           boxShadow: [
//             const BoxShadow(
//               color: Colors.grey, // Color of the shadow
//               offset: Offset(0, 2), // Offset of the shadow
//               blurRadius: 4.0, // Spread of the shadow
//               spreadRadius: 0, // How much the shadow expands
//             ),
//           ],
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         popActionScreens: PopActionScreensType.all,
//         itemAnimationProperties: const ItemAnimationProperties(
//           // Navigation Bar's items animation properties.
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: const ScreenTransitionAnimation(
//           // Screen transition animation on change of selected tab.
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   List<Widget> _buildScreens() {
//     return [
//       const HomeScreen(),
//       const ShouldLogin(child: FavouritesScreen()),
//       ShouldLogin(child: ProfileScreen(user: getIt<AuthHandler>().loginModel?.user)),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(CupertinoIcons.home),
//         title: ('Home'),
//         activeColorPrimary: AppColors.primary,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(CupertinoIcons.bookmark_fill),
//         title: ('Saved'),
//         activeColorPrimary: AppColors.primary,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(CupertinoIcons.person),
//         title: ('Profile'),
//         activeColorPrimary: AppColors.primary,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//     ];
//   }
// }
