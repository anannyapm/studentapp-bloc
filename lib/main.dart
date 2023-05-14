import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_bloc.dart';

import 'package:stdappbloc/view/screens/screenhome.dart';

import 'businesslogic/bloc/studentbloc/app_bloc.dart';
import 'data/model/model.dart';

void main() async {
  //the WidgetFlutterBinding is used to interact with the Flutter engine.
  //ensureInitialized() make sure that you have an instance of the WidgetsBinding so that the call to
  // initialize plugin via engine happens asynchronously.
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  //open box intially
  await Hive.openBox<StudentModel>('student_db');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
        BlocProvider(
          create: (context) => PhotoBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Student App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            elevatedButtonTheme: const ElevatedButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    foregroundColor: MaterialStatePropertyAll(Colors.white))),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black, foregroundColor: Colors.white),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white)),
            useMaterial3: true,
            primarySwatch: Colors.indigo,
            fontFamily: 'Raleway',
          ),
          home: const ScreenHome()),
    );
  }
}
