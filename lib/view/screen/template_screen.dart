import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class TemplateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[800],
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: buildBody(context),
          ),
        ),
      ),
    );
  }

  /// set app bar
  ///
  ///
  Widget _buildAppBar(BuildContext context) => AppBar(
      backgroundColor: Colors.purple[800],
      title: Text(title),
      leading: getLeading(context),
      actions: getAppBarActions(context),
      elevation: 0,
      centerTitle: centerTitle,
      leadingWidth: 36,
      automaticallyImplyLeading: false);

  /// get [AppBar] title position
  ///
  ///
  bool get centerTitle => true;

  /// get [AppBar] title
  ///
  ///
  String get title;

  /// get [AppBar] leading icon
  ///
  ///
  Widget get leading => Container(
        padding: const EdgeInsets.only(left: 5),
        child: SvgPicture.asset(
          'images/logo.svg',
        ),
      );

  /// get [AppBar] leading with size
  ///
  ///
  double get leadingWith => 56;

  /// get [AppBar] leading icon with context
  ///
  ///
  Widget getLeading(BuildContext context) => leading;

  /// build body
  /// it must be overrided
  ///
  Widget buildBody(BuildContext context);

  /// Get [AppBar] action items.
  ///
  ///
  List<Widget> get appBarActions => <Widget>[];

  /// Get [AppBar] action items wit context
  ///
  ///
  List<Widget> getAppBarActions(BuildContext context) => appBarActions;
}
