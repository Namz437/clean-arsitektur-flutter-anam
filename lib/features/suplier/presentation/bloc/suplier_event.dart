part of 'suplier_bloc.dart';

abstract class SuplierEvent extends Equatable {}

class SuplierEventAdd extends SuplierEvent {
  final SuplierModel suplierModel;

  SuplierEventAdd({required this.suplierModel});

  @override
  List<Object?> get props => [suplierModel];
}

class SuplierEventEdit extends SuplierEvent {
  final SuplierModel suplierModel;

  SuplierEventEdit({required this.suplierModel});

  @override
  List<Object?> get props => [suplierModel];
}

class SuplierEventDelete extends SuplierEvent {
  final String id;

  SuplierEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class SuplierEventGetAll extends SuplierEvent {
  @override
  List<Object?> get props => [];
}

class SuplierEventGetById extends SuplierEvent {
  final String id;

  SuplierEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}

