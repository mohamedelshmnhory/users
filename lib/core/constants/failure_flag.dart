enum FailureFlags {
  ok('OK'),
  invalidEntry('INVALID_ENTRY'),
  validToken('VALID_TOKEN'),
  anotherDevice('ANOTHER_DEVICE'),
  invalidToken('INVALID_TOKEN'),
  endOFMonth('END_OF_MONTH'),
  maintenance('MAINTINANCE'),
  upgradeRequired('UPGRADE_REQUIRED'),
  userNotFound('NOT_FOUND'),
  joiningRequest('JOINING_REQUEST'),
  newUser('NEW_USER'),
  notApproved('NOT_APPROVED'),
  criticalUpgrade('CRITICAL_UPGRADE'),
  normalUpgrade('NOMINAL_UPGRADE'),
  unknown('unknown');

  final String? message;

  const FailureFlags(this.message);

  static FailureFlags getFlag(String flag) {
    for (FailureFlags failureMessages in FailureFlags.values) {
      if (failureMessages.message == flag) return failureMessages;
    }
    return FailureFlags.unknown;
  }
}

enum QrcodeStatus {
  found('VALID',"found"),
  notFound('NOT_FOUND',"not_found"),
  unknown('UNKNOWN',"unknown");

  final String message;
  final String text;

  const QrcodeStatus(this.message,this.text);

  static QrcodeStatus getFlag(String flag) {
    for (QrcodeStatus failureMessages in QrcodeStatus.values) {
      if (failureMessages.message == flag) return failureMessages;
    }
    return QrcodeStatus.unknown;
  }
}
