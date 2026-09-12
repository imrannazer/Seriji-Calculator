import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('ur')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Siraji'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Islamic Inheritance Made Clear'**
  String get appTagline;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Inheritance & Property Distribution Calculator'**
  String get appSubtitle;

  /// No description provided for @languageSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelectionTitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCalculations.
  ///
  /// In en, this message translates to:
  /// **'Calculations'**
  String get navCalculations;

  /// No description provided for @navKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get navKnowledge;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Siraji'**
  String get homeGreeting;

  /// No description provided for @homeHeroDesc.
  ///
  /// In en, this message translates to:
  /// **'Shariah-compliant Islamic inheritance calculations, estate distribution, and legal Will management in accordance with Quranic principles.'**
  String get homeHeroDesc;

  /// No description provided for @primaryActionTitle.
  ///
  /// In en, this message translates to:
  /// **'Faraid Calculation'**
  String get primaryActionTitle;

  /// No description provided for @primaryActionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate Quranic fixed shares (Fard) and residual inheritance (Asaba)'**
  String get primaryActionSubtitle;

  /// No description provided for @primaryActionCta.
  ///
  /// In en, this message translates to:
  /// **'Start Calculation'**
  String get primaryActionCta;

  /// No description provided for @actionPropertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Property Distribution'**
  String get actionPropertyTitle;

  /// No description provided for @actionPropertySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allocate real estate, cash, and assets among eligible heirs'**
  String get actionPropertySubtitle;

  /// No description provided for @actionWillTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Will (Wasiyyah)'**
  String get actionWillTitle;

  /// No description provided for @actionWillSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Draft and document legal bequests within the 1/3 Shariah limit'**
  String get actionWillSubtitle;

  /// No description provided for @actionKnowledgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Knowledge Base'**
  String get actionKnowledgeTitle;

  /// No description provided for @actionKnowledgeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn the foundational jurisprudence and rules of Faraid'**
  String get actionKnowledgeSubtitle;

  /// No description provided for @actionReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Reports'**
  String get actionReportsTitle;

  /// No description provided for @actionReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View, export, and manage your past inheritance calculations'**
  String get actionReportsSubtitle;

  /// No description provided for @calculationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculations'**
  String get calculationsTitle;

  /// No description provided for @calculationsHeader.
  ///
  /// In en, this message translates to:
  /// **'Inheritance Calculator'**
  String get calculationsHeader;

  /// No description provided for @calculationsIntro.
  ///
  /// In en, this message translates to:
  /// **'Determine exact legal shares for all surviving heirs according to classical Islamic jurisprudence.'**
  String get calculationsIntro;

  /// No description provided for @startFaraidCta.
  ///
  /// In en, this message translates to:
  /// **'Start New Calculation'**
  String get startFaraidCta;

  /// No description provided for @recentCalculations.
  ///
  /// In en, this message translates to:
  /// **'Recent Saved Calculations'**
  String get recentCalculations;

  /// No description provided for @noCalculationsYet.
  ///
  /// In en, this message translates to:
  /// **'No saved calculations yet. Tap below to begin your first calculation.'**
  String get noCalculationsYet;

  /// No description provided for @knowledgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get knowledgeTitle;

  /// No description provided for @knowledgeHeader.
  ///
  /// In en, this message translates to:
  /// **'Islamic Inheritance Jurisprudence'**
  String get knowledgeHeader;

  /// No description provided for @knowledgeIntro.
  ///
  /// In en, this message translates to:
  /// **'Explore authentic foundational topics in the science of inheritance (Ilm al-Faraid).'**
  String get knowledgeIntro;

  /// No description provided for @searchKnowledgeHint.
  ///
  /// In en, this message translates to:
  /// **'Search concepts, heirs, rules, terms...'**
  String get searchKnowledgeHint;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @minRead.
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get minRead;

  /// No description provided for @articleReferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Scholarly References & Sources'**
  String get articleReferencesTitle;

  /// No description provided for @articleRelatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Related Topics'**
  String get articleRelatedTitle;

  /// No description provided for @btnTryInCalculator.
  ///
  /// In en, this message translates to:
  /// **'Try in Inheritance Calculator'**
  String get btnTryInCalculator;

  /// No description provided for @noArticlesFound.
  ///
  /// In en, this message translates to:
  /// **'No knowledge topics found matching your query.'**
  String get noArticlesFound;

  /// No description provided for @btnClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get btnClearSearch;

  /// No description provided for @btnReadArticle.
  ///
  /// In en, this message translates to:
  /// **'Read Topic'**
  String get btnReadArticle;

  /// No description provided for @knowledgeDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Content is grounded in authentic classical Fiqh (Al-Sirajiyyah, Al-Mughni, and Quranic exegesis).'**
  String get knowledgeDisclaimer;

  /// No description provided for @categoryPrinciples.
  ///
  /// In en, this message translates to:
  /// **'Principles of Faraid'**
  String get categoryPrinciples;

  /// No description provided for @categoryShares.
  ///
  /// In en, this message translates to:
  /// **'Quranic Fixed Shares'**
  String get categoryShares;

  /// No description provided for @categoryHeirs.
  ///
  /// In en, this message translates to:
  /// **'Categories of Heirs'**
  String get categoryHeirs;

  /// No description provided for @categoryExclusion.
  ///
  /// In en, this message translates to:
  /// **'Rules of Exclusion (Hajb)'**
  String get categoryExclusion;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @reportsHeader.
  ///
  /// In en, this message translates to:
  /// **'Saved Calculations & Reports'**
  String get reportsHeader;

  /// No description provided for @reportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View, review, print, and export saved calculation reports'**
  String get reportsSubtitle;

  /// No description provided for @emptyReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Saved Reports Yet'**
  String get emptyReportsTitle;

  /// No description provided for @emptyReportsDesc.
  ///
  /// In en, this message translates to:
  /// **'Your completed calculations and estate distribution records will be saved here for offline access, PDF generation, and printing.'**
  String get emptyReportsDesc;

  /// No description provided for @searchReportsHint.
  ///
  /// In en, this message translates to:
  /// **'Search by deceased name or reference...'**
  String get searchReportsHint;

  /// No description provided for @btnOpenReport.
  ///
  /// In en, this message translates to:
  /// **'View Report'**
  String get btnOpenReport;

  /// No description provided for @btnDeleteReport.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btnDeleteReport;

  /// No description provided for @dialogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Calculation Record'**
  String get dialogDeleteTitle;

  /// No description provided for @dialogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this saved calculation? This action cannot be undone.'**
  String get dialogDeleteMessage;

  /// No description provided for @dialogDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get dialogDeleteConfirm;

  /// No description provided for @dialogDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogDeleteCancel;

  /// No description provided for @toastDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Calculation record deleted successfully.'**
  String get toastDeletedSuccess;

  /// No description provided for @btnPrintPdf.
  ///
  /// In en, this message translates to:
  /// **'Print Report'**
  String get btnPrintPdf;

  /// No description provided for @btnSharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF Report'**
  String get btnSharePdf;

  /// No description provided for @btnDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'View & Export PDF'**
  String get btnDownloadPdf;

  /// No description provided for @noReportsFound.
  ///
  /// In en, this message translates to:
  /// **'No saved reports match your search.'**
  String get noReportsFound;

  /// No description provided for @reportDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Inheritance Report Details'**
  String get reportDetailsTitle;

  /// No description provided for @reportMetaDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reportMetaDate;

  /// No description provided for @reportMetaEstate.
  ///
  /// In en, this message translates to:
  /// **'Net Estate'**
  String get reportMetaEstate;

  /// No description provided for @reportMetaHeirs.
  ///
  /// In en, this message translates to:
  /// **'Heirs'**
  String get reportMetaHeirs;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsHeader.
  ///
  /// In en, this message translates to:
  /// **'Application Preferences'**
  String get settingsHeader;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language / زبان / اللغة'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageDesc.
  ///
  /// In en, this message translates to:
  /// **'English, اردو, العربية'**
  String get settingsLanguageDesc;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About Siraji'**
  String get settingsAbout;

  /// No description provided for @settingsAboutDesc.
  ///
  /// In en, this message translates to:
  /// **'Version, acknowledgments & legal disclaimer'**
  String get settingsAboutDesc;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Guidance'**
  String get settingsHelp;

  /// No description provided for @settingsHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'User manual and frequently asked questions'**
  String get settingsHelpDesc;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settingsData;

  /// No description provided for @settingsDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Local storage status, backup & data reset'**
  String get settingsDataDesc;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Language'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get settingsSectionData;

  /// No description provided for @settingsSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsSectionHelp;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About & Legal'**
  String get settingsSectionAbout;

  /// No description provided for @settingsLanguageOptionEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageOptionEn;

  /// No description provided for @settingsLanguageOptionUr.
  ///
  /// In en, this message translates to:
  /// **'اردو'**
  String get settingsLanguageOptionUr;

  /// No description provided for @settingsLanguageOptionAr.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLanguageOptionAr;

  /// No description provided for @settingsDataStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline Local Storage'**
  String get settingsDataStorageTitle;

  /// No description provided for @settingsDataStorageDesc.
  ///
  /// In en, this message translates to:
  /// **'All calculation records and reports are stored locally on your device for complete privacy. Zero data is transmitted to external servers.'**
  String get settingsDataStorageDesc;

  /// No description provided for @settingsDataExport.
  ///
  /// In en, this message translates to:
  /// **'Export Data Backup (.siraji.json)'**
  String get settingsDataExport;

  /// No description provided for @settingsDataExportDesc.
  ///
  /// In en, this message translates to:
  /// **'Export all saved calculations and estate profiles to a secure local file.'**
  String get settingsDataExportDesc;

  /// No description provided for @settingsDataImport.
  ///
  /// In en, this message translates to:
  /// **'Import Data Backup (.siraji.json)'**
  String get settingsDataImport;

  /// No description provided for @settingsDataImportDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore saved calculations and estate profiles from a previously exported backup file.'**
  String get settingsDataImportDesc;

  /// No description provided for @settingsDataClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All Saved Data'**
  String get settingsDataClearAll;

  /// No description provided for @settingsDataClearAllDesc.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove all saved calculations and reports from this device.'**
  String get settingsDataClearAllDesc;

  /// No description provided for @dialogClearDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Saved Calculations'**
  String get dialogClearDataTitle;

  /// No description provided for @dialogClearDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete all saved calculations from this device? This action cannot be undone.'**
  String get dialogClearDataMessage;

  /// No description provided for @dialogClearDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get dialogClearDataConfirm;

  /// No description provided for @toastClearedSuccess.
  ///
  /// In en, this message translates to:
  /// **'All saved calculation data has been cleared.'**
  String get toastClearedSuccess;

  /// No description provided for @toastExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data backup prepared successfully.'**
  String get toastExportSuccess;

  /// No description provided for @dialogImportPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Data Import'**
  String get dialogImportPreviewTitle;

  /// No description provided for @dialogImportPreviewDesc.
  ///
  /// In en, this message translates to:
  /// **'The following valid records were found in this backup file:'**
  String get dialogImportPreviewDesc;

  /// No description provided for @importPreviewCalculations.
  ///
  /// In en, this message translates to:
  /// **'Saved Calculations'**
  String get importPreviewCalculations;

  /// No description provided for @importPreviewWills.
  ///
  /// In en, this message translates to:
  /// **'Estate & Will Profiles'**
  String get importPreviewWills;

  /// No description provided for @importPreviewSchema.
  ///
  /// In en, this message translates to:
  /// **'Schema Version'**
  String get importPreviewSchema;

  /// No description provided for @btnConfirmImport.
  ///
  /// In en, this message translates to:
  /// **'Import & Restore'**
  String get btnConfirmImport;

  /// No description provided for @toastImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data successfully restored from backup!'**
  String get toastImportSuccess;

  /// No description provided for @errorImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import validation failed'**
  String get errorImportFailed;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Guidance'**
  String get helpTitle;

  /// No description provided for @helpHeader.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpHeader;

  /// No description provided for @helpIntro.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive user guide on how to calculate inheritance, understand shares, manage reports, and use Siraji offline.'**
  String get helpIntro;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Siraji'**
  String get aboutTitle;

  /// No description provided for @aboutHeader.
  ///
  /// In en, this message translates to:
  /// **'About Siraji'**
  String get aboutHeader;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutBuild.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get aboutBuild;

  /// No description provided for @aboutLicense.
  ///
  /// In en, this message translates to:
  /// **'Copyright & License'**
  String get aboutLicense;

  /// No description provided for @aboutDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Legal & Religious Disclaimer'**
  String get aboutDisclaimerTitle;

  /// No description provided for @aboutDisclaimerText.
  ///
  /// In en, this message translates to:
  /// **'Siraji is developed strictly as an educational and preliminary informational calculation tool in accordance with classical Islamic jurisprudence (Ilm al-Faraid). It is not a substitute for formal judicial decree or binding legal fatwa. Users are advised to review sensitive or disputed inheritance matters with certified Islamic scholars (Muftis) and local legal authorities.'**
  String get aboutDisclaimerText;

  /// No description provided for @aboutSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Jurisprudential Sources'**
  String get aboutSourcesTitle;

  /// No description provided for @aboutSourcesText.
  ///
  /// In en, this message translates to:
  /// **'Content and calculation logic are modeled upon authentic classical Fiqh references, primarily Al-Sirajiyyah fi al-Faraid (Imam Siraj al-Din al-Sajawandi), Al-Mughni (Imam Ibn Qudamah), and direct Quranic verses (Surah An-Nisa 4:11, 4:12, 4:176).'**
  String get aboutSourcesText;

  /// No description provided for @badgeFuturePhase.
  ///
  /// In en, this message translates to:
  /// **'Phase 2+'**
  String get badgeFuturePhase;

  /// No description provided for @badgeComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get badgeComingSoon;

  /// No description provided for @dialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialogClose;

  /// No description provided for @stepEstateTitle.
  ///
  /// In en, this message translates to:
  /// **'Estate Info'**
  String get stepEstateTitle;

  /// No description provided for @stepDeceasedTitle.
  ///
  /// In en, this message translates to:
  /// **'Deceased'**
  String get stepDeceasedTitle;

  /// No description provided for @stepHeirsTitle.
  ///
  /// In en, this message translates to:
  /// **'Heirs'**
  String get stepHeirsTitle;

  /// No description provided for @stepReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get stepReviewTitle;

  /// No description provided for @fieldGrossAssets.
  ///
  /// In en, this message translates to:
  /// **'Total Gross Estate Value'**
  String get fieldGrossAssets;

  /// No description provided for @fieldGrossAssetsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500000'**
  String get fieldGrossAssetsHint;

  /// No description provided for @fieldDebts.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Debts (Duyun)'**
  String get fieldDebts;

  /// No description provided for @fieldDebtsHint.
  ///
  /// In en, this message translates to:
  /// **'Debts owed by deceased'**
  String get fieldDebtsHint;

  /// No description provided for @fieldFuneral.
  ///
  /// In en, this message translates to:
  /// **'Funeral & Burial Expenses'**
  String get fieldFuneral;

  /// No description provided for @fieldFuneralHint.
  ///
  /// In en, this message translates to:
  /// **'Tajheez & Takfeen costs'**
  String get fieldFuneralHint;

  /// No description provided for @fieldBequest.
  ///
  /// In en, this message translates to:
  /// **'Valid Bequest / Wasiyyah (Max 1/3)'**
  String get fieldBequest;

  /// No description provided for @fieldBequestHint.
  ///
  /// In en, this message translates to:
  /// **'Non-heir bequest amount'**
  String get fieldBequestHint;

  /// No description provided for @netDistributableEstate.
  ///
  /// In en, this message translates to:
  /// **'Net Distributable Estate (Tarakah)'**
  String get netDistributableEstate;

  /// No description provided for @fieldDeceasedName.
  ///
  /// In en, this message translates to:
  /// **'Deceased Name / Title'**
  String get fieldDeceasedName;

  /// No description provided for @fieldDeceasedNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Late Muhammad Ali'**
  String get fieldDeceasedNameHint;

  /// No description provided for @fieldDeceasedGender.
  ///
  /// In en, this message translates to:
  /// **'Gender of Deceased'**
  String get fieldDeceasedGender;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male (Marhum)'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female (Marhuma)'**
  String get genderFemale;

  /// No description provided for @fieldMaritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status at Death'**
  String get fieldMaritalStatus;

  /// No description provided for @maritalMarried.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get maritalMarried;

  /// No description provided for @maritalSingle.
  ///
  /// In en, this message translates to:
  /// **'Single / Unmarried'**
  String get maritalSingle;

  /// No description provided for @maritalWidowed.
  ///
  /// In en, this message translates to:
  /// **'Widowed / Divorced'**
  String get maritalWidowed;

  /// No description provided for @heirsPrimarySection.
  ///
  /// In en, this message translates to:
  /// **'Primary Quranic Heirs'**
  String get heirsPrimarySection;

  /// No description provided for @heirsSecondarySection.
  ///
  /// In en, this message translates to:
  /// **'Secondary & Extended Heirs'**
  String get heirsSecondarySection;

  /// No description provided for @heirHusband.
  ///
  /// In en, this message translates to:
  /// **'Husband'**
  String get heirHusband;

  /// No description provided for @heirWife.
  ///
  /// In en, this message translates to:
  /// **'Wife / Wives'**
  String get heirWife;

  /// No description provided for @heirSon.
  ///
  /// In en, this message translates to:
  /// **'Son(s)'**
  String get heirSon;

  /// No description provided for @heirDaughter.
  ///
  /// In en, this message translates to:
  /// **'Daughter(s)'**
  String get heirDaughter;

  /// No description provided for @heirFather.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get heirFather;

  /// No description provided for @heirMother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get heirMother;

  /// No description provided for @heirGrandfather.
  ///
  /// In en, this message translates to:
  /// **'Paternal Grandfather'**
  String get heirGrandfather;

  /// No description provided for @heirGrandmother.
  ///
  /// In en, this message translates to:
  /// **'Paternal Grandmother'**
  String get heirGrandmother;

  /// No description provided for @heirMaternalGrandmother.
  ///
  /// In en, this message translates to:
  /// **'Maternal Grandmother'**
  String get heirMaternalGrandmother;

  /// No description provided for @heirGrandson.
  ///
  /// In en, this message translates to:
  /// **'Grandson(s)'**
  String get heirGrandson;

  /// No description provided for @heirGranddaughter.
  ///
  /// In en, this message translates to:
  /// **'Granddaughter(s)'**
  String get heirGranddaughter;

  /// No description provided for @heirFullBrother.
  ///
  /// In en, this message translates to:
  /// **'Full Brother(s)'**
  String get heirFullBrother;

  /// No description provided for @heirFullSister.
  ///
  /// In en, this message translates to:
  /// **'Full Sister(s)'**
  String get heirFullSister;

  /// No description provided for @heirPaternalHalfBrother.
  ///
  /// In en, this message translates to:
  /// **'Paternal Half-Brother(s)'**
  String get heirPaternalHalfBrother;

  /// No description provided for @heirPaternalHalfSister.
  ///
  /// In en, this message translates to:
  /// **'Paternal Half-Sister(s)'**
  String get heirPaternalHalfSister;

  /// No description provided for @heirMaternalHalfBrother.
  ///
  /// In en, this message translates to:
  /// **'Maternal Half-Brother(s)'**
  String get heirMaternalHalfBrother;

  /// No description provided for @heirMaternalHalfSister.
  ///
  /// In en, this message translates to:
  /// **'Maternal Half-Sister(s)'**
  String get heirMaternalHalfSister;

  /// No description provided for @heirPaternalUncle.
  ///
  /// In en, this message translates to:
  /// **'Paternal Uncle(s)'**
  String get heirPaternalUncle;

  /// No description provided for @heirPaternalUnclesSon.
  ///
  /// In en, this message translates to:
  /// **'Paternal Uncle\'s Son(s)'**
  String get heirPaternalUnclesSon;

  /// No description provided for @btnNext.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get btnNext;

  /// No description provided for @btnBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get btnBack;

  /// No description provided for @btnCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate Shares'**
  String get btnCalculate;

  /// No description provided for @btnEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get btnEdit;

  /// No description provided for @btnSaveCalculation.
  ///
  /// In en, this message translates to:
  /// **'Save Calculation'**
  String get btnSaveCalculation;

  /// No description provided for @btnNewCalculation.
  ///
  /// In en, this message translates to:
  /// **'New Calculation'**
  String get btnNewCalculation;

  /// No description provided for @btnBackToCalculations.
  ///
  /// In en, this message translates to:
  /// **'Back to Calculations'**
  String get btnBackToCalculations;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculation Result'**
  String get resultTitle;

  /// No description provided for @resultEstateSummary.
  ///
  /// In en, this message translates to:
  /// **'Estate & Deductions Summary'**
  String get resultEstateSummary;

  /// No description provided for @resultGrossValue.
  ///
  /// In en, this message translates to:
  /// **'Total Assets'**
  String get resultGrossValue;

  /// No description provided for @resultTotalDeductions.
  ///
  /// In en, this message translates to:
  /// **'Total Deductions'**
  String get resultTotalDeductions;

  /// No description provided for @resultNetEstate.
  ///
  /// In en, this message translates to:
  /// **'Net Distributable Value'**
  String get resultNetEstate;

  /// No description provided for @resultHeirsBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Heir Shares & Distribution Breakdown'**
  String get resultHeirsBreakdown;

  /// No description provided for @resultTableHeir.
  ///
  /// In en, this message translates to:
  /// **'Heir Category'**
  String get resultTableHeir;

  /// No description provided for @resultTableCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get resultTableCount;

  /// No description provided for @resultTableShare.
  ///
  /// In en, this message translates to:
  /// **'Share (Fraction / %)'**
  String get resultTableShare;

  /// No description provided for @resultTableTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Share'**
  String get resultTableTotalAmount;

  /// No description provided for @resultTablePerPerson.
  ///
  /// In en, this message translates to:
  /// **'Per Person'**
  String get resultTablePerPerson;

  /// No description provided for @resultExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Jurisprudential Explanation (Fiqh)'**
  String get resultExplanationTitle;

  /// No description provided for @resultDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Scholarly Disclaimer'**
  String get resultDisclaimerTitle;

  /// No description provided for @resultDisclaimerText.
  ///
  /// In en, this message translates to:
  /// **'This calculation is provided as an educational and preliminary informational tool based on standard Islamic jurisprudence. Real-world estate distribution should always be reviewed and confirmed with a qualified Islamic mufti/scholar and legal authority.'**
  String get resultDisclaimerText;

  /// No description provided for @toastSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Calculation successfully saved!'**
  String get toastSavedSuccess;

  /// No description provided for @toastValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Please check the required fields before continuing.'**
  String get toastValidationFailed;

  /// No description provided for @valDeceasedNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the deceased person\'s name or reference.'**
  String get valDeceasedNameRequired;

  /// No description provided for @valEstateValueRequired.
  ///
  /// In en, this message translates to:
  /// **'Estate value must be greater than 0.'**
  String get valEstateValueRequired;

  /// No description provided for @valDebtsExceedEstate.
  ///
  /// In en, this message translates to:
  /// **'Debts and funeral expenses cannot exceed total estate.'**
  String get valDebtsExceedEstate;

  /// No description provided for @valBequestExceedsThird.
  ///
  /// In en, this message translates to:
  /// **'Bequest (Wasiyyah) cannot exceed 1/3 (33.33%) of net estate.'**
  String get valBequestExceedsThird;

  /// No description provided for @valAtLeastOneHeir.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one surviving heir.'**
  String get valAtLeastOneHeir;

  /// No description provided for @valMaxWives.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of wives is 4.'**
  String get valMaxWives;

  /// No description provided for @valMaxHusbands.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of husbands is 1.'**
  String get valMaxHusbands;

  /// No description provided for @navWill.
  ///
  /// In en, this message translates to:
  /// **'Will / Wasiyyah'**
  String get navWill;

  /// No description provided for @willSectionHeader.
  ///
  /// In en, this message translates to:
  /// **'Estate Profile & Will (Wasiyyah)'**
  String get willSectionHeader;

  /// No description provided for @willSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Document testator details, estate assets, bequests (max 1/3), and calculate Shariah-compliant distribution.'**
  String get willSectionSubtitle;

  /// No description provided for @btnCreateNewWill.
  ///
  /// In en, this message translates to:
  /// **'Create New Will / Profile'**
  String get btnCreateNewWill;

  /// No description provided for @emptyWillsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Estate Profiles Yet'**
  String get emptyWillsTitle;

  /// No description provided for @emptyWillsDesc.
  ///
  /// In en, this message translates to:
  /// **'Document your estate details and legal bequests within the 1/3 Shariah limit, and connect them directly to the Faraid inheritance calculator.'**
  String get emptyWillsDesc;

  /// No description provided for @searchWillsHint.
  ///
  /// In en, this message translates to:
  /// **'Search by testator name or notes...'**
  String get searchWillsHint;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusReviewed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get statusReviewed;

  /// No description provided for @statusFinalized.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get statusFinalized;

  /// No description provided for @dialogDeleteWillTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Will / Profile'**
  String get dialogDeleteWillTitle;

  /// No description provided for @dialogDeleteWillMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this estate and Will profile? This action cannot be undone.'**
  String get dialogDeleteWillMessage;

  /// No description provided for @toastWillDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Estate & Will profile deleted successfully.'**
  String get toastWillDeletedSuccess;

  /// No description provided for @toastWillSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Estate & Will profile successfully saved!'**
  String get toastWillSavedSuccess;

  /// No description provided for @btnCalculateFaraid.
  ///
  /// In en, this message translates to:
  /// **'Calculate Faraid Shares'**
  String get btnCalculateFaraid;

  /// No description provided for @fieldBequestNotes.
  ///
  /// In en, this message translates to:
  /// **'Bequest Notes & Execution Instructions'**
  String get fieldBequestNotes;

  /// No description provided for @fieldBequestNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Specify beneficiaries for the 1/3 non-heir bequest and special instructions...'**
  String get fieldBequestNotesHint;

  /// No description provided for @statusSelectorLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile Status'**
  String get statusSelectorLabel;
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
      <String>['ar', 'en', 'ur'].contains(locale.languageCode);

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
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
