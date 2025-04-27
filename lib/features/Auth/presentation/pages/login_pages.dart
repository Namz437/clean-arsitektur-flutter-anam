import 'package:cek/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cek/core/components/cubit/option_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            BlocProvider(
              create: (_) => OptionCubit(),
              child: BlocBuilder<OptionCubit, bool>(
                builder: (context, isObscure) {
                  return TextFormField(
                    controller: password,
                    obscureText: !isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context.read<OptionCubit>().change();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('/register');
                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login gagal. Periksa email atau password.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is AuthStateLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login berhasil!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.go('/produk');
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthEventLogin(
                            email: email.text,
                            password: password.text,
                          ),
                        );
                  },
                  child: Text(
                    state is AuthStateLoading ? 'Loading...' : 'Login',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
