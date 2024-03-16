import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';

final routes = GoRouter(
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  navigatorKey: _rootNavigationKey,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) => const SettingsPage(),
    ),

    /// ShellRoute is used for:
    /// display routes in justa subsection of the screen
    /// alongside another widget that remain constant (like BtmNavBar that switches between routes)
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '$_basePath/:tab',
          name: HomePage.pageConfig.name,
          builder: (context, state) => HomePage(
            key: state
                .pageKey, // every time we have state change we have a new key and rebuild it
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        )
      ],
    ),

    GoRoute(
      name: CreateToDoCollectionPage.pageConfig.name,
      path: '$_basePath/overview/${CreateToDoCollectionPage.pageConfig.name}',
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Collection'),
          leading: BackButton(onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(HomePage.pageConfig.name,
                  pathParameters: {'tab': OverviewPage.pageConfig.name});
            }
          }),
        ),
        body: SafeArea(
          child: CreateToDoCollectionPage.pageConfig.child,
        ),
      ),
    ),

    GoRoute(
      name: CreateToDoEntryPage.pageConfig.name,
      path: '$_basePath/overview/${CreateToDoEntryPage.pageConfig.name}',
      builder: (context, state) {
        final castedExtras = state.extra as CreateToDoEntryPageExtra;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Entry'),
            leading: BackButton(onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name});
              }
            }),
          ),
          body: SafeArea(
            child: CreateToDoEntryPageProvider(
                toDoEntryItemAddedCallBack:
                    castedExtras.toDoEntryItemAddedCallBack,
                collectionId: castedExtras.collectionId),
          ),
        );
      },
    ),

    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) {
        /// bloclistener is used to listen the state change
        /// and put detail page from small break point into
        /// secondary body in the mediumAndUp breakpoint
        return BlocListener<NavigationToDoCubit, NavigationToDoCubitState>(
          listenWhen: (previous, current) =>
              previous.isSecondBodyIsDisplayed !=
              current.isSecondBodyIsDisplayed,
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyIsDisplayed ?? false)) {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Details'),
              leading: BackButton(onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.pageConfig.name,
                      pathParameters: {'tab': OverviewPage.pageConfig.name});
                }
              }),
            ),
            body: ToDoDetailPageProvider(
              collectionId: CollectionId.fromUniqueString(
                  state.pathParameters['collectionId'] ?? ''),
            ),
          ),
        );
      },
    )
  ],
);
