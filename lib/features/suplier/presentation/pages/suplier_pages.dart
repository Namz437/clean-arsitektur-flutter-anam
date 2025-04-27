import 'package:cek/core/components/custom-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cek/features/suplier/data/models/suplier_model.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cek/features/suplier/presentation/bloc/suplier_bloc.dart';

class SuplierPages extends StatelessWidget {
  const SuplierPages({super.key});

  @override
  Widget build(BuildContext context) {
     // Panggil event getAll sekali saat build pertama
    Future.microtask(() {
      context.read<SuplierBloc>().add(SuplierEventGetAll());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Suplier Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showSuplierFormModal(context); // open modal for adding a supplier
            },
            icon: Icon(Icons.plus_one),
          )
        ],
      ),
             drawer: const CustomDrawer(), //sidebar

      body: BlocBuilder<SuplierBloc, SuplierState>(
        builder: (context, state) {
          if (state is SuplierStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SuplierStateError) {
            return Center(child: Text(state.message));
          } else if (state is SuplierStateLoadedAll) {
            return ListView.builder(
              itemCount: state.supliers.length,
              itemBuilder: (context, index) {
                var suplier = state.supliers[index];
                return ListTile(
                  title: Text(suplier.namaSuplier),
                  subtitle: Text(suplier.nomorTelpon),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showSuplierFormModal(
                            context,
                            isEdit: true, // indicates it's for editing
                            suplier: suplier, // pass data to be edited
                          );
                        },
                      ),
                      // Delete button
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<SuplierBloc>().add(SuplierEventDelete(id: suplier.id));
                          context.read<SuplierBloc>().add(SuplierEventGetAll()); // refresh the list
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

  // Function to open bottom sheet for adding or editing supplier
  void showSuplierFormModal(BuildContext context,
      {bool isEdit = false, Suplier? suplier}) {
    final _namaController = TextEditingController(text: isEdit ? suplier?.namaSuplier : '');
    final _telponController = TextEditingController(text: isEdit ? suplier?.nomorTelpon : '');
    final _alamatController = TextEditingController(text: isEdit ? suplier?.alamat : '');

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Suplier'),
              ),
              TextFormField(
                controller: _telponController,
                decoration: InputDecoration(labelText: 'Nomor Telpon'),
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              BlocBuilder<SuplierBloc, SuplierState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      final suplierModel = SuplierModel(
                        id: isEdit ? suplier!.id : '', // id only during edit
                        namaSuplier: _namaController.text,
                        nomorTelpon: _telponController.text,
                        alamat: _alamatController.text,
                      );
                      if (isEdit) {
                        // send edit event
                        context.read<SuplierBloc>().add(SuplierEventEdit(suplierModel: suplierModel));
                      } else {
                        // send add event
                        context.read<SuplierBloc>().add(SuplierEventAdd(suplierModel: suplierModel));
                      }
                    },
                    icon: state is SuplierStateLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.save),
                    label: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Suplier'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
