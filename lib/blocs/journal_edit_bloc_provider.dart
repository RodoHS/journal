import 'package:flutter/material.dart';
import 'package:journal/blocs/journal_edit_bloc.dart';
//import '../models/journal.dart';

class JournalEditBlocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  //final bool add;
  //final Journal journal;

  const JournalEditBlocProvider(
      {Key key, Widget child, this.journalEditBloc})
      : super(key: key, child: child);


  static JournalEditBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<JournalEditBlocProvider>());
  }

  @override bool updateShouldNotify(JournalEditBlocProvider oldWidget) {
    return false;
  }
}