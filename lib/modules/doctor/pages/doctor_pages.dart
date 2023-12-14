import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/views/ui/doctor_dashboard_view.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/views/ui/input_medical_record_view.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/views/ui/select_icds_view.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/views/ui/detail_patient_view.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/views/ui/patient_list_view.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/views/ui/detail_queue_view.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/views/ui/patient_queue_view.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/views/ui/create_places_view.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/views/ui/create_schedule_view.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/views/ui/places_view.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/views/ui/schedule_view.dart';
import 'package:get/get.dart';

class DoctorPages {
  DoctorPages._();

  static List<GetPage> getPages() => [
        GetPage(
          name: DoctorRoutesConst.doctor,
          page: () => const DoctorHomeView(),
        ),
        GetPage(
          name: DoctorRoutesConst.patientQueue,
          page: () => const PatientQueueView(),
        ),
        GetPage(
          name: DoctorRoutesConst.patientQueueDetail,
          page: () => const DetailQueueView(),
        ),
        GetPage(
          name: DoctorRoutesConst.selectIcds,
          page: () => const SelectICDSView(),
        ),
        GetPage(
          name: DoctorRoutesConst.medicalRecord,
          page: () => const InputMedicalRecordView(),
        ),
        GetPage(
          name: DoctorRoutesConst.patientList,
          page: () => const PatientListView(),
        ),
        GetPage(
          name: DoctorRoutesConst.patientDetail,
          page: () => const DetailPatientView(),
        ),
        GetPage(
          name: DoctorRoutesConst.doctorScheduleList,
          page: () => const ScheduleView(),
        ),
        GetPage(
          name: DoctorRoutesConst.doctorScheduleCreate,
          page: () => const CreateScheduleView(),
        ),
        GetPage(
          name: DoctorRoutesConst.doctorPlaceList,
          page: () => const SelectPlaceView(),
        ),
        GetPage(
          name: DoctorRoutesConst.doctorPlaceCreate,
          page: () => const CreatePlaceView(),
        ),
      ];
}
