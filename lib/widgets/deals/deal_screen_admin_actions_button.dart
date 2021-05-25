import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealScreenAdminActionsButton extends StatelessWidget {
  final DealModel deal;
  final Color color;

  const DealScreenAdminActionsButton(this.deal, {this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _openAdminActions(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.ellipsis_vertical,
          size: 22,
          color: color ?? Colors.black,
        ),
      ),
    );
  }

  void _openAdminActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Akcje admina'),
              ),
              _buildListTile('Usuń okazję', CupertinoIcons.clear, () {
                _deleteDeal(context, deal.id);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile(String title, IconData icon, Function() function) {
    return ListTile(
      leading: Icon(icon, size: 18),
      onTap: function,
      title: Text(title, style: const TextStyle(fontSize: 13)),
    );
  }

  Future<void> _deleteDeal(BuildContext context, String dealId) async {
    Navigator.of(context).popUntil((route) {
      return route.isFirst;
    });
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName, arguments: true);
    await Provider.of<Deals>(context, listen: false).deleteDeal(deal.id);
  }
}
