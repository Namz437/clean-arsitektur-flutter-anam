import 'package:cek/features/kategori_produk/data/datasources/kategori_produk_datasource.dart';
import 'package:cek/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:cek/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:dartz/dartz.dart';

class KategoriProdukRepoImpl implements KategoriProdukRepo {
  //menambahkan ProdukRemoteDataSource
  final KategoriProdukRemoteDataSource kategoriprodukRemoteDataSource;

  KategoriProdukRepoImpl({required this.kategoriprodukRemoteDataSource});
  @override
  Future<Either<Exception, void>> addKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    try {
      final data = await kategoriprodukRemoteDataSource.addKategoriProduk(kategoriProduk: kategoriProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteKategoriProduk({required String id}) async {
    try {
      final data = await kategoriprodukRemoteDataSource.deleteKategoriProduk(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editKategoriProduk(
      {required KategoriProdukModel kategoriProduk}) async {
    try {
      final data = await kategoriprodukRemoteDataSource.editKategoriProduk(kategoriProduk: kategoriProduk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<KategoriProduk>>> getAllKategoriProduk() async {
    try {
      final data = await kategoriprodukRemoteDataSource.getAllKategoriProduk();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, KategoriProduk>> getKategoriProdukById({required String id}) async {
    try {
      final data = await kategoriprodukRemoteDataSource.getKategoriProdukById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}