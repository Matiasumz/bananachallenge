import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

class ProductListPage extends StatefulWidget {
  final String token;

  const ProductListPage({Key? key, required this.token}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<dynamic> _products = [];
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Challenge 2023'),
        backgroundColor: Color(0xFF9e007e),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _getProducts();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar producto',
                suffixIcon: IconButton(
                  onPressed: () {
                    _getProducts();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                _getProducts();
              },
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
            Expanded(
              child: _products.isNotEmpty
                  ? ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    child: ListTile(
                      title: Text(product['title']),
                      subtitle: Text('\$${product['price']}'),
                      leading: Image.network(product['image']),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  'No se encontraron productos',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> _getProducts() async {
    final searchQuery = _searchController.text;
    final url = Uri.parse('https://fakestoreapi.com/products?query=$searchQuery');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _products = List.from(responseData);
        _errorMessage = null;
      });
    } else {
      setState(() {
        _products = [];
        _errorMessage = 'No se encontraron productos';
      });
    }
    return _products;
  }
}
