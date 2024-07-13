import 'package:flutter/foundation.dart';
import 'package:read_quran/model/bookmarkModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkProvider with ChangeNotifier {
  List<Bookmark> _bookmarks = [];

  BookmarkProvider() {
    _loadBookmarks();
  }

  List<Bookmark> get bookmarks => _bookmarks;

  void addBookmark(Bookmark bookmark) {
    _bookmarks.add(bookmark);
    _saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(Bookmark bookmark) {
    _bookmarks.remove(bookmark);
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(Bookmark bookmark) {
    return _bookmarks.contains(bookmark);
  }

  void _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkStrings = _bookmarks.map((bookmark) => json.encode({'ayah': bookmark.ayah})).toList();
    prefs.setStringList('bookmarks', bookmarkStrings);
  }

  void _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkStrings = prefs.getStringList('bookmarks') ?? [];
    _bookmarks = bookmarkStrings.map((bookmarkString) {
      Map<String, dynamic> bookmarkMap = json.decode(bookmarkString);
      return Bookmark(ayah: bookmarkMap['ayah']);
    }).toList();
    notifyListeners();
  }
}
