import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class PinputView extends StatefulWidget {
  const PinputView({Key? key}) : super(key: key);

  @override
  _PinputViewState createState() => _PinputViewState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _PinputViewState extends State<PinputView> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  final GlobalRepositoryService _globalRepositoryService =
      GlobalRepositoryService();

  User? user;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _globalRepositoryService.getCurrentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Colors.redAccent;
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        errorText: showError ? 'PIN yang anda masukkan salah' : null,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          if (int.parse(pin) == user?.accessCode) {
            Get.offNamed(PatientsRoutesConst.medicalReport);
          } else {
            Get.snackbar(
              'Gagal',
              'PIN yang anda masukkan salah',
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
            controller.clear();

            // refocus
            Future.delayed(const Duration(milliseconds: 100), () {
              FocusScope.of(context).requestFocus(focusNode);
            });
          }
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class EnterPasscodeView extends StatefulWidget {
  const EnterPasscodeView({Key? key}) : super(key: key);

  @override
  State<EnterPasscodeView> createState() => _EnterPasscodeViewState();
}

class _EnterPasscodeViewState extends State<EnterPasscodeView>
    with AutomaticKeepAliveClientMixin {
  User? user;

  final GlobalRepositoryService _globalRepositoryService =
      GlobalRepositoryService();

  @override
  void initState() {
    super.initState();
    _globalRepositoryService.getCurrentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  Future<void> setUser() async {
    var newUser = await _globalRepositoryService.getCurrentUser();
    setState(() {
      user = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Conditional.single(
          context: context,
          conditionBuilder: (_) => user?.accessCode != null,
          widgetBuilder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OtpHeader(),
              const PinputView(),
              const SizedBox(height: 44),
              GestureDetector(
                onTap: () async {
                  await Get.toNamed(AppRoutes.privateInformation);
                  await setUser();
                },
                child: Text(
                  'Lupa PIN?',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromRGBO(62, 116, 165, 1),
                  ),
                ),
              ),
            ],
          ),
          fallbackBuilder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Anda belum memiliki pin',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(30, 60, 87, 1),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Silahkan buat pin anda terlebih dahulu',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromRGBO(133, 153, 170, 1),
                ),
              ),
              const SizedBox(height: 64),
              const SizedBox(height: 44),
              GestureDetector(
                onTap: () async {
                  await Get.toNamed(AppRoutes.privateInformation);
                  await setUser();
                },
                child: Text(
                  'Buat PIN',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromRGBO(62, 116, 165, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OtpHeader extends StatelessWidget {
  const OtpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Verifikasi',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(30, 60, 87, 1),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Masukkan pin anda untuk melanjutkan',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color.fromRGBO(133, 153, 170, 1),
          ),
        ),
        const SizedBox(height: 64),
      ],
    );
  }
}
