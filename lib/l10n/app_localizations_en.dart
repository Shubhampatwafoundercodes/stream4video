// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get continues => 'Continue';

  @override
  String get hindi => 'Hindi';

  @override
  String get english => 'English';

  @override
  String get punjabi => 'Punjabi';

  @override
  String get bhojpuri => 'Bhojpuri';

  @override
  String get login_skip => 'Skip';

  @override
  String get login_title => 'Login or Signup';

  @override
  String get login_mobileLabel => 'Mobile Number*';

  @override
  String get login_mobileHint => 'Enter mobile number';

  @override
  String get login_otpInfo => 'We\'ll send you an OTP to confirm your mobile number';

  @override
  String get login_sendingOtp => 'Sending OTP...';

  @override
  String get otp_title => 'Enter OTP';

  @override
  String otp_sent_to(Object mobile) {
    return 'OTP sent to +91 $mobile';
  }

  @override
  String otp_resend_in(Object seconds) {
    return 'Resend OTP in $seconds sec';
  }

  @override
  String get otp_didnt_receive => 'Didn’t receive OTP?';

  @override
  String get otp_resend_now => 'Resend Now';

  @override
  String get otp_resending => 'Resending OTP...';

  @override
  String get otp_verify => 'Verify';

  @override
  String get otp_invalid_length => 'Enter valid 6 digit OTP';

  @override
  String get otp_invalid => 'Invalid OTP';

  @override
  String get otp_verifying => 'Verifying OTP...';

  @override
  String get otp_resend_failed => 'Failed to resend OTP';

  @override
  String get auth_accountBlocked_title => 'Account Blocked';

  @override
  String get auth_accountBlocked_subtitle => 'Your account has been blocked. Please contact support for more information.';

  @override
  String get auth_accountBlocked_confirm => 'Contact Support';

  @override
  String get auth_deviceLimit_title => 'Device limit reached';

  @override
  String get auth_deviceLimit_subtitle => 'Your account is already logged in on another device. Log out from an existing device to continue.';

  @override
  String get auth_genericError => 'Something went wrong. Please try again';

  @override
  String get bottom_home => 'Home';

  @override
  String get bottom_free => 'Free';

  @override
  String get bottom_premium => 'Premium';

  @override
  String get bottom_search => 'Search';

  @override
  String get bottom_myplan => 'My Plan';

  @override
  String get exit_title => 'Exit App';

  @override
  String get exit_subtitle => 'Are you sure you want to exit?';

  @override
  String get exit_confirm => 'Exit';

  @override
  String get exit_cancel => 'Cancel';

  @override
  String get search_hint => 'Search movies, shows, actors';

  @override
  String get search_trending_title => 'Trending Searches';

  @override
  String get search_no_results => 'No results found';

  @override
  String get watchlist_title => 'My Watchlist';

  @override
  String get watchlist_empty => 'No items in Watchlist';

  @override
  String get watchlist_watch_now => 'Watch Now';

  @override
  String get watchlist_see_all => 'See All';

  @override
  String get detail_play => 'Play';

  @override
  String get detail_episodes => 'Episodes';

  @override
  String get detail_watchlist_added => 'Added';

  @override
  String get detail_watchlist_add => 'Watchlist';

  @override
  String get detail_cast_crew => 'Cast & Crew';

  @override
  String get detail_more_like_this => 'More like this';

  @override
  String get detail_premium_badge => 'PREMIUM •';

  @override
  String get detail_free_badge => 'FREE •';

  @override
  String get detail_select_season => 'Select Season';

  @override
  String get profile_edit_title => 'Edit Profile';

  @override
  String get profile_registered_mobile => 'Registered mobile number';

  @override
  String profile_mobile_format(Object mobile) {
    return '+91-$mobile';
  }

  @override
  String get profile_guest_message => 'Welcome! Sign in to unlock all features';

  @override
  String get profile_full_name_label => 'Full Name';

  @override
  String get profile_full_name_hint => 'Enter your name';

  @override
  String get profile_email_label => 'Email Address';

  @override
  String get profile_email_hint => 'Enter email address';

  @override
  String get profile_login_continue => 'Login to continue';

  @override
  String get profile_save_changes => 'Save Changes';

  @override
  String get profile_updating => 'Updating...';

  @override
  String get help_title => 'Help Center';

  @override
  String get profile_title => 'Profile Screen';

  @override
  String get profile_greeting_guest => 'Hi there 👋';

  @override
  String get profile_edit => 'Edit';

  @override
  String get profile_plans_offers => 'Plans &\nOffers';

  @override
  String get profile_help_center => 'Help\nCenter';

  @override
  String get profile_settings => 'Settings';

  @override
  String get profile_watchlist_title => 'Watchlist';

  @override
  String get profile_watchlist_view_all => 'View all';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_watchlist => 'Watchlist';

  @override
  String get settings_notifications => 'Notifications';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_logout => 'Logout';

  @override
  String get settings_delete_account => 'Delete Account';

  @override
  String get settings_logout_confirm_title => 'Are you sure you want to logout?';

  @override
  String get settings_logout_confirm_button => 'Log out';

  @override
  String get active_device_title => 'Active Devices';

  @override
  String get active_device_loading_error => 'Failed to load devices';

  @override
  String get active_device_limit_title => 'Device limit reached';

  @override
  String get active_device_limit_desc => 'Your current subscription allows a limited number of active devices. To continue, please log out from one of the devices listed below.';

  @override
  String get active_device_limit_note => 'You can sign in again on any device after logging out.';

  @override
  String get active_device_your_devices => 'Your Devices';

  @override
  String get active_device_other_devices => 'Other Devices';

  @override
  String get active_device_logout => 'Logout';

  @override
  String get active_device_current => 'This device';

  @override
  String get active_device_logout_confirm_title => 'Logout device?';

  @override
  String get active_device_logout_confirm_subtitle => 'This device will be logged out from your account.';

  @override
  String get active_device_logout_confirm_button => 'Logout';

  @override
  String get active_device_logout_loading => 'Logging out...';

  @override
  String get active_device_already_logged_in_subtitle => 'Your account is already logged in on another device. Log out from an existing device to continue.';

  @override
  String get plan_title => 'My Plans';

  @override
  String get plan_no_available => 'No Plans Available';

  @override
  String get plan_buy_title => 'Buy Subscription';

  @override
  String plan_buy_subtitle(Object planName, Object price) {
    return 'Continue with $planName for ₹$price?';
  }

  @override
  String get plan_buy_confirm => 'Proceed to Pay';

  @override
  String get plan_buy_cancel => 'Cancel';

  @override
  String get plan_subscribe_now => 'Subscribe Now';

  @override
  String get plan_no_commitment => 'No commitment, cancel anytime';

  @override
  String get plan_feature_quality => 'Quality';

  @override
  String get plan_feature_devices => 'Devices';

  @override
  String get plan_feature_downloads => 'Downloads';

  @override
  String get plan_feature_ads => 'Ads';

  @override
  String get plan_feature_yes => 'Yes';

  @override
  String get plan_feature_no => 'No';

  @override
  String get badge_unlimited => 'Unlimited';

  @override
  String get badge_maximum => 'Maximum';

  @override
  String get badge_priority => 'Priority';

  @override
  String get badge_advanced => 'Advanced';

  @override
  String get badge_standard => 'Standard';

  @override
  String get badge_secure => 'Secure';

  @override
  String get payment_success_title => 'Payment Successful 🎉';

  @override
  String get payment_success_subtitle => 'Your subscription has been activated successfully';

  @override
  String get payment_failed_title => 'Payment Failed';

  @override
  String get payment_failed_subtitle => 'Something went wrong. Please try again.';

  @override
  String get payment_failed_retry => 'Retry';

  @override
  String get payment_failed_close => 'Close';

  @override
  String get mySubscriptionTitle => 'My Subscription';

  @override
  String get currentPlan => 'CURRENT PLAN';

  @override
  String get startDate => 'Start Date';

  @override
  String get expireDate => 'Expire';

  @override
  String get quality => 'Quality';

  @override
  String get devices => 'Devices';

  @override
  String get ads => 'Ads';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get addons => 'Add-ons';

  @override
  String get extraDevices => 'Extra Devices';

  @override
  String get extraDownloads => 'Extra Downloads';

  @override
  String get addon => 'Addon';

  @override
  String get addonDevicesValue => 'Devices';

  @override
  String get addonDownloadsValue => 'Downloads';

  @override
  String get rechargeAddon => 'Recharge Add-On';

  @override
  String get payNow => 'Pay Now';

  @override
  String get activePlan => 'ACTIVE PLAN';

  @override
  String get selected => 'SELECTED';

  @override
  String addonPriceSubtitle(Object addon, Object price) {
    return '$addon for ₹$price';
  }
}
