import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  Future addBook() async {
    final _userCollection = FirebaseFirestore.instance.collection('books');
    if(title == null || title == ""){
      throw '本のタイトルが入力されていません';
    }
    if(author == null || author!.isEmpty){
      throw '著者が追加されていません';
    }

    //Firestoreに追加
    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
