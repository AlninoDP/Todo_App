import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  /// make a list for the tabs or the view
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Using .map() make object of NavigationDestination using data from the list
  final destinations = HomePage.tabs
      .map(
        (page) =>
            NavigationDestination(icon: Icon(page.icon), label: page.name),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /// The Primary navigation is the left navigation on page
        /// The breakpoint is set to Medium to higher layout
        /// Which mean, it will display only in medium up layout
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                destinations: destinations
                    .map((element) =>
                        AdaptiveScaffold.toRailDestination(element))
                    .toList(),
              ),
            ),
          }),

          /// The Bottom navigation located at bottom on the page
          /// The breakpoint is set to small layout
          /// Which mean, it will display only in small layout
          bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('bottom-navigation-small'),
              builder: (context) =>
                  AdaptiveScaffold.standardBottomNavigationBar(
                destinations: destinations,
              ),
            ),
          }),

          /// The body is the main body of the page
          /// The breakpoint is set to small to high layout
          /// Which mean, it will always be displayed
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body'),
                builder: (context) => const Placeholder())
          }),

          /// The second body is second body of the page
          /// The breakpoint is set to medium to high layout
          /// Which mean, it will display only in medium to high layout
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body'),
                builder: (context) => const Placeholder())
          }),
        ),
      ),
    );
  }
}
