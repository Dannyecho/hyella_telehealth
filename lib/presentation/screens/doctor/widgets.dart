import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';

Widget homeButton(
  BuildContext context, {
  required String label,
  required FaIcon icon,
  Color? background,
  Color? iconBackground,
  int? badge,
  GestureTapCallback? onTap,
}) {
  final _width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: _width * .43,
      // height: _width * .2,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: iconBackground,
                ),
                child: icon,
              ),
              SizedBox(
                width: _width * .28,
                child: Text(
                  label,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          badge != null && badge > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    // width: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      badge.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: iconBackground ?? Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ),
  );
}
