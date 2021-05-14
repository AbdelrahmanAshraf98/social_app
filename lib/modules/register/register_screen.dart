import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if(state is CreateUserSuccessState)
              navigateAndFinish(HomeLayout(),context);
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Register now and start getting socialized',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        prefix: Icons.person_outline,
                        controller: nameController,
                        label: 'Name',
                        type: TextInputType.text,
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
                          suffix: RegisterCubit.get(context).isPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixFn: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                        prefix: Icons.phone_android_outlined,
                        controller: phoneController,
                        label: 'Phone',
                        type: TextInputType.phone,
                        onValidation: (String value) {
                          if (value.isEmpty)
                            return "This Field mustn't be empty";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is RegisterLoadingState,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                        fallback: (context) => defaultMaterialButton(
                          text: 'Register',
                          fn: () {
                            if (formkey.currentState.validate())
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
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
                          Text('Have an account?'),
                          TextButton(
                              onPressed: () {
                                navigateTo(LoginScreen(), context);
                              },
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ))
                        ],
                      ),
                      Image(
                        image: AssetImage('assets/images/account.png'),
                      ),
                    ],
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
