import 'package:cek/features/jenis_produk/data/datasources/jenis_produk_datasource.dart';
import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cek/features/jenis_produk/domain/repositories/jenis_produk_repo.dart';
import 'package:dartz/dartz.dart';

class JenisProdukRepoImpl implements JenisProdukRepo {
  //menambahkan ProdukRemoteDataSource
  final JenisProdukRemoteDataSource jenisprodukRemoteDataSource;

  JenisProdukRepoImpl({required this.jenisprodukRemoteDataSource});
  @override
  Future<Either<Exception, void>> addJenisProduk(
      {required JenisProdukModel jenisProduk}) async {
    try {
      final data = await jenisprodukRemoteDataSource.addJenisProduk(jenisProduk: jenisProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteJenisProduk({required String id}) async {
    try {
      final data = await jenisprodukRemoteDataSource.deleteJenisProduk(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editJenisProduk(
      {required JenisProdukModel jenisProduk}) async {
    try {
      final data = await jenisprodukRemoteDataSource.editJenisProduk(jenisProduk: jenisProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<JenisProduk>>> getAllJenisProduk() async {
    try {
      final data = await jenisprodukRemoteDataSource.getAllJenisProduk();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, JenisProduk>> getJenisProdukById({required String id}) async {
    try {
      final data = await jenisprodukRemoteDataSource.getJenisProdukById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}