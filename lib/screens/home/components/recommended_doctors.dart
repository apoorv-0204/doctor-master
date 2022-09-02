import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'recommended_doctor_card.dart';
import '../../../models/RecommendDoctor.dart';

class RecommendedDoctors extends StatelessWidget {
  const RecommendedDoctors({
    Key? key,
  }) : super(key: key);

  Future<List<RecommendedDoctor>?> getRecommendDoctorList() async {
    
    print('Hello');

    List<RecommendedDoctor>? doctorList = await checker();
    print(doctorList);
    return doctorList;
  }

  Future<List<RecommendedDoctor>?> checker() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('doctors');
    List<RecommendedDoctor> doctorList = [];
    await ref.get().then((value) => {
      value.docs.forEach((element) async {
        print(element.data());
        doctorList.add(
           RecommendedDoctor(
              name: await element.get("name"),
              speciality: await element.get("speciality"),
              institute: await element.get("institute"),
              image: await element.get("image")
          )
        );
      })
    });
    print(doctorList);
    return doctorList;

  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: FutureBuilder<List<RecommendedDoctor>?>(
        future: getRecommendDoctorList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            print(snapshot.data);
            return PageView.builder(
              controller: PageController(viewportFraction: 0.85, initialPage: 3),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) => RecommendDoctorCard(
                doctor: snapshot.data![index],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
