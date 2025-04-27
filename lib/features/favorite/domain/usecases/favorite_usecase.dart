import 'package:cek/features/favorite/data/models/favorite_model.dart';
import 'package:cek/features/favorite/domain/entities/favorite.dart';
import 'package:cek/features/favorite/domain/repositories/favorite_repo.dart';
import 'package:dartz/dartz.dart';

class FavoriteUsecasesGetAll {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecasesGetAll({required this.favoriteRepo});

  Future<Either<Exception, List<Favorite>>> execute() async {
    return await favoriteRepo.getAllFavorite();
  }
}

class FavoriteUsecasesGetById {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecasesGetById({required this.favoriteRepo});

  Future<Either<Exception, Favorite>> execute({required String id}) async {
    return await favoriteRepo.getFavoriteById(id: id);
  }
}

class FavoriteUsecasesAddFavorite {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecasesAddFavorite({required this.favoriteRepo});

  Future<Either<Exception, void>> execute(
      {required FavoriteModel favorite}) async {
    return await favoriteRepo.addFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesEditFavorite {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecasesEditFavorite({required this.favoriteRepo});

  Future<Either<Exception, void>> execute(
      {required FavoriteModel favorite}) async {
    return await favoriteRepo.editFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesDeleteFavorite {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecasesDeleteFavorite({required this.favoriteRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await favoriteRepo.deleteFavorite(id: id);
  }
}