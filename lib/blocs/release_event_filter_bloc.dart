import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vocadb/models/artist_model.dart';
import 'package:vocadb/models/tag_model.dart';
import 'package:vocadb/utils/date_utils.dart';

class ReleaseEventFilterBloc {
  final _category = BehaviorSubject<String>();
  final _sort = BehaviorSubject<String>();
  final _artists = BehaviorSubject<Map<int, ArtistModel>>();
  final _tags = BehaviorSubject<Map<int, TagModel>>();
  final _fromDate = BehaviorSubject<String>();
  final _toDate = BehaviorSubject<String>();

  Observable get category$ => _category.stream;
  Observable get sort$ => _sort.stream;
  Observable get artists$ => _artists.stream;
  Observable get tags$ => _tags.stream;
  Observable get fromDate$ => _fromDate.stream;
  Observable get toDate$ => _toDate.stream;

  String get category => _category.value;
  String get sort => _sort.value;
  Map<int, ArtistModel> get artists => _artists.value;
  Map<int, TagModel> get tags => _tags.value;
  List<ArtistModel> get artistList => artists?.values?.toList();
  List<TagModel> get tagList => tags?.values?.toList();
  String get fromDate => _fromDate.value;
  String get toDate => _toDate.value;

  Observable get params$ =>
      Observable.merge([category$, sort$, artists$, tags$, fromDate$, toDate$]);

  void updateCategory(String category) {
    _category.add(category);
  }

  void updateSort(String sort) {
    _sort.add(sort);
  }

  Future<void> addArtist(ArtistModel artist) {
    Map<int, ArtistModel> a = artists ?? {};
    a.putIfAbsent(artist.id, () => artist);
    _artists.add(a);

    return Future.value();
  }

  void removeArtist(int id) {
    Map<int, ArtistModel> a = artists;
    a.remove(id);
    _artists.add(a);
  }

  Future<void> addTag(TagModel tag) {
    Map<int, TagModel> a = tags ?? {};
    a.putIfAbsent(tag.id, () => tag);
    _tags.add(a);

    return Future.value();
  }

  void removeTag(int id) {
    Map<int, TagModel> a = tags;
    a.remove(id);
    _tags.add(a);
  }

  void setFromDateAsToday() {
    updateFromDate(DateTime.now());
  }

  void updateFromDate(DateTime startDate) {
    if (startDate == null) return;
    _fromDate.add(DateUtils.toUtcDateString(startDate));
  }

  void updateToDate(DateTime toDate) {
    if (toDate == null) return;
    _toDate.add(DateUtils.toUtcDateString(toDate));
  }

  Map<String, String> params() {
    Map<String, String> params = {'sort': sort ?? 'Name'};
    if (category != null) params['category'] = category;
    if (tagList != null && tagList.length > 0)
      params['tagId'] = tags.keys.join(',');
    if (artistList != null && artistList.length > 0)
      params['artistId'] = artists.keys.join(',');
    if (_fromDate != null) params['afterDate'] = _fromDate.value;
    if (_toDate != null) params['beforeDate'] = _toDate.value;

    return params;
  }

  void dispose() {
    _category.close();
    _sort.close();
    _artists.close();
    _tags.close();
    _fromDate.close();
    _toDate.close();
  }
}
