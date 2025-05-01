import 'package:bloc/bloc.dart';
import 'package:cek/features/favorite/data/models/favorite_model.dart';
import 'package:cek/features/favorite/domain/entities/favorite.dart';
import 'package:cek/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUsecasesAddFavorite favoriteUsecasesAdd;
  final FavoriteUsecasesEditFavorite favoriteUsecasesEditFavorite;
  final FavoriteUsecasesDeleteFavorite favoriteUsecasesDeleteFavorite;
  final FavoriteUsecasesGetAll favoriteUsecasesGetAll;
  final FavoriteUsecasesGetById favoriteUsecasesGetById;
  FavoriteBloc(
      {required this.favoriteUsecasesAdd,
      required this.favoriteUsecasesEditFavorite,
      required this.favoriteUsecasesDeleteFavorite,
      required this.favoriteUsecasesGetAll,
      required this.favoriteUsecasesGetById})
      : super(FavoriteInitial()) {
    on<FavoriteEventAdd>((event, emit) async {
      emit(FavoriteStateLoading());
      final data =
          await favoriteUsecasesAdd.execute(favorite: event.favoriteModel);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());

          add(FavoriteEventGetAll());
        },
      );
    });
    on<FavoriteEventEdit>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesEditFavorite.execute(
          favorite: event.favoriteModel);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());

          add(FavoriteEventGetAll());
        },
      );
    });
    on<FavoriteEventDelete>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesDeleteFavorite.execute(id: event.id);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());

          add(FavoriteEventGetAll());
        },
      );
    });
    on<FavoriteEventGetAll>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateLoadedAll(favorites: r));
        },
      );
    });
    on<FavoriteEventGetById>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateLoaded(favorites: r));
        },
      );
    });
  }
}

