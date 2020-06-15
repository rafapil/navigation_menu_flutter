import 'package:filgs/bloc/navigation_bloc/NavigationBloc.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("CONTACT Page"),
    );
  }
}
