import 'package:cek/features/produk/data/models/produk_model.dart';
import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:dartz/dartz.dart';

abstract class ProdukRepositories {
  //future tipe data bisa banyak
  Future<Either<Exception, List<Produk>>> getAllProduk();
  Future<Either<Exception, Produk>> getProdukById({required String id});
  Future<Either<Exception, void>> addProduk({required ProdukModel produk});
  Future<Either<Exception, void>> editProduk({required ProdukModel produk});
  Future<Either<Exception, void>> deleteProduk({required String id});
}