import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/gudang/data/models/gudang_model.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:cek/features/suplier/data/datasources/suplier_datasource.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GudangPages extends StatelessWidget {
  const GudangPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil event getAll sekali saat build pertama
    Future.microtask(() {
      context.read<GudangBloc>().add(GudangEventGetAll());
    });

    // DataSource untuk ambil data Suplier
    final suplierDataSource = SuplierRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Gudang Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showGudangFormModal(context);
            },
            icon: Icon(Icons.plus_one),
          )
        ],
      ),
             drawer: const CustomDrawer(), //sidebar
      body: BlocListener<GudangBloc, GudangState>(
        listener: (context, state) {
          if (state is GudangStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<GudangBloc, GudangState>(
          builder: (context, state) {
            if (state is GudangStateLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GudangStateLoadedAll) {
              return ListView.builder(
                itemCount: state.gudangs.length,
                itemBuilder: (context, index) {
                  final gudang = state.gudangs[index];

                  return FutureBuilder<Suplier?>( 
                    future: gudang.suplierUid != null
                        ? suplierDataSource.getSuplierById(id: gudang.suplierUid!)
                        : Future.value(null),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text("Loading..."));
                      }

                      final suplier = snapshot.data;
                      final namaSuplier = suplier?.namaSuplier ?? 'Tidak ada suplier';

                      return ListTile(
                        title: Text(gudang.namaGudang),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gudang.kota),
                            Text('Suplier: $namaSuplier'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showGudangFormModal(
                                  context,
                                  isEdit: true,
                                  gudang: gudang,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<GudangBloc>().add(GudangEventDelete(id: gudang.id));
                                context.read<GudangBloc>().add(GudangEventGetAll());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is GudangStateError) {
              return Center(child: Text(state.message));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  // Modal Form Gudang
  void showGudangFormModal(BuildContext context, {bool isEdit = false, Gudang? gudang}) {
    final kodeController = TextEditingController(text: isEdit ? gudang?.kodeGudang : '');
    final namaController = TextEditingController(text: isEdit ? gudang?.namaGudang : '');
    final kotaController = TextEditingController(text: isEdit ? gudang?.kota : '');
    final kapasitasController = TextEditingController(text: isEdit ? gudang?.kapasitas.toString() : '');
    final suplierUidController = TextEditingController(text: isEdit ? gudang?.suplierUid : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: kodeController,
                  decoration: InputDecoration(labelText: 'Kode Gudang'),
                ),
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Gudang'),
                ),
                TextFormField(
                  controller: kotaController,
                  decoration: InputDecoration(labelText: 'Lokasi Gudang'),
                ),
                TextFormField(
                  controller: kapasitasController,
                  decoration: InputDecoration(labelText: 'Kapasitas'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: suplierUidController,
                  decoration: InputDecoration(labelText: 'Suplier ID'),
                ),
                SizedBox(height: 16),
                BlocListener<GudangBloc, GudangState>(
                  listener: (context, state) {
                    if (state is GudangStateSuccess) {
                      Navigator.of(context).pop();
                      context.read<GudangBloc>().add(GudangEventGetAll());
                    }
                    if (state is GudangStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final gudangBaru = GudangModel(
                        id: isEdit ? gudang!.id : '',
                        kodeGudang: kodeController.text,
                        namaGudang: namaController.text,
                        kota: kotaController.text,
                        kapasitas: kapasitasController.text,
                        suplierUid: suplierUidController.text.isNotEmpty ? suplierUidController.text : null,
                      );

                      if (isEdit) {
                        context.read<GudangBloc>().add(GudangEventEdit(gudangModel: gudangBaru));
                      } else {
                        context.read<GudangBloc>().add(GudangEventAdd(gudangModel: gudangBaru));
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text(isEdit ? 'Simpan Data' : 'Tambah Gudang'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
