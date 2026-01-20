import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';

class CommonHelpOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CommonHelpOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white70,
                  size: 22,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: ConstText(
                    text: title,
                    color: Colors.white,
                    fontSize: AppConstant.fontSizeTwo,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  color: Colors.white38,
                  size: 22,
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 0.6,
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.15),
          ),
        ],
      ),
    );
  }
}
