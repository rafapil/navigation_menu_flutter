import 'package:filgs/view/pages/ContactPageView.dart';
import 'package:filgs/view/pages/HomePageView.dart';
import 'package:filgs/view/pages/PostsPageView.dart';
import 'package:filgs/view/pages/ProjectPageView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  ContactPageClickedEvent,
  PostsPageClickedEvent,
  ProjectPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // TODO: implement initialState
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    // TODO: implement mapEventToState
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.ContactPageClickedEvent:
        yield ContactPage();
        break;
      case NavigationEvents.PostsPageClickedEvent:
        yield PostsPage();
        break;
      case NavigationEvents.ProjectPageClickedEvent:
        yield ProjectPage();
        break;
    }
  }
}
