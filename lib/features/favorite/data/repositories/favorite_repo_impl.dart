import 'package:cek/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:cek/features/favorite/data/models/favorite_model.dart';
import 'package:cek/features/favorite/domain/entities/favorite.dart';
import 'package:cek/features/favorite/domain/repositories/favorite_repo.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  //menambahkan FavoriteRemoteDataSource
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRepoImpl({required this.favoriteRemoteDataSource});

  @override
  Future<Either<Exception, void>> addFavorite(
      {required FavoriteModel favorite}) async {
    try {
      final data =
          await favoriteRemoteDataSource.addFavorite(favorite: favorite);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteFavorite({required String id}) async {
    try {
      final data = await favoriteRemoteDataSource.deleteFavorite(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editFavorite(
      {required FavoriteModel favorite}) async {
    try {
      final data =
          await favoriteRemoteDataSource.editFavorite(favorite: favorite);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Favorite>>> getAllFavorite() async {
    try {
      final data = await favoriteRemoteDataSource.getAllFavorite();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Favorite>> getFavoriteById(
      {required String id}) async {
    try {
      final data = await favoriteRemoteDataSource.getFavoriteById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}