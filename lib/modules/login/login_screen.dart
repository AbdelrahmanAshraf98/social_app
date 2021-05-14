import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState)
              showToast(msg: state.error, color: Colors.red);
            if (state is LoginSuccessState) {
              showToast(msg: 'Logged in Successfully', color: Colors.green);
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateAndFinish(HomeLayout(), context);
              });
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now and start getting socialized',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          prefix: Icons.email_outlined,
                          controller: emailController,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          onValidation: (String value) {
                            if (value.isEmpty)
                              return "This Field mustn't be empty";
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextFormField(
                            prefix: Icons.lock_outlined,
                            controller: passwordController,
                            label: 'Password',
                            type: TextInputType.text,
                            onValidation: (String value) {
                              if (value.isEmpty)
                                return "This Field mustn't be empty";
                              return null;
                            },
                            suffix: LoginCubit.get(context).isPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixFn: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is LoginLoadingState,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultMaterialButton(
                            text: 'Login',
                            fn: () {
                              if (formKey.currentState.validate())
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                            },
                            context: context,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(RegisterScreen(), context);
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
                          ],
                        ),
                        Image(
                          image: AssetImage('assets/images/login.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
