import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/kurir/data/models/kurir_model.dart';
import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cek/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KurirPages extends StatelessWidget {
  const KurirPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Memicu event getAll saat pertama kali halaman dibuka
    context.read<KurirBloc>().add(KurirEventGetAll());

    final gudangDataSource = GudangRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Kurir Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showKurirFormModal(context, gudangDataSource: gudangDataSource); // Modal form untuk tambah kurir
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
             drawer: const CustomDrawer(), //sidebar

      body: BlocListener<KurirBloc, KurirState>(
        listener: (context, state) {
          if (state is KurirStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<KurirBloc, KurirState>(
          builder: (context, state) {
            if (state is KurirStateLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is KurirStateLoadedAll) {
              return ListView.builder(
                itemCount: state.kurirs.length,
                itemBuilder: (context, index) {
                  final kurir = state.kurirs[index];

                  return FutureBuilder<Gudang?>( // Menampilkan nama gudang berdasarkan ID
                    future: (kurir.gudangUid?.isNotEmpty ?? false)
                        ? gudangDataSource.getGudangById(id: kurir.gudangUid!)
                        : Future.value(null),
                    builder: (context, snapshot) {
                      final namaGudang = snapshot.data?.namaGudang ?? 'Tidak ada Gudang';

                      return ListTile(
                        title: Text(kurir.namaKurir),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(kurir.noTelpon),
                            Text(kurir.email),
                            Text('Gudang: ' + namaGudang),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showKurirFormModal(
                                  context,
                                  isEdit: true,
                                  kurir: kurir,
                                  gudangDataSource: gudangDataSource,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<KurirBloc>().add(KurirEventDelete(id: kurir.id));
                                context.read<KurirBloc>().add(KurirEventGetAll()); // Memperbarui list setelah delete
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return SizedBox(); // fallback jika state belum dikenali
            }
          },
        ),
      ),
    );
  }

  // Modal Form Kurir (Tambah & Edit)
  void showKurirFormModal(
    BuildContext context, {
    bool isEdit = false,
    Kurir? kurir,
    required GudangRemoteDataSource gudangDataSource,
  }) {
    final _namaController = TextEditingController(text: isEdit ? kurir?.namaKurir : '');
    final _telponController = TextEditingController(text: isEdit ? kurir?.noTelpon : '');
    final _emailController = TextEditingController(text: isEdit ? kurir?.email : '');
    final _gudangController = TextEditingController(text: isEdit ? kurir?.gudangUid : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Kurir'),
              ),
              TextFormField(
                controller: _telponController,
                decoration: InputDecoration(labelText: 'Nomor Telpon'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _gudangController,
                decoration: InputDecoration(labelText: 'ID Gudang'),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  final kurirModel = KurirModel(
                    id: isEdit ? kurir!.id : '', // ID hanya diset saat edit
                    namaKurir: _namaController.text,
                    email: _emailController.text,
                    noTelpon: _telponController.text,
                    gudangUid: _gudangController.text,
                  );

                  if (isEdit) {
                    context.read<KurirBloc>().add(KurirEventEdit(kurirModel: kurirModel));
                  } else {
                    context.read<KurirBloc>().add(KurirEventAdd(kurirModel: kurirModel));
                  }

                  Navigator.pop(context); // Menutup modal setelah submit
                },
                icon: Icon(Icons.save),
                label: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Kurir'),
              ),
            ],
          ),
        );
      },
    );
  }
}
