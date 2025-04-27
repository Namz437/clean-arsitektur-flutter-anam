import 'package:cek/features/keranjang/data/datasources/keranjang_datasource.dart';
import 'package:cek/features/keranjang/data/models/keranjang_model.dart';
import 'package:cek/features/keranjang/domain/entities/keranjang.dart';
import 'package:cek/features/keranjang/domain/repositories/keranjang_repo.dart';
import 'package:dartz/dartz.dart';

class KeranjangRepoImpl implements KeranjangRepo {
  //menambahkan KeranjangRemoteDataSource
  final KeranjangRemoteDataSource keranjangRemoteDataSource;

  KeranjangRepoImpl({required this.keranjangRemoteDataSource});

  @override
  Future<Either<Exception, void>> addKeranjang(
      {required KeranjangModel keranjang}) async {
    try {
      final data =
          await keranjangRemoteDataSource.addKeranjang(keranjang: keranjang);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteKeranjang({required String id}) async {
    try {
      final data = await keranjangRemoteDataSource.deleteKeranjang(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editKeranjang(
      {required KeranjangModel keranjang}) async {
    try {
      final data =
          await keranjangRemoteDataSource.editKeranjang(keranjang: keranjang);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Keranjang>>> getAllkeranjang() async {
    try {
      final data = await keranjangRemoteDataSource.getAllKeranjang();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Keranjang>> getkeranjangById(
      {required String id}) async {
    try {
      final data = await keranjangRemoteDataSource.getKeranjangById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}