import 'package:bloc/bloc.dart';
import 'package:cek/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cek/features/kategori_produk/domain/usecases/kategori_produk_usecase.dart';
import 'package:equatable/equatable.dart';

part 'kategori_produk_event.dart';
part 'kategori_produk_state.dart';

class KategoriProdukBloc extends Bloc<KategoriProdukEvent, KategoriProdukState> {
  final KategoriProdukUsecasesAddKategoriProduk kategoriprodukUsecasesAdd;
  final KategoriProdukUsecasesEditKategoriProduk kategoriprodukUsecasesEditProduk;
  final KategoriProdukUsecasesDeleteKategoriProduk kategoriprodukUsecasesDeleteProduk;
  final KategoriProdukUsecasesGetAll kategoriprodukUsecasesGetAll;
  final KategoriProdukUsecasesGetById kategoriprodukUsecasesGetById;
  KategoriProdukBloc(
      {required this.kategoriprodukUsecasesAdd,
      required this.kategoriprodukUsecasesEditProduk,
      required this.kategoriprodukUsecasesDeleteProduk,
      required this.kategoriprodukUsecasesGetAll,
      required this.kategoriprodukUsecasesGetById})
      : super(KategoriProdukInitial()) {
    on<KategoriProdukEventAdd>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriprodukUsecasesAdd.execute(kategoriProduk: event.kategoriprodukModel);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());

          add(KategoriProdukEventGetAll());
        },
      );
    });
    on<KategoriProdukEventEdit>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data =
          await kategoriprodukUsecasesEditProduk.execute(kategoriProduk: event.kategoriprodukModel);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());

          add(KategoriProdukEventGetAll());
        },
      );
    });
    on<KategoriProdukEventDelete>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriprodukUsecasesDeleteProduk.execute(id: event.id);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateSuccess());

          add(KategoriProdukEventGetAll());
        },
      );
    });
    on<KategoriProdukEventGetAll>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriprodukUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateLoadedAll(kategoriProduks: r));
        },
      );
    });
    on<KategoriProdukEventGetById>((event, emit) async {
      emit(KategoriProdukStateLoading());
      final data = await kategoriprodukUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KategoriProdukStateError(message: l.toString()));
        },
        (r) {
          emit(KategoriProdukStateLoaded(kategoriProduks: r));
        },
      );
    });
  }
}
