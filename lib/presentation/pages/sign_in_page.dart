import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_event.dart';

import 'package:hyella_telehealth/logic/bloc/sign_in_state.dart';
import 'package:hyella_telehealth/logic/controllers/sign_in_controller.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/reuseable.dart';

part 'widgets/sign_in_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String userType = 'user_mgt_login';
  bool isStaff = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passWordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: buildAppBar(
          title: "Sign In",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            /* decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
              'assets/images/telehealth_img.jpg',
            ))), */
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* buildThirdPartyLogin(context),
                    Center(
                      child: reuseableText("Or login with your email account"),
                    ), */
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          imageUrl: context
                              .read<EndpointBloc>()
                              .state
                              .endPointEntity!
                              .data!
                              .client!
                              .logo!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseableText('Email'),
                          buildTextField(
                            focusNode: _emailFocusNode,
                            type: 'text',
                            hintText: 'Enter your email address',
                            icon: 'user',
                            onChange: (value) {
                              context.read<SignInBloc>().add(
                                    EmailEvent(email: value),
                                  );
                            },
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                _passWordFocusNode.requestFocus();
                              } else {
                                _emailFocusNode.requestFocus();
                              }
                            },
                          ),
                          reuseableText('Password'),
                          buildTextField(
                            focusNode: _passWordFocusNode,
                            type: 'password',
                            hintText: 'Enter your password',
                            icon: 'lock',
                            onChange: (value) {
                              context.read<SignInBloc>().add(
                                    PasswordEvent(password: value),
                                  );
                            },
                            onSubmitted: (p0) {
                              final signInController =
                                  SignInController(context);
                              signInController.handleSignIn();
                            },
                          ),
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              return CheckboxListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(
                                    "I'm a health provider",
                                    style: TextStyle(
                                      color: AppColors2.color1,
                                    ),
                                  ),
                                  value: state.isStaff,
                                  onChanged: (value) {
                                    context
                                        .read<SignInBloc>()
                                        .add(IsStaffEvent(isStaff: value!));
                                  });
                            },
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          forgotPassword(),
                          loginAndRegisterButton(
                              text: "Login",
                              type: 'login',
                              onTap: () {
                                final signInController =
                                    SignInController(context);
                                signInController.handleSignIn();
                              }),
                          loginAndRegisterButton(
                              text: "Register",
                              type: 'register',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.register);
                              }),
                        ],
                      ),
                    ),
                    // const Spacer(),
                  ],
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
