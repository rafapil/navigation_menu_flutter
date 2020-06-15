import 'package:filgs/bloc/navigation_bloc/NavigationBloc.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("PROJECT Page"),
    );
  }
}
