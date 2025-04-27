import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cek/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JenisProdukPages extends StatelessWidget {
  const JenisProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil event getAll sekali saat build pertama
    Future.microtask(() {
      context.read<JenisProdukBloc>().add(JenisProdukEventGetAll());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis Produk Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showJenisProdukFormModal(context);
            },
            icon: Icon(Icons.plus_one),
          )
        ],
      ),
             drawer: const CustomDrawer(), //sidebar
      body: BlocBuilder<JenisProdukBloc, JenisProdukState>(
        builder: (context, state) {
          if (state is JenisProdukStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is JenisProdukStateError) {
            return Center(child: Text(state.message));
          } else if (state is JenisProdukStateLoadedAll) {
            return ListView.builder(
              itemCount: state.jenisProduks.length,
              itemBuilder: (context, index) {
                var jenisProduk = state.jenisProduks[index];
                return ListTile(
                  title: Text(jenisProduk.namaJenis),
                  subtitle: Text(jenisProduk.deskripsi),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showJenisProdukFormModal(
                            context,
                            isEdit: true,
                            jenisProduk: jenisProduk,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<JenisProdukBloc>().add(
                              JenisProdukEventDelete(id: jenisProduk.id));
                          context.read<JenisProdukBloc>().add(JenisProdukEventGetAll());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  void showJenisProdukFormModal(BuildContext context,
      {bool isEdit = false, JenisProduk? jenisProduk}) {
    final namaJenisProdukController =
        TextEditingController(text: isEdit ? jenisProduk?.namaJenis : '');
    final deskripsiProdukController =
        TextEditingController(text: isEdit ? jenisProduk?.deskripsi : '');

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaJenisProdukController,
                decoration: InputDecoration(labelText: 'Nama Jenis Produk'),
              ),
              TextFormField(
                controller: deskripsiProdukController,
                decoration: InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              BlocConsumer<JenisProdukBloc, JenisProdukState>(
                listener: (context, state) {
                  if (state is JenisProdukStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)));
                  }
                  if (state is JenisProdukStateSuccess) {
                    Navigator.pop(context); // tutup modal
                    context.read<JenisProdukBloc>().add(JenisProdukEventGetAll());
                  }
                },
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      final jenisProdukModel = JenisProdukModel(
                        id: isEdit ? jenisProduk!.id : '',
                        namaJenis: namaJenisProdukController.text,
                        deskripsi: deskripsiProdukController.text,
                      );
                      if (isEdit) {
                        context.read<JenisProdukBloc>().add(
                              JenisProdukEventEdit(jenisprodukModel: jenisProdukModel),
                            );
                      } else {
                        context.read<JenisProdukBloc>().add(
                              JenisProdukEventAdd(jenisprodukModel: jenisProdukModel),
                            );
                      }
                    },
                    icon: state is JenisProdukStateLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.save),
                    label: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Jenis Produk'),
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
