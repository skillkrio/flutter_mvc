import 'package:flutter/material.dart';
import 'package:playground/controller/controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserController(),
        )
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() => context.read<UserController>().fetchUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserController>(
        builder: (context, userCtrl, child) {
          if (userCtrl.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userCtrl.error != null) {
            return Center(
              child: Text(userCtrl.error!),
            );
          } else if (userCtrl.userList.isNotEmpty) {
            final listItem = userCtrl.userList;
            return ListView.builder(
              itemCount: listItem.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(listItem[index].name),
              ),
            );
          } else {
            return Center(
              child: Text("No items to display"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //another way of fetching users
        context.read<UserController>().fetchUser();
      }),
    );
  }
}
