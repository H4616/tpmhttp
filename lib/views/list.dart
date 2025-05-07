import 'dart:math';

import 'package:api/models/anime_model.dart';
import 'package:api/presenters/anime_presenter.dart';
import 'package:flutter/material.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> 
  implements AnimeView {
    late AnimePresenter _presenter;
    bool _isLoading = false;
    List<Anime> _animeList = [];
    String? _errorMessage;
    String _currentendpoint ='akatsuki';


  @override
  void initState() {
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimeData(_currentendpoint);
  }
  void _fetchData(String endpoint) {
    setState(() {
      _currentendpoint = endpoint;
    });
    _presenter.loadAnimeData(endpoint);
  }

  @override
  void hideLoading() {
    _isLoading = false;
  }

  @override
  void showAnimeList(List<Anime> animeList) {
    setState(() {
      _animeList = animeList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anime List"),
      )

      body: Column(
        children:[
          Row(
            MainAxisAlignment: MainAxisAlignment.Center(
              children:[
                ElevatedButton(
                  onPressed: () (),
                  child: Text("Akatsuki"), 
                ),
                sizedBox(widget,10),
                ElevatedButton(
                  onPressed: () (),
                  child: Text("Kara"), 
                ),
              ]
            ),
          )
        ]
        }
      )
    )
  }

}
