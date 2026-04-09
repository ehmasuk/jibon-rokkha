import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final bookmarkProvider = StateNotifierProvider<BookmarkNotifier, List<String>>((ref) {
  final box = Hive.box<String>('bookmarks');
  return BookmarkNotifier(box);
});

class BookmarkNotifier extends StateNotifier<List<String>> {
  final Box<String> _box;

  BookmarkNotifier(this._box) : super(_box.values.toList());

  bool isBookmarked(String id) {
    return state.contains(id);
  }

  void toggleBookmark(String id) {
    if (state.contains(id)) {
      _removeBookmark(id);
    } else {
      _addBookmark(id);
    }
  }

  void _addBookmark(String id) {
    _box.add(id);
    state = [...state, id];
  }

  void _removeBookmark(String id) {
    final index = _box.values.toList().indexOf(id);
    if (index != -1) {
      _box.deleteAt(index);
      state = state.where((item) => item != id).toList();
    }
  }
}
