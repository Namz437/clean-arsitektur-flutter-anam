import 'package:cek/features/gudang/data/models/gudang_model.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:dartz/dartz.dart';

abstract class GudangRepo {
  //future tipe data bisa banyak
  Future<Either<Exception, List<Gudang>>> getAllGudang();
  Future<Either<Exception, Gudang>> getGudangById({required String id});
  Future<Either<Exception, void>> addGudang({required GudangModel gudang});
  Future<Either<Exception, void>> editGudang({required GudangModel gudang});
  Future<Either<Exception, void>> deleteGudang({required String id});
}