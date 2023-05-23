import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/view/allmusic/allmusic.dart';

import '../all_songs_fetching_provider/all_songs_fetching_provider.dart';

class SearchNotifier with ChangeNotifier {
  SearchNotifier() {
    searchResult.addAll(allsongInMap.values);
  }

  List<SongDbModel> searchResult = [];
  searchedSongsFetching(String serchingName) {
    List<String> trieSugetions = [];
    trieSugetions.clear();
    searchResult.clear();
    trieSugetions = trie.search(serchingName);
    for (String name in trieSugetions) {
      searchResult.add(allsongInMap[name]!);
    }
    notifyListeners();
  }
}

class TrieNode {
  final Map<String, TrieNode> children;
  bool isEndOfWord;

  TrieNode()
      : children = {},
        isEndOfWord = false;
}

class Trie {
  TrieNode? root;

  Trie() {
    root = TrieNode();
  }

  void insert(String word) {
    TrieNode? currentNode = root;
    for (int i = 0; i < word.length; i++) {
      final char = word[i];
      if (!currentNode!.children.containsKey(char)) {
        currentNode.children[char] = TrieNode();
      }
      currentNode = currentNode.children[char]!;
    }
    currentNode?.isEndOfWord = true;
  }

  List<String> search(String prefix) {
    final List<String> results = [];
    TrieNode? currentNode = root;

    for (int i = 0; i < prefix.length; i++) {
      final char = prefix[i];
      print(currentNode!.children.containsKey(char));
      if (currentNode.children.containsKey(char)) {
        currentNode = currentNode.children[char]!;
      } else {
        return results;
      }
    }

    _dfs(currentNode, prefix, results);
    return results;
  }

  void _dfs(TrieNode? node, String prefix, List<String> results) {
    if (node!.isEndOfWord) {
      results.add(prefix);
    }

    for (final entry in node.children.entries) {
      final char = entry.key;
      final childNode = entry.value;
      _dfs(childNode, prefix + char, results);
    }
  }
}
