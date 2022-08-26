// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Widgets/CounterText.dart';
import 'package:game/Widgets/CustomCircularProgressIndicator.dart';
import 'package:game/Widgets/RippleAnimation.dart';

class ToastService {
  static const _heightDivider = 7;

  static void errorToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    GlobalKey keyCircularProgress = GlobalKey();

    if (alignment == Alignment.bottomCenter) {
      visible.value = false;
    }

    showToastWidget(
      GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width + 10,
                height: MediaQuery.of(context).size.height / 7 + 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / _heightDivider,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                margin:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: AppColors.errorColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const RippleAnimation(
                          color: AppColors.white,
                          size: 15,
                          child: Icon(
                            Icons.error_rounded,
                            color: AppColors.errorColor,
                            size: 20.0,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisSize: title.isNotEmpty
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Visibility(
                                visible: title.isNotEmpty,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.22,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.18,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        child: Visibility(
                                          visible: counter ?? false,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: AppColors.redButton,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CounterText(
                                                count: progressDuration != null
                                                    ? progressDuration.inSeconds
                                                    : 0),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: message,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomCircularProgressIndicator(
                        key: keyCircularProgress,
                        duration: progressDuration ??
                            const Duration(milliseconds: 5500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
              }
              if (!visible.value) {
                visible.value = true;
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          }),
      context: context,
      animation: alignment == Alignment.bottomCenter
          ? StyledToastAnimation.slideFromBottom
          : StyledToastAnimation.slideFromTop,
      reverseAnimation: alignment == Alignment.bottomCenter
          ? StyledToastAnimation.slideToBottom
          : StyledToastAnimation.slideToTop,
      position: alignment == Alignment.bottomCenter
          ? StyledToastPosition.bottom
          : alignment == Alignment.topCenter
              ? StyledToastPosition.top
              : StyledToastPosition.center,
      isIgnoring: false,
      alignment: alignment,
      axis: Axis.vertical,
      textDirection: TextDirection.ltr,
      animDuration: const Duration(milliseconds: 500),
      duration: Duration.zero,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );
  }

  static void successToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    GlobalKey keyCircularProgress = GlobalKey();
    if (alignment == Alignment.bottomCenter) {
      visible.value = false;
    }

    showToastWidget(
        GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width + 10,
                height:
                    MediaQuery.of(context).size.height / _heightDivider + 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / _heightDivider,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                margin:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: AppColors.successColor,
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RippleAnimation(
                          color: AppColors.white,
                          size: 15,
                          child: Icon(
                            Icons.check_circle,
                            color: AppColors.successColor,
                            size: 20.0,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisSize: title.isNotEmpty
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Visibility(
                                visible: title.isNotEmpty,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.22,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.18,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        child: Visibility(
                                          visible: counter ?? false,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: AppColors.redButton,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CounterText(
                                                count: progressDuration != null
                                                    ? progressDuration.inSeconds
                                                    : 0),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: message,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomCircularProgressIndicator(
                        key: keyCircularProgress,
                        duration: progressDuration ??
                            const Duration(milliseconds: 5500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
              }
              if (!visible.value) {
                visible.value = true;
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          },
        ),
        context: context,
        animation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideFromBottom
            : StyledToastAnimation.slideFromTop,
        reverseAnimation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideToBottom
            : StyledToastAnimation.slideToTop,
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  static void infoToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    final keyCircularProgress = GlobalKey();
    if (alignment == Alignment.bottomCenter) {
      visible.value = false;
    }

    showToastWidget(
        GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width + 10,
                height:
                    MediaQuery.of(context).size.height / _heightDivider + 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.infoColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / _heightDivider,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                margin:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: AppColors.infoColor,
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RippleAnimation(
                          color: AppColors.white,
                          size: 15,
                          child: Icon(
                            Icons.info,
                            color: AppColors.infoColor,
                            size: 20.0,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisSize: title.isNotEmpty
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Visibility(
                                visible: title.isNotEmpty,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.22,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    // style: TextStyles(context,true).toasterMessage,
                                    children: [
                                      WidgetSpan(
                                        child: Visibility(
                                          visible: counter ?? false,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: AppColors.redButton,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CounterText(
                                                count: progressDuration != null
                                                    ? progressDuration.inSeconds
                                                    : 0),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: message,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomCircularProgressIndicator(
                        key: keyCircularProgress,
                        duration: progressDuration ??
                            const Duration(milliseconds: 5500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
                if (!visible.value) {
                  visible.value = true;
                }
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          },
        ),
        context: context,
        animation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideFromBottom
            : StyledToastAnimation.slideFromTop,
        reverseAnimation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideToBottom
            : StyledToastAnimation.slideToTop,
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  static void warningToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    final keyCircularProgress = GlobalKey();
    if (alignment == Alignment.bottomCenter) {
      visible.value = false;
    }

    showToastWidget(
      GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width + 10,
              height: MediaQuery.of(context).size.height / _heightDivider + 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.warningColor.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / _heightDivider,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
              margin:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColors.warningColor,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RippleAnimation(
                        color: AppColors.white,
                        size: 15,
                        child: Icon(
                          Icons.warning,
                          color: AppColors.warningColor,
                          size: 20.0,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: title.isNotEmpty
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            Visibility(
                              visible: title.isNotEmpty,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.22,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.18,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Visibility(
                                        visible: counter ?? false,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 2),
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.redButton,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: CounterText(
                                              count: progressDuration != null
                                                  ? progressDuration.inSeconds
                                                  : 0),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: message,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomCircularProgressIndicator(
                      key: keyCircularProgress,
                      duration: progressDuration ??
                          const Duration(milliseconds: 5500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onLongPressStart: (details) {
          CustomCircularProgressIndicator widget = keyCircularProgress
              .currentWidget as CustomCircularProgressIndicator;
          widget.animationController?.stop();
        },
        onLongPressEnd: (details) {
          CustomCircularProgressIndicator widget = keyCircularProgress
              .currentWidget as CustomCircularProgressIndicator;
          widget.animationController?.forward();
        },
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            // Down Swipe
            if (alignment == Alignment.bottomCenter) {
              dismissAllToast(showAnim: true);
            }
            if (!visible.value) {
              visible.value = true;
            }
          } else if (details.delta.dy < -sensitivity) {
            // Up Swipe
            if (alignment == Alignment.topCenter) {
              dismissAllToast(showAnim: true);
            }
          }
        },
      ),
      context: context,
      animation: alignment == Alignment.bottomCenter
          ? StyledToastAnimation.slideFromBottom
          : StyledToastAnimation.slideFromTop,
      reverseAnimation: alignment == Alignment.bottomCenter
          ? StyledToastAnimation.slideToBottom
          : StyledToastAnimation.slideToTop,
      position: alignment == Alignment.bottomCenter
          ? StyledToastPosition.bottom
          : alignment == Alignment.topCenter
              ? StyledToastPosition.top
              : StyledToastPosition.center,
      isIgnoring: false,
      alignment: alignment,
      axis: Axis.vertical,
      textDirection: TextDirection.ltr,
      animDuration: const Duration(milliseconds: 500),
      duration: Duration.zero,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }

  static void notificationToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    final keyCircularProgress = GlobalKey();
    if (alignment == Alignment.bottomCenter) {
      visible.value = false;
    }

    showToastWidget(
        GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width + 10,
                height:
                    MediaQuery.of(context).size.height / _heightDivider + 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / _heightDivider,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                margin:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: AppColors.infoColor,
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RippleAnimation(
                          color: AppColors.mainColor,
                          size: 15,
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.white,
                            size: 20.0,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisSize: title.isNotEmpty
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Visibility(
                                visible: title.isNotEmpty,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.22,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Visibility(
                                          visible: counter ?? false,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: AppColors.redButton,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CounterText(
                                                count: progressDuration != null
                                                    ? progressDuration.inSeconds
                                                    : 0),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: message,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomCircularProgressIndicator(
                        key: keyCircularProgress,
                        duration: progressDuration ??
                            const Duration(milliseconds: 5500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
                if (!visible.value) {
                  visible.value = true;
                }
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          },
        ),
        context: context,
        animation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideFromBottom
            : StyledToastAnimation.slideFromTop,
        reverseAnimation: alignment == Alignment.bottomCenter
            ? StyledToastAnimation.slideToBottom
            : StyledToastAnimation.slideToTop,
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }
}
