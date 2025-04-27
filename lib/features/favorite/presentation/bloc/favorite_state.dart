part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteStateLoading extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteStateError extends FavoriteState {
  final String message;

  FavoriteStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class FavoriteStateLoadedAll extends FavoriteState {
  final List<Favorite> favorites;

  FavoriteStateLoadedAll({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteStateLoaded extends FavoriteState {
  final Favorite favorites;

  FavoriteStateLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteStateSuccess extends FavoriteState {
  @override
  List<Object?> get props => [];
}