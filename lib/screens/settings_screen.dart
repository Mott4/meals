import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChanged;

  const SettingsScreen(this.settings, this.onSettingsChanged);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settings = Settings();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800]),
      ),
      subtitle: Text(subtitle),
      value: value,
      onChanged: ((value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        elevation: 3,
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  'Sem Glúten',
                  'Somente refeições sem glúten!',
                  settings.isGlutenFree,
                  (value) => setState((() => settings.isGlutenFree = value)),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Somente refeições sem lactose!',
                  settings.isLactoseFree,
                  (value) => setState((() => settings.isLactoseFree = value)),
                ),
                _createSwitch(
                  'Vegana',
                  'Somente refeições veganas!',
                  settings.isVegan,
                  (value) => setState((() => settings.isVegan = value)),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Somente refeições vegetarianas!',
                  settings.isVegetarian,
                  (value) => setState((() => settings.isVegetarian = value)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
