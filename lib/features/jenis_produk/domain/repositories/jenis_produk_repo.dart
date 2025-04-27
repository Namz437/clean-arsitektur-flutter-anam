import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:dartz/dartz.dart';

abstract class JenisProdukRepo {
  //future tipe data bisa banyak
  Future<Either<Exception, List<JenisProduk>>> getAllJenisProduk();
  Future<Either<Exception, JenisProduk>> getJenisProdukById({required String id});
  Future<Either<Exception, void>> addJenisProduk({required JenisProdukModel jenisProduk});
  Future<Either<Exception, void>> editJenisProduk({required JenisProdukModel jenisProduk});
  Future<Either<Exception, void>> deleteJenisProduk({required String id});
}