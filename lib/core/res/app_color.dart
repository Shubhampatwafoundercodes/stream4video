
import 'package:flutter/material.dart';



class AppColors {

  static const primary = Color(0xFFE4002B);        // Main brand red
  static const primaryLight = Color(0xFFFF3D5C);   // Slightly lighter red
  static const primaryDark = Color(0xFFC70022);    // Deep brand tone

  static const accent = Color(0xFFFF193F);

  static const primaryBackground = Color(0xFF222629); // <-- YOUR NEW COLOR

  static const background = Color(0xFF0B0B0C);        // Main app background
  static const backgroundDark = Color(0xFF0E0F12);    // Slight deeper tone
  static const surface = Color(0xFF111215);           // Cards / Sheets
  static const surfaceLight = Color(0xFF181A1F);      // Elevated surfaces



  static const textPrimary = Color(0xFFFFFFFF);    // Main white text
  static const textSecondary = Color(0xFFE5E5E7);  // Light grey text
  static const textTertiary = Color(0xFFA8A8AA);   // Soft grey
  static const textHint = Color(0xFF6D6D71);       // Hint / placeholder text

  static const blackPrimary = Color(0xFF000000);      // Pure black
  static const blackSecondary = Color(0xFF1A1A1A);    // Deep black (heavy UI)
  static const blackMedium = Color(0xFF3A3A3C);       // Medium black (titles)
  static const blackLight = Color(0xFF5A5A5C);        // Light readable black
  static const blackFaded = Color(0xFF7C7C7E);        // Hint-like black
  static const blackHint = Color(0xFF9A9A9C);




  static const border = Color(0xFF2D2F33);
  static const borderLight = Color(0xFF3A3C41);


  static const success = Color(0xFF2ECC71);
  static const warning = Color(0xFFF1C40F);
  static const error = Color(0xFFE74C3C);


  // static const buttonGradient = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [
  //     Color(0xFFFFFFFF), // top white shine
  //     Color(0xFFF2F2F2), // middle soft grey
  //     Color(0xFFCACCCF), // bottom grey with black tint
  //   ],
  //   stops: [0.0, 0.45, 1.0],
  // );


  static const buttonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF), // 🔆 strong top shine
      Color(0xFFF7F7F7), // soft glossy highlight
      Color(0xFFE0E0E0), // mid neutral
      Color(0xFFB8BBC0), // lower depth
      Color(0xFF9EA2A8), // bottom shadow
    ],
    stops: [0.0, 0.18, 0.45, 0.75, 1.0],
  );
  static const secondButtonGradient =  LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.primaryBackground,
      Color(0xFF4A4A4A),

    ],
  );

  static const transparentButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x22FFFFFF), // slight white tint (top)
      Color(0x11FFFFFF), // softer transparent (middle)
      Color(0x00FFFFFF), // fully transparent at bottom
    ],
  );
  static const backgroundColourGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A1D23),
      Color(0xFF121418),
      Color(0xFF0F1115),
    ],
  );

  static const buttonShadow = [
    BoxShadow(
      color: Color(0x55000000),  // deep soft shadow
      blurRadius: 14,
      spreadRadius: 1,
      offset: Offset(0, 6), // perfect lifted look
    ),
    BoxShadow(
      color: Color(0x22000000), // secondary soft shadow
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const buttonGradientSoft = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x33FFFFFF),   // subtle white glow
      Color(0x66FFFFFF),   // stronger middle glow
      Color(0xFF666A6D),   // Xstream silver
    ],
  );


  static const redGlow = Color(0x33E4002B);
}

/// ✨ AppShimmer
/// Central shimmer colors & gradients (Airtel Xstream style)
class AppShimmer {
  /// Base background (dark surface)
  static const Color baseColor = AppColors.surface;

  /// Moving highlight (silver light)
  static const Color highlightColor = Color(0xFF2C2F36);

  /// Slight mid-tone for smooth shimmer
  static const Color midColor = Color(0xFF23262C);

  /// 🔥 Primary shimmer gradient (MOST USED)
  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      baseColor,
      midColor,
      highlightColor,
      midColor,
      baseColor,
    ],
    stops: [0.0, 0.35, 0.5, 0.65, 1.0],
  );

  /// Card shimmer gradient (slightly softer)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1B1E23),
      Color(0xFF2A2E35),
      Color(0xFF1B1E23),
    ],
  );

  /// Radius presets
  static BorderRadius radiusSmall = BorderRadius.circular(6);
  static BorderRadius radiusMedium = BorderRadius.circular(10);
  static BorderRadius radiusLarge = BorderRadius.circular(14);
}




