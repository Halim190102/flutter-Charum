import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/loading.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyDialog extends ConsumerStatefulWidget {
  const VerifyDialog({required this.registerPage, super.key});
  final bool registerPage;

  @override
  ConsumerState<VerifyDialog> createState() => _VerifyDialogState();
}

class _VerifyDialogState extends ConsumerState<VerifyDialog> {
  @override
  Widget build(BuildContext context) {
    String email = ref.watch(authProvider).emails;
    String? message = ref.watch(authProvider).verifMessage;
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 20),
      backgroundColor: white,
      surfaceTintColor: transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      title: textUtils(
        text: "Verify your email",
        weight: FontWeight.bold,
        size: 18,
        align: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          containerUtils(
            width: 230,
            child: textUtils(
              line: 3,
              size: 14,
              text: "Verify your email through the email we have sent you.",
              align: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          textUtils(
            size: 14,
            text: message ?? '',
            align: TextAlign.center,
            color:
                message == 'Email has not been verified' ? red : Colors.green,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            GestureDetector(
              onTap: () {
                modal(context);
                ref.read(authProvider.notifier).checkEmailWasVerify(
                    email: email,
                    context: context,
                    registerPage: widget.registerPage);
              },
              child: containerUtils(
                height: 40,
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                borderRadius: 10,
                color: greenCharum,
                child: textUtils(
                  size: 10,
                  text: 'Verify',
                  color: white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                modal(context);
                ref.read(authProvider.notifier).resendEmailLink(
                      email: email,
                      context: context,
                    );
              },
              child: const CircleAvatar(
                radius: 16,
                child: Icon(
                  size: 12,
                  Icons.replay,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

verif(BuildContext context, bool registerPage) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => VerifyDialog(
      registerPage: registerPage,
    ),
  );
}
