// ignore_for_file: must_be_immutable

import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';

class ViewMyDate extends StatelessWidget {
  ViewMyDate({
    super.key,
  });
  CacheHelper prefs = CacheHelper();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("My name: ${prefs.getData(key: 'userName')}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("My iD: ${prefs.getData(key: 'id')}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
