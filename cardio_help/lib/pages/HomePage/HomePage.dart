import 'package:flutter/material.dart';
import 'package:cardio_help/objects/database.dart'; 
import 'package:cardio_help/pages/DrugsPage/drugsPage.dart';

class HomePage extends StatefulWidget {
  final Color background;

  const HomePage({Key key, @required this.background}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database data = new Database();
  List medicamentos;    //Lista de medicamentos
  
  Future<void> load() async {
    List l = await data.loadDrugsJsonData();
    setState(() {
      medicamentos = l;
     });
  }

  void initState(){
    this.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child : Scaffold(
        appBar: AppBar(
          backgroundColor: widget.background,
          title: Text('Cardio Help'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Medicamentos'),
              Tab(text: 'Info'),
              ],
          ),
        ),
        body: TabBarView(
          children: [
            (medicamentos != null)?
            ListView.builder( //Gerador de itens da lista
              itemBuilder: (context, index) => ListTile(
                title: Text(medicamentos[index]["name"]),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){

                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DrugsPage(medicamento: medicamentos[index])
                      )
                  );
                },
              ),
              itemCount: medicamentos.length,
            ): Center(
              child: CircularProgressIndicator(),
            ),
            Icon(Icons.info),
          ],
        ),
      ),
    );
  }
}
