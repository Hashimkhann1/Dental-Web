import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get dentist;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @ourExperts.
  ///
  /// In en, this message translates to:
  /// **'Our Experts'**
  String get ourExperts;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @careAndSmile.
  ///
  /// In en, this message translates to:
  /// **'Care & Smile'**
  String get careAndSmile;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @welcomeToOurClinic.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Our Clinic'**
  String get welcomeToOurClinic;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Smile is\nOur Priority'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Professional dental care with a gentle touch. We provide comprehensive dental services for the whole family in a comfortable, modern environment.'**
  String get homeSubtitle;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @happyPatients.
  ///
  /// In en, this message translates to:
  /// **'Happy Patients'**
  String get happyPatients;

  /// No description provided for @yearsExperience.
  ///
  /// In en, this message translates to:
  /// **'Years Experience'**
  String get yearsExperience;

  /// No description provided for @emergencyCare.
  ///
  /// In en, this message translates to:
  /// **'Emergency Care'**
  String get emergencyCare;

  /// No description provided for @fiveHondradPlus.
  ///
  /// In en, this message translates to:
  /// **'500+'**
  String get fiveHondradPlus;

  /// No description provided for @fifteenPlus.
  ///
  /// In en, this message translates to:
  /// **'15+'**
  String get fifteenPlus;

  /// No description provided for @twentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'24/7'**
  String get twentyFourHours;

  /// No description provided for @learnMoreAboutUs.
  ///
  /// In en, this message translates to:
  /// **'Learn More About Us'**
  String get learnMoreAboutUs;

  /// No description provided for @aboutOurClinic.
  ///
  /// In en, this message translates to:
  /// **'About Our Clinic'**
  String get aboutOurClinic;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your trusted partner in dental health and beautiful smiles'**
  String get aboutSubtitle;

  /// No description provided for @whyChooseUs.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Us?'**
  String get whyChooseUs;

  /// No description provided for @aboutParagraph.
  ///
  /// In en, this message translates to:
  /// **'At our dental clinic, we combine years of expertise with cutting-edge technology to provide exceptional dental care. Our team of experienced professionals is dedicated to ensuring your comfort while delivering the highest quality treatments.'**
  String get aboutParagraph;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experienced & certified dentists'**
  String get experience;

  /// No description provided for @latestDental.
  ///
  /// In en, this message translates to:
  /// **'Latest dental technology'**
  String get latestDental;

  /// No description provided for @flexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible appointment scheduling'**
  String get flexible;

  /// No description provided for @familyFriendly.
  ///
  /// In en, this message translates to:
  /// **'Family-friendly environment'**
  String get familyFriendly;

  /// No description provided for @satisfactionRate.
  ///
  /// In en, this message translates to:
  /// **'Satisfaction Rate'**
  String get satisfactionRate;

  /// No description provided for @satisfaction.
  ///
  /// In en, this message translates to:
  /// **'100%'**
  String get satisfaction;

  /// No description provided for @ourProfessionalServices.
  ///
  /// In en, this message translates to:
  /// **'Our Professional Services'**
  String get ourProfessionalServices;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @ourServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive dental care with state-of-the-art technology and personalized treatment plans.'**
  String get ourServicesDescription;

  /// No description provided for @rootCanalTitle.
  ///
  /// In en, this message translates to:
  /// **'Root Canal (painless)'**
  String get rootCanalTitle;

  /// No description provided for @rootCanalDescription.
  ///
  /// In en, this message translates to:
  /// **'Advanced painless root canal treatment using modern techniques and sedation options.'**
  String get rootCanalDescription;

  /// No description provided for @dentalImplantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dental Implants'**
  String get dentalImplantsTitle;

  /// No description provided for @dentalImplantsDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanent tooth replacement solutions with titanium implants for natural-looking results.'**
  String get dentalImplantsDescription;

  /// No description provided for @paediatricDentistryTitle.
  ///
  /// In en, this message translates to:
  /// **'Paediatric Dentistry'**
  String get paediatricDentistryTitle;

  /// No description provided for @paediatricDentistryDescription.
  ///
  /// In en, this message translates to:
  /// **'Specialized dental care for children in a fun, comfortable, and child-friendly environment.'**
  String get paediatricDentistryDescription;

  /// No description provided for @orthodonticTreatmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Orthodontic Treatment'**
  String get orthodonticTreatmentTitle;

  /// No description provided for @orthodonticTreatmentDescription.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive orthodontic solutions including braces and clear aligners for perfect smiles.'**
  String get orthodonticTreatmentDescription;

  /// No description provided for @restorativeDentistryTitle.
  ///
  /// In en, this message translates to:
  /// **'Restorative Dentistry'**
  String get restorativeDentistryTitle;

  /// No description provided for @restorativeDentistryDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete restoration services including fillings, crowns, and bridges using premium materials.'**
  String get restorativeDentistryDescription;

  /// No description provided for @cosmeticDentistryTitle.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Dentistry'**
  String get cosmeticDentistryTitle;

  /// No description provided for @cosmeticDentistryDescription.
  ///
  /// In en, this message translates to:
  /// **'Transform your smile with veneers, whitening, and cosmetic procedures for enhanced beauty.'**
  String get cosmeticDentistryDescription;

  /// No description provided for @readyToTransform.
  ///
  /// In en, this message translates to:
  /// **'Ready to Transform Your Smile?'**
  String get readyToTransform;

  /// No description provided for @consultationDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedule your consultation today and take the first step towards optimal dental health'**
  String get consultationDescription;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @ourExpertDoctors.
  ///
  /// In en, this message translates to:
  /// **'Our Expert Doctors'**
  String get ourExpertDoctors;

  /// No description provided for @meetOurTeam.
  ///
  /// In en, this message translates to:
  /// **'Meet our team of experienced healthcare professionals dedicated to providing exceptional medical care with compassion and expertise.'**
  String get meetOurTeam;

  /// No description provided for @tapForDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap for details'**
  String get tapForDetails;

  /// No description provided for @letsStartConversation.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start a\n Conversation'**
  String get letsStartConversation;

  /// No description provided for @conversationDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'re here to help and answer any questions you might have. We look forward to hearing from you.'**
  String get conversationDescription;

  /// No description provided for @whatsAppUs.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Us'**
  String get whatsAppUs;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get emailUs;

  /// No description provided for @visitUs.
  ///
  /// In en, this message translates to:
  /// **'Visit Us'**
  String get visitUs;

  /// No description provided for @followUs.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get followUs;

  /// No description provided for @available247.
  ///
  /// In en, this message translates to:
  /// **'Available 24/7'**
  String get available247;

  /// No description provided for @quickResponseGuaranteed.
  ///
  /// In en, this message translates to:
  /// **'Quick response guaranteed'**
  String get quickResponseGuaranteed;

  /// No description provided for @scheduleVisit.
  ///
  /// In en, this message translates to:
  /// **'Schedule your visit with us'**
  String get scheduleVisit;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @messagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your symptoms or concerns...'**
  String get messagePlaceholder;

  /// No description provided for @appointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appointmentDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred date'**
  String get selectDate;

  /// No description provided for @pleaseSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Please select an appointment date'**
  String get pleaseSelectDate;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNamePlaceholder;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailPlaceholder;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberPlaceholder;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get addressPlaceholder;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @quickLinks.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get quickLinks;

  /// No description provided for @clinicHours.
  ///
  /// In en, this message translates to:
  /// **'Clinic Hours'**
  String get clinicHours;

  /// No description provided for @healthPriority.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Our Priority'**
  String get healthPriority;

  /// No description provided for @exceptionalHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Providing exceptional healthcare services with compassion, expertise, and cutting-edge medical technology. Your wellness is our commitment.'**
  String get exceptionalHealthcare;

  /// No description provided for @stayConnected.
  ///
  /// In en, this message translates to:
  /// **'Stay connected with us on social media for health tips, updates, and community support.'**
  String get stayConnected;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @mondayFriday.
  ///
  /// In en, this message translates to:
  /// **'Monday - Friday'**
  String get mondayFriday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @genInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get genInTouch;

  /// No description provided for @callus.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get callus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
