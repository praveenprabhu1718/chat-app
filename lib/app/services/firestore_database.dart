import 'package:chat_app/app/pages/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  CollectionReference _messages =
      FirebaseFirestore.instance.collection('Messages');

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  Stream<QuerySnapshot> getMessages() {
    return _messages.snapshots();
  }

  Future<void> sendMessage(Message message) async {
    await _messages
        .doc(documentIdFromCurrentDate())
        .set(message.toJson())
        .then((value) => print('Customer Added'))
        .catchError((e) => print('Failed to add'));
  }
}
