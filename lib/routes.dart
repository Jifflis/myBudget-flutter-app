import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/view_budget_controller.dart';
import 'model/account.dart';
import 'repository/acount_repository.dart';
import 'repository/transaction_repository.dart';
import 'view/screen/add_budget_screen.dart';
import 'view/screen/add_transaction_screen.dart';
import 'view/screen/change_currency_screen.dart';
import 'view/screen/home_screen.dart';
import 'view/screen/initial_screen.dart';
import 'view/screen/introduction_screen.dart';
import 'view/screen/main_screen.dart';
import 'view/screen/set_passcode_screen.dart';
import 'view/screen/settings_screen.dart';
import 'view/screen/sign_in_screen.dart';
import 'view/screen/transactions_screen.dart';
import 'view/screen/view_budget_screen.dart';
import 'view/screen/view_transaction_screen.dart';

class Routes {
  Routes._();

  ///Screen Routes
  ///
  ///
  static const String SCREEN_INITIAL = '/';
  static const String SCREEN_MAIN = '/main_screen';
  static const String SCREEN_INTRODUCTION = '/introduction_screen';
  static const String SCREEN_HOME = '/home_screen';
  static const String SCREEN_SETTINGS = '/settings_screen';
  static const String SCREEN_TRANSACTIONS = '/transaction_screen';
  static const String SCREEN_ADD_BUDGET = '/add_budget_screen';
  static const String SCREEN_VIEW_BUDGET = '/view_budget_screen';
  static const String SCREEN_ADD_TRANSACTION = '/add_transaction_screen';
  static const String SCREEN_VIEW_TRANSACTION = '/view_transaction_screen';
  static const String SCREEN_CHANGE_CURRENCY = '/change_currency_screen';
  static const String SCREEN_SET_PASSCODE = '/set_passcode_screen';
  static const String SCREEN_SIGN_IN = '/sign_in_screen';

  //navigator key ------------------------------------------------------------
  /// set navigators key.
  ///
  ///
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> settingsNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> transactionNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Get navigators.
  ///
  ///
  static NavigatorState get rootNavigator => rootNavigatorKey.currentState;

  static NavigatorState get homeNavigator => homeNavigatorKey.currentState;

  static NavigatorState get settingsNavigator =>
      settingsNavigatorKey.currentState;

  static NavigatorState get transactionNavigator =>
      transactionNavigatorKey.currentState;

  /// List of initial routes when a [SubNavigator]
  /// widget is created.
  ///
  static String currentSubNavigatorInitialRoute;

  /// [MaterialApp.onGenerateRoute] callback.
  ///
  ///
  static CupertinoPageRoute<Widget> onGenerateRoute(RouteSettings settings) {
    Widget screen;

    switch (settings.name) {
      case SCREEN_INITIAL:
        screen = InitialScreen();
        break;

      case SCREEN_MAIN:
        screen = MainScreen();
        break;

      case SCREEN_INTRODUCTION:
        screen = IntroductionScreen();
        break;

      case SCREEN_HOME:
        screen = HomeScreen();
        break;

      case SCREEN_TRANSACTIONS:
        screen = TransactionsScreen();
        break;

      case SCREEN_SETTINGS:
        screen = SettingsScreen();
        break;

      case SCREEN_ADD_BUDGET:
        screen = AddBudgetScreen();
        break;

      case SCREEN_VIEW_BUDGET:
        final Account account = settings.arguments as Account;
        final ViewBudgetController controller = Get.put(
          ViewBudgetController(
            AccountRepository(),
            TransactionRepository(),
          ),
        );
        controller.initAccount(account);
        screen = ViewBudgetScreen(controller);
        break;

      case SCREEN_ADD_TRANSACTION:
        screen = AddTransactionScreen();
        break;

      case SCREEN_VIEW_TRANSACTION:
        screen = ViewTransactionScreen();
        break;

      case SCREEN_CHANGE_CURRENCY:
        screen = ChangeCurrencyScreen();
        break;
      case SCREEN_SET_PASSCODE:
        screen = SetPasscodeScreen();
        break;
      case SCREEN_SIGN_IN:
        screen = SignInScreen();
        break;
    }

    if (settings.name == SCREEN_MAIN &&
        currentSubNavigatorInitialRoute != null) {
      // When current sub-navigator initial route is set,
      // do not display initial route because it is already displayed.
      return null;
    }

    return CupertinoPageRoute<Widget>(
      builder: (_) {
        if (currentSubNavigatorInitialRoute == settings.name) {
          // Disable back swipe gesture.
          return WillPopScope(
            onWillPop: () async => false,
            child: screen,
          );
        }

        return screen;
      },
      settings: settings,
    );
  }

  /// Delayed route used when calling [pushNamedOnSubNavigatorChanged].
  ///
  ///
  static Function _delayedRoute;

