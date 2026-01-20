// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bihari languages (`bh`).
class AppLocalizationsBh extends AppLocalizations {
  AppLocalizationsBh([String locale = 'bh']) : super(locale);

  @override
  String get chooseLanguage => 'आपन भाषा चुनीं';

  @override
  String get continues => 'आगे बढ़ीं';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get punjabi => 'पंजाबी';

  @override
  String get bhojpuri => 'भोजपुरी';

  @override
  String get login_skip => 'छोड़ीं';

  @override
  String get login_title => 'लॉगिन या साइन अप करीं';

  @override
  String get login_mobileLabel => 'मोबाइल नंबर*';

  @override
  String get login_mobileHint => 'मोबाइल नंबर डालीं';

  @override
  String get login_otpInfo => 'आपन मोबाइल नंबर के पुष्टि खातिर हम ओटीपी भेजब';

  @override
  String get login_sendingOtp => 'ओटीपी भेजल जा रहल बा...';

  @override
  String get otp_title => 'ओटीपी डालीं';

  @override
  String otp_sent_to(Object mobile) {
    return '+91 $mobile पर ओटीपी भेजल गइल बा';
  }

  @override
  String otp_resend_in(Object seconds) {
    return '$seconds सेकंड में दोबारा ओटीपी भेजीं';
  }

  @override
  String get otp_didnt_receive => 'ओटीपी ना मिलल?';

  @override
  String get otp_resend_now => 'अब दोबारा भेजीं';

  @override
  String get otp_resending => 'ओटीपी फिर से भेजल जा रहल बा...';

  @override
  String get otp_verify => 'जांच करीं';

  @override
  String get otp_invalid_length => '6 अंक के सही ओटीपी डालीं';

  @override
  String get otp_invalid => 'गलत ओटीपी';

  @override
  String get otp_verifying => 'ओटीपी जांचल जा रहल बा...';

  @override
  String get otp_resend_failed => 'ओटीपी दोबारा भेजे में असफल';

  @override
  String get auth_accountBlocked_title => 'खाता बंद कर दिहल गइल बा';

  @override
  String get auth_accountBlocked_subtitle => 'आपन खाता ब्लॉक कर दिहल गइल बा। जादा जानकारी खातिर सपोर्ट से संपर्क करीं।';

  @override
  String get auth_accountBlocked_confirm => 'सपोर्ट से बात करीं';

  @override
  String get auth_deviceLimit_title => 'डिवाइस सीमा पूरा हो गइल बा';

  @override
  String get auth_deviceLimit_subtitle => 'आपन खाता पहिले से दुसर डिवाइस पर लॉगिन बा। आगे बढ़े खातिर पहिले उहां से लॉग आउट करीं।';

  @override
  String get auth_genericError => 'कुछ गड़बड़ हो गइल बा। कृपया फिर से कोशिश करीं।';

  @override
  String get bottom_home => 'होम';

  @override
  String get bottom_free => 'फ्री';

  @override
  String get bottom_premium => 'प्रीमियम';

  @override
  String get bottom_search => 'खोजीं';

  @override
  String get bottom_myplan => 'मोर प्लान';

  @override
  String get exit_title => 'ऐप बंद करीं';

  @override
  String get exit_subtitle => 'का आप सच में ऐप बंद करना चाहत बानी?';

  @override
  String get exit_confirm => 'बंद करीं';

  @override
  String get exit_cancel => 'रद्द करीं';

  @override
  String get search_hint => 'फिल्म, शो, कलाकार खोजीं';

  @override
  String get search_trending_title => 'चर्चित खोज';

  @override
  String get search_no_results => 'कउनो नतीजा ना मिलल';

  @override
  String get watchlist_title => 'मोर वॉचलिस्ट';

  @override
  String get watchlist_empty => 'वॉचलिस्ट में कउनो आइटम नइखे';

  @override
  String get watchlist_watch_now => 'अब देखीं';

  @override
  String get watchlist_see_all => 'सब देखीं';

  @override
  String get detail_play => 'चलाईं';

  @override
  String get detail_episodes => 'एपिसोड';

  @override
  String get detail_watchlist_added => 'जुड़ गइल';

  @override
  String get detail_watchlist_add => 'वॉचलिस्ट';

  @override
  String get detail_cast_crew => 'कलाकार आ टीम';

  @override
  String get detail_more_like_this => 'एह जइसन अउरी';

  @override
  String get detail_premium_badge => 'प्रीमियम •';

  @override
  String get detail_free_badge => 'फ्री •';

  @override
  String get detail_select_season => 'सीजन चुनीं';

  @override
  String get profile_edit_title => 'प्रोफाइल बदलीं';

  @override
  String get profile_registered_mobile => 'रजिस्टर्ड मोबाइल नंबर';

  @override
  String profile_mobile_format(Object mobile) {
    return '+91-$mobile';
  }

  @override
  String get profile_guest_message => 'स्वागत बा! सब फीचर खोले खातिर साइन इन करीं';

  @override
  String get profile_full_name_label => 'पूरा नाम';

  @override
  String get profile_full_name_hint => 'आपन नाम डालीं';

  @override
  String get profile_email_label => 'ईमेल पता';

  @override
  String get profile_email_hint => 'ईमेल पता डालीं';

  @override
  String get profile_login_continue => 'आगे बढ़े खातिर लॉगिन करीं';

  @override
  String get profile_save_changes => 'बदलाव सेव करीं';

  @override
  String get profile_updating => 'अपडेट हो रहल बा...';

  @override
  String get help_title => 'मदद केंद्र';

  @override
  String get profile_title => 'प्रोफाइल';

  @override
  String get profile_greeting_guest => 'नमस्ते 👋';

  @override
  String get profile_edit => 'बदलीं';

  @override
  String get profile_plans_offers => 'प्लान आ\nऑफर';

  @override
  String get profile_help_center => 'मदद\nकेंद्र';

  @override
  String get profile_settings => 'सेटिंग';

  @override
  String get profile_watchlist_title => 'वॉचलिस्ट';

  @override
  String get profile_watchlist_view_all => 'सब देखीं';

  @override
  String get settings_title => 'सेटिंग';

  @override
  String get settings_watchlist => 'वॉचलिस्ट';

  @override
  String get settings_notifications => 'सूचना';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_logout => 'लॉग आउट';

  @override
  String get settings_delete_account => 'खाता मिटाईं';

  @override
  String get settings_logout_confirm_title => 'का आप लॉग आउट करना चाहत बानी?';

  @override
  String get settings_logout_confirm_button => 'लॉग आउट';

  @override
  String get active_device_title => 'सक्रिय डिवाइस';

  @override
  String get active_device_loading_error => 'डिवाइस लोड करे में दिक्कत';

  @override
  String get active_device_limit_title => 'डिवाइस सीमा पूरा हो गइल बा';

  @override
  String get active_device_limit_desc => 'आपन सब्सक्रिप्शन सीमित डिवाइस के अनुमति देला। आगे बढ़े खातिर नीचे दिहल डिवाइस में से कउनो एक से लॉग आउट करीं।';

  @override
  String get active_device_limit_note => 'लॉग आउट करे के बाद आप कउनो भी डिवाइस पर दोबारा साइन इन कर सकत बानी।';

  @override
  String get active_device_your_devices => 'आपन डिवाइस';

  @override
  String get active_device_other_devices => 'दुसर डिवाइस';

  @override
  String get active_device_logout => 'लॉग आउट';

  @override
  String get active_device_current => 'ई डिवाइस';

  @override
  String get active_device_logout_confirm_title => 'डिवाइस से लॉग आउट करीं?';

  @override
  String get active_device_logout_confirm_subtitle => 'ई डिवाइस आपन खाता से लॉग आउट हो जाई।';

  @override
  String get active_device_logout_confirm_button => 'लॉग आउट';

  @override
  String get active_device_logout_loading => 'लॉग आउट हो रहल बा...';

  @override
  String get active_device_already_logged_in_subtitle => 'आपन खाता पहिले से दुसर डिवाइस पर लॉगिन बा। आगे बढ़े खातिर पहिले उहां से लॉग आउट करीं।';

  @override
  String get plan_title => 'मोर प्लान';

  @override
  String get plan_no_available => 'कउनो प्लान उपलब्ध नइखे';

  @override
  String get plan_buy_title => 'सब्सक्रिप्शन खरीदीं';

  @override
  String plan_buy_subtitle(Object planName, Object price) {
    return '$planName के साथ ₹$price में जारी रखीं?';
  }

  @override
  String get plan_buy_confirm => 'भुगतान करीं';

  @override
  String get plan_buy_cancel => 'रद्द करीं';

  @override
  String get plan_subscribe_now => 'अब सब्सक्राइब करीं';

  @override
  String get plan_no_commitment => 'कउनो बंधन नइखे, कबो भी बंद करीं';

  @override
  String get plan_feature_quality => 'क्वालिटी';

  @override
  String get plan_feature_devices => 'डिवाइस';

  @override
  String get plan_feature_downloads => 'डाउनलोड';

  @override
  String get plan_feature_ads => 'विज्ञापन';

  @override
  String get plan_feature_yes => 'हां';

  @override
  String get plan_feature_no => 'ना';

  @override
  String get badge_unlimited => 'अनलिमिटेड';

  @override
  String get badge_maximum => 'ज्यादा';

  @override
  String get badge_priority => 'प्राथमिकता';

  @override
  String get badge_advanced => 'एडवांस';

  @override
  String get badge_standard => 'स्टैंडर्ड';

  @override
  String get badge_secure => 'सुरक्षित';
}
