import 'package:equatable/equatable.dart';

class FirebaseUserModel extends Equatable {
  final String PARAM;

  const FirebaseUserModel({required this.PARAM});

  factory FirebaseUserModel.fromMap(Map<String, dynamic> map) {
    return FirebaseUserModel(
      PARAM: map['PARAM'],
    );
  }

  Map<String,dynamic> toMap() =>{
    'PARAM':PARAM,
  };


  FirebaseUserModel copyWith({
    String? PARAM,
  }) {
    return FirebaseUserModel(
      PARAM: PARAM ?? this.PARAM,
    );
  }

  @override
  List<Object?> get props => [PARAM];

  @override
  bool get stringify => true;
}
