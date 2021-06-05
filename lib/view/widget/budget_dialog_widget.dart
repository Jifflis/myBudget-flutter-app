import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BudgetDialog extends StatelessWidget {
  const BudgetDialog({
    @required this.description,
    this.title = '',
    this.button1Title = 'Ok',
    this.button2Title = 'Close',
    this.showButton1 = true,
    this.showButton2 = true,
    this.onButton1Press,
    this.onButton2Press,
  });

  final String title;
  final String description;
  final String button1Title;
  final String button2Title;
  final bool showButton1;
  final bool showButton2;
  final Function onButton1Press;
  final Function onButton2Press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(),
          _buildBody(),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.purple,
      ),
    );
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(description),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (showButton2)
                TextButton(
                  onPressed: onButton2Press,
                  child: Text(
                    button2Title,
                    style: const TextStyle(color: Colors.purple),
                  ),
                ),
              const SizedBox(
                width: 8,
              ),
              if (showButton1)
                TextButton(
                  onPressed: onButton1Press,
                  child: Text(
                    button1Title,
                    style: const TextStyle(color: Colors.purple),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