  /// Navigate to screen via [CupertinoPageRoute].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void push(Widget screen, {NavigatorState navigator}) {
    final CupertinoPageRoute<Widget> route = CupertinoPageRoute<Widget>(
      builder: (_) => screen,
    );

    if (navigator != null) {
      navigator.push(route);
      return;
    }

    rootNavigator.push(route);
  }

  /// Navigate to route name via [CupertinoPageRoute].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static Future<dynamic> pushNamed(String routeName,
      {NavigatorState navigator, Object arguments}) {
    if (navigator != null) {
      return navigator.pushNamed(routeName, arguments: arguments);
    }

    return rootNavigator.pushNamed(routeName, arguments: arguments);
  }

  /// Navigate to route name via [CupertinoPageRoute].
  ///
  /// [navigateTo] is a function where the changing of [SubNavigator]
  /// happens. Example of this is changing the selected item of the
  /// bottom nav bar.
  ///
  /// If [isUseRootNavigator] is set to TRUE, it will use the [rootNavigator],
  /// otherwise, it will use the navigator of the target [SubNavigator].
  static void pushNamedOnSubNavigatorChanged(
      String routeName, VoidCallback navigateTo,
      {bool isUseRootNavigator = false, Object arguments}) {
    _delayedRoute = (NavigatorState navigator) async {
      Routes._delayedRoute = null;
      await Future<void>.delayed(const Duration(milliseconds: 50));
      pushNamed(routeName,
          navigator: isUseRootNavigator ? null : navigator,
          arguments: arguments);
    };
    navigateTo();
  }

  /// Navigate to route name via [CupertinoPageRoute].
  ///
  /// [navigateTo] is a function where the changing of [SubNavigator]
  /// happens. Example of this is changing the selected item of the
  /// bottom nav bar.
  static void executeOnSubNavigatorChanged(
    VoidCallback executeOnChanged,
    VoidCallback navigateTo,
  ) {
    _delayedRoute = (NavigatorState navigator) async {
      Routes._delayedRoute = null;
      await Future<void>.delayed(const Duration(milliseconds: 50));
      executeOnChanged();
    };
    navigateTo();
  }

  /// Replace current route and navigate to
  /// route name via [CupertinoPageRoute].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void pushReplacementNamed(String routeName,
      {NavigatorState navigator, Object arguments}) {
    if (navigator != null) {
      navigator.pushReplacementNamed(routeName, arguments: arguments);
      return;
    }

    rootNavigator.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pop current route of [navigator].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void pop<T extends Object>({NavigatorState navigator, T result}) {
    if (navigator != null) {
      navigator.pop(result);
      return;
    }

    rootNavigator.pop(result);
  }

  /// Pop routes until [predicate] returns TRUE.
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void popUntil(
    RoutePredicate predicate, {
    NavigatorState navigator,
  }) {
    if (navigator != null) {
      navigator.popUntil(predicate);
      return;
    }

    rootNavigator.popUntil(predicate);
  }
}

//--------------------------------------------------------------------------------
/// A navigator widget who is a child of [MaterialApp] navigator.
///
///
class SubNavigator extends StatelessWidget {
  const SubNavigator(
      {@required this.navigatorKey, @required this.initialRoute, Key key})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    final _SubNavigatorObserver _navigatorObserver =
        _SubNavigatorObserver(initialRoute, navigatorKey);
    Routes.currentSubNavigatorInitialRoute = initialRoute;

    return WillPopScope(
      onWillPop: () async {
        if (_navigatorObserver.isInitialScreen) {
          Routes.currentSubNavigatorInitialRoute = null;
          await SystemNavigator.pop();
          return true;
        }

        final bool canPop = navigatorKey.currentState.canPop();

        if (canPop) {
          navigatorKey.currentState.pop();
        }

        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        observers: <NavigatorObserver>[_navigatorObserver],
        initialRoute: initialRoute,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

//--------------------------------------------------------------------------------
/// [NavigatorObserver] of [SubNavigator] widget.
///
///
class _SubNavigatorObserver extends NavigatorObserver {
  _SubNavigatorObserver(this._initialRoute, this._navigatorKey);

  final String _initialRoute;
  final GlobalKey<NavigatorState> _navigatorKey;
  final List<String> _routeNameStack = <String>[];

  bool _isInitialScreen = false;

  /// Flag if current route is the initial screen.
  ///
  ///
  bool get isInitialScreen => _isInitialScreen;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _routeNameStack.add(route.settings.name);
    _isInitialScreen = _routeNameStack.last == _initialRoute;

    if (_isInitialScreen && Routes._delayedRoute != null) {
      Routes._delayedRoute(_navigatorKey.currentState);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _routeNameStack.remove(route.settings.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    _routeNameStack.remove(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    _routeNameStack.remove(oldRoute.settings.name);
    _routeNameStack.add(newRoute.settings.name);
  }
}
