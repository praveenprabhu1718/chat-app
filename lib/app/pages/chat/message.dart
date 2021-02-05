import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

  final String text;
  final String email;

  Message({this.text, this.email});

  factory Message.fromMap(QueryDocumentSnapshot data){
    return Message(
      text: data['text'],
      email: data['email']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'text': this.text,
      'email': this.email
    };
  }

}