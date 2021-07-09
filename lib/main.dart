import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fade and Slide transition sample'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
              transitionDuration: const Duration(milliseconds: 300),
              context: context,
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return WarningPopUp();
              },
              transitionBuilder: slideInAndFadeTransitionBuilder);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class WarningPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          constraints: BoxConstraints.expand(
              width: size.width * 0.8, height: size.height * 0.2),
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          alignment: Alignment.topRight,
          child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: Navigator.of(context).pop),
        ),
      ),
    );
  }
}

Widget slideInAndFadeTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
    child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutQuart))
            .animate(animation),
        child: child), // child is the value returned by pageBuilder
  );
}
