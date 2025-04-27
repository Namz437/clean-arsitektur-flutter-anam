part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {}

class FavoriteEventAdd extends FavoriteEvent {
  final FavoriteModel favoriteModel;

  FavoriteEventAdd({required this.favoriteModel});

  @override
  List<Object?> get props => [favoriteModel];
}

class FavoriteEventEdit extends FavoriteEvent {
  final FavoriteModel favoriteModel;

  FavoriteEventEdit({required this.favoriteModel});

  @override
  List<Object?> get props => [favoriteModel];
}

class FavoriteEventDelete extends FavoriteEvent {
  final String id;

  FavoriteEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class FavoriteEventGetAll extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class FavoriteEventGetById extends FavoriteEvent {
  final String id;

  FavoriteEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}