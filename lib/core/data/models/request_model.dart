import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RequestModel extends Equatable {
  RequestModel(this.progressListener);

  final cancelToken = CancelToken();
  void cancelRequest([dynamic reason]) => cancelToken.cancel(reason);

  final RequestProgressListener? progressListener;

  Map<String, dynamic> toJson();
}

class RequestProgressListener {
  RequestProgressListener({this.onSendProgress, this.onReceiveProgress});

  final Function(int, int)? onSendProgress;
  final Function(int, int)? onReceiveProgress;
}

class EmptyRequestModel extends RequestModel {
  EmptyRequestModel({RequestProgressListener? progressListener}) : super(progressListener);

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic> toJson() => {};
}
