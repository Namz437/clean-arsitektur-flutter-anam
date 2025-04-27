import 'package:cek/features/kurir/data/models/kurir_model.dart';
import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cek/features/kurir/domain/repositories/kurir_repo.dart';
import 'package:dartz/dartz.dart';

class KurirUsecasesGetAll {
  final KurirRepo kurirRepo;

  KurirUsecasesGetAll({required this.kurirRepo});

  Future<Either<Exception, List<Kurir>>> execute() async {
    return await kurirRepo.getAllKurir();
  }
}

class KurirUsecasesGetById {
  final KurirRepo kurirRepo;

  KurirUsecasesGetById({required this.kurirRepo});

  Future<Either<Exception, Kurir>> execute({required String id}) async {
    return await kurirRepo.getKurirById(id: id);
  }
}

class KurirUsecasesAddKurir {
  final KurirRepo kurirRepo;

  KurirUsecasesAddKurir({required this.kurirRepo});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepo.addKurir(kurir: kurir);
  }
}

class KurirUsecasesEditKurir {
  final KurirRepo kurirRepo;

  KurirUsecasesEditKurir({required this.kurirRepo});


  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepo.editKurir(kurir: kurir);
  }
}

class KurirUsecasesDeleteKurir {
  final KurirRepo kurirRepo;

  KurirUsecasesDeleteKurir({required this.kurirRepo});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kurirRepo.deleteKurir(id: id);
  }
}