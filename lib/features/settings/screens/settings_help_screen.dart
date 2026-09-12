import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigation/route_names.dart';
import '../../../theme/siraji_colors.dart';
import '../../../theme/siraji_spacing.dart';
import '../../../theme/siraji_typography.dart';
import '../../../widgets/siraji_button.dart';
import '../../../widgets/siraji_card.dart';
import '../../../widgets/siraji_scaffold.dart';

class SettingsHelpScreen extends StatelessWidget {
  const SettingsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    final faqs = _getLocalizedFaqs(languageCode);

    return SirajiScaffold(
      title: loc.helpTitle,
      titleIcon: Icons.help_outline,
      currentNavIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: SirajiSpacing.pagePadding,
          right: SirajiSpacing.pagePadding,
          top: SirajiSpacing.md,
          bottom: SirajiSpacing.footerHeight + SirajiSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SirajiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: SirajiColors.gold.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.help_outline, color: SirajiColors.deepGold, size: 24),
                          ),
                          const SizedBox(width: SirajiSpacing.sm),
                          Expanded(
                            child: Text(
                              loc.helpHeader,
                              style: SirajiTypography.titleLarge.copyWith(
                                color: SirajiColors.deepGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SirajiSpacing.xs),
                      Text(
                        loc.helpIntro,
                        style: SirajiTypography.bodySmall.copyWith(
                          color: SirajiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajiSpacing.md),
                ...faqs.map((faq) => _FaqExpansionCard(question: faq.q, answer: faq.a)),
                const SizedBox(height: SirajiSpacing.lg),
                SirajiButton(
                  label: loc.btnBack,
                  variant: SirajiButtonVariant.secondary,
                  fullWidth: true,
                  onPressed: () => context.go(RouteNames.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<({String q, String a})> _getLocalizedFaqs(String lang) {
    if (lang == 'ur') {
      return [
        (
          q: 'سراجی میں وراثت کا نیا حساب کیسے شروع کریں؟',
          a: 'نیچے موجود نیویگیشن بار سے "حسابات" پر ٹیپ کریں، پھر "نیا حساب شروع کریں" پر کلک کریں۔ آپ چار آسان مراحل میں ترکہ کی تفصیل، متوفی کا ڈیٹا، ورثاء کا انتخاب اور مکمل جائزہ مکمل کر کے حساب لگا سکتے ہیں۔',
        ),
        (
          q: 'ترکہ سے قرض، تجہیز اور وصیت کیسے منہا کی جاتی ہے؟',
          a: 'مرحلہ 1 میں آپ کل ترکہ کے ساتھ ساتھ متوفی کے واجب الادا قرضے، کفن و دفن کے اخراجات، اور غیر وارث کے لیے وصیت درج کر سکتے ہیں۔ شریعت کے مطابق وصیت کی رقم خالص ترکہ کے ایک تہائی (1/3) سے زیادہ نہیں ہو سکتی۔',
        ),
        (
          q: 'قرآنی مقررہ حصص (فروض) اور عصبہ میں کیا فرق ہے؟',
          a: 'اصحاب الفروض (جیسے شوہر، بیوی، ماں، بیٹی) کا حصہ قرآن میں قطعی کسر (جیسے 1/2، 1/4، 1/8) کے طور پر مقرر ہے۔ ان کے حصے دینے کے بعد بچ جانے والا مال عصبات (جیسے بیٹے اور باپ) کو 2:1 کے شرعی تناسب سے ملتا ہے۔',
        ),
        (
          q: 'حسابات کو کیسے محفوظ کریں اور پی ڈی ایف رپورٹ کیسے بنائیں؟',
          a: 'حساب کے نتیجے والے صفحے پر "حساب محفوظ کریں" کا بٹن دبائیں۔ بعد میں آپ "رپورٹس" سیکشن سے اپنی تمام محفوظ شدہ رپورٹس دیکھ سکتے ہیں، پرنٹ کر سکتے ہیں یا پی ڈی ایف کی شکل میں شیئر کر سکتے ہیں۔',
        ),
        (
          q: 'کیا سراجی کو استعمال کرنے کے لیے انٹرنیٹ درکار ہے؟',
          a: 'نہیں، سراجی مکمل طور پر آف لائن کام کرتا ہے۔ آپ کا تمام حسابی ڈیٹا آپ کے ڈیوائس پر ہی لوکل ڈیٹا بیس میں محفوظ رہتا ہے اور کبھی کسی بیرونی سرور پر نہیں بھیجا جاتا۔',
        ),
      ];
    } else if (lang == 'ar') {
      return [
        (
          q: 'كيف تبدأ مسألة ميراث جديدة في سراجي؟',
          a: 'اضغط على تبويب "الحسابات" من شريط التنقل السفلي، ثم اضغط على "بدء مسألة جديدة". اتبع الخطوات الأربع لإدخال بيانات التركة، والمورِّث، وتحديد الورثة، ثم مراجعة النتائج.',
        ),
        (
          q: 'كيف يتم استقطاع الديون ومؤن التجهيز والوصية؟',
          a: 'في الخطوة الأولى، يمكنك إدخال الديون المستحقة وتكاليف الكفن والدفن، ومبلغ الوصية لغير وارث. يُلزم الفقه الإسلامي ألا تتجاوز الوصية ثلث الباقي من التركة.',
        ),
        (
          q: 'ما الفرق بين أصحاب الفروض والعصبات؟',
          a: 'أصحاب الفروض هم من قدر الله لهم سهماً محدداً بنص القرآن (كالنصف والربع والثمن). وبعد استيفائهم لفروضهم، يأخذ العصبات ما تبقى من التركة (للذكر مثل حظ الأنثيين للأولاد).',
        ),
        (
          q: 'كيف تحفظ المسائل وتصدر تقرير PDF؟',
          a: 'اضغط على زر "حفظ المسألة" في شاشة النتائج. يمكنك الرجوع إلى جميع المسائل من تبويب "التقارير" لطباعتها أو تصديرها ومشاركتها كملف PDF رسمي.',
        ),
        (
          q: 'هل يتطلب التطبيق اتصالاً بالإنترنت؟',
          a: 'كلا، تطبيق سراجي يعمل بشكل كامل دون اتصال بالإنترنت (Offline)، وتُحفظ جميع بياناتك محلياً على جهازك بأعلى درجات الخصوصية والأمان.',
        ),
      ];
    } else {
      return [
        (
          q: 'How do I start an inheritance calculation?',
          a: 'Navigate to "Calculations" from the bottom navigation bar and tap "Start New Calculation". Follow the 4-step wizard to enter estate assets, deceased information, surviving heirs, and review your data before calculating.',
        ),
        (
          q: 'How are debts, funeral costs, and bequests deducted?',
          a: 'In Step 1 (Estate Info), enter total gross assets along with debts, funeral costs, and legal bequests (Wasiyyah). In accordance with Shariah, bequests to non-heirs are strictly capped at one-third (1/3) of the net estate.',
        ),
        (
          q: 'What is the difference between Quranic Fixed Shares and Residuaries (Asaba)?',
          a: 'Zawil-Furood (fixed-share heirs) receive exact Quranic fractions (1/2, 1/4, 1/8, 2/3, 1/3, 1/6). After fixed shares are deducted, residuary heirs (Asabat, such as sons) inherit the remaining balance according to the 2:1 male-to-female ratio.',
        ),
        (
          q: 'How do I save calculations and export PDF reports?',
          a: 'On the calculation result screen, tap "Save Calculation". You can later access all your saved records under the "Reports" section to review, print directly, or export and share professional PDF documents.',
        ),
        (
          q: 'Does Siraji require an internet connection or send data online?',
          a: 'No, Siraji is an offline-first and privacy-first application. All calculations and records are stored strictly on your local device without any external server transmission.',
        ),
      ];
    }
  }
}

class _FaqExpansionCard extends StatelessWidget {
  const _FaqExpansionCard({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SirajiSpacing.sm),
      child: SirajiCard(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(top: 8, bottom: 4),
            leading: const Icon(Icons.help_outline, color: SirajiColors.deepGold, size: 20),
            title: Text(
              question,
              style: SirajiTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: SirajiColors.deepGreen,
              ),
            ),
            children: [
              Text(
                answer,
                style: SirajiTypography.bodyMedium.copyWith(
                  color: SirajiColors.textPrimary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
