import 'package:cek/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cek/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:dartz/dartz.dart';

class KategoriProdukUsecasesGetAll {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecasesGetAll({required this.kategoriProdukRepo});


  Future<Either<Exception, List<KategoriProduk>>> execute() async {
    return await kategoriProdukRepo.getAllKategoriProduk();
  }
}

class KategoriProdukUsecasesGetById {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecasesGetById({required this.kategoriProdukRepo});

  Future<Either<Exception, KategoriProduk>> execute({required String id}) async {
    return await kategoriProdukRepo.getKategoriProdukById(id: id);
  }
}

class KategoriProdukUsecasesAddKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecasesAddKategoriProduk({required this.kategoriProdukRepo});

  Future<Either<Exception, void>> execute({required KategoriProdukModel kategoriProduk}) async {
    return await kategoriProdukRepo.addKategoriProduk(kategoriProduk: kategoriProduk);
  }
}

class KategoriProdukUsecasesEditKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecasesEditKategoriProduk({required this.kategoriProdukRepo});


  Future<Either<Exception, void>> execute({required KategoriProdukModel kategoriProduk}) async {
    return await kategoriProdukRepo.editKategoriProduk(kategoriProduk: kategoriProduk);
  }
}

class KategoriProdukUsecasesDeleteKategoriProduk {
  final KategoriProdukRepo kategoriProdukRepo;

  KategoriProdukUsecasesDeleteKategoriProduk({required this.kategoriProdukRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kategoriProdukRepo.deleteKategoriProduk(id: id);
  }
}