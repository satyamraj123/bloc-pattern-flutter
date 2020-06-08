import 'dart:async';
import 'dart:convert';
import 'Category_icon.dart';
import 'package:http/http.dart' as http;

class CategoryIconsBloc {
//data
  List<CategoryIcon> _categoryIcons = [];

  //streams
  final _listStreamController = StreamController<List<CategoryIcon>>();

//getters
  Stream<List<CategoryIcon>> get listStream => _listStreamController.stream;
  StreamSink<List<CategoryIcon>> get listSink => _listStreamController.sink;

//constructors
  CategoryIconsBloc() {
    _listStreamController.add(_categoryIcons);
  }

//core functions
  Future<void> getIcons() async {
    final response = await http.post('https://newprod.zypher.co/ebooks/getHome',
        headers: {"userId": "5ec972e92d2da600109e8844"});

    final data = json.decode(response.body);
    data['category'].forEach((cat) {
      _categoryIcons
          .add(CategoryIcon(cat['categoryImageURL'], cat['categoryName']));
    });
    print(_categoryIcons.toString());
    listSink.add(_categoryIcons);
  }

  void dispose() {
    _listStreamController.close();
  }
}
