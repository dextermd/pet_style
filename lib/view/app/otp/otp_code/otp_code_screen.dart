import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/view/app/menu/app_bar_back.dart';
import 'package:pet_style/view/widget/my_button.dart';
import 'package:pinput/pinput.dart';

class OtpCodeScreen extends StatefulWidget {
  final String phone;

  const OtpCodeScreen({
    super.key,
    required this.phone,
  });

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  String? otpCode;
  bool isLoading = false;
  bool invalidOtp = false;
  int resendTime = 60;
  late Timer countDownTimer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          resendTime--;
        });
      }
    });
  }

  void stopTimer() {
    if (countDownTimer.isActive) {
      countDownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(onPressed: () {
        context.pop();
      }),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryElement),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/lottie/otp-code2.json',
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                      const SizedBox(
                        width: 20,
                        height: 5,
                      ),
                      const Text(
                        "Введите код",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Мы отправили вам код подтверждения на номер телефона +373${widget.phone}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.containerColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: AppColors.primaryElement)),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText.withOpacity(0.8),
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: MyButton(
                          width: double.infinity,
                          onPressed: () {
                            if (otpCode != null) {
                              context.goNamed('home');
                            }
                          },
                          text: "Подтвердить",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                        text: "Не получили код? ",
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 14,
                        ),
                        children: [
                          resendTime == 0
                              ? TextSpan(
                                  text: "Отправить повторно",
                                  style: const TextStyle(
                                      color: AppColors.primaryLinkText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        resendTime = 60;
                                      });
                                      startTimer();
                                    },
                                )
                              : const TextSpan(
                                  text: "",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 14,
                                  ),
                                ),
                        ],
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      resendTime == 0
                          ? const SizedBox()
                          : Text(
                              "Выслать код повторно через 00:$resendTime",
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 14,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
