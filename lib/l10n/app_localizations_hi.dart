// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get continues => 'जारी रखें';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get punjabi => 'पंजाबी';

  @override
  String get bhojpuri => 'भोजपुरी';

  @override
  String get login_skip => 'छोड़ें';

  @override
  String get login_title => 'लॉगिन या साइन अप करें';

  @override
  String get login_mobileLabel => 'मोबाइल नंबर*';

  @override
  String get login_mobileHint => 'मोबाइल नंबर दर्ज करें';

  @override
  String get login_otpInfo => 'आपके मोबाइल नंबर की पुष्टि के लिए हम आपको एक ओटीपी भेजेंगे';

  @override
  String get login_sendingOtp => 'ओटीपी भेजा जा रहा है...';

  @override
  String get otp_title => 'ओटीपी दर्ज करें';

  @override
  String otp_sent_to(Object mobile) {
    return '+91 $mobile पर ओटीपी भेजा गया है';
  }

  @override
  String otp_resend_in(Object seconds) {
    return '$seconds सेकंड में ओटीपी दोबारा भेजें';
  }

  @override
  String get otp_didnt_receive => 'ओटीपी प्राप्त नहीं हुआ?';

  @override
  String get otp_resend_now => 'दोबारा भेजें';

  @override
  String get otp_resending => 'ओटीपी दोबारा भेजा जा रहा है...';

  @override
  String get otp_verify => 'सत्यापित करें';

  @override
  String get otp_invalid_length => 'कृपया 6 अंकों का सही ओटीपी दर्ज करें';

  @override
  String get otp_invalid => 'गलत ओटीपी';

  @override
  String get otp_verifying => 'ओटीपी सत्यापित किया जा रहा है...';

  @override
  String get otp_resend_failed => 'ओटीपी दोबारा भेजने में विफल';

  @override
  String get auth_accountBlocked_title => 'खाता ब्लॉक कर दिया गया है';

  @override
  String get auth_accountBlocked_subtitle => 'आपका खाता ब्लॉक कर दिया गया है। अधिक जानकारी के लिए कृपया सहायता से संपर्क करें।';

  @override
  String get auth_accountBlocked_confirm => 'सहायता से संपर्क करें';

  @override
  String get auth_deviceLimit_title => 'डिवाइस सीमा पूरी हो गई है';

  @override
  String get auth_deviceLimit_subtitle => 'आपका खाता पहले से किसी अन्य डिवाइस पर लॉग इन है। जारी रखने के लिए पहले वहां से लॉग आउट करें।';

  @override
  String get auth_genericError => 'कुछ गलत हो गया। कृपया पुनः प्रयास करें।';

  @override
  String get bottom_home => 'होम';

  @override
  String get bottom_free => 'फ्री';

  @override
  String get bottom_premium => 'प्रीमियम';

  @override
  String get bottom_search => 'खोजें';

  @override
  String get bottom_myplan => 'मेरी योजना';

  @override
  String get exit_title => 'ऐप बंद करें';

  @override
  String get exit_subtitle => 'क्या आप वाकई ऐप बंद करना चाहते हैं?';

  @override
  String get exit_confirm => 'बंद करें';

  @override
  String get exit_cancel => 'रद्द करें';

  @override
  String get search_hint => 'फ़िल्में, शो, कलाकार खोजें';

  @override
  String get search_trending_title => 'ट्रेंडिंग खोजें';

  @override
  String get search_no_results => 'कोई परिणाम नहीं मिला';

  @override
  String get watchlist_title => 'मेरी वॉचलिस्ट';

  @override
  String get watchlist_empty => 'वॉचलिस्ट में कोई आइटम नहीं है';

  @override
  String get watchlist_watch_now => 'अभी देखें';

  @override
  String get watchlist_see_all => 'सभी देखें';

  @override
  String get detail_play => 'चलाएँ';

  @override
  String get detail_episodes => 'एपिसोड्स';

  @override
  String get detail_watchlist_added => 'जोड़ा गया';

  @override
  String get detail_watchlist_add => 'वॉचलिस्ट';

  @override
  String get detail_cast_crew => 'कलाकार और क्रू';

  @override
  String get detail_more_like_this => 'इस जैसे और';

  @override
  String get detail_premium_badge => 'प्रीमियम •';

  @override
  String get detail_free_badge => 'फ्री •';

  @override
  String get detail_select_season => 'सीज़न चुनें';

  @override
  String get profile_edit_title => 'प्रोफ़ाइल संपादित करें';

  @override
  String get profile_registered_mobile => 'पंजीकृत मोबाइल नंबर';

  @override
  String profile_mobile_format(Object mobile) {
    return '+91-$mobile';
  }

  @override
  String get profile_guest_message => 'सभी सुविधाओं को अनलॉक करने के लिए साइन इन करें';

  @override
  String get profile_full_name_label => 'पूरा नाम';

  @override
  String get profile_full_name_hint => 'अपना नाम दर्ज करें';

  @override
  String get profile_email_label => 'ईमेल पता';

  @override
  String get profile_email_hint => 'ईमेल पता दर्ज करें';

  @override
  String get profile_login_continue => 'लॉगिन करें';

  @override
  String get profile_save_changes => 'परिवर्तन सहेजें';

  @override
  String get profile_updating => 'अपडेट किया जा रहा है...';

  @override
  String get help_title => 'सहायता केंद्र';

  @override
  String get profile_title => 'प्रोफ़ाइल';

  @override
  String get profile_greeting_guest => 'नमस्ते 👋';

  @override
  String get profile_edit => 'संपादित करें';

  @override
  String get profile_plans_offers => 'प्लान और\nऑफ़र';

  @override
  String get profile_help_center => 'सहायता\nकेंद्र';

  @override
  String get profile_settings => 'सेटिंग्स';

  @override
  String get profile_watchlist_title => 'वॉचलिस्ट';

  @override
  String get profile_watchlist_view_all => 'सभी देखें';

  @override
  String get settings_title => 'सेटिंग्स';

  @override
  String get settings_watchlist => 'वॉचलिस्ट';

  @override
  String get settings_notifications => 'सूचनाएं';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_logout => 'लॉग आउट';

  @override
  String get settings_delete_account => 'खाता हटाएं';

  @override
  String get settings_logout_confirm_title => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get settings_logout_confirm_button => 'लॉग आउट';

  @override
  String get active_device_title => 'सक्रिय डिवाइस';

  @override
  String get active_device_loading_error => 'डिवाइस लोड नहीं हो पाए';

  @override
  String get active_device_limit_title => 'डिवाइस सीमा पूरी हो गई है';

  @override
  String get active_device_limit_desc => 'आपकी वर्तमान सदस्यता में सीमित डिवाइस की अनुमति है। जारी रखने के लिए नीचे सूचीबद्ध किसी एक डिवाइस से लॉग आउट करें।';

  @override
  String get active_device_limit_note => 'लॉग आउट करने के बाद आप किसी भी डिवाइस पर फिर से साइन इन कर सकते हैं।';

  @override
  String get active_device_your_devices => 'आपके डिवाइस';

  @override
  String get active_device_other_devices => 'अन्य डिवाइस';

  @override
  String get active_device_logout => 'लॉग आउट';

  @override
  String get active_device_current => 'यह डिवाइस';

  @override
  String get active_device_logout_confirm_title => 'डिवाइस से लॉग आउट करें?';

  @override
  String get active_device_logout_confirm_subtitle => 'यह डिवाइस आपके खाते से लॉग आउट कर दी जाएगी।';

  @override
  String get active_device_logout_confirm_button => 'लॉग आउट';

  @override
  String get active_device_logout_loading => 'लॉग आउट किया जा रहा है...';

  @override
  String get active_device_already_logged_in_subtitle => 'आपका खाता पहले से किसी अन्य डिवाइस पर लॉग इन है। जारी रखने के लिए पहले वहां से लॉग आउट करें।';

  @override
  String get plan_title => 'मेरी योजनाएँ';

  @override
  String get plan_no_available => 'कोई योजना उपलब्ध नहीं है';

  @override
  String get plan_buy_title => 'सब्सक्रिप्शन खरीदें';

  @override
  String plan_buy_subtitle(Object planName, Object price) {
    return '$planName योजना ₹$price में जारी रखें?';
  }

  @override
  String get plan_buy_confirm => 'भुगतान करें';

  @override
  String get plan_buy_cancel => 'रद्द करें';

  @override
  String get plan_subscribe_now => 'अभी सब्सक्राइब करें';

  @override
  String get plan_no_commitment => 'कोई बाध्यता नहीं, कभी भी रद्द करें';

  @override
  String get plan_feature_quality => 'क्वालिटी';

  @override
  String get plan_feature_devices => 'डिवाइस';

  @override
  String get plan_feature_downloads => 'डाउनलोड';

  @override
  String get plan_feature_ads => 'विज्ञापन';

  @override
  String get plan_feature_yes => 'हाँ';

  @override
  String get plan_feature_no => 'नहीं';

  @override
  String get badge_unlimited => 'अनलिमिटेड';

  @override
  String get badge_maximum => 'अधिकतम';

  @override
  String get badge_priority => 'प्राथमिकता';

  @override
  String get badge_advanced => 'एडवांस';

  @override
  String get badge_standard => 'स्टैंडर्ड';

  @override
  String get badge_secure => 'सुरक्षित';
}
