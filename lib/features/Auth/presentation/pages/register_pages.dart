import 'package:cek/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cek/core/components/cubit/option_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username Field
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Email Field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Password Field
            BlocProvider(
              create: (_) => OptionCubit(),
              child: BlocBuilder<OptionCubit, bool>(
                builder: (context, isObscure) {
                  return TextFormField(
                    controller: passwordController,
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
            const SizedBox(height: 15),
            // Button Register
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Register gagal. Coba lagi.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is AuthStateLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Register berhasil!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.go('/');
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
                      AuthEventRegister(
                        name: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  child: Text(
                    state is AuthStateLoading ? 'Loading...' : 'Register',
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
