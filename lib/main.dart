import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_room_database_and_share_preferance/database/dao/bank_details_dao.dart';
import 'package:flutter_room_database_and_share_preferance/database/database.dart';
import 'package:flutter_room_database_and_share_preferance/database/entity/bank_details.dart';
import 'package:flutter_room_database_and_share_preferance/read_write_json_file.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder("Bridge2Supplier_DB").build();
  final bankDetailsDao = database.bankDetailsDao;

  //final bankDetails = BankDetails("1213",3,"SBI","Testing...");
  /* bankDetails.itemCode = "12345";
  bankDetails.itemValue = "HDFC";
  bankDetails.itemId = "123";
  bankDetails.id = 10;*/
  //bankDetailsDao.saveBankDetail(bankDetails);

  /*final result = await bankDetailsDao.getAllBanks();
  print('result -> ${result[0].itemValue}');*/
  runApp(MyApp(bankDetailsDao));
}

class MyApp extends StatelessWidget {
  final BankDetailsDao dao;

  const MyApp(this.dao, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final BankDetailsDao dao;

  const MyHomePage({
    Key? key,
    required this.title,
    required this.dao,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
             MaterialButton(
                color: Colors.blue,
                onPressed:() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ReadWriteJsonFile(storage: CounterStorage())));
                },
                child: const Text("Open Read Write Json Page",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),

            ),
            TasksListView(
              dao: widget.dao,
            ),
            //TasksTextField(dao: widget.dao),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

/*Future<void> _startNewPage() async {
  try {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>  ReadWriteJsonFile(storage: CounterStorage())));
  } on PlatformException catch (e) {
    debugPrint("Error: '${e.message}'.");
  }
}*/

class TasksListView extends StatelessWidget {
  final BankDetailsDao dao;

  const TasksListView({
    Key? key,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BankDetails>>(
        future: dao.getAllBanks(),
        initialData: const <BankDetails>[],
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final tasks = snapshot.requireData;
          if (tasks.isNotEmpty) {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                if (tasks[index].id == null) {
                  return Container();
                } else {
                  return TaskListCell(
                    task: tasks[index],
                    dao: dao,
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

/*//showing in cardView
body: FutureBuilder<List<BankDetails>>(
future: widget.dao.getAllBanks(),
initialData: const <BankDetails>[],
builder: (context, snapshot) {
return snapshot.hasData
? ListView.builder(
itemCount: snapshot.data!.length,
itemBuilder: (_, int position) {
final item = snapshot.data![position];
//get your item data here ...
return Card(
child: ListTile(
title: Text(
"Employee Name: ${snapshot.data![position].itemValue}"),
),
);
},
)
    : Center(
child: CircularProgressIndicator(),
);
},
)*/

class TaskListCell extends StatelessWidget {
  final BankDetails task;
  final BankDetailsDao dao;

  const TaskListCell({
    Key? key,
    required this.task,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.hashCode}'),
      background: Container(
        padding: const EdgeInsets.only(left: 16),
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Change status',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      child: ListTile(
        title: Text(task.itemValue!),
        subtitle: Text('Status: ${task.itemCode}'),
      ),
    );
  }
}
