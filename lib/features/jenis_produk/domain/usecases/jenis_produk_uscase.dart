import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cek/features/jenis_produk/domain/repositories/jenis_produk_repo.dart';
import 'package:dartz/dartz.dart';

class JenisProdukUsecasesGetAll {
  final JenisProdukRepo jenisProdukRepo;

  JenisProdukUsecasesGetAll({required this.jenisProdukRepo});


  Future<Either<Exception, List<JenisProduk>>> execute() async {
    return await jenisProdukRepo.getAllJenisProduk();
  }
}

class JenisProdukUsecasesGetById {
  final JenisProdukRepo jenisProdukRepo;

  JenisProdukUsecasesGetById({required this.jenisProdukRepo});

  Future<Either<Exception, JenisProduk>> execute({required String id}) async {
    return await jenisProdukRepo.getJenisProdukById(id: id);
  }
}

class JenisProdukUsecasesAddJenisProduk {
  final JenisProdukRepo jenisProdukRepo;

  JenisProdukUsecasesAddJenisProduk({required this.jenisProdukRepo});

  Future<Either<Exception, void>> execute({required JenisProdukModel jenisProduk}) async {
    return await jenisProdukRepo.addJenisProduk(jenisProduk: jenisProduk);
  }
}

class JenisProdukUsecasesEditJenisProduk {
  final JenisProdukRepo jenisProdukRepo;

  JenisProdukUsecasesEditJenisProduk({required this.jenisProdukRepo});


  Future<Either<Exception, void>> execute({required JenisProdukModel jenisProduk}) async {
    return await jenisProdukRepo.editJenisProduk(jenisProduk: jenisProduk);
  }
}

class JenisProdukUsecasesDeleteJenisProduk {
  final JenisProdukRepo jenisProdukRepo;

  JenisProdukUsecasesDeleteJenisProduk({required this.jenisProdukRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await jenisProdukRepo.deleteJenisProduk(id: id);
  }
}