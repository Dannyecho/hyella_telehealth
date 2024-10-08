import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/form_builder/form_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/logic/controllers/register_controller.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/reuseable.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late List<EndPointEntityDataFormsSignUp?>? editForm;
  late FormBuilder formBuilder;
  EndPointEntityData? endpoint;

  @override
  void initState() {
    super.initState();
    editForm =
        context.read<EndpointBloc>().state.endPointEntity!.data!.forms!.signUp!;

    formBuilder = FormBuilder(
      context,
      formObject: editForm!.first!,
      onSubmit: (url, formData) {
        RegisterController registerController = RegisterController();
        print("${formData} In init state");
        registerController.registerUser(url: url, formData: formData);
      },
    );

    endpoint = context.read<EndpointBloc>().state.endPointEntity?.data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/5.jpg',
                ),
                fit: BoxFit.fitHeight,
                // opacity: .2,
                alignment: Alignment.center,
                colorFilter: ColorFilter.linearToSrgbGamma(),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    endpoint?.client?.name ?? "Sign Up",
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.satisfy(
                      color: AppColors2.color1,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CachedNetworkImage(
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
                        .logo!,
                  ),
                  const Text(
                    "Register Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  reuseableText("Sign up with us and share our resources"),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocBuilder<FormBuilderBloc, FormBuilderState>(
                      builder: (context, state) {
                        return formBuilder.buildForm(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoute.signIn,
                  ),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
