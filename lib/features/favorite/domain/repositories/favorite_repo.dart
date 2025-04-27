import 'package:cek/features/favorite/data/models/favorite_model.dart';
import 'package:cek/features/favorite/domain/entities/favorite.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepo {
  Future<Either<Exception, List<Favorite>>> getAllFavorite();
  Future<Either<Exception, Favorite>> getFavoriteById({required String id});
  Future<Either<Exception, void>> addFavorite(
      {required FavoriteModel favorite});
  Future<Either<Exception, void>> editFavorite(
      {required FavoriteModel favorite});
  Future<Either<Exception, void>> deleteFavorite({required String id});
}
