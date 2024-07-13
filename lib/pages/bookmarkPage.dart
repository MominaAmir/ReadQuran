import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_quran/model/bookmarkModel.dart';
import 'package:read_quran/provider.dart/bookmarkProvider.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          return ListView.builder(
            itemCount: bookmarkProvider.bookmarks.length,
            itemBuilder: (context, index) {
              Bookmark bookmark = bookmarkProvider.bookmarks[index];
              return ListTile(
                title: Text('Ayah ${bookmark.ayah}'),
                onTap: () {
                  // Navigate to the bookmarked ayah
                },
              );
            },
          );
        },
      ),
    );
  }
}
