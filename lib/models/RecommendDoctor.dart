import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RecommendedDoctor {
  final String name, speciality, institute, image;

  // factory RecommendedDoctor.fromJson(dynamic json) {
  //   return RecommendedDoctor(
  //     name: json["name"],
  //     speciality: json["speciality"],
  //     institute: json["institute"],
  //     image: json["image"]
  //   );
  // }

  const RecommendedDoctor({
    required this.name,
    required this.speciality,
    required this.institute,
    required this.image,
  });
}

const List<RecommendedDoctor> demo_recommended_doctor = [
  RecommendedDoctor(
    name: "Dr. Salina Zaman",
    speciality: "Medicine & Heart Spelist",
    institute: "Good Health Clinic",
    image: "assets/images/Salina_Zaman.png",
  ),
  RecommendedDoctor(
    name: "Dr. Serena Gome",
    speciality: "Medicine Specialist ",
    institute: "Good Health Clinic",
    image: "assets/images/Serena_Gome.png",
  ),
  RecommendedDoctor(
    name: "Dr. Salina Zaman",
    speciality: "Medicine & Heart Spelist",
    institute: "Good Health Clinic",
    image: "assets/images/Salina_Zaman.png",
  ),
  RecommendedDoctor(
    name: "Dr. Asma Khan",
    speciality: "Medicine & Heart Spelist",
    institute: "Good Health Clinic",
    image: "assets/images/Asma_Khan.png",
  ),
  RecommendedDoctor(
    name: "Dr. Salina Zaman",
    speciality: "Medicine & Heart Spelist",
    institute: "Good Health Clinic",
    image: "assets/images/Salina_Zaman.png",
  ),
];



