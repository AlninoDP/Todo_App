import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  final int index;
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  static const pageConfig = PageConfig(icon: Icons.home_rounded, name: '/home');

  /// list of all tabs that should be displayed inside navigation bar and bottom nav bar
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
                trailing: IconButton(
                  onPressed: () =>
                      context.pushNamed(SettingsPage.pageConfig.name),
                  icon: Icon(SettingsPage.pageConfig.icon),
                  tooltip: 'Setting',
                ),
                width: 85,
                selectedIndex: widget.index,
                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),

                /// Page Tab that will be displayed in PrimaryNavigation
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
                currentIndex: widget.index,

                /// Page Tab that will be displayed in BottomNavigation
                destinations: destinations,

                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),
              ),
            ),
          }),

          /// The body is the main body of the page
          /// The breakpoint is set to small to high layout
          /// Which mean, it will always be displayed
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (_) => HomePage.tabs[widget.index].child,
            )
          }),

          /// The second body is second body of the page
          /// The breakpoint is set to medium to high layout
          /// Which mean, it will display only in medium to high layout
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body'),
              builder: widget.index != 1
                  ? null
                  : (_) => BlocBuilder<NavigationToDoCubit,
                          NavigationToDoCubitState>(
                        builder: (context, state) {
                          final selectedId = state.selectedCollectionId;
                          final isSecondBodyDisplayed =
                              Breakpoints.mediumAndUp.isActive(context);
                          context
                              .read<NavigationToDoCubit>()
                              .secondBodyHasChanged(
                                  isSecondBodyDisplayed: isSecondBodyDisplayed);
                          if (selectedId == null) {
                            return const Placeholder();
                          }
                          return ToDoDetailPageProvider(
                              key: Key(selectedId.value),
                              collectionId: selectedId);
                        },
                      ),
            )
          }),
        ),
      ),
    );
  }

  /// to show the url
  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(
        HomePage.pageConfig.name,
        pathParameters: {
          'tab': HomePage.tabs[index].name,
        },
      );
}
