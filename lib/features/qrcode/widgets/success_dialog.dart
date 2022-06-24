import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    const textStyle = TextStyle(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontFamily: "SFProText",
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 256,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: SvgPicture.asset("assets/images/ticket-bg.svg"),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2 - 64,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                      size: 45,
                    ),
                  ),
                ),
                Positioned(
                  top: 56,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Thank You!",
                    style: textStyle.copyWith(
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Text(
                    "The process has completed successfully and securely",
                    style: textStyle.copyWith(
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  top: 131,
                  left: 14,
                  child: SvgPicture.asset("assets/images/dotted-line.svg"),
                ),
                Positioned(
                  bottom: 96,
                  left: 36,
                  right: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DATE",
                        style: textStyle.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                      ),
                      Text(
                        "TIME",
                        style: textStyle.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 76,
                  left: 36,
                  right: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${now.day} ${DateFormat.MMMM().format(now)}, ${now.year}",
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "${now.hour % 12}:${now.minute} ${now.hour >= 12 ? "PM" : "AM"}",
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 48,
                  left: 0,
                  right: 0,
                  child: Text(
                    "VENDOR",
                    style: textStyle.copyWith(
                      color: const Color(0xFFA1A1A1),
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    "IBM PTE LTD",
                    style: textStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: Navigator.of(context).pop,
            child: const Icon(
              Icons.cancel,
              color: Color(0xFFD9D9D9),
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
