import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';

Widget buildSearchTextField(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * .9,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      onChanged: (value) {
        context
            .read<ChatContactBloc>()
            .add(FilterContactListEvent(term: value));
      },
      cursorColor: const Color(0XF757575),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        fillColor: Colors.white,
        labelText: "Search",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide:
              BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
      ),
    ),
  );
}
