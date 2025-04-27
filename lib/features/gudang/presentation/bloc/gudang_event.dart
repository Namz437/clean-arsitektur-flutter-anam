part of 'gudang_bloc.dart';

abstract class GudangEvent extends Equatable {}

class GudangEventAdd extends GudangEvent {
  final GudangModel gudangModel;

  GudangEventAdd({required this.gudangModel});

  @override
  List<Object?> get props => [gudangModel];
}

class GudangEventEdit extends GudangEvent {
  final GudangModel gudangModel;

  GudangEventEdit({required this.gudangModel});

  @override
  List<Object?> get props => [gudangModel];
}

class GudangEventDelete extends GudangEvent {
  final String id;

  GudangEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class GudangEventGetAll extends GudangEvent {
  @override
  List<Object?> get props => [];
}

class GudangEventGetById extends GudangEvent {
  final String id;

  GudangEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}

