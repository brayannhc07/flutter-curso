import 'package:flutter/material.dart';
import 'package:preferenciasuserapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasuserapp/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    _prefs.ultimaPagina = routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias de Usuario"),
        backgroundColor: _prefs.colorSecundario ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Color Secundario: ${_prefs.colorSecundario} '),
          Divider(),
          Text('Género: ${_prefs.genero}'),
          Divider(),
          Text('Nombre de Usuario: ${_prefs.nombreUsuario}'),
          Divider(),
        ],
      ),
    );
  }
}
