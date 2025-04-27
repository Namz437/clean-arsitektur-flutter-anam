part of 'jenis_produk_bloc.dart';

abstract class JenisProdukEvent extends Equatable {}

class JenisProdukEventAdd extends JenisProdukEvent {
  final JenisProdukModel jenisprodukModel;

  JenisProdukEventAdd({required this.jenisprodukModel});

  @override
  List<Object?> get props => [jenisprodukModel];
}

class JenisProdukEventEdit extends JenisProdukEvent {
  final JenisProdukModel jenisprodukModel;

  JenisProdukEventEdit({required this.jenisprodukModel});

  @override
  List<Object?> get props => [jenisprodukModel];
}

class JenisProdukEventDelete extends JenisProdukEvent {
  final String id;

  JenisProdukEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class JenisProdukEventGetAll extends JenisProdukEvent {
  @override
  List<Object?> get props => [];
}

class JenisProdukEventGetById extends JenisProdukEvent {
  final String id;

  JenisProdukEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}
