part of 'kategori_produk_bloc.dart';

abstract class KategoriProdukEvent extends Equatable {}

class KategoriProdukEventAdd extends KategoriProdukEvent {
  final KategoriProdukModel kategoriprodukModel;

  KategoriProdukEventAdd({required this.kategoriprodukModel});

  @override
  List<Object?> get props => [kategoriprodukModel];
}

class KategoriProdukEventEdit extends KategoriProdukEvent {
  final KategoriProdukModel kategoriprodukModel;

  KategoriProdukEventEdit({required this.kategoriprodukModel});

  @override
  List<Object?> get props => [kategoriprodukModel];
}

class KategoriProdukEventDelete extends KategoriProdukEvent {
  final String id;

  KategoriProdukEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class KategoriProdukEventGetAll extends KategoriProdukEvent {
  @override
  List<Object?> get props => [];
}

class KategoriProdukEventGetById extends KategoriProdukEvent {
  final String id;

  KategoriProdukEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}
