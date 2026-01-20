// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get chooseLanguage => 'ਆਪਣੀ ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get continues => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get hindi => 'ਹਿੰਦੀ';

  @override
  String get english => 'ਅੰਗ੍ਰੇਜ਼ੀ';

  @override
  String get punjabi => 'ਪੰਜਾਬੀ';

  @override
  String get bhojpuri => 'ਭੋਜਪੁਰੀ';

  @override
  String get login_skip => 'ਛੱਡੋ';

  @override
  String get login_title => 'ਲਾਗਇਨ ਜਾਂ ਸਾਈਨ ਅੱਪ ਕਰੋ';

  @override
  String get login_mobileLabel => 'ਮੋਬਾਈਲ ਨੰਬਰ*';

  @override
  String get login_mobileHint => 'ਮੋਬਾਈਲ ਨੰਬਰ ਦਰਜ ਕਰੋ';

  @override
  String get login_otpInfo => 'ਅਸੀਂ ਤੁਹਾਡੇ ਮੋਬਾਈਲ ਨੰਬਰ ਦੀ ਪੁਸ਼ਟੀ ਲਈ ਇੱਕ OTP ਭੇਜਾਂਗੇ';

  @override
  String get login_sendingOtp => 'OTP ਭੇਜਿਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get otp_title => 'OTP ਦਰਜ ਕਰੋ';

  @override
  String otp_sent_to(Object mobile) {
    return '+91 $mobile ਤੇ OTP ਭੇਜਿਆ ਗਿਆ ਹੈ';
  }

  @override
  String otp_resend_in(Object seconds) {
    return '$seconds ਸਕਿੰਟ ਵਿੱਚ OTP ਦੁਬਾਰਾ ਭੇਜੋ';
  }

  @override
  String get otp_didnt_receive => 'OTP ਨਹੀਂ ਮਿਲਿਆ?';

  @override
  String get otp_resend_now => 'ਹੁਣੇ ਦੁਬਾਰਾ ਭੇਜੋ';

  @override
  String get otp_resending => 'OTP ਮੁੜ ਭੇਜਿਆ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get otp_verify => 'ਤਸਦੀਕ ਕਰੋ';

  @override
  String get otp_invalid_length => '6 ਅੰਕਾਂ ਵਾਲਾ ਠੀਕ OTP ਦਰਜ ਕਰੋ';

  @override
  String get otp_invalid => 'ਗਲਤ OTP';

  @override
  String get otp_verifying => 'OTP ਦੀ ਜਾਂਚ ਹੋ ਰਹੀ ਹੈ...';

  @override
  String get otp_resend_failed => 'OTP ਮੁੜ ਭੇਜਣ ਵਿੱਚ ਅਸਫਲ';

  @override
  String get auth_accountBlocked_title => 'ਖਾਤਾ ਬਲੌਕ ਕਰ ਦਿੱਤਾ ਗਿਆ ਹੈ';

  @override
  String get auth_accountBlocked_subtitle => 'ਤੁਹਾਡਾ ਖਾਤਾ ਬਲੌਕ ਕਰ ਦਿੱਤਾ ਗਿਆ ਹੈ। ਹੋਰ ਜਾਣਕਾਰੀ ਲਈ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।';

  @override
  String get auth_accountBlocked_confirm => 'ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ';

  @override
  String get auth_deviceLimit_title => 'ਡਿਵਾਈਸ ਸੀਮਾ ਪੂਰੀ ਹੋ ਗਈ ਹੈ';

  @override
  String get auth_deviceLimit_subtitle => 'ਤੁਹਾਡਾ ਖਾਤਾ ਪਹਿਲਾਂ ਹੀ ਕਿਸੇ ਹੋਰ ਡਿਵਾਈਸ ਤੇ ਲਾਗਇਨ ਹੈ। ਜਾਰੀ ਰੱਖਣ ਲਈ ਉੱਥੋਂ ਲਾਗਆਉਟ ਕਰੋ।';

  @override
  String get auth_genericError => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ। ਕਿਰਪਾ ਕਰਕੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get bottom_home => 'ਹੋਮ';

  @override
  String get bottom_free => 'ਮੁਫ਼ਤ';

  @override
  String get bottom_premium => 'ਪ੍ਰੀਮੀਅਮ';

  @override
  String get bottom_search => 'ਖੋਜ';

  @override
  String get bottom_myplan => 'ਮੇਰਾ ਪਲਾਨ';

  @override
  String get exit_title => 'ਐਪ ਬੰਦ ਕਰੋ';

  @override
  String get exit_subtitle => 'ਕੀ ਤੁਸੀਂ ਸੱਚਮੁੱਚ ਐਪ ਬੰਦ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get exit_confirm => 'ਬੰਦ ਕਰੋ';

  @override
  String get exit_cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get search_hint => 'ਫਿਲਮਾਂ, ਸ਼ੋਅ, ਕਲਾਕਾਰ ਖੋਜੋ';

  @override
  String get search_trending_title => 'ਟ੍ਰੈਂਡਿੰਗ ਖੋਜਾਂ';

  @override
  String get search_no_results => 'ਕੋਈ ਨਤੀਜਾ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get watchlist_title => 'ਮੇਰੀ ਵਾਚਲਿਸਟ';

  @override
  String get watchlist_empty => 'ਵਾਚਲਿਸਟ ਵਿੱਚ ਕੋਈ ਆਈਟਮ ਨਹੀਂ';

  @override
  String get watchlist_watch_now => 'ਹੁਣ ਦੇਖੋ';

  @override
  String get watchlist_see_all => 'ਸਭ ਵੇਖੋ';

  @override
  String get detail_play => 'ਚਲਾਓ';

  @override
  String get detail_episodes => 'ਐਪੀਸੋਡ';

  @override
  String get detail_watchlist_added => 'ਸ਼ਾਮਲ ਹੋ ਗਿਆ';

  @override
  String get detail_watchlist_add => 'ਵਾਚਲਿਸਟ';

  @override
  String get detail_cast_crew => 'ਕਲਾਕਾਰ ਅਤੇ ਟੀਮ';

  @override
  String get detail_more_like_this => 'ਇਸ ਵਰਗਾ ਹੋਰ';

  @override
  String get detail_premium_badge => 'ਪ੍ਰੀਮੀਅਮ •';

  @override
  String get detail_free_badge => 'ਮੁਫ਼ਤ •';

  @override
  String get detail_select_season => 'ਸੀਜ਼ਨ ਚੁਣੋ';

  @override
  String get profile_edit_title => 'ਪ੍ਰੋਫਾਈਲ ਸੋਧੋ';

  @override
  String get profile_registered_mobile => 'ਰਜਿਸਟਰ ਕੀਤਾ ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String profile_mobile_format(Object mobile) {
    return '+91-$mobile';
  }

  @override
  String get profile_guest_message => 'ਸੁਆਗਤ ਹੈ! ਸਾਰੇ ਫੀਚਰ ਖੋਲ੍ਹਣ ਲਈ ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get profile_full_name_label => 'ਪੂਰਾ ਨਾਮ';

  @override
  String get profile_full_name_hint => 'ਆਪਣਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get profile_email_label => 'ਈਮੇਲ ਪਤਾ';

  @override
  String get profile_email_hint => 'ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ';

  @override
  String get profile_login_continue => 'ਜਾਰੀ ਰੱਖਣ ਲਈ ਲਾਗਇਨ ਕਰੋ';

  @override
  String get profile_save_changes => 'ਬਦਲਾਅ ਸੇਵ ਕਰੋ';

  @override
  String get profile_updating => 'ਅੱਪਡੇਟ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get help_title => 'ਮਦਦ ਕੇਂਦਰ';

  @override
  String get profile_title => 'ਪ੍ਰੋਫਾਈਲ';

  @override
  String get profile_greeting_guest => 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ 👋';

  @override
  String get profile_edit => 'ਸੋਧੋ';

  @override
  String get profile_plans_offers => 'ਪਲਾਨ ਅਤੇ\nਆਫ਼ਰ';

  @override
  String get profile_help_center => 'ਮਦਦ\nਕੇਂਦਰ';

  @override
  String get profile_settings => 'ਸੈਟਿੰਗ';

  @override
  String get profile_watchlist_title => 'ਵਾਚਲਿਸਟ';

  @override
  String get profile_watchlist_view_all => 'ਸਭ ਵੇਖੋ';

  @override
  String get settings_title => 'ਸੈਟਿੰਗ';

  @override
  String get settings_watchlist => 'ਵਾਚਲਿਸਟ';

  @override
  String get settings_notifications => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get settings_language => 'ਭਾਸ਼ਾ';

  @override
  String get settings_logout => 'ਲਾਗਆਉਟ';

  @override
  String get settings_delete_account => 'ਖਾਤਾ ਮਿਟਾਓ';

  @override
  String get settings_logout_confirm_title => 'ਕੀ ਤੁਸੀਂ ਲਾਗਆਉਟ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get settings_logout_confirm_button => 'ਲਾਗਆਉਟ';

  @override
  String get active_device_title => 'ਸਕ੍ਰਿਆ ਡਿਵਾਈਸ';

  @override
  String get active_device_loading_error => 'ਡਿਵਾਈਸ ਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਫਲ';

  @override
  String get active_device_limit_title => 'ਡਿਵਾਈਸ ਸੀਮਾ ਪੂਰੀ ਹੋ ਗਈ ਹੈ';

  @override
  String get active_device_limit_desc => 'ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਕੁਝ ਗਿਣਤੀ ਦੇ ਡਿਵਾਈਸਾਂ ਦੀ ਆਗਿਆ ਦਿੰਦੀ ਹੈ। ਜਾਰੀ ਰੱਖਣ ਲਈ ਹੇਠਾਂ ਦਿੱਤੇ ਡਿਵਾਈਸਾਂ ਵਿੱਚੋਂ ਕਿਸੇ ਇੱਕ ਤੋਂ ਲਾਗਆਉਟ ਕਰੋ।';

  @override
  String get active_device_limit_note => 'ਲਾਗਆਉਟ ਕਰਨ ਤੋਂ ਬਾਅਦ ਤੁਸੀਂ ਕਿਸੇ ਵੀ ਡਿਵਾਈਸ ਤੇ ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get active_device_your_devices => 'ਤੁਹਾਡੇ ਡਿਵਾਈਸ';

  @override
  String get active_device_other_devices => 'ਹੋਰ ਡਿਵਾਈਸ';

  @override
  String get active_device_logout => 'ਲਾਗਆਉਟ';

  @override
  String get active_device_current => 'ਇਹ ਡਿਵਾਈਸ';

  @override
  String get active_device_logout_confirm_title => 'ਡਿਵਾਈਸ ਤੋਂ ਲਾਗਆਉਟ ਕਰੋ?';

  @override
  String get active_device_logout_confirm_subtitle => 'ਇਹ ਡਿਵਾਈਸ ਤੁਹਾਡੇ ਖਾਤੇ ਤੋਂ ਲਾਗਆਉਟ ਹੋ ਜਾਵੇਗਾ।';

  @override
  String get active_device_logout_confirm_button => 'ਲਾਗਆਉਟ';

  @override
  String get active_device_logout_loading => 'ਲਾਗਆਉਟ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get active_device_already_logged_in_subtitle => 'ਤੁਹਾਡਾ ਖਾਤਾ ਪਹਿਲਾਂ ਹੀ ਕਿਸੇ ਹੋਰ ਡਿਵਾਈਸ ਤੇ ਲਾਗਇਨ ਹੈ। ਜਾਰੀ ਰੱਖਣ ਲਈ ਉੱਥੋਂ ਲਾਗਆਉਟ ਕਰੋ।';

  @override
  String get plan_title => 'ਮੇਰੇ ਪਲਾਨ';

  @override
  String get plan_no_available => 'ਕੋਈ ਪਲਾਨ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get plan_buy_title => 'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਖਰੀਦੋ';

  @override
  String plan_buy_subtitle(Object planName, Object price) {
    return '$planName ਨਾਲ ₹$price ਲਈ ਜਾਰੀ ਰੱਖੋ?';
  }

  @override
  String get plan_buy_confirm => 'ਭੁਗਤਾਨ ਕਰੋ';

  @override
  String get plan_buy_cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get plan_subscribe_now => 'ਹੁਣ ਸਬਸਕ੍ਰਾਈਬ ਕਰੋ';

  @override
  String get plan_no_commitment => 'ਕੋਈ ਬੰਨ੍ਹ ਨਹੀਂ, ਕਦੇ ਵੀ ਰੱਦ ਕਰੋ';

  @override
  String get plan_feature_quality => 'ਗੁਣਵੱਤਾ';

  @override
  String get plan_feature_devices => 'ਡਿਵਾਈਸ';

  @override
  String get plan_feature_downloads => 'ਡਾਊਨਲੋਡ';

  @override
  String get plan_feature_ads => 'ਵਿਗਿਆਪਨ';

  @override
  String get plan_feature_yes => 'ਹਾਂ';

  @override
  String get plan_feature_no => 'ਨਹੀਂ';

  @override
  String get badge_unlimited => 'ਅਣਲਿਮਿਟਡ';

  @override
  String get badge_maximum => 'ਵੱਧ ਤੋਂ ਵੱਧ';

  @override
  String get badge_priority => 'ਤਰਜੀਹ';

  @override
  String get badge_advanced => 'ਐਡਵਾਂਸ';

  @override
  String get badge_standard => 'ਸਟੈਂਡਰਡ';

  @override
  String get badge_secure => 'ਸੁਰੱਖਿਅਤ';

  @override
  String get payment_success_title => 'ਭੁਗਤਾਨ ਸਫਲ 🎉';

  @override
  String get payment_success_subtitle => 'ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਸਫਲਤਾਪੂਰਵਕ ਐਕਟੀਵੇਟ ਹੋ ਗਈ ਹੈ';

  @override
  String get payment_failed_title => 'ਭੁਗਤਾਨ ਅਸਫਲ';

  @override
  String get payment_failed_subtitle => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get payment_failed_retry => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get payment_failed_close => 'ਬੰਦ ਕਰੋ';

  @override
  String get mySubscriptionTitle => 'ਮੇਰੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ';

  @override
  String get currentPlan => 'ਮੌਜੂਦਾ ਪਲਾਨ';

  @override
  String get startDate => 'ਸ਼ੁਰੂ ਦੀ ਤਾਰੀਖ';

  @override
  String get expireDate => 'ਮਿਆਦ ਖਤਮ';

  @override
  String get quality => 'ਗੁਣਵੱਤਾ';

  @override
  String get devices => 'ਡਿਵਾਈਸ';

  @override
  String get ads => 'ਇਸ਼ਤਿਹਾਰ';

  @override
  String get yes => 'ਹਾਂ';

  @override
  String get no => 'ਨਹੀਂ';

  @override
  String get addons => 'ਐਡ-ਆਨ';

  @override
  String get extraDevices => 'ਵਾਧੂ ਡਿਵਾਈਸ';

  @override
  String get extraDownloads => 'ਵਾਧੂ ਡਾਊਨਲੋਡ';

  @override
  String get addon => 'ਐਡ-ਆਨ';

  @override
  String get addonDevicesValue => 'ਡਿਵਾਈਸ';

  @override
  String get addonDownloadsValue => 'ਡਾਊਨਲੋਡ';

  @override
  String get rechargeAddon => 'ਐਡ-ਆਨ ਰੀਚਾਰਜ';

  @override
  String get payNow => 'ਹੁਣ ਭੁਗਤਾਨ ਕਰੋ';

  @override
  String get activePlan => 'ਸਕ੍ਰਿਆ ਪਲਾਨ';

  @override
  String get selected => 'ਚੁਣਿਆ ਹੋਇਆ';

  @override
  String addonPriceSubtitle(Object addon, Object price) {
    return '$addon ₹$price ਲਈ';
  }
}
