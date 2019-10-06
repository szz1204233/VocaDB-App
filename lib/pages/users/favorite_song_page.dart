import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocadb/blocs/favorite_song_bloc.dart';
import 'package:vocadb/models/song_model.dart';
import 'package:vocadb/widgets/center_content.dart';
import 'package:vocadb/widgets/result.dart';
import 'package:vocadb/widgets/song_tile.dart';

class FavoriteSongScreen extends StatelessWidget {
  static const String routeName = '/user/favoriteSongs';

  @override
  Widget build(BuildContext context) {
    return FavoriteSongPage();
  }
}

class FavoriteSongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FavoriteSongBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite songs'),
      ),
      body: StreamBuilder(
        stream: bloc.songs$,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return CenterResult.error(
              message: snapshot.error.toString(),
            );

          Map<int, SongModel> songMap = snapshot.data;

          if (songMap == null || songMap.isEmpty) {
            return CenterResult(
                result: Result(Icon(Icons.music_note), 'No song'));
          }
          List<SongModel> songs = songMap.values.toList();

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final SongModel song = songs[index];
              return SongTile.fromSong(
                song,
                tag: 'favorite_song_${song.id}',
              );
            },
          );
        },
      ),
    );
  }
}