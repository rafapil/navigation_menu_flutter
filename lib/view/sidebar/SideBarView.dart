import 'dart:async';
//import 'dart:html';
import 'package:filgs/bloc/navigation_bloc/NavigationBloc.dart';
import 'package:filgs/view/sidebar/MenuItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  // Classes responsaveis pelo comportamento
  // Controller para animação do objeto
  AnimationController _animationController;

  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
//  final bool isSideBarOpened = true;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    // TODO: implement dispose
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // declarar p tamanho da tela com mediaQuery
    final screenWidh = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          // Aqui é importante se atentar a esse ponto.
          // Da mesma forma que usamos o screenWidh para pegar e fechar a tela usamos ele de
          // forma negativa para abrir e não perder a formatação de Row.
          left: isSideBarOpenedAsync.data ? 0 : -screenWidh,
          right: isSideBarOpenedAsync.data ? 0 : screenWidh - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.blueAccent,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      ListTile(
                        title: Text(
                          "Rafa",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "rafa@mail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 36,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 26,
                        endIndent: 26,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.work,
                        title: "Projects",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ProjectPageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.archive,
                        title: "Posts",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.PostsPageClickedEvent);
                        },
                      ),
                      Divider(
                        height: 36,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 26,
                        endIndent: 26,
                      ),
                      MenuItem(
                        icon: Icons.chat,
                        title: "Chat",
                      ),
                      MenuItem(
                        icon: Icons.contact_mail,
                        title: "Contato",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ContactPageClickedEvent);
                        },
                      ),
                      Divider(
                        height: 36,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 26,
                        endIndent: 26,
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Sair",
                      ),
                      // Adicionar itens do menu a partir de outro file
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.amber,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
//      child:
    );
  }
}

// configuraçoes de definicoes da borda

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 14);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 14);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
