


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/notif/bloc.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {

  FirebaseMessaging _firebaseMessaging;

  NotifBloc(NotifState initialstate, FirebaseMessaging messaging) : super(initialstate) {
    _firebaseMessaging = messaging;
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  @override
  Stream<NotifState> mapEventToState(NotifEvent event) async* {

  }
}