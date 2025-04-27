part of 'kategori_produk_bloc.dart';

abstract class KategoriProdukState extends Equatable {}

class KategoriProdukInitial extends KategoriProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class KategoriProdukStateLoading extends KategoriProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KategoriProdukStateError extends KategoriProdukState {
  final String message;

  KategoriProdukStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class KategoriProdukStateLoadedAll extends KategoriProdukState {
  final List<KategoriProduk> kategoriProduks;

  KategoriProdukStateLoadedAll({required this.kategoriProduks});

  @override
  // TODO: implement props
  List<Object?> get props => [kategoriProduks];
}

class KategoriProdukStateLoaded extends KategoriProdukState {
  final KategoriProduk kategoriProduks;

  KategoriProdukStateLoaded({required this.kategoriProduks});

  @override
  // TODO: implement props
  List<Object?> get props => [kategoriProduks];
}

class KategoriProdukStateSuccess extends KategoriProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
