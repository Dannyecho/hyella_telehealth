import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';

class CheckboxFieldBuilder extends BaseInputBuilder {
  dynamic value = false;
  String key;
  EndpointFormFields field;
  BuildContext context;

  void Function()? onUpdate;
  late final validator;

  CheckboxFieldBuilder({
    required this.key,
    required this.field,
    required this.context,
    super.initialValue,
  }) : super(context: context, key: key, field: field);

  @override
  Widget get widget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: CheckboxListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(field.fieldLabel!),
          value: context.read<FormBuilderBloc>().state.formData[key]!.value,
          onChanged: (value) => context
              .read<FormBuilderBloc>()
              .add(SetField(key: key, value: value)),
        ),
      );
}
