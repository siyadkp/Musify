import 'package:flutter/material.dart';
import 'package:myapp/controller/functions/allsong_db_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/view/allmusic/allmusiclist_tile.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/search_provider/search_provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  TextEditingController _textControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _searchNotifier = Provider.of<SearchNotifier>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.zero),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/page-1/images/home.png',
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02, left: 8),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.0),
                    child: SizedBox(
                      width: width * 10,
                      height: 55,
                      child: TextField(
                        style: const TextStyle(
                            color: Color.fromARGB(204, 255, 255, 255),
                            fontSize: 18),
                        controller: _textControler,
                        textAlign: TextAlign.left,
                        onChanged: (value) => _searchNotifier
                            .searchedSongsFetching(value.toLowerCase()),
                        decoration: InputDecoration(
                          hintText: 'What do you want to listen to?',
                          suffixIcon: _textControler.text.isNotEmpty
                              ? InkWell(
                                  onTap: () => _textControler.text = '',
                                  child: const Icon(
                                    Icons.clear,
                                    size: 35,
                                    color: Colors.white70,
                                  ),
                                )
                              : const Icon(
                                  Icons.search,
                                  size: 35,
                                  color: Colors.white,
                                ),
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  Consumer<SearchNotifier>(
                      builder: (context, searchNotifier, _) {
                    return searchNotifier.searchResult.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                'No Searched Songs',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Allmusiclisttile(
                                  songmodel: searchNotifier.searchResult),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
