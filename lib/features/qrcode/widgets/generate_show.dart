import 'package:flutter/material.dart';

class GenerateShow extends StatefulWidget {
  const GenerateShow({Key? key}) : super(key: key);

  @override
  State<GenerateShow> createState() => _GenerateShowState();
}

class _GenerateShowState extends State<GenerateShow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Container(
          width: 270,
          height: 270,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: SizedBox(
              width: 168,
              height: 168,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 180,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              "04:33",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "What is this QR code used for?\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "This QR code can be used to retrieve information from user(s). If a Credentity user scans this and authorizes their information to be shared, you can see it here!\n\n",
                ),
                TextSpan(
                  text: "What is this timer for?\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "To ensure for improved security, the QR code will expire within 5 minutes and will re-generate itself",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 160,
          height: 44,
          child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xFFD9D9D9),
              ),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            onPressed: () {},
            child: Row(
              children: const [
                Icon(
                  Icons.file_download_outlined,
                  color: Colors.black,
                ),
                SizedBox(width: 4),
                Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
