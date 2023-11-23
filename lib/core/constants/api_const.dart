class ApiConst {
  ApiConst._();
  static const String baseUrl = "http://192.168.1.6:8000/api/";

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String currentLoginUser = "auth/me";
  static const String logout = "auth/logout";
  static const String updatePassword = "auth/update_password";
  static const String updateProfile = "auth/update_profile";

  static const String doctorSchedule = "doctor/schedule";
  static const String doctorMySchedule = "doctor/my_schedule";
  static const String scheduleCreate = "doctor/schedule/create";
  static const String scheduleUpdate = "doctor/schedule/update";
  static const String doctorAll = "doctor/all";
  static const String doctorPlaces = "doctor/places/";
  static const String reservationTodayTotal = "reservation/today_total";
  static const String reservationBook = "reservation/book";
  static const String reservationDetail = "reservation/detail/";
  static const String reservationQuota = "reservation/quota/";

  /// Get my reservation
  /// params: patient_id
  /// reservation/my?patient_id=1
  static const String reservationMy = "reservation/my";

  /// /api/reservation/all?limit=5&page=1
  static const String reservationAll = "reservation/all";
  static const String reservationApprove = "reservation/approve";

  static const String announcementAll = "announcement/all";
  static const String announcementCreate = "announcement/create";
  static const String announcementUpdate = "announcement/update";
  static const String announcementDelete = "announcement/delete";

  // /medical_record/icds?search=Arthrodesis
  static const String medicalRecordIcds = "medical_record/icds";
  static const String medicalRecordAdd = "medical_record/add";
  // medical_record/my?patient_id=1&limit=3
  static const String medicalRecordMy = "medical_record/my";

  static const String patientAll = "patient/all";
  static const String patientUpdateAccessCode = "patient/update_access_code";

  // /notification/all
  static const String notificationAll = "notification/all";
  static const String notificationRead = "notification/read";
}
