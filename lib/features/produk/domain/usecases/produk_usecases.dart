import 'package:cek/features/produk/data/models/produk_model.dart';
import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:cek/features/produk/domain/repositories/produk_repositories.dart';
import 'package:dartz/dartz.dart';

class ProdukUsecasesGetAll {
  final ProdukRepositories produkRepositories;

  ProdukUsecasesGetAll({required this.produkRepositories});

  Future<Either<Exception, List<Produk>>> execute() async {
    return await produkRepositories.getAllProduk();
  }
}

class ProdukUsecasesGetById {
  final ProdukRepositories produkRepositories;

  ProdukUsecasesGetById({required this.produkRepositories});

  Future<Either<Exception, Produk>> execute({required String id}) async {
    return await produkRepositories.getProdukById(id: id);
  }
}

class ProdukUsecasesAddProduk {
  final ProdukRepositories produkRepositories;

  ProdukUsecasesAddProduk({required this.produkRepositories});

  Future<Either<Exception, void>> execute({required ProdukModel produk}) async {
    return await produkRepositories.addProduk(produk: produk);
  }
}

class ProdukUsecasesEditProduk {
  final ProdukRepositories produkRepositories;

  ProdukUsecasesEditProduk({required this.produkRepositories});

  Future<Either<Exception, void>> execute({required ProdukModel produk}) async {
    return await produkRepositories.editProduk(produk: produk);
  }
}

class ProdukUsecasesDeleteProduk {
  final ProdukRepositories produkRepositories;

  ProdukUsecasesDeleteProduk({required this.produkRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await produkRepositories.deleteProduk(id: id);
  }
}