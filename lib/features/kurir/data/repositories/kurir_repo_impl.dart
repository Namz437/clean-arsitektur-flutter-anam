import 'package:cek/features/kurir/data/datasources/kurir_datasource.dart';
import 'package:cek/features/kurir/data/models/kurir_model.dart';
import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cek/features/kurir/domain/repositories/kurir_repo.dart';
import 'package:dartz/dartz.dart';

class KurirRepoImpl implements KurirRepo {
  //menambahkan ProdukRemoteDataSource
  final KurirRemoteDataSource kurirRemoteDataSource;

  KurirRepoImpl({required this.kurirRemoteDataSource});
  @override
  Future<Either<Exception, void>> addKurir(
      {required KurirModel kurir}) async {
    try {
      final data = await kurirRemoteDataSource.addKurir(kurir: kurir);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteKurir({required String id}) async {
    try {
      final data = await kurirRemoteDataSource.deleteKurir(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editKurir(
      {required KurirModel kurir}) async {
    try {
      final data = await kurirRemoteDataSource.editKurir(kurir: kurir);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Kurir>>> getAllKurir() async {
    try {
      final data = await kurirRemoteDataSource.getAllKurir();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Kurir>> getKurirById({required String id}) async {
    try {
      final data = await kurirRemoteDataSource.getKurirById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}