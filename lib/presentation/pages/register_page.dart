import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/form_builder/form_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/logic/controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late List<EndPointEntityDataFormsSignUp?>? editForm;
  late FormBuilder formBuilder;
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            editForm!.first!.title!,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<FormBuilderBloc, FormBuilderState>(
              builder: (context, state) {
                return formBuilder.buildForm(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
