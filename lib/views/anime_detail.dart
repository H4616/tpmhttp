import 'package:api/network/Base_Network.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String endpoint;
  const DetailScreen({super.key, required this.id, required this.endpoint});

  @override
  State<DetailScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async {
    try {
      final data = await BaseNetwork.getDetalData(widget.endpoint, widget.id);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Detail ")),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text("Error : ${_errorMessage} !"))
                : _detailData != null
                    ? Column(
                        children: [
                          Image.network(
                            _detailData?['images']?[0] ??
                                'https://placehold.co/600x400',
                          ),
                          Text("Nama : ${_detailData?['name'] ?? "Unknown"}"),
                          Text(
                            "Family : ${_detailData?['family'] ?? "Unknown"}",
                          ),
                          Text(
                            "Keke Genkai : ${_detailData?['kekkeiGenkai'] ?? "Empty"}",
                          ),
                          Text(
                            "Jutsu : ${_detailData?['jutsu'] ?? "Empty"}",
                          ),
                          Text("Title : ${_detailData?['titles'] ?? "No Title"}"),
                          Text("Debut : ${_detailData?['debut'] ?? "No Debut"}"),
                        ],
                      )
                    : Center(child: Text("No Data Found !")),
      ),
    );
  }
}
