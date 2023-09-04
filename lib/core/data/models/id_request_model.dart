import 'request_model.dart';

class IdRequestModel extends RequestModel {
  IdRequestModel({
    required this.id,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final int id;

  @override
  List<Object?> get props => [id];

  @override
   Map<String, dynamic>  toJson()   => {'id': id};
}
