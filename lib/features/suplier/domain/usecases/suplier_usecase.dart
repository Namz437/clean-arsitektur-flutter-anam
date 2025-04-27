import 'package:cek/features/suplier/data/models/suplier_model.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cek/features/suplier/domain/repositories/suplier_repo.dart';
import 'package:dartz/dartz.dart';

class SuplierUsecasesGetAll {
  final SuplierRepo suplierRepo;

  SuplierUsecasesGetAll({required this.suplierRepo});

  Future<Either<Exception, List<Suplier>>> execute() async {
    return await suplierRepo.getAllSuplier();
  }
}

class SuplierUsecasesGetById {
  final SuplierRepo suplierRepo;

  SuplierUsecasesGetById({required this.suplierRepo});

  Future<Either<Exception, Suplier>> execute({required String id}) async {
    return await suplierRepo.getSuplierById(id: id);
  }
}

class SuplierUsecasesAddSuplier {
  final SuplierRepo suplierRepo;

  SuplierUsecasesAddSuplier({required this.suplierRepo});

  Future<Either<Exception, void>> execute({required SuplierModel suplier}) async {
    return await suplierRepo.addSuplier(suplier: suplier);
  }
}

class SuplierUsecasesEditSuplier {
  final SuplierRepo suplierRepo;

  SuplierUsecasesEditSuplier({required this.suplierRepo});


  Future<Either<Exception, void>> execute({required SuplierModel suplier}) async {
    return await suplierRepo.editSuplier(suplier: suplier);
  }
}

class SuplierUsecasesDeleteSuplier {
  final SuplierRepo suplierRepo;

  SuplierUsecasesDeleteSuplier({required this.suplierRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await suplierRepo.deleteSuplier(id: id);
  }
}