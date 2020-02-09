import 'dart:async';
import 'package:journal/services/authentication_api.dart';
import '../services/db_api.dart';
import '../models/journal.dart';

class HomeBloc {
  final DbApi dbApi;
  final AuthenticationApi authenticationApi;

  final StreamController<List<Journal>> _journalController =
      StreamController<List<Journal>>.broadcast();
  Sink<List<Journal>> get _addListJournal => _journalController.sink;
  Stream<List<Journal>> get listJournal => _journalController.stream;

  final StreamController<Journal> _journalDeleteController =
      StreamController<Journal>.broadcast();
  Sink<Journal> get deleteJournal => _journalDeleteController.sink;

  HomeBloc(this.dbApi, this.authenticationApi) {
    _startListeners();
  }

  void dispose() {
    _journalController.close();
    _journalDeleteController.close();
  }

  void _startListeners() {
    //Retrieve Firestore Journal Records as List<Journal> not DocumentSnapshot

    authenticationApi.getAuth().currentUser().then((user) {
      dbApi.getJournalList(user.uid).listen((journalDocs) {
        _addListJournal.add(journalDocs);
      });

      _journalDeleteController.stream
          .listen((journal) => dbApi.deleteJournal(journal));
    });
  }
}
