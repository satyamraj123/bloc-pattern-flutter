import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:ui_1/Category_icon.dart';
import 'categoryIcons_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI',
      home: UIPage(),
    );
  }
}

class UIPage extends StatefulWidget {
  @override
  _UIPageState createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  final CategoryIconsBloc _categoryIconsBloc = CategoryIconsBloc();

  @override
  void initState() {
    super.initState();
    _categoryIconsBloc.getIcons();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryIconsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            //appdrawerButton
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.subject,
                    size: 30,
                  ),
                  height: 50,
                  width: 300,
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            //welcomeText
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    width: 295,
                    child: Text(
                      'What would\nYou Read, Ariel?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                      softWrap: true,
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),

            //searchBar
            NeuCard(
              padding: EdgeInsets.all(8),
              curveType: CurveType.concave,
              bevel: 15,
              margin: EdgeInsets.all(10),
              height: 70,
              width: 400,
              decoration: NeumorphicDecoration(
                color: Color.fromRGBO(230, 230, 230, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  leading: Icon(Icons.search, size: 40),
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: 'title,genre,author',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  height: 50,
                  width: 300,
                ),
              ],
            ),

            //categoriesList
            Container(
              color: Color.fromRGBO(250, 250, 250, 1),
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<List<CategoryIcon>>(
                  stream: _categoryIconsBloc.listStream,
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, i) => Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Image.network(
                                        snapshot.data[i].categoryIconUrl
                                            .toString(),
                                        height: 40,
                                        width: 30,
                                      )),
                                  SizedBox(height: 10),
                                  Text(
                                      snapshot.data[i].categoryName.toString()),
                                ],
                              ),
                            ),
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
