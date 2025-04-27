import 'package:cek/features/suplier/data/datasources/suplier_datasource.dart';
import 'package:cek/features/suplier/data/models/suplier_model.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cek/features/suplier/domain/repositories/suplier_repo.dart';
import 'package:dartz/dartz.dart';

class SuplierRepoImpl implements SuplierRepo {
  //menambahkan ProdukRemoteDataSource
  final SuplierRemoteDataSource suplierRemoteDataSource;

  SuplierRepoImpl({required this.suplierRemoteDataSource});
  @override
  Future<Either<Exception, void>> addSuplier(
      {required SuplierModel suplier}) async {
    try {
      final data = await suplierRemoteDataSource.addSuplier(suplier: suplier);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteSuplier({required String id}) async {
    try {
      final data = await suplierRemoteDataSource.deleteSuplier(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editSuplier(
      {required SuplierModel suplier}) async {
    try {
      final data = await suplierRemoteDataSource.editSuplier(suplier: suplier);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Suplier>>> getAllSuplier() async {
    try {
      final data = await suplierRemoteDataSource.getAllSuplier();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Suplier>> getSuplierById({required String id}) async {
    try {
      final data = await suplierRemoteDataSource.getSuplierById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}