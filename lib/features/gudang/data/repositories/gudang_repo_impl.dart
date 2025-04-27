import 'package:cek/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:cek/features/gudang/data/models/gudang_model.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/gudang/domain/repositories/gudang_repo.dart';
import 'package:dartz/dartz.dart';

class GudangRepoImpl implements GudangRepo {
  //menambahkan ProdukRemoteDataSource
  final GudangRemoteDataSource gudangRemoteDataSource;

  GudangRepoImpl({required this.gudangRemoteDataSource});
  @override
  Future<Either<Exception, void>> addGudang(
      {required GudangModel gudang}) async {
    try {
      final data = await gudangRemoteDataSource.addGudang(gudang: gudang);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteGudang({required String id}) async {
    try {
      final data = await gudangRemoteDataSource.deleteGudang(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editGudang(
      {required GudangModel gudang}) async {
    try {
      final data = await gudangRemoteDataSource.editGudang(gudang: gudang);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Gudang>>> getAllGudang() async {
    try {
      final data = await gudangRemoteDataSource.getAllGudang();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Gudang>> getGudangById({required String id}) async {
    try {
      final data = await gudangRemoteDataSource.getGudangById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}