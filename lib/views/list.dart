import 'dart:math';

import 'package:api/models/anime_model.dart';
import 'package:api/presenters/anime_presenter.dart';
import 'package:api/views/anime_detail.dart';
import 'package:flutter/material.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> implements AnimeView {
  late AnimePresenter _presenter;
  bool _isLoading = false;
  List<Anime> _animeList = [];
  String? _errorMessage;
  String _currentendpoint = "akatsuki";

  @override
  void initState() {
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimeData(_currentendpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentendpoint = endpoint;
      _presenter.loadAnimeData(endpoint);
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
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
      appBar: AppBar(
        title: Text("Anime List"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _fetchData('akatsuki');
                },
                child: Text("Akatsuki"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _fetchData('kara');
                },
                child: Text("Kara"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _fetchData('characters');
                },
                child: Text("Main Characters"),
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text(_errorMessage!))
                    : ListView.builder(
                        itemCount: _animeList.length,
                        itemBuilder: (context, index) {
                          final anime = _animeList[index];
                          return ListTile(
                            leading: anime.imageUrl != null
                                ? Image.network(anime.imageUrl)
                                : Image.asset('assets/placeholder.png'),
                            title: Text(anime.name),
                            subtitle: Text("Family ${anime.familyCreator}"),
                            onTap: () {
                              // Push DetailScreen with the anime ID and endpoint
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    id: anime.id,
                                    endpoint: _currentendpoint,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
