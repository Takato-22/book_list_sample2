import 'package:book_list_sample/add_book/add_book_page.dart';
import 'package:book_list_sample/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/book.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BookListSample'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;
            if(books == null){
              return const CircularProgressIndicator();
            }
            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
            ).toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: Consumer<BookListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async{
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage(),
                  ),
                );

                if(added != null && added) {
                  const snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('本を追加しました'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                model.fetchBookList();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}