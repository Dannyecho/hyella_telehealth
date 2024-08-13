import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';

class RadioFieldBuilder extends BaseInputBuilder {
  RadioFieldBuilder({
    required super.key,
    required super.context,
    required super.field,
    super.initialValue,
  }) {
    // context.read<FormBuilderBloc>().state.formData[key]?.value = initialValue;
  }

  List<Widget> getRadios() {
    List<Widget> listOps = [];
    if (field.formFieldOptions != null) {
      for (var option in field.formFieldOptions!) {
        listOps.add(
          RadioListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(option!.value),
            value: option.key,
            groupValue:
                context.read<FormBuilderBloc>().state.formData[key]?.value ??
                    initialValue,
            onChanged: (valueOp) {
              context
                  .read<FormBuilderBloc>()
                  .add(SetField(key: key, value: valueOp.toString()));
            },
          ),
        );
      }
    }
    return listOps;
  }

  @override
  Widget get widget => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(field.fieldLabel!), ...getRadios()],
      );
}
