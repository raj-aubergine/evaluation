import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_test/bloc/addTemplate/add_template_cubit.dart';
import 'package:frontend_test/bloc/template/template_cubit.dart';
import 'package:frontend_test/bloc/viewTemplate/view_template_cubit.dart';
import 'package:frontend_test/helpers/api_repositary.dart';
import 'package:frontend_test/helpers/api_service.dart';
import 'package:frontend_test/screens/add_template_screen.dart';
import 'package:frontend_test/screens/home_screen.dart';
import 'package:frontend_test/screens/view_template.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TemplateCubit>(
          create: (context) => TemplateCubit(
              apiRepository: ApiRepository(apiService: ApiService())),
        ),
        BlocProvider<ViewTemplateCubit>(
          create: (context) => ViewTemplateCubit(
              apiRepository: ApiRepository(apiService: ApiService())),
        ),
        BlocProvider<AddTemplateCubit>(
          create: (context) => AddTemplateCubit(
              apiRepository: ApiRepository(apiService: ApiService())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (_) => HomeScreen(),
          '/addTemplate': (_) => AddTemplateScreen(),
        },
      ),
    );
  }
}
