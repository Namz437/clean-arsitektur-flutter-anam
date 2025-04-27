import 'package:cek/features/gudang/data/models/gudang_model.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/gudang/domain/repositories/gudang_repo.dart';
import 'package:dartz/dartz.dart';

class GudangUsecasesGetAll {
  final GudangRepo gudangRepo;

  GudangUsecasesGetAll({required this.gudangRepo});

  Future<Either<Exception, List<Gudang>>> execute() async {
    return await gudangRepo.getAllGudang();
  }
}

class GudangUsecasesGetById {
  final GudangRepo gudangRepo;

  GudangUsecasesGetById({required this.gudangRepo});

  Future<Either<Exception, Gudang>> execute({required String id}) async {
    return await gudangRepo.getGudangById(id: id);
  }
}

class GudangUsecasesAddGudang {
  final GudangRepo gudangRepo;

  GudangUsecasesAddGudang({required this.gudangRepo});

  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepo.addGudang(gudang: gudang);
  }
}

class GudangUsecasesEditGudang {
  final GudangRepo gudangRepo;

  GudangUsecasesEditGudang({required this.gudangRepo});


  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepo.editGudang(gudang: gudang);
  }
}

class GudangUsecasesDeleteGudang {
  final GudangRepo gudangRepo;

  GudangUsecasesDeleteGudang({required this.gudangRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await gudangRepo.deleteGudang(id: id);
  }
}