import '../../../domain/models/knowledge_article.dart';

class KnowledgeData {
  KnowledgeData._();

  static const List<KnowledgeCategory> categories = [
    KnowledgeCategory(
      id: 'intro',
      iconName: 'auto_stories',
      nameEn: 'Introduction to Faraid',
      nameUr: 'علم الفرائض کا تعارف',
      nameAr: 'مقدمة في علم الفرائض',
      descriptionEn: 'Definition, importance, and Quranic authority of Islamic inheritance.',
      descriptionUr: 'علم الفرائض کی تعریف، فضیلت اور قرآنی حیثیت۔',
      descriptionAr: 'تعريف علم الفرائض وأهميته ومكانته في القرآن الكريم والسنة.',
      sortOrder: 1,
    ),
    KnowledgeCategory(
      id: 'principles',
      iconName: 'account_balance',
      nameEn: 'Estate & Deductions',
      nameUr: 'ترکہ اور اس کے حقوق',
      nameAr: 'الحقوق المتعلقة بالتركة',
      descriptionEn: 'The 4 fundamental rights: Funeral, Debts, Bequests, and Inheritance.',
      descriptionUr: 'ترکہ سے متعلق چار بنیادی حقوق: تجہیز، دیون، وصیت اور وراثت۔',
      descriptionAr: 'الحقوق الأربعة: مؤن التجهيز، الديون، الوصية، وقسمة الميراث.',
      sortOrder: 2,
    ),
    KnowledgeCategory(
      id: 'heirs',
      iconName: 'groups',
      nameEn: 'Categories of Heirs',
      nameUr: 'ورثاء کے درجات و اقسام',
      nameAr: 'أصناف ومراتب الورثة',
      descriptionEn: 'Primary and secondary heirs: Zawil-Furood, Asabat, and Zawil-Arham.',
      descriptionUr: 'وارثوں کے درجات: ذوی الفروض، عصبات اور ذوی الارحام۔',
      descriptionAr: 'مراتب الورثة: أصحاب الفروض، العصبات، وذوو الأرحام.',
      sortOrder: 3,
    ),
    KnowledgeCategory(
      id: 'shares',
      iconName: 'pie_chart',
      nameEn: 'Quranic Fixed Shares',
      nameUr: 'قرآنی معین حصص (الفروض)',
      nameAr: 'الفروض المقدرة في كتاب الله',
      descriptionEn: 'The 6 Quranic fractions: 1/2, 1/4, 1/8, 2/3, 1/3, and 1/6.',
      descriptionUr: 'قرآن کریم کے چھ مقررہ حصے: 1/2، 1/4، 1/8، 2/3، 1/3 اور 1/6۔',
      descriptionAr: 'الفروض الستة: النصف، الربع، الثمن، الثلثان، الثلث، والسدس.',
      sortOrder: 4,
    ),
    KnowledgeCategory(
      id: 'residuaries',
      iconName: 'account_tree',
      nameEn: 'Residuaries (Asaba)',
      nameUr: 'عصبات اور ان کے احکام',
      nameAr: 'العصبات وأحكامها',
      descriptionEn: 'Male-line heirs who inherit the remaining residue of the estate.',
      descriptionUr: 'وہ ورثاء جو اصحاب الفروض کے بعد بچا ہوا مال لیتے ہیں۔',
      descriptionAr: 'أحكام العصبة بالنفس، والعصبة بالغير، والعصبة مع الغير.',
      sortOrder: 5,
    ),
    KnowledgeCategory(
      id: 'exclusion',
      iconName: 'block',
      nameEn: 'Exclusion Rules (Hajb)',
      nameUr: 'حجب کے قواعد و ضوابط',
      nameAr: 'أحكام الحجب وقواعده',
      descriptionEn: 'Rules determining when closer heirs block distant relatives.',
      descriptionUr: 'قریبی ورثاء کی موجودگی میں دور کے رشتہ داروں کی محرومی کے اصول۔',
      descriptionAr: 'حجب الحرمان وحجب النقصان وقواعد حجب الأقارب.',
      sortOrder: 6,
    ),
    KnowledgeCategory(
      id: 'distribution',
      iconName: 'calculate',
      nameEn: 'Distribution & Adjustments',
      nameUr: 'عول، رد اور تقسیم کے اصول',
      nameAr: 'العول والرد والتصحيح',
      descriptionEn: 'Mathematical methods: Awl (deficits) and Radd (surpluses).',
      descriptionUr: 'ترکہ کی کمی اور بیشی کے شرعی حل: عول اور رد۔',
      descriptionAr: 'معالجة النقص بالزيادة (العول) ورد الفائض على أصحاب الفروض.',
      sortOrder: 7,
    ),
    KnowledgeCategory(
      id: 'terminology',
      iconName: 'menu_book',
      nameEn: 'Key Terminology',
      nameUr: 'اصطلاحاتِ فرائض',
      nameAr: 'المصطلحات الفقهية',
      descriptionEn: 'Essential vocabulary and definitions in classical Islamic jurisprudence.',
      descriptionUr: 'علم میراث میں مستعمل بنیادی فقہی و شرعی اصطلاحات۔',
      descriptionAr: 'معجم أهم المصطلحات الفقهية في علم المواريث.',
      sortOrder: 8,
    ),
  ];

  static const List<KnowledgeArticle> articles = [
    // 1. What is Faraid?
    KnowledgeArticle(
      id: 'what-is-faraid',
      categoryId: 'intro',
      titleEn: 'What is Ilm al-Faraid?',
      titleUr: 'علم الفرائض کیا ہے؟',
      titleAr: 'ما هو علم الفرائض؟',
      summaryEn: 'An introduction to the science of Islamic inheritance, its divine origin, and its vital importance in Islamic jurisprudence.',
      summaryUr: 'علمِ میراث کی تعریف، اس کی اہمیت، فضیلت اور شریعتِ اسلامی میں اس کا بنیادی مقام۔',
      summaryAr: 'مقدمة شاملة في تعريف علم المواريث وأهميته وتأصيله في الشريعة الإسلامية.',
      contentEn: '''### Definition
Ilm al-Faraid (علم الفرائض) is the specialized branch of Islamic jurisprudence (Fiqh) that deals with the legal rules governing the determination of heirs, the calculation of their precise Quranic shares, and the distribution of a deceased person's estate.

### Linguistic Meaning
Linguistically, *Faraid* is the plural of *Faridah* (فریضة), which signifies an ordained obligation, a fixed measure, or a decreed portion. In Islamic legal terminology, it refers to the specific shares predetermined directly by Allah in the Noble Quran.

### Divine Authority
Unlike many other legal matters where broad principles are set and detailed applications left to human discretion, Allah revealed detailed, precise fractions for inheritance directly in **Surah An-Nisa (Verses 11, 12, and 176)**.

### Importance in Sunnah
The Prophet Muhammad (peace be upon him) highlighted the urgency of learning and preserving this knowledge:
> *"Learn the laws of inheritance and teach them to the people, for it is half of knowledge."* (Sunan Ibn Majah, 2719)''',
      contentUr: '''### تعریف
علم الفرائض فقہ اسلامی کا وہ عظیم شعبہ ہے جس میں متوفی کے ترکہ سے متعلق احکام، مستحق ورثاء کی شناخت، اور ہر وارث کے معین و غیر معین حصص کے تعین اور تقسیم کے اصول بیان کیے جاتے ہیں۔

### لغوی مفہوم
"فرائض" عربی لفظ "فریضہ" کی جمع ہے، جس کے معنی مقررہ، فرض کردہ یا معین حصے کے ہیں۔ اصطلاحِ شریعت میں اس سے مراد وہ قطعی حصص ہیں جنہیں اللہ تعالیٰ نے قرآنِ مجید میں متعین فرمایا ہے۔

### قرآنی حیثیت
اسلامی شریعت میں وراثت کے قوانین کی تقسیم کو انسانوں کی ذاتی پسند یا رائے پر نہیں چھوڑا گیا، بلکہ اللہ تعالیٰ نے خود سورۂ النساء کی آیات (11، 12 اور 176) میں ہر وارث کا حصہ تفصیل کے ساتھ نازل فرمایا ہے۔

### فضیلت و اہمیت
رسول اللہ ﷺ نے اس علم کے سیکھنے اور سکھانے کی خاص تاکید فرمائی:
> *"علم الفرائض سیکھو اور لوگوں کو سکھاؤ، کیونکہ یہ نصف علم ہے۔"* (سنن ابن ماجہ)''',
      contentAr: '''### التعريف الاصطلاحي
علم الفرائض (أو علم المواريث) هو فقه المواريث والتركات، ومعرفة الحساب الموصل إلى معرفة حق كل ذي حق من التركة.

### المعنى اللغوي
الفرائض جمع فريضة، وهي مأخوذة من الفرض بمعنى التقدير، لقوله تعالى: ﴿نَصِيبًا مَفْرُوضًا﴾، أي مقدراً معلوماً.

### المكانة والتأصيل الشرعي
تولى الله سبحانه وتعالى بنفسه تقدير الأنصبة وقسمة التركات في محكم التنزيل في سورة النساء (الآيات 11، 12، 176)، ولم يكل قسمتها إلى ملك مقرب ولا نبي مرسل.

### الحث النبوي على تعلمه
روي عن النبي ﷺ أنه قال:
> «تَعَلَّمُوا الْفَرَائِضَ وَعَلِّمُوهَا النَّاسَ، فَإِنَّهُ نِصْفُ الْعِلْمِ» (سنن ابن ماجه)''',
      references: [
        KnowledgeReference(source: 'Noble Quran', citation: 'Surah An-Nisa (4:11-14)'),
        KnowledgeReference(source: 'Sunan Ibn Majah', citation: 'Kitab al-Faraid, Hadith 2719'),
        KnowledgeReference(source: 'Al-Sirajiyyah fi al-Faraid', citation: 'Imam Siraj al-Din al-Sajawandi'),
      ],
      relatedArticleIds: ['estate-and-deductions', 'quranic-fixed-shares'],
      readingTimeMinutes: 3,
      sortOrder: 1,
    ),

    // 2. Estate & Deductions (Tarakah)
    KnowledgeArticle(
      id: 'estate-and-deductions',
      categoryId: 'principles',
      titleEn: 'Rights Related to the Estate (Tarakah)',
      titleUr: 'ترکہ اور اس کے حقوقِ اربعہ',
      titleAr: 'الحقوق المتعلقة بالتركة وترتيبها',
      summaryEn: 'The four sequential rights that must be fulfilled before inheritance is distributed among heirs.',
      summaryUr: 'ترکہ کی تقسیم سے پہلے ادا کیے جانے والے چار ضروری حقوق کی شرعی ترتیب۔',
      summaryAr: 'الترتيب الشرعي للحقوق الأربعة الواجب أداؤها من تركة الميت قبل القسمة.',
      contentEn: '''### The Four Successive Rights
When a Muslim passes away, their gross estate (*Tarakah*) cannot be divided among heirs immediately. Classical Islamic jurisprudence outlines a strict order of priority for deductions:

1. **Funeral & Burial Costs (Tajheez & Takfeen):** Reasonable, customary expenses for shroud, washing, transportation, and grave preparation without extravagance.
2. **Settlement of Debts (Duyun):** All outstanding debts must be fully repaid from the remaining estate. This includes debts owed to people (commercial loans, unpaid dowry) and debts owed to Allah (unpaid Zakat, expiations/Kaffarah).
3. **Execution of Valid Bequest (Wasiyyah):** Legally documented bequests to non-heirs are fulfilled from the remaining balance, up to a maximum limit of **one-third (1/3)** of the remaining estate.
4. **Distribution of Net Estate (Mirath):** The remaining balance after fulfilling the above three obligations is strictly distributed among eligible Quranic and residuary heirs according to Faraid rules.''',
      contentUr: '''### ترکہ کے چار لازمی حقوق (حقوقِ اربعہ)
کسی بھی مسلمان کے انتقال کے بعد اس کے چھوڑے ہوئے مال و جائیداد کی ورثاء میں تقسیم سے قبل درج ذیل چار حقوق کو علی الترتیب ادا کرنا شرعاً فرض ہے:

1. **تجہیز و تکفین:** متوفی کے غسل، کفن، اور تدفین کے ضروری و مناسب اخراجات بغیر کسی اسراف یا بخل کے ادا کیے جائیں گے۔
2. **ادائے دیون (قرضوں کی ادائیگی):** متوفی کے تمام واجب الادا قرضے خواہ وہ بندوں کے ہوں (قرض، ادھار، غیر ادا شدہ مہر) یا اللہ کے حقوق ہوں (زکوٰۃ، کفارہ)، مکمل ادا کیے جائیں گے۔
3. **جائز وصیت کا نفاذ:** غیر وارث کے حق میں کی گئی جائز وصیت بقیہ ترکہ کے زیادہ سے زیادہ **ایک تہائی (1/3)** حصے تک نافذ کی جائے گی۔
4. **ورثاء میں تقسیمِ میراث:** مذکورہ بالا تینوں حقوق کی تکمیل کے بعد جو خالص مال بچے گا، وہ تمام شرعی ورثاء میں مقررہ حصص کے مطابق تقسیم ہوگا۔''',
      contentAr: '''### ترتيب الحقوق المتعلقة بالتركة
يتعلق بتركة الميت أربعة حقوق مرتبة وجوباً وفق الفقه الإسلامي:

1. **مؤن التجهيز والتكفين:** ما يحتاج إليه الميت من كفن وغسل ودفن بالمعروف من غير إسراف ولا تقتير.
2. **قضاء الديون:** ديون الله تعالى (كالزكاة والكفارات) وديون العباد (كالديون المالية والمؤجل من المهر).
3. **تنفيذ الوصايا:** الوصية لغير وارث في حدود **ثلث** الباقي من التركة بعد الديون ومؤن التجهيز.
4. **قسمة الميراث:** توزيع ما تبقى من المال على الورثة المستحقين شرعاً بحسب فرائضهم المقدرة.''',
      references: [
        KnowledgeReference(source: 'Noble Quran', citation: 'Surah An-Nisa 4:11 ("من بعد وصية يوصي بها أو دين")'),
        KnowledgeReference(source: 'Sahih al-Bukhari', citation: 'Kitab al-Wasaya, Hadith 2742'),
      ],
      relatedArticleIds: ['what-is-faraid', 'quranic-fixed-shares'],
      readingTimeMinutes: 4,
      sortOrder: 2,
    ),

    // 3. Quranic Fixed Shares
    KnowledgeArticle(
      id: 'quranic-fixed-shares',
      categoryId: 'shares',
      titleEn: 'The Six Quranic Fixed Shares',
      titleUr: 'قرآنی معین حصص (الفروض المقدرة)',
      titleAr: 'الفروض الستة المقدرة في القرآن الكريم',
      summaryEn: 'Detailed explanation of the six Quranic fractions and the conditions under which heirs receive them.',
      summaryUr: 'قرآن کریم میں بیان کردہ چھ بنیادی کسروں (1/2، 1/4، 1/8، 2/3، 1/3، 1/6) اور ان کے شرائط کی تفصیل۔',
      summaryAr: 'شرح تفصيلي للفروض الستة وأصحاب كل فرض من كتاب الله تعالى.',
      contentEn: '''### The Six Ordained Fractions
The Quran sets forth exactly six primary fractional shares (*Zawil-Furood*):

1. **One-Half (1/2):**
   * **Husband:** In the absence of child/grandchild descendants.
   * **Daughter:** Single daughter in the absence of a son.
   * **Son's Daughter (Granddaughter):** Single, in absence of direct children or grandsons.
   * **Full Sister:** Single, in absence of father, grandfather, children, or full brother.
   * **Paternal Half-Sister:** Single, under equivalent conditions without full siblings.

2. **One-Fourth (1/4):**
   * **Husband:** In the presence of surviving children or grandchildren.
   * **Wife/Wives:** In the absence of surviving children or grandchildren (shared equally).

3. **One-Eighth (1/8):**
   * **Wife/Wives:** In the presence of surviving children or grandchildren (shared equally).

4. **Two-Thirds (2/3):**
   * **Two or More Daughters:** In the absence of a son.
   * **Two or More Granddaughters / Full Sisters / Paternal Sisters:** Under corresponding conditions without brothers.

5. **One-Third (1/3):**
   * **Mother:** In the absence of children/grandchildren and having at most one sibling.
   * **Maternal Siblings:** Two or more shared equally (male and female equally).

6. **One-Sixth (1/6):**
   * **Father / Grandfather:** In the presence of surviving children.
   * **Mother / Grandmother:** In the presence of children or multiple siblings.
   * **Single Maternal Sibling.**''',
      contentUr: '''### قرآن کے چھ معین حصص
قرآنِ مجید میں اصحاب الفروض کے لیے کل چھ قطعی حصے بیان کیے گئے ہیں:

1. **نصف (1/2):**
   * **شوہر:** اگر متوفیہ کی کوئی اولاد (بیٹا، بیٹی، پوتا، پوتی) نہ ہو۔
   * **اکلوتی بیٹی:** اگر متوفی کا کوئی بیٹا نہ ہو۔
   * **پوتی / سگی بہن / سوتیلی بہن:** مخصوص شرعی شرائط کے ساتھ۔

2. **ایک چوتھائی (1/4):**
   * **شوہر:** اگر متوفیہ کی اولاد موجود ہو۔
   * **بیوی (یا بیویاں):** اگر متوفی کی کوئی اولاد نہ ہو (سب بیویاں اس میں برابر شریک ہوں گی)۔

3. **ایک آٹھواں (1/8):**
   * **بیوی (یا بیویاں):** اگر متوفی کی اولاد موجود ہو (سب بیویاں اس میں برابر شریک ہوں گی)۔

4. **دو تہائی (2/3):**
   * **دو یا زائد بیٹیاں:** اگر متوفی کا کوئی بیٹا نہ ہو۔
   * **دو یا زائد پوتیاں یا سگی بہنیں:** مخصوص شرائط کے ساتھ۔

5. **ایک تہائی (1/3):**
   * **والدہ:** اگر اولاد نہ ہو اور بھائی بہنوں کی تعداد ایک سے زیادہ نہ ہو۔
   * **اخیافی (ماں شریک) بہن بھائی:** اگر دو یا دو سے زائد ہوں (مرد و عورت برابر ہوں گے)۔

6. **چھٹا حصہ (1/6):**
   * **والد اور دادا:** اولاد کی موجودگی میں۔
   * **والدہ اور دادی/نانی:** اولاد یا متعدد بھائی بہنوں کی موجودگی میں۔
   * **ایک اخیافی بھائی یا بہن۔**''',
      contentAr: '''### الفروض الستة المنصوص عليها
الفروض المقدرة في كتاب الله تعالى ستة:

1. **النصف (1/2):** للزوج (عند عدم الفرع الوارث)، والبنت المنفردة، وبنت الابن، والأخت الشقيقة، والأخت لأب.
2. **الربع (1/4):** للزوج (مع الفرع الوارث)، وللزوجة أو الزوجات (عند عدم الفرع الوارث).
3. **الثمن (1/8):** للزوجة أو الزوجات (مع وجود الفرع الوارث).
4. **الثلثان (2/3):** للبنتين فأكثر، وبنات الابن فأكثر، والأخوات الشقيقات فأكثر، والأخوات لأب فأكثر.
5. **الثلث (1/3):** للأم (عند عدم الفرع الوارث والجمع من الإخوة)، وللإخوة لأم (إذا كانوا اثنين فأكثر بالتساوي).
6. **السدس (1/6):** للأب والجد، وللأم والجدة، وبنت الابن مع البنت، والأخت لأب مع الشقيقة، وللواحد من ولد الأم.''',
      references: [
        KnowledgeReference(source: 'Noble Quran', citation: 'Surah An-Nisa 4:11, 4:12, 4:176'),
        KnowledgeReference(source: 'Bidayat al-Mujtahid', citation: 'Ibn Rushd'),
      ],
      relatedArticleIds: ['asaba-residuaries', 'hajb-exclusion'],
      readingTimeMinutes: 5,
      sortOrder: 3,
    ),

    // 4. Residuaries (Asaba)
    KnowledgeArticle(
      id: 'asaba-residuaries',
      categoryId: 'residuaries',
      titleEn: 'Understanding Residuary Heirs (Asabat)',
      titleUr: 'عصبات کی اقسام اور ان کا حصہ',
      titleAr: 'أحكام العصبات وأنواعها في الميراث',
      summaryEn: 'How male-line relatives inherit the remaining estate after all Quranic fixed shares are distributed.',
      summaryUr: 'عصبات کے تینوں درجات (عصبہ بالنفس، عصبہ بالغیر، عصبہ مع الغیر) اور ان کے ترکہ وصول کرنے کے اصول۔',
      summaryAr: 'بيان أنواع العصبات الثلاث وقواعد استحقاقهم لباقي التركة.',
      contentEn: '''### Who are the Asabat?
*Asabah* refers to universal residuary heirs who inherit whatever remains of the estate after the fixed Quranic shares (*Zawil-Furood*) have been assigned. If there are no fixed-share heirs, the Asabah takes the entire estate.

### The Three Types of Asabah
1. **Asabah bi-Nafsihi (Residuary in their own right):**
   * All male relatives connected to the deceased through male lineage (e.g. Son, Grandson, Father, Paternal Grandfather, Full Brother, Paternal Brother, Nephews, Paternal Uncles).
2. **Asabah bi-Ghayrihi (Residuary by another):**
   * Female fixed-share heirs who are made residuary heirs by the presence of an equivalent male sibling (e.g. Daughters with Sons, Granddaughters with Grandsons, Full Sisters with Full Brothers).
   * **Rule of 2:1:** The male receives twice the share of the female (*Lidh-dhakari mithlu hazzil-unthayayn*).
3. **Asabah ma'a Ghayrihi (Residuary with another):**
   * Sisters when they inherit alongside surviving daughters/granddaughters.''',
      contentUr: '''### عصبہ کسے کہتے ہیں؟
عصبہ وہ وارث ہیں جن کا کوئی معین حصہ (جیسے 1/2 یا 1/4) مقرر نہیں ہوتا، بلکہ وہ اصحاب الفروض کو ان کے مقررہ حصے دینے کے بعد بچا ہوا پورا ترکہ لے لیتے ہیں۔ اگر کوئی اصحاب الفروض نہ ہو تو عصبہ پورے ترکہ کا مالک بنتا ہے۔

### عصبات کی تین اقسام
1. **عصبہ بالنفس:** وہ تمام مذکر رشتہ دار جن کے متوفی سے تعلق میں کوئی عورت واسطہ نہ بنے (جیسے بیٹا، پوتا، باپ، دادا، سگا بھائی، بھتیجا، چچا وغیرہ)۔
2. **عصبہ بالغیر:** وہ چار خواتین جو اپنے ہم پلہ مذکر رشتہ دار کی موجودگی میں عصبہ بن جاتی ہیں:
   * بیٹی (بیٹے کے ساتھ)
   * پوتی (پوتے کے ساتھ)
   * سگی بہن (سگے بھائی کے ساتھ)
   * سوتیلی بہن (سوتیلے بھائی کے ساتھ)
   * **قاعدہ 2:1:** اس صورت میں مرد کو عورت کے مقابلے میں دوگنا حصہ ملتا ہے (لِلذَّكَرِ مِثْلُ حَظِّ الْأُنْثَيَيْنِ)۔
3. **عصبہ مع الغیر:** سگی یا سوتیلی بہنیں جب بیٹی یا پوتی کے ساتھ وارث بنیں۔''',
      contentAr: '''### تعريف العصبة
العاصب هو كل من يحوز جميع التركة إذا انفرد، أو ما أبقته الفروض المقدرة إذا وجد أصحاب الفروض.

### أقسام العصبة الثلاثة
1. **عصبة بالنفس:** كل ذكر لا تدخل في نسبة إلى الميت أنثى (كالابن وابنه، والأب والجد، والأخ الشقيق ولأب، والعم).
2. **عصبة بالغير:** كل أنثى صاحبة فرض صارت عصبة بوجود أخيها المساوي لها (البنت مع الابن، بنت الابن مع ابن الابن، الأخت الشقيقة مع الأخ الشقيق). ويكون للذكر مثل حظ الأنثيين.
3. **عصبة مع الغير:** الأخوات الشقيقات أو لأب مع البنات أو بنات الابن.''',
      references: [
        KnowledgeReference(source: 'Sahih al-Bukhari', citation: 'Hadith 6732 ("ألحقوا الفرائض بأهلها...")'),
        KnowledgeReference(source: 'Al-Sirajiyyah', citation: 'Bab al-Asabat'),
      ],
      relatedArticleIds: ['quranic-fixed-shares', 'hajb-exclusion'],
      readingTimeMinutes: 4,
      sortOrder: 4,
    ),

    // 5. Exclusion Rules (Hajb)
    KnowledgeArticle(
      id: 'hajb-exclusion',
      categoryId: 'exclusion',
      titleEn: 'Rules of Exclusion (Hajb)',
      titleUr: 'حجب کے احکام اور اصول',
      titleAr: 'أحكام الحجب وقواعد حجب الورثة',
      summaryEn: 'How closer relatives completely or partially exclude distant heirs from the inheritance.',
      summaryUr: 'حجبِ حرمان (مکمل محرومی) اور حجبِ نقصان (حصہ کی کمی) کے شرعی اصول اور مثالیں۔',
      summaryAr: 'شرح حجب الحرمان وحجب النقصان وقواعد منع الأقارب الأبعدين بالأقربين.',
      contentEn: '''### What is Hajb?
*Hajb* (حجب) means exclusion or prevention. It is the Islamic legal doctrine whereby one heir prevents another relative from inheriting either entirely or partially.

### Two Major Types of Hajb
1. **Hajb Nuqsan (Partial Exclusion / Reduction):**
   * Moving an heir from a larger share to a smaller share due to the presence of another relative (e.g. Husband reduced from 1/2 to 1/4 due to children; Mother reduced from 1/3 to 1/6).
2. **Hajb Hirman (Total Exclusion):**
   * Completely blocking an heir from any share of the estate.

### Golden Rules of Total Exclusion
* **Direct Descendants Block Indirect:** A direct Son excludes all grandsons, granddaughters, brothers, sisters, and uncles.
* **The Father Blocks Grandfathers & Collaterals:** The Father excludes paternal grandfathers, brothers, sisters, and uncles.
* **The Closer Relative Blocks the More Distant:** A full brother blocks a paternal half-brother and paternal uncles.
* **The 6 Inviolable Heirs:** There are six heirs who are **never totally excluded** by anyone:
  1. Father
  2. Mother
  3. Husband
  4. Wife
  5. Son
  6. Daughter''',
      contentUr: '''### حجب کی تعریف
"حجب" کے لغوی معنی روکنے یا پردہ ڈالنے کے ہیں۔ شریعت میں ایک وارث کی موجودگی کے سبب دوسرے وارث کے حق میں کمی واقع ہونا یا اس کا مکمل محروم ہو جانا "حجب" کہلاتا ہے۔

### حجب کی دو بنیادی اقسام
1. **حجبِ نقصان:** کسی وارث کے بڑے حصے کا چھوٹے حصے میں تبدیل ہو جانا (جیسے اولاد کی وجہ سے شوہر کا 1/2 سے 1/4 اور والدہ کا 1/3 سے 1/6 ہو جانا)۔
2. **حجبِ حرمان:** کسی وارث کا مکمل طور پر وراثت سے محروم ہو جانا۔

### حجبِ حرمان کے بنیادی اصول
* **بیٹا:** تمام پوتوں، پوتیوں، بھائیوں، بہنوں اور چچاؤں کو مکمل محجوب کر دیتا ہے۔
* **والد:** تمام دادا، دادی، بھائیوں، بہنوں اور چچاؤں کو محجوب کر دیتا ہے۔
* **ماں:** تمام دادیوں اور نانیوں کو محجوب کر دیتی ہے۔
* **چھ ورثاء جو کبھی محجوب نہیں ہوتے:**
  1. شوہر
  2. بیوی
  3. باپ
  4. ماں
  5. بیٹا
  6. بیٹی''',
      contentAr: '''### تعريف الحجب
الحجب هو منع وارث من كل الميراث أو من بعضه لوجود وارث آخر هو أقرب منه إلى الميت.

### نوعا الحجب
1. **حجب نقصان:** نقل الوارث من فرض أعلى إلى فرض أدنى (كنقصان الزوج من النصف إلى الربع بوجود الولد).
2. **حجب حرمان:** إسقاط الوارث وحرمانه من كل الميراث.

### الستة الذين لا يحجبون حجب حرمان أبداً
1. الأب
2. الأم
3. الابن
4. البنت
5. الزوج
6. الزوجة''',
      references: [
        KnowledgeReference(source: 'Al-Sirajiyyah fi al-Faraid', citation: 'Fasl fi al-Hajb'),
        KnowledgeReference(source: 'Al-Mughni', citation: 'Ibn Qudamah'),
      ],
      relatedArticleIds: ['asaba-residuaries', 'quranic-fixed-shares'],
      readingTimeMinutes: 4,
      sortOrder: 5,
    ),

    // 6. Awl & Radd
    KnowledgeArticle(
      id: 'awl-and-radd',
      categoryId: 'distribution',
      titleEn: 'Awl and Radd: Deficits & Surpluses',
      titleUr: 'عول اور رد کے اصول',
      titleAr: 'أحكام العول والرد في المسائل الفرائضية',
      summaryEn: 'How classical jurisprudence resolves cases where total fractions exceed 100% (Awl) or leave a surplus (Radd).',
      summaryUr: 'جب قرآنی حصص کل ترکہ سے بڑھ جائیں (عول) یا بچ جائیں (رد) تو اس کے شرعی حل کا تفصیلی جائزہ۔',
      summaryAr: 'طرق معالجة زيادة الفروض عن أصل المسألة (العول) أو بقاء فائض من التركة (الرد).',
      contentEn: '''### 1. The Concept of Awl (العول)
When the sum of fixed Quranic shares in an inheritance case exceeds the whole estate (i.e. numerator exceeds denominator), *Awl* (proportional reduction) is applied.
* **Origin:** Instituted by the consensus of the Companions under Caliph Umar ibn al-Khattab (may Allah be pleased with him).
* **Method:** The base denominator is mathematically increased to match the sum of numerators, ensuring every heir receives their equitable share with proportionate reduction.

### 2. The Concept of Radd (الرد)
When the fixed shares do not exhaust the total estate and there are no residuary heirs (*Asabah*) to claim the remainder, the surplus is redistributed (*Radd*) back to eligible fixed-share heirs in proportion to their Quranic shares (excluding spouses according to the majority classical view).''',
      contentUr: '''### 1. عول کا مفہوم
جب کسی وراثت کے مسئلے میں تمام ذوی الفروض کے حصص کا مجموعہ کل ترکہ سے بڑھ جائے (یعنی کسر 1 سے تجاوز کر جائے)، تو "عول" کا طریقہ اختیار کیا جاتا ہے۔
* **تاریخ:** اس پر حضرت عمر فاروق رضی اللہ عنہ کے دورِ خلافت میں صحابہ کرام کا اجماع ہوا۔
* **طریقہ کار:** مخرج (ڈینومینیٹر) کو تمام حصص کے مجموعے کے برابر بڑھا دیا جاتا ہے، تاکہ ہر وارث پر تناسب کے ساتھ مساوی کمی واقع ہو۔

### 2. رد کا مفہوم
جب تمام اصحاب الفروض کو حصے دینے کے بعد ترکہ میں مال بچ جائے اور کوئی عصبہ موجود نہ ہو، تو بچا ہوا مال اصحاب الفروض کو ان کے مقررہ تناسب کے مطابق واپس لوٹا دیا جاتا ہے، جسے "رد" کہتے ہیں۔''',
      contentAr: '''### 1. العول
العول هو زيادة في السهام المفروضة على أصل المسألة، مما يؤدي إلى نقص أنصباء الورثة بنسبة سهامهم. وقد قضى به أمير المؤمنين عمر بن الخطاب رضي الله عنه بموافقة الصحابة.

### 2. الرد
الرد هو ضد العول، وهو أن يفضل من التركة شيء بعد أخذ أصحاب الفروض فروضهم ولا يوجد عاصب، فيرد الباقي على أصحاب الفروض بنسبة فروضهم (عدا الزوجين عند الجمهور).''',
      references: [
        KnowledgeReference(source: 'Sunan al-Bayhaqi', citation: 'Kitab al-Faraid'),
        KnowledgeReference(source: 'Al-Sirajiyyah', citation: 'Bab al-Awl wa al-Radd'),
      ],
      relatedArticleIds: ['quranic-fixed-shares', 'asaba-residuaries'],
      readingTimeMinutes: 4,
      sortOrder: 6,
    ),

    // 7. Key Terminology
    KnowledgeArticle(
      id: 'key-terminology',
      categoryId: 'terminology',
      titleEn: 'Essential Faraid Terminology',
      titleUr: 'علم الفرائض کی اہم اصطلاحات',
      titleAr: 'معجم مصطلحات علم الفرائض',
      summaryEn: 'Comprehensive glossary of classical terms used in Islamic inheritance calculation.',
      summaryUr: 'علمِ وراثت و فرائض میں کثرت سے مستعمل بنیادی عربی و شرعی اصطلاحات کی فرہنگ۔',
      summaryAr: 'دليل شامل لأهم المصطلحات الفقهية والشرعية في علم التركات والمواريث.',
      contentEn: '''### Glossary of Terms
* **Tarakah (تركة):** The total net estate, property, and assets left behind by a deceased person.
* **Mawruth / Muwarrith (مُوَرِّث):** The deceased individual whose estate is being inherited.
* **Warith (وارث):** The legal living heir who has a Shariah-prescribed right to inherit.
* **Zawil-Furood (ذوو الفروض):** Heirs whose fractional portions are explicitly fixed in the Quran.
* **Asabah (عصبة):** Residuary heirs who inherit the remaining balance.
* **Zawil-Arham (ذوو الأرحام):** Uterine and distant relatives who inherit when neither Zawil-Furood nor Asabat exist.
* **Hajb (حجب):** The legal exclusion of an heir by a closer relative.
* **Wasiyyah (وصية):** A voluntary testamentary bequest made to a non-heir (limited to 1/3).
* **Awl (عول):** Proportional reduction when shares exceed unity.
* **Radd (رد):** Proportional return of surplus when shares do not total unity.''',
      contentUr: '''### فرہنگِ اصطلاحات
* **ترکہ (Tarakah):** متوفی کی چھوڑی ہوئی کل منقولہ و غیر منقولہ جائیداد اور نقدی۔
* **مُوَرِّث (Muwarrith):** وہ فوت شدہ شخص جس کا مال تقسیم کیا جا رہا ہو۔
* **وارث (Warith):** وہ زندہ شخص جو شرعاً متوفی کے ترکہ میں حصہ پانے کا حقدار ہو۔
* **ذوی الفروض (Zawil-Furood):** وہ ورثاء جن کے حصے قرآنِ مجید میں متعین ہیں۔
* **عصبہ (Asabah):** وہ ورثاء جو اصحاب الفروض کے بعد بچا ہوا مال وصول کرتے ہیں۔
* **ذوی الارحام (Zawil-Arham):** وہ دور کے رشتہ دار جو اصحاب الفروض اور عصبات کی عدم موجودگی میں وارث بنتے ہیں۔
* **حجب (Hajb):** قریبی وارث کی وجہ سے دور کے وارث کا محروم یا کم حصہ پانا۔
* **وصیت (Wasiyyah):** غیر وارث کے حق میں کیا جانے والا مالی عطیہ جو ایک تہائی تک جائز ہے۔
* **عول (Awl):** حصص کے مجموعے کا کل ترکہ سے بڑھ جانا۔
* **رد (Radd):** بچ جانے والے ترکہ کا دوبارہ اصحاب الفروض پر لوٹایا جانا۔''',
      contentAr: '''### معجم المصطلحات
* **التركة:** كل ما يخلفه الميت من أموال وحقوق مالية.
* **المورِّث:** الشخص المتوفى صاحب التركة.
* **الوارث:** الحي المستحق لنصيب من التركة بعد الموت.
* **أصحاب الفروض:** الورثة الذين قدر الله لهم نصيباً محدداً في القرآن.
* **العصبة:** كل من يأخذ ما أبقته الفروض أو كل التركة عند الانفراد.
* **ذوو الأرحام:** كل قريب للميت ليس بصاحب فرض ولا عصبة.
* **الحجب:** منع وارث من الإرث كلياً أو جزئياً.
* **الوصية:** تبرع بالمال مضاف إلى ما بعد الموت في حدود الثلث.
* **العول:** زيادة في مجموع السهام ونقص في الأنصباء.
* **الرد:** صرف الفائض من التركة إلى أصحاب الفروض عند عدم العاصب.''',
      references: [
        KnowledgeReference(source: 'Mu\'jam Lughat al-Fuqaha', citation: 'Dr. Muhammad Rawas Qal\'aji'),
      ],
      relatedArticleIds: ['what-is-faraid', 'estate-and-deductions'],
      readingTimeMinutes: 3,
      sortOrder: 8,
    ),
  ];
}
