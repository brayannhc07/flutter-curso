import 'package:flutter/material.dart';
import 'package:preferenciasuserapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasuserapp/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario;
  int _genero;
  final _prefs = new PreferenciasUsuario();

  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _genero = _prefs.genero;
    _colorSecundario = _prefs.colorSecundario;
    _textController = new TextEditingController(text: _prefs.nombreUsuario);
  }

  _setSelectedRadio(int valor) {
    _prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _prefs.ultimaPagina = SettingsPage.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
        backgroundColor: _prefs.colorSecundario ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Center(
          child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Settings",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          SwitchListTile(
              value: _colorSecundario,
              title: Text("Color Secundario"),
              onChanged: (value) {
                setState(() {
                  _prefs.colorSecundario = value;
                  _colorSecundario = value;
                });
              }),
          RadioListTile(
              value: 1,
              title: Text("Masculino"),
              groupValue: _genero,
              onChanged: _setSelectedRadio),
          RadioListTile(
              value: 2,
              title: Text("Femenino"),
              groupValue: _genero,
              onChanged: _setSelectedRadio),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: "Nombre de la persona que usa el teléfono"),
              onChanged: (value) {
                _prefs.nombreUsuario = value;
              },
            ),
          ),
        ],
      )),
    );
  }
}
