import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/networking/api_provider.dart';
import 'package:news_app/repo/repository.dart';
import 'package:news_app/view/home.dart';

void main() {
  runApp(MyApp(
    provider: ApiProvider(),
  ));
}

class MyApp extends StatelessWidget {
  final ApiProvider provider;
  const MyApp({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => NewsBloc(
          repo: Repository(provider: provider),
        ),
        child: const Home(),
      ),
    );
  }
}
