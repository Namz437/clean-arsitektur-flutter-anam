import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cek/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KategoriProdukPages extends StatelessWidget {
  const KategoriProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger event hanya sekali saat build pertama
    Future.microtask(() {
      context.read<KategoriProdukBloc>().add(KategoriProdukEventGetAll());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Produk Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showKategoriProdukFormModal(context);
            },
            icon: Icon(Icons.plus_one),
          )
        ],
      ),
             drawer: const CustomDrawer(), //sidebar
      body: BlocBuilder<KategoriProdukBloc, KategoriProdukState>(
        builder: (context, state) {
          if (state is KategoriProdukStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is KategoriProdukStateLoadedAll) {
            return ListView.builder(
              itemCount: state.kategoriProduks.length,
              itemBuilder: (context, index) {
                var kategoriProduk = state.kategoriProduks[index];
                return ListTile(
                  title: Text(kategoriProduk.namaKategori),
                  subtitle: Text(kategoriProduk.deskripsi),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showKategoriProdukFormModal(
                            context,
                            isEdit: true,
                            kategoriProduk: kategoriProduk,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<KategoriProdukBloc>().add(
                              KategoriProdukEventDelete(id: kategoriProduk.id));
                          context.read<KategoriProdukBloc>().add(KategoriProdukEventGetAll());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is KategoriProdukStateError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }

  void showKategoriProdukFormModal(BuildContext context,
      {bool isEdit = false, KategoriProduk? kategoriProduk}) {
    final namaKategoriController =
        TextEditingController(text: isEdit ? kategoriProduk?.namaKategori : '');
    final deskripsiKategoriController =
        TextEditingController(text: isEdit ? kategoriProduk?.deskripsi : '');

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaKategoriController,
                decoration: InputDecoration(labelText: 'Nama Kategori'),
              ),
              TextFormField(
                controller: deskripsiKategoriController,
                decoration: InputDecoration(labelText: 'Deskripsi Kategori'),
              ),
              BlocBuilder<KategoriProdukBloc, KategoriProdukState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      final kategoriProdukModel = KategoriProdukModel(
                        id: isEdit ? kategoriProduk!.id : '',
                        namaKategori: namaKategoriController.text,
                        deskripsi: deskripsiKategoriController.text,
                      );
                      if (isEdit) {
                        context.read<KategoriProdukBloc>().add(
                            KategoriProdukEventEdit(kategoriprodukModel: kategoriProdukModel));
                      } else {
                        context.read<KategoriProdukBloc>().add(
                            KategoriProdukEventAdd(kategoriprodukModel: kategoriProdukModel));
                      }
                    },
                    icon: state is KategoriProdukStateLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.save),
                    label: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Kategori'),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
