import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocadb/app_theme.dart';
import 'package:vocadb/blocs/config_bloc.dart';
import 'package:vocadb/blocs/home_bloc.dart';
import 'package:vocadb/blocs/ranking_bloc.dart';
import 'package:vocadb/global_variables.dart';
import 'package:vocadb/pages/album_detail/album_detail_page.dart';
import 'package:vocadb/pages/artist_detail/artist_detail_page.dart';
import 'package:vocadb/pages/song_detail/song_detail_page.dart';
import 'package:vocadb/pages/tag_detail/tag_detail_page.dart';

import 'pages/main/account_tab.dart';
import 'pages/main/home_tab.dart';
import 'pages/main/ranking_tab.dart';

void main() async {
  await GlobalVariables.init();

  runApp(VocaDBApp());
}

class VocaDBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigBloc configBloc = ConfigBloc(GlobalVariables.pref);

    return MultiProvider(
      providers: [
        Provider<ConfigBloc>.value(value: configBloc),
        Provider<HomeBloc>.value(value: HomeBloc(configBloc)),
        Provider<RankingBloc>.value(value: RankingBloc(configBloc))
      ],
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigBloc>(context);
    return StreamBuilder(
      stream: config.themeDataStream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'VocaDB Flutter Demo',
          theme: (snapshot.hasData)
              ? config.getThemeData(snapshot.data)
              : AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => MyHomePage(title: 'VocaDB Demo Home Page'),
            SongDetailScreen.routeName: (context) => SongDetailScreen(),
            AlbumDetailScreen.routeName: (context) => AlbumDetailScreen(),
            ArtistDetailScreen.routeName: (context) => ArtistDetailScreen(),
            TagDetailScreen.routeName: (context) => TagDetailScreen(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    RankingTab(),
    AccountTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    final rankingBloc = Provider.of<RankingBloc>(context);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Ranking'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('Menu'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              homeBloc.fetch();
              break;
            case 1:
              rankingBloc.fetch();
              break;
          }

          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
