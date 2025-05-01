import 'package:bloc/bloc.dart';
import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cek/features/jenis_produk/domain/usecases/jenis_produk_uscase.dart';
import 'package:equatable/equatable.dart';

part 'jenis_produk_event.dart';
part 'jenis_produk_state.dart';

class JenisProdukBloc extends Bloc<JenisProdukEvent, JenisProdukState> {
  final JenisProdukUsecasesAddJenisProduk jenisprodukUsecasesAdd;
  final JenisProdukUsecasesEditJenisProduk jenisprodukUsecasesEditJenisProduk;
  final JenisProdukUsecasesDeleteJenisProduk
      jenisprodukUsecasesDeleteJenisProduk;
  final JenisProdukUsecasesGetAll jenisprodukUsecasesGetAll;
  final JenisProdukUsecasesGetById jenisprodukUsecasesGetById;
  JenisProdukBloc(
      {required this.jenisprodukUsecasesAdd,
      required this.jenisprodukUsecasesEditJenisProduk,
      required this.jenisprodukUsecasesDeleteJenisProduk,
      required this.jenisprodukUsecasesGetAll,
      required this.jenisprodukUsecasesGetById})
      : super(JenisProdukInitial()) {
    on<JenisProdukEventAdd>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisprodukUsecasesAdd.execute(
          jenisProduk: event.jenisprodukModel);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());

          add(JenisProdukEventGetAll());
        },
      );
    });
    on<JenisProdukEventEdit>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisprodukUsecasesEditJenisProduk.execute(
          jenisProduk: event.jenisprodukModel);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());

          add(JenisProdukEventGetAll());
        },
      );
    });
    on<JenisProdukEventDelete>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data =
          await jenisprodukUsecasesDeleteJenisProduk.execute(id: event.id);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateSuccess());

          add(JenisProdukEventGetAll());
        },
      );
    });
    on<JenisProdukEventGetAll>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisprodukUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateLoadedAll(jenisProduks: r));
        },
      );
    });
    on<JenisProdukEventGetById>((event, emit) async {
      emit(JenisProdukStateLoading());
      final data = await jenisprodukUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(JenisProdukStateError(message: l.toString()));
        },
        (r) {
          emit(JenisProdukStateLoaded(jenisProduks: r));
        },
      );
    });
  }
}
