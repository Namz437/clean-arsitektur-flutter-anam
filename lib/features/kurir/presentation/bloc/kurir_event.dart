part of 'kurir_bloc.dart';

abstract class KurirEvent extends Equatable {}

class KurirEventAdd extends KurirEvent {
  final KurirModel kurirModel;

  KurirEventAdd({required this.kurirModel});

  @override
  List<Object?> get props => [kurirModel];
}

class KurirEventEdit extends KurirEvent {
  final KurirModel kurirModel;

  KurirEventEdit({required this.kurirModel});

  @override
  List<Object?> get props => [kurirModel];
}

class KurirEventDelete extends KurirEvent {
  final String id;

  KurirEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class KurirEventGetAll extends KurirEvent {
  @override
  List<Object?> get props => [];
}

class KurirEventGetById extends KurirEvent {
  final String id;

  KurirEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}

