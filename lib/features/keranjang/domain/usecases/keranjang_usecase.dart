import 'package:cek/features/keranjang/data/models/keranjang_model.dart';
import 'package:cek/features/keranjang/domain/entities/keranjang.dart';
import 'package:cek/features/keranjang/domain/repositories/keranjang_repo.dart';
import 'package:dartz/dartz.dart';

class KeranjangUsecasesGetAll {
  final KeranjangRepo keranjangRepo;

  KeranjangUsecasesGetAll({required this.keranjangRepo});

  Future<Either<Exception, List<Keranjang>>> execute() async {
    return await keranjangRepo.getAllkeranjang();
  }
}

class KeranjangUsecasesGetById {
  final KeranjangRepo keranjangRepo;

  KeranjangUsecasesGetById({required this.keranjangRepo});

  Future<Either<Exception, Keranjang>> execute({required String id}) async {
    return await keranjangRepo.getkeranjangById(id: id);
  }
}

class KeranjangUsecasesAddKeranjang {
  final KeranjangRepo keranjangRepo;

  KeranjangUsecasesAddKeranjang({required this.keranjangRepo});

  Future<Either<Exception, void>> execute(
      {required KeranjangModel keranjang}) async {
    return await keranjangRepo.addKeranjang(keranjang: keranjang);
  }
}

class KeranjangUsecasesEditKeranjang {
  final KeranjangRepo keranjangRepo;

  KeranjangUsecasesEditKeranjang({required this.keranjangRepo});

  Future<Either<Exception, void>> execute(
      {required KeranjangModel keranjang}) async {
    return await keranjangRepo.editKeranjang(keranjang: keranjang);
  }
}

class KeranjangUsecasesDeleteKeranjang {
  final KeranjangRepo keranjangRepo;

  KeranjangUsecasesDeleteKeranjang({required this.keranjangRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await keranjangRepo.deleteKeranjang(id: id);
  }
}