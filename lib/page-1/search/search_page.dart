import 'package:flutter/material.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/model/model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<SongDbModel> displayresult = [];
TextEditingController _textControler = TextEditingController();

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 10,
                      height: 55,
                      child: TextField(
                        style: const TextStyle(
                            color: Color.fromARGB(204, 255, 255, 255),
                            fontSize: 18),
                        controller: _textControler,
                        textAlign: TextAlign.left,
                        onChanged: (value) => searchresult(value),
                        decoration: InputDecoration(
                          hintText: 'What do you want to listen to?',
                          suffixIcon: _textControler.text.isNotEmpty
                              ? InkWell(
                                  onTap: () => setState(() {
                                    _textControler.text = '';
                                  }),
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
                    displayresult.isEmpty
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
                              child: Allmusiclisttile(songmodel: displayresult),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchresult(String text) {
    List<SongDbModel> result = [];
    if (text.isEmpty) {
      return result = resulted;
    } else {
      result = resulted
          .where((element) =>
              element.displayName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      displayresult = result;
    });
  }
}
