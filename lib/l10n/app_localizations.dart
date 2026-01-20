import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bh.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bh'),
    Locale('en'),
    Locale('hi'),
    Locale('pa')
  ];

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continues;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @punjabi.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get punjabi;

  /// No description provided for @bhojpuri.
  ///
  /// In en, this message translates to:
  /// **'Bhojpuri'**
  String get bhojpuri;

  /// No description provided for @login_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get login_skip;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login or Signup'**
  String get login_title;

  /// No description provided for @login_mobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number*'**
  String get login_mobileLabel;

  /// No description provided for @login_mobileHint.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile number'**
  String get login_mobileHint;

  /// No description provided for @login_otpInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you an OTP to confirm your mobile number'**
  String get login_otpInfo;

  /// No description provided for @login_sendingOtp.
  ///
  /// In en, this message translates to:
  /// **'Sending OTP...'**
  String get login_sendingOtp;

  /// No description provided for @otp_title.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get otp_title;

  /// No description provided for @otp_sent_to.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to +91 {mobile}'**
  String otp_sent_to(Object mobile);

  /// No description provided for @otp_resend_in.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in {seconds} sec'**
  String otp_resend_in(Object seconds);

  /// No description provided for @otp_didnt_receive.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive OTP?'**
  String get otp_didnt_receive;

  /// No description provided for @otp_resend_now.
  ///
  /// In en, this message translates to:
  /// **'Resend Now'**
  String get otp_resend_now;

  /// No description provided for @otp_resending.
  ///
  /// In en, this message translates to:
  /// **'Resending OTP...'**
  String get otp_resending;

  /// No description provided for @otp_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otp_verify;

  /// No description provided for @otp_invalid_length.
  ///
  /// In en, this message translates to:
  /// **'Enter valid 6 digit OTP'**
  String get otp_invalid_length;

  /// No description provided for @otp_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP'**
  String get otp_invalid;

  /// No description provided for @otp_verifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying OTP...'**
  String get otp_verifying;

  /// No description provided for @otp_resend_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend OTP'**
  String get otp_resend_failed;

  /// No description provided for @auth_accountBlocked_title.
  ///
  /// In en, this message translates to:
  /// **'Account Blocked'**
  String get auth_accountBlocked_title;

  /// No description provided for @auth_accountBlocked_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been blocked. Please contact support for more information.'**
  String get auth_accountBlocked_subtitle;

  /// No description provided for @auth_accountBlocked_confirm.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get auth_accountBlocked_confirm;

  /// No description provided for @auth_deviceLimit_title.
  ///
  /// In en, this message translates to:
  /// **'Device limit reached'**
  String get auth_deviceLimit_title;

  /// No description provided for @auth_deviceLimit_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account is already logged in on another device. Log out from an existing device to continue.'**
  String get auth_deviceLimit_subtitle;

  /// No description provided for @auth_genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get auth_genericError;

  /// No description provided for @bottom_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_home;

  /// No description provided for @bottom_free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get bottom_free;

  /// No description provided for @bottom_premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get bottom_premium;

  /// No description provided for @bottom_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get bottom_search;

  /// No description provided for @bottom_myplan.
  ///
  /// In en, this message translates to:
  /// **'My Plan'**
  String get bottom_myplan;

  /// No description provided for @exit_title.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exit_title;

  /// No description provided for @exit_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get exit_subtitle;

  /// No description provided for @exit_confirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit_confirm;

  /// No description provided for @exit_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get exit_cancel;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search movies, shows, actors'**
  String get search_hint;

  /// No description provided for @search_trending_title.
  ///
  /// In en, this message translates to:
  /// **'Trending Searches'**
  String get search_trending_title;

  /// No description provided for @search_no_results.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get search_no_results;

  /// No description provided for @watchlist_title.
  ///
  /// In en, this message translates to:
  /// **'My Watchlist'**
  String get watchlist_title;

  /// No description provided for @watchlist_empty.
  ///
  /// In en, this message translates to:
  /// **'No items in Watchlist'**
  String get watchlist_empty;

  /// No description provided for @watchlist_watch_now.
  ///
  /// In en, this message translates to:
  /// **'Watch Now'**
  String get watchlist_watch_now;

  /// No description provided for @watchlist_see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get watchlist_see_all;

  /// No description provided for @detail_play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get detail_play;

  /// No description provided for @detail_episodes.
  ///
  /// In en, this message translates to:
  /// **'Episodes'**
  String get detail_episodes;

  /// No description provided for @detail_watchlist_added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get detail_watchlist_added;

  /// No description provided for @detail_watchlist_add.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get detail_watchlist_add;

  /// No description provided for @detail_cast_crew.
  ///
  /// In en, this message translates to:
  /// **'Cast & Crew'**
  String get detail_cast_crew;

  /// No description provided for @detail_more_like_this.
  ///
  /// In en, this message translates to:
  /// **'More like this'**
  String get detail_more_like_this;

  /// No description provided for @detail_premium_badge.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM •'**
  String get detail_premium_badge;

  /// No description provided for @detail_free_badge.
  ///
  /// In en, this message translates to:
  /// **'FREE •'**
  String get detail_free_badge;

  /// No description provided for @detail_select_season.
  ///
  /// In en, this message translates to:
  /// **'Select Season'**
  String get detail_select_season;

  /// No description provided for @profile_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profile_edit_title;

  /// No description provided for @profile_registered_mobile.
  ///
  /// In en, this message translates to:
  /// **'Registered mobile number'**
  String get profile_registered_mobile;

  /// No description provided for @profile_mobile_format.
  ///
  /// In en, this message translates to:
  /// **'+91-{mobile}'**
  String profile_mobile_format(Object mobile);

  /// No description provided for @profile_guest_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Sign in to unlock all features'**
  String get profile_guest_message;

  /// No description provided for @profile_full_name_label.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profile_full_name_label;

  /// No description provided for @profile_full_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get profile_full_name_hint;

  /// No description provided for @profile_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profile_email_label;

  /// No description provided for @profile_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get profile_email_hint;

  /// No description provided for @profile_login_continue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue'**
  String get profile_login_continue;

  /// No description provided for @profile_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profile_save_changes;

  /// No description provided for @profile_updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get profile_updating;

  /// No description provided for @help_title.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_title;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile Screen'**
  String get profile_title;

  /// No description provided for @profile_greeting_guest.
  ///
  /// In en, this message translates to:
  /// **'Hi there 👋'**
  String get profile_greeting_guest;

  /// No description provided for @profile_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profile_edit;

  /// No description provided for @profile_plans_offers.
  ///
  /// In en, this message translates to:
  /// **'Plans &\nOffers'**
  String get profile_plans_offers;

  /// No description provided for @profile_help_center.
  ///
  /// In en, this message translates to:
  /// **'Help\nCenter'**
  String get profile_help_center;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profile_settings;

  /// No description provided for @profile_watchlist_title.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get profile_watchlist_title;

  /// No description provided for @profile_watchlist_view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get profile_watchlist_view_all;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get settings_watchlist;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settings_logout;

  /// No description provided for @settings_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settings_delete_account;

  /// No description provided for @settings_logout_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settings_logout_confirm_title;

  /// No description provided for @settings_logout_confirm_button.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settings_logout_confirm_button;

  /// No description provided for @active_device_title.
  ///
  /// In en, this message translates to:
  /// **'Active Devices'**
  String get active_device_title;

  /// No description provided for @active_device_loading_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to load devices'**
  String get active_device_loading_error;

  /// No description provided for @active_device_limit_title.
  ///
  /// In en, this message translates to:
  /// **'Device limit reached'**
  String get active_device_limit_title;

  /// No description provided for @active_device_limit_desc.
  ///
  /// In en, this message translates to:
  /// **'Your current subscription allows a limited number of active devices. To continue, please log out from one of the devices listed below.'**
  String get active_device_limit_desc;

  /// No description provided for @active_device_limit_note.
  ///
  /// In en, this message translates to:
  /// **'You can sign in again on any device after logging out.'**
  String get active_device_limit_note;

  /// No description provided for @active_device_your_devices.
  ///
  /// In en, this message translates to:
  /// **'Your Devices'**
  String get active_device_your_devices;

  /// No description provided for @active_device_other_devices.
  ///
  /// In en, this message translates to:
  /// **'Other Devices'**
  String get active_device_other_devices;

  /// No description provided for @active_device_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get active_device_logout;

  /// No description provided for @active_device_current.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get active_device_current;

  /// No description provided for @active_device_logout_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Logout device?'**
  String get active_device_logout_confirm_title;

  /// No description provided for @active_device_logout_confirm_subtitle.
  ///
  /// In en, this message translates to:
  /// **'This device will be logged out from your account.'**
  String get active_device_logout_confirm_subtitle;

  /// No description provided for @active_device_logout_confirm_button.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get active_device_logout_confirm_button;

  /// No description provided for @active_device_logout_loading.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get active_device_logout_loading;

  /// No description provided for @active_device_already_logged_in_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account is already logged in on another device. Log out from an existing device to continue.'**
  String get active_device_already_logged_in_subtitle;

  /// No description provided for @plan_title.
  ///
  /// In en, this message translates to:
  /// **'My Plans'**
  String get plan_title;

  /// No description provided for @plan_no_available.
  ///
  /// In en, this message translates to:
  /// **'No Plans Available'**
  String get plan_no_available;

  /// No description provided for @plan_buy_title.
  ///
  /// In en, this message translates to:
  /// **'Buy Subscription'**
  String get plan_buy_title;

  /// No description provided for @plan_buy_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with {planName} for ₹{price}?'**
  String plan_buy_subtitle(Object planName, Object price);

  /// No description provided for @plan_buy_confirm.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Pay'**
  String get plan_buy_confirm;

  /// No description provided for @plan_buy_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get plan_buy_cancel;

  /// No description provided for @plan_subscribe_now.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get plan_subscribe_now;

  /// No description provided for @plan_no_commitment.
  ///
  /// In en, this message translates to:
  /// **'No commitment, cancel anytime'**
  String get plan_no_commitment;

  /// No description provided for @plan_feature_quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get plan_feature_quality;

  /// No description provided for @plan_feature_devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get plan_feature_devices;

  /// No description provided for @plan_feature_downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get plan_feature_downloads;

  /// No description provided for @plan_feature_ads.
  ///
  /// In en, this message translates to:
  /// **'Ads'**
  String get plan_feature_ads;

  /// No description provided for @plan_feature_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get plan_feature_yes;

  /// No description provided for @plan_feature_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get plan_feature_no;

  /// No description provided for @badge_unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get badge_unlimited;

  /// No description provided for @badge_maximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get badge_maximum;

  /// No description provided for @badge_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get badge_priority;

  /// No description provided for @badge_advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get badge_advanced;

  /// No description provided for @badge_standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get badge_standard;

  /// No description provided for @badge_secure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get badge_secure;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bh', 'en', 'hi', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bh': return AppLocalizationsBh();
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'pa': return AppLocalizationsPa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
