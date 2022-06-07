import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelector extends StatefulWidget {
  final String defaultCurrency;

  const CurrencySelector({Key key, @required this.defaultCurrency})
      : super(key: key);

  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  String groupValue;

  @override
  void initState() {
    groupValue = widget.defaultCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ExpansionTile(
          title: const Text('Local Currency', style: textStyle1),
          children: _buildOptions()),
    );
  }

  List<Widget> _buildOptions() {
    return CURRENCIES.map((currency) {
      return ListTile(
        onTap: () => _changeValue(currency),
        title: Text(currency),
        trailing: Radio(
            value: currency, groupValue: groupValue, onChanged: _changeValue),
      );
    }).toList();
  }

  void _changeValue(String value) {
    var userStore = Provider.of<UserStore>(context);
    userStore.setUserDetails(
        userStore.details.copyWith(
            currency: value
        )
    );
    setState(() => groupValue = value);
    userStore.updateProfile(userStore.details.toJson());
  }
}
