import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget buildDoctorCard({
  required String imageUrl,
  required String doctorName,
  required String experience,
  required String specialization,
  required VoidCallback OnTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: OnTap,
      child: Card(
        color: Color.fromRGBO(5, 2, 11, 1),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(doctorName),
                  const SizedBox(height: 5),
                  Text("Experince: `$experience`years"),
                  Text(specialization),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
