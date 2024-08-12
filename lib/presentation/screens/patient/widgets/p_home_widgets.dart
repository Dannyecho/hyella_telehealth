import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

Row pHomeHeader(User? appUser) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${AppUtil.getGreeting()},",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "${appUser?.lastName}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "EMR: ${appUser?.emrNumber}",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      Image.asset(
        'assets/images/light-logo.png',
        width: 100,
      ),
    ],
  );
}
