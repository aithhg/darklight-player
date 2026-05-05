// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$recommendationsAtom = Atom(
    name: '_HomeStore.recommendations',
    context: context,
  );

  @override
  ObservableList<SearchResult> get recommendations {
    _$recommendationsAtom.reportRead();
    return super.recommendations;
  }

  @override
  set recommendations(ObservableList<SearchResult> value) {
    _$recommendationsAtom.reportWrite(value, super.recommendations, () {
      super.recommendations = value;
    });
  }

  late final _$genreSectionsAtom = Atom(
    name: '_HomeStore.genreSections',
    context: context,
  );

  @override
  ObservableMap<String, List<SearchResult>> get genreSections {
    _$genreSectionsAtom.reportRead();
    return super.genreSections;
  }

  @override
  set genreSections(ObservableMap<String, List<SearchResult>> value) {
    _$genreSectionsAtom.reportWrite(value, super.genreSections, () {
      super.genreSections = value;
    });
  }

  late final _$feedSectionsAtom = Atom(
    name: '_HomeStore.feedSections',
    context: context,
  );

  @override
  ObservableMap<String, List<SearchResult>> get feedSections {
    _$feedSectionsAtom.reportRead();
    return super.feedSections;
  }

  @override
  set feedSections(ObservableMap<String, List<SearchResult>> value) {
    _$feedSectionsAtom.reportWrite(value, super.feedSections, () {
      super.feedSections = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_HomeStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_HomeStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadFeedsAsyncAction = AsyncAction(
    '_HomeStore.loadFeeds',
    context: context,
  );

  @override
  Future<void> loadFeeds() {
    return _$loadFeedsAsyncAction.run(() => super.loadFeeds());
  }

  late final _$refreshAsyncAction = AsyncAction(
    '_HomeStore.refresh',
    context: context,
  );

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  @override
  String toString() {
    return '''
recommendations: ${recommendations},
genreSections: ${genreSections},
feedSections: ${feedSections},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
