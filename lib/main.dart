import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HorofiFarmApp());
}

class HorofiFarmApp extends StatelessWidget {
  const HorofiFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حروفي المرحة 🌻',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF46B84B)),
      ),
      home: const MainFarmScreen(),
    );
  }
}

// -------------------------------------------------------------
// البيانات التعليمية (الحروف، الحركات، الكلمات والرموز التعبيرية)
// -------------------------------------------------------------
class LessonItem {
  final String pic;
  final String word;
  final String? display;

  const LessonItem({required this.pic, required this.word, this.display});
}

const List<String> lettersList = [
  'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص',
  'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'هـ', 'و', 'ي'
];

const List<String> vowelsMarks = ['َ', 'ِ', 'ُ'];
const List<String> vowelsNames = ['فتحة', 'كسرة', 'ضمة'];

const List<Color> tileColors = [
  Color(0xFFFF685C),
  Color(0xFF188FEB),
  Color(0xFF9D42D9),
  Color(0xFF25B55C),
  Color(0xFFFF9B1B),
];

const Map<String, List<LessonItem>> lessonData = {
  'أ': [
    LessonItem(pic: '🦁', word: 'أَسَد', display: 'أَ'),
    LessonItem(pic: '🪡', word: 'إِبْرَة', display: 'إِ'),
    LessonItem(pic: '👂', word: 'أُذُن', display: 'أُ'),
  ],
  'ب': [
    LessonItem(pic: '🦆', word: 'بَطَّة', display: 'بَ'),
    LessonItem(pic: '👧', word: 'بِنْت', display: 'بِ'),
    LessonItem(pic: '🦉', word: 'بُومَة', display: 'بُ'),
  ],
  'ت': [
    LessonItem(pic: '🍎', word: 'تَفَّاحَة', display: 'تَ'),
    LessonItem(pic: '🐊', word: 'تِمْسَاح', display: 'تِ'),
    LessonItem(pic: '🫐', word: 'تُوت', display: 'تُ'),
  ],
  'ث': [
    LessonItem(pic: '🦊', word: 'ثَعْلَب', display: 'ثَ'),
    LessonItem(pic: '👕', word: 'ثِيَاب', display: 'ثِ'),
    LessonItem(pic: '🧄', word: 'ثُوم', display: 'ثُ'),
  ],
  'ج': [
    LessonItem(pic: '🐪', word: 'جَمَل', display: 'جَ'),
    LessonItem(pic: '🔔', word: 'جَرَس', display: 'جِ'),
    LessonItem(pic: '🥕', word: 'جُزَر', display: 'جُ'),
  ],
  'ح': [
    LessonItem(pic: '🐎', word: 'حَصَان', display: 'حَ'),
    LessonItem(pic: '🖋️', word: 'حِبْر', display: 'حِ'),
    LessonItem(pic: '🐋', word: 'حُوت', display: 'حُ'),
  ],
  'خ': [
    LessonItem(pic: '🐑', word: 'خَرُوف', display: 'خَ'),
    LessonItem(pic: '🏕️', word: 'خَيْمَة', display: 'خِ'),
    LessonItem(pic: '🍑', word: 'خَوْخ', display: 'خُ'),
  ],
  'د': [
    LessonItem(pic: '🐔', word: 'دَجَاجَة', display: 'دَ'),
    LessonItem(pic: '🐓', word: 'دِيك', display: 'دِ'),
    LessonItem(pic: '🧸', word: 'دُمْيَة', display: 'دُ'),
  ],
  'ذ': [
    LessonItem(pic: '🪙', word: 'ذَهَب', display: 'ذَ'),
    LessonItem(pic: '🐺', word: 'ذِئْب', display: 'ذِ'),
    LessonItem(pic: '🪰', word: 'ذُبَابَة', display: 'ذُ'),
  ],
  'ر': [
    LessonItem(pic: '🎨', word: 'رَسْم', display: 'رَ'),
    LessonItem(pic: '🪶', word: 'رِيشَة', display: 'رِ'),
    LessonItem(pic: '🍎', word: 'رُمَّان', display: 'رُ'),
  ],
  'ز': [
    LessonItem(pic: '🌹', word: 'زَهْرَة', display: 'زَ'),
    LessonItem(pic: '🎀', word: 'زِينَة', display: 'زِ'),
    LessonItem(pic: '🦒', word: 'زُرَافَة', display: 'زُ'),
  ],
  'س': [
    LessonItem(pic: '🐟', word: 'سَمَكَة', display: 'سَ'),
    LessonItem(pic: '🧿', word: 'سِوَار', display: 'سِ'),
    LessonItem(pic: '🐢', word: 'سُلَحْفَاة', display: 'سُ'),
  ],
  'ش': [
    LessonItem(pic: '☀️', word: 'شَمْس', display: 'شَ'),
    LessonItem(pic: '⛵', word: 'شِرَاع', display: 'شِ'),
    LessonItem(pic: '🔥', word: 'شُعْلَة', display: 'شُ'),
  ],
  'ص': [
    LessonItem(pic: '🦅', word: 'صَقْر', display: 'صَ'),
    LessonItem(pic: '🍽️', word: 'صِينِيَّة', display: 'صِ'),
    LessonItem(pic: '📦', word: 'صُنْدُوق', display: 'صُ'),
  ],
  'ض': [
    LessonItem(pic: '🐸', word: 'ضَفْدَع', display: 'ضَ'),
    LessonItem(pic: '🦷', word: 'ضِرْس', display: 'ضِ'),
    LessonItem(pic: '💇‍♀️', word: 'ضُفِيرَة', display: 'ضُ'),
  ],
  'ط': [
    LessonItem(pic: '✈️', word: 'طَائِرَة', display: 'طَ'),
    LessonItem(pic: '🧱', word: 'طِين', display: 'طِ'),
    LessonItem(pic: '🥁', word: 'طَبْل', display: 'طُ'),
  ],
  'ظ': [
    LessonItem(pic: '✉️', word: 'ظَرْف', display: 'ظَ'),
    LessonItem(pic: '🌳', word: 'ظِلّ', display: 'ظِ'),
    LessonItem(pic: '💅', word: 'ظُفْر', display: 'ظُ'),
  ],
  'ع': [
    LessonItem(pic: '🍯', word: 'عَسَل', display: 'عَ'),
    LessonItem(pic: '🧕', word: 'عِمَامَة', display: 'عِ'),
    LessonItem(pic: '🐦', word: 'عُصْفُور', display: 'عُ'),
  ],
  'غ': [
    LessonItem(pic: '🦌', word: 'غَزَال', display: 'غَ'),
    LessonItem(pic: '🍲', word: 'غِذَاء', display: 'غِ'),
    LessonItem(pic: '🐦‍⬛', word: 'غُرَاب', display: 'غُ'),
  ],
  'ف': [
    LessonItem(pic: '🦋', word: 'فَرَاشَة', display: 'فَ'),
    LessonItem(pic: '👗', word: 'فُسْتَان', display: 'فِ'),
    LessonItem(pic: '🫘', word: 'فُول', display: 'فُ'),
  ],
  'ق': [
    LessonItem(pic: '🌙', word: 'قَمَر', display: 'قَ'),
    LessonItem(pic: '🐈', word: 'قِطَّة', display: 'قِ'),
    LessonItem(pic: '🧢', word: 'قُبَّعَة', display: 'قُ'),
  ],
  'ك': [
    LessonItem(pic: '🐕', word: 'كَلْب', display: 'كَ'),
    LessonItem(pic: '👜', word: 'كِيس', display: 'كِ'),
    LessonItem(pic: '📚', word: 'كُتُب', display: 'كُ'),
  ],
  'ل': [
    LessonItem(pic: '🥛', word: 'لَبَن', display: 'لَ'),
    LessonItem(pic: '👅', word: 'لِسَان', display: 'لِ'),
    LessonItem(pic: '🧸', word: 'لُعْبَة', display: 'لُ'),
  ],
  'م': [
    LessonItem(pic: '🍌', word: 'مَوْز', display: 'مَ'),
    LessonItem(pic: '🔑', word: 'مِفْتَاح', display: 'مِ'),
    LessonItem(pic: '🐎', word: 'مُهْر', display: 'مُ'),
  ],
  'ن': [
    LessonItem(pic: '🐝', word: 'نَحْلَة', display: 'نَ'),
    LessonItem(pic: '🦩', word: 'نِعَامَة', display: 'نِ'),
    LessonItem(pic: '⭐', word: 'نُجُوم', display: 'نُ'),
  ],
  'هـ': [
    LessonItem(pic: '🎁', word: 'هَدِيَّة', display: 'هَـ'),
    LessonItem(pic: '🌙', word: 'هِلال', display: 'هِـ'),
    LessonItem(pic: '🐦', word: 'هُدْهُد', display: 'هُـ'),
  ],
  'و': [
    LessonItem(pic: '🌹', word: 'وَرْدَة', display: 'وَ'),
    LessonItem(pic: '🧣', word: 'وِشَاح', display: 'وِ'),
    LessonItem(pic: '🌺', word: 'وُرُود', display: 'وُ'),
  ],
  'ي': [
    LessonItem(pic: '✋', word: 'يَد', display: 'يَ'),
    LessonItem(pic: '🗣️', word: 'يِ: صوت قصير', display: 'يِ'),
    LessonItem(pic: '🧥', word: 'يُوسُف', display: 'يُ'),
  ],
};

LessonItem getLessonItem(int letterIdx, int vowelIdx) {
  final letter = lettersList[letterIdx];
  final items = lessonData[letter];
  if (items != null && vowelIdx < items.length) {
    return items[vowelIdx];
  }
  return LessonItem(
    pic: '⭐',
    word: letter,
    display: letter + vowelsMarks[vowelIdx],
  );
}

// -------------------------------------------------------------
// الشاشة الرئيسية والمتحكم العام
// -------------------------------------------------------------
class MainFarmScreen extends StatefulWidget {
  const MainFarmScreen({super.key});

  @override
  State<MainFarmScreen> createState() => _MainFarmScreenState();
}

class _MainFarmScreenState extends State<MainFarmScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  late SharedPreferences _prefs;

  // الحالات العامة للتطبيق
  int _stars = 0;
  Set<int> _knownLetters = {};
  String _childName = 'يا بطل';
  String _gender = 'm'; // m: بطل, f: بطلة
  String _currentView = 'home'; // home, learn, quiz, rewards, progress
  String _homeMessage = '🐥 أهلاً بك في مزرعتنا الجميلة!';

  // حالة شاشة التعلم
  int _currentLetterIdx = 1; // حرف الباء افتراضياً
  int _currentVowelIdx = 0;

  // حالة شاشة اللعبة (Quiz)
  int _quizLetterIdx = 0;
  int _quizVowelIdx = 0;
  int _quizScore = 0;
  bool _quizAnswered = false;
  List<Map<String, dynamic>> _quizOptions = [];
  String _quizMessage = '🐥 استمع جيداً واختر الحرف الصحيح!';

  // الاحتفال بالقصاصات
  bool _showConfetti = false;
  late AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _initTts();
    _loadState();

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void dispose() {
    _tts.stop();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('ar');
    await _tts.setSpeechRate(0.45); // سرعة نطق مناسبة لتعليم الأطفال
    await _tts.setPitch(1.15); // طبقة صوتية محببة وودودة
  }

  Future<void> _loadState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _stars = _prefs.getInt('stars') ?? 0;
      _childName = _prefs.getString('name') ?? 'يا بطل';
      _gender = _prefs.getString('gender') ?? 'm';
      final savedKnown = _prefs.getStringList('known') ?? [];
      _knownLetters = savedKnown.map((e) => int.tryParse(e) ?? 0).toSet();
    });
  }

  Future<void> _saveState() async {
    await _prefs.setInt('stars', _stars);
    await _prefs.setString('name', _childName);
    await _prefs.setString('gender', _gender);
    await _prefs.setStringList(
      'known',
      _knownLetters.map((e) => e.toString()).toList(),
    );
  }

  String _praise() {
    return _gender == 'f' ? 'أحسنتِ يا بطلة' : 'أحسنت يا بطل';
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  void _triggerCelebration([String? msg]) {
    if (msg != null) {
      setState(() => _homeMessage = msg);
    }
    setState(() => _showConfetti = true);
    _confettiController.forward(from: 0.0).then((_) {
      if (mounted) setState(() => _showConfetti = false);
    });
  }

  // -------------------------
  // منطق التعلم
  // -------------------------
  void _selectLetter(int idx) {
    setState(() {
      _currentLetterIdx = idx;
      _currentVowelIdx = 0;
      if (!_knownLetters.contains(idx)) {
        _knownLetters.add(idx);
        _stars += 2;
        _saveState();
        _homeMessage = '🌟 رائع! حصلت على نجمتين لتعلم حرف جديد';
      }
    });
    _speakLetter();
  }

  void _selectVowel(int vIdx) {
    setState(() => _currentVowelIdx = vIdx);
    _speakLetter();
  }

  void _nextLetter() {
    _selectLetter((_currentLetterIdx + 1) % lettersList.length);
  }

  void _speakLetter() {
    final item = getLessonItem(_currentLetterIdx, _currentVowelIdx);
    final display = item.display ?? (lettersList[_currentLetterIdx] + vowelsMarks[_currentVowelIdx]);
    _speak(display);
  }

  void _speakWord() {
    final item = getLessonItem(_currentLetterIdx, _currentVowelIdx);
    _speak(item.word);
  }

  // -------------------------
  // منطق الاختبار والمسابقة
  // -------------------------
  void _startQuiz() {
    setState(() {
      _currentView = 'quiz';
      _generateQuizQuestion();
    });
  }

  void _generateQuizQuestion() {
    final rand = Random();
    _quizAnswered = false;
    _quizLetterIdx = rand.nextInt(lettersList.length);
    _quizVowelIdx = rand.nextInt(3);

    final correctDisplay = getLessonItem(_quizLetterIdx, _quizVowelIdx).display ??
        (lettersList[_quizLetterIdx] + vowelsMarks[_quizVowelIdx]);

    final List<Map<String, dynamic>> options = [
      {'letterIdx': _quizLetterIdx, 'vowelIdx': _quizVowelIdx, 'display': correctDisplay, 'correct': true}
    ];

    while (options.length < 3) {
      final ni = rand.nextInt(lettersList.length);
      final nv = rand.nextInt(3);
      final disp = getLessonItem(ni, nv).display ?? (lettersList[ni] + vowelsMarks[nv]);
      if (!options.any((o) => o['letterIdx'] == ni && o['vowelIdx'] == nv)) {
        options.add({'letterIdx': ni, 'vowelIdx': nv, 'display': disp, 'correct': false});
      }
    }

    options.shuffle();

    setState(() {
      _quizOptions = options;
      _quizMessage = '🐥 استمع للحرف أو اضغط على الصورة!';
    });
    _speakQuizQuestion();
  }

  void _speakQuizQuestion() {
    final item = getLessonItem(_quizLetterIdx, _quizVowelIdx);
    final display = item.display ?? (lettersList[_quizLetterIdx] + vowelsMarks[_quizVowelIdx]);
    _speak('$display ، ${item.word}');
  }

  void _answerQuiz(bool isCorrect) {
    if (_quizAnswered) return;

    if (isCorrect) {
      setState(() {
        _quizAnswered = true;
        _stars += 3;
        _quizScore += 1;
        _quizMessage = '🎉 ${_praise()}! حصلت على 3 نجوم ⭐';
      });
      _saveState();
      _triggerCelebration();
      _speak('${_praise()}! ممتاز');
    } else {
      setState(() {
        _quizMessage = '💛 حاول مرة أخرى، أنت تستطيع!';
      });
      _speak('حاول مرة أخرى');
    }
  }

  // -------------------------
  // تغيير الاسم والجنس
  // -------------------------
  void _showNameDialog() {
    final controller = TextEditingController(text: _childName == 'يا بطل' ? '' : _childName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFFFFDF0),
        title: const Text('✏️ ما اسم بطلنا الصغير؟', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'اكتب الاسم هنا',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF20BA45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _childName = controller.text.trim();
                });
                _saveState();
                _triggerCelebration('مرحباً بطلنا $_childName! 🌻');
              }
              Navigator.pop(ctx);
            },
            child: const Text('حفظ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFFFFDF0),
        title: const Text('🧒 اختر صيغة التشجيع', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF168EEA),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                setState(() => _gender = 'm');
                _saveState();
                Navigator.pop(ctx);
                _triggerCelebration('أهلاً بالبطل الشجاع! 👦');
              },
              child: const Text('👦 بطل (مذكر)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF24A9B),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                setState(() => _gender = 'f');
                _saveState();
                Navigator.pop(ctx);
                _triggerCelebration('أهلاً بالبطلة الذكية! 👧');
              },
              child: const Text('👧 بطلة (مؤنث)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية المزرعة الزاهية مع التدرج وتفاصيل الطبيعة
          const FarmBackground(),

          // المحتوى التفاعلي الرئيسي
          SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  // الشريط العلوي (اسم الطفل + رصيد النجوم)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _PillBadge(
                          icon: _gender == 'f' ? '👧' : '👦',
                          label: _childName,
                        ),
                        _PillBadge(
                          icon: '⭐',
                          label: '$_stars',
                          iconColor: const Color(0xFFFFB300),
                        ),
                      ],
                    ),
                  ),

                  // عرض الشاشة الحالية
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildCurrentScreen(),
                    ),
                  ),

                  // حقوق وتذييل التطبيق
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'صنع بحب ❤ | حروفي المرحة V4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // تأثير الاحتفال المتطاير (Confetti Animation)
          if (_showConfetti)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ConfettiPainter(progress: _confettiController.value),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentView) {
      case 'learn':
        return _buildLearnScreen();
      case 'quiz':
        return _buildQuizScreen();
      case 'rewards':
        return _buildRewardsScreen();
      case 'progress':
        return _buildProgressScreen();
      default:
        return _buildHomeScreen();
    }
  }

  // -------------------------------------------------------------
  // 1. شاشة المزرعة الرئيسية
  // -------------------------------------------------------------
  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      key: const ValueKey('home'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // عنوان الترحيب
          const SizedBox(height: 10),
          const Text(
            '🌈 حروفي المرحة 🌈',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(color: Color(0xFFE26334), offset: Offset(3, 4)),
                Shadow(color: Color(0xFF185D2A), blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9DD),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 3))],
            ),
            child: const Text(
              'في مزرعة الحروف السعيدة 🐮🌻',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF286538)),
            ),
          ),
          const SizedBox(height: 20),

          // الصندوق الرئيسي للأزرار
          _FarmCard(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                  children: [
                    _MenuBlockButton(
                      emoji: '📚',
                      title: 'تعلم الحروف',
                      color: const Color(0xFFFF7E2B),
                      onTap: () => setState(() => _currentView = 'learn'),
                    ),
                    _MenuBlockButton(
                      emoji: '🎮',
                      title: 'العب وتعلم',
                      color: const Color(0xFF20BA45),
                      onTap: _startQuiz,
                    ),
                    _MenuBlockButton(
                      emoji: '🏆',
                      title: 'بطاقات أبطالي',
                      color: const Color(0xFFB94BEC),
                      onTap: () => setState(() => _currentView = 'rewards'),
                    ),
                    _MenuBlockButton(
                      emoji: '📈',
                      title: 'تقدمي',
                      color: const Color(0xFF168EEA),
                      onTap: () => setState(() => _currentView = 'progress'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _TactileActionButton(
                  icon: '✏️',
                  label: 'اكتب اسم الطفل',
                  color: const Color(0xFF14A4F1),
                  onTap: _showNameDialog,
                ),
                const SizedBox(height: 10),
                _TactileActionButton(
                  icon: '🧒',
                  label: 'اختر صيغة التشجيع (بطل / بطلة)',
                  color: const Color(0xFFA044D8),
                  onTap: _showGenderDialog,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _homeMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Color(0xFF185D2A), blurRadius: 6)],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // 2. شاشة تعلم الحروف
  // -------------------------------------------------------------
  Widget _buildLearnScreen() {
    final item = getLessonItem(_currentLetterIdx, _currentVowelIdx);
    final letterColor = tileColors[(_currentLetterIdx + _currentVowelIdx) % tileColors.length];
    final displayLetter = item.display ?? (lettersList[_currentLetterIdx] + vowelsMarks[_currentVowelIdx]);

    return SingleChildScrollView(
      key: const ValueKey('learn'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: _FarmCard(
        child: Column(
          children: [
            // ترويسة الشاشة مع زر الرجوع والتالي
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundNavButton(
                  icon: Icons.home_rounded,
                  onTap: () => setState(() => _currentView = 'home'),
                ),
                const Text(
                  '📚 هيا نتعلم الحروف',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
                ),
                _RoundNavButton(
                  icon: Icons.arrow_forward_rounded,
                  onTap: _nextLetter,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // الحرف بحجم كبير
            Text(
              displayLetter,
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w900,
                color: letterColor,
                shadows: const [
                  Shadow(color: Colors.black26, offset: Offset(3, 5), blurRadius: 4),
                ],
              ),
            ),

            // الصورة الدلالية
            GestureDetector(
              onTap: _speakWord,
              child: AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 150),
                child: Text(
                  item.pic,
                  style: const TextStyle(fontSize: 85),
                ),
              ),
            ),

            // الكلمة المشكولة
            TextButton(
              onPressed: _speakWord,
              child: Text(
                item.word,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF23432E)),
              ),
            ),
            const Text(
              '👆 اضغط على الصورة أو الكلمة لتسمع نطقها',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 12),

            // زر الاستماع للحرف
            _TactileActionButton(
              icon: '🔊',
              label: 'استمع إلى صوت الحرف',
              color: const Color(0xFF14A4F1),
              onTap: _speakLetter,
            ),
            const SizedBox(height: 16),

            // أزرار الحركات الثلاث (فتحة، كسرة، ضمة)
            Row(
              children: List.generate(3, (vIdx) {
                final isSelected = _currentVowelIdx == vIdx;
                final vLetter = lettersList[_currentLetterIdx] + vowelsMarks[vIdx];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () => _selectVowel(vIdx),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9C5FF),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFFFC930) : Colors.white,
                            width: isSelected ? 4 : 2,
                          ),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, offset: Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              vLetter,
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4A154B)),
                            ),
                            Text(
                              vowelsNames[vIdx],
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF6B236E)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '🌼 اختر حرفاً من المزرعة:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
              ),
            ),
            const SizedBox(height: 10),

            // شبكة الحروف الـ 28
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1.0,
              ),
              itemCount: lettersList.length,
              itemBuilder: (context, i) {
                final isCurrent = i == _currentLetterIdx;
                final btnColor = tileColors[i % tileColors.length];
                return InkWell(
                  onTap: () => _selectLetter(i),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrent ? const Color(0xFFFFDA32) : Colors.white,
                        width: isCurrent ? 3.5 : 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, offset: Offset(0, 3)),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lettersList[i],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 3. شاشة لعبة الحركات (Quiz)
  // -------------------------------------------------------------
  Widget _buildQuizScreen() {
    final item = getLessonItem(_quizLetterIdx, _quizVowelIdx);

    return SingleChildScrollView(
      key: const ValueKey('quiz'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: _FarmCard(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundNavButton(
                  icon: Icons.home_rounded,
                  onTap: () => setState(() => _currentView = 'home'),
                ),
                const Text(
                  '🎮 لعبة الحركات',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
                ),
                _PillBadge(icon: '⭐', label: '$_quizScore', iconColor: const Color(0xFFFFB300)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'استمع جيداً ثم اختر الحرف الصحيح!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // صورة وكلمة السؤال
            GestureDetector(
              onTap: _speakQuizQuestion,
              child: Text(item.pic, style: const TextStyle(fontSize: 85)),
            ),
            Text(
              item.word,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF23432E)),
            ),
            const SizedBox(height: 12),

            _TactileActionButton(
              icon: '🔊',
              label: 'اسمع السؤال',
              color: const Color(0xFF14A4F1),
              onTap: _speakQuizQuestion,
            ),
            const SizedBox(height: 20),

            // خيارات الإجابة
            Row(
              children: _quizOptions.map((opt) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: InkWell(
                      onTap: () => _answerQuiz(opt['correct'] as bool),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7E0FF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Color(0xFFB9A6C8), offset: Offset(0, 5)),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          opt['display'].toString(),
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF7733BA),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            Text(
              _quizMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF098C3D)),
            ),
            const SizedBox(height: 16),

            _TactileActionButton(
              icon: '🔄',
              label: 'سؤال جديد',
              color: const Color(0xFF28B94C),
              onTap: _generateQuizQuestion,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 4. شاشة بطاقات التحفيز (Rewards)
  // -------------------------------------------------------------
  Widget _buildRewardsScreen() {
    final List<Map<String, dynamic>> badges = [
      {'icon': '🌟', 'title': 'نجم الحروف', 'req': 3},
      {'icon': '🐥', 'title': 'بطل المزرعة', 'req': 10},
      {'icon': '🦁', 'title': 'شجاع الحروف', 'req': 20},
      {'icon': '🏆', 'title': 'المبدع الصغير', 'req': 40},
      {'icon': '🚀', 'title': 'عبقري اليوم', 'req': 70},
      {'icon': '👑', 'title': 'ملك الحروف', 'req': 100},
    ];

    return SingleChildScrollView(
      key: const ValueKey('rewards'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: _FarmCard(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundNavButton(
                  icon: Icons.home_rounded,
                  onTap: () => setState(() => _currentView = 'home'),
                ),
                const Text(
                  '🏆 بطاقات أبطالي',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'اجمع النجوم وافتح بطاقات جديدة!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: badges.length,
              itemBuilder: (context, idx) {
                final badge = badges[idx];
                final isUnlocked = _stars >= (badge['req'] as int);

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isUnlocked
                          ? [const Color(0xFFFFF2A0), Colors.white]
                          : [Colors.grey.shade300, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isUnlocked ? const Color(0xFFFFCE45) : Colors.grey.shade400,
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isUnlocked ? badge['icon'].toString() : '🔒',
                        style: const TextStyle(fontSize: 44),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        badge['title'].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? Colors.brown.shade800 : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isUnlocked ? '🎊 تم فتح البطاقة' : '⭐ تحتاج ${badge['req']} نجمة',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? Colors.green.shade700 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 5. شاشة تقدمي (Progress)
  // -------------------------------------------------------------
  Widget _buildProgressScreen() {
    final masteredCount = _knownLetters.length;
    final progressPercent = masteredCount / lettersList.length;

    return SingleChildScrollView(
      key: const ValueKey('progress'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: _FarmCard(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundNavButton(
                  icon: Icons.home_rounded,
                  onTap: () => setState(() => _currentView = 'home'),
                ),
                const Text(
                  '📈 تقدّمي الرائع',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'تعلمت $masteredCount من أصل 28 حرفاً 🎉',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF23432E)),
            ),
            const SizedBox(height: 12),

            // شريط التقدم الملون
            Container(
              height: 24,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDBE7E1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: progressPercent.clamp(0.02, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFC800), Color(0xFF39C961)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Text(
              '⭐ مجموع النجوم التي جمعتها: $_stars',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFA4541D)),
            ),
            const SizedBox(height: 16),

            // شبكة إتقان الحروف
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1.0,
              ),
              itemCount: lettersList.length,
              itemBuilder: (context, i) {
                final isLearned = _knownLetters.contains(i);
                final color = isLearned ? tileColors[i % tileColors.length] : const Color(0xFFADBCB0);
                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, offset: Offset(0, 3)),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lettersList[i],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isLearned ? Colors.white : Colors.white70,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            _TactileActionButton(
              icon: '📚',
              label: 'أكمل التعلّم الآن',
              color: const Color(0xFF14A4F1),
              onTap: () => setState(() => _currentView = 'learn'),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// عناصر الـ UI المخصصة (Widgets) للأطفال بتصميم مبهج
// -------------------------------------------------------------

class _FarmCard extends StatelessWidget {
  final Widget child;
  const _FarmCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF0).withOpacity(0.96),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [
          BoxShadow(color: Color(0x603B8C3D), offset: Offset(0, 8), blurRadius: 0),
          BoxShadow(color: Color(0x35185D2A), offset: Offset(0, 14), blurRadius: 20),
        ],
      ),
      child: child,
    );
  }
}

class _PillBadge extends StatelessWidget {
  final String icon;
  final String label;
  final Color? iconColor;

  const _PillBadge({required this.icon, required this.label, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFF2),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(color: Color(0xFFA4CE82), offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF23432E)),
          ),
        ],
      ),
    );
  }
}

class _RoundNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF89D8FF), width: 3),
          boxShadow: const [
            BoxShadow(color: Color(0xFF278CC0), offset: Offset(0, 4)),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF168EEA), size: 26),
      ),
    );
  }
}

class _MenuBlockButton extends StatelessWidget {
  final String emoji;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _MenuBlockButton({
    required this.emoji,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Color(0x35000000), offset: Offset(0, 6)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black26, offset: Offset(0, 2))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TactileActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _TactileActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: const [
            BoxShadow(color: Color(0x40000000), offset: Offset(0, 5)),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black26, offset: Offset(0, 1))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// خلفية المزرعة الرسومية الكرتونية
// -------------------------------------------------------------
class FarmBackground extends StatelessWidget {
  const FarmBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // تدرج السماء والأرض الخضراء
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.40, 0.41, 1.0],
              colors: [
                Color(0xFF67CFFF), // سماء زرقاء مشمسة
                Color(0xFFB9EDFF),
                Color(0xFF8EE36C), // بداية التلال الخضراء
                Color(0xFF46B84B),
              ],
            ),
          ),
        ),
        // الشمس الساطعة
        const Positioned(
          top: 38,
          left: 24,
          child: Text('☀️', style: TextStyle(fontSize: 55)),
        ),
        // الغيوم
        const Positioned(
          top: 70,
          right: 20,
          child: Opacity(opacity: 0.85, child: Text('☁️', style: TextStyle(fontSize: 50))),
        ),
        const Positioned(
          top: 140,
          left: 15,
          child: Opacity(opacity: 0.8, child: Text('☁️', style: TextStyle(fontSize: 40))),
        ),
        // التل الأخضر والحيوانات في الأسفل
        Positioned(
          bottom: 12,
          right: 12,
          child: const Text('🌳🌻🌼', style: TextStyle(fontSize: 32)),
        ),
        Positioned(
          bottom: 14,
          left: 12,
          child: const Text('🏡🐄🐥', style: TextStyle(fontSize: 32)),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// رسام تأثير الاحتفال (Confetti Painter)
// -------------------------------------------------------------
class ConfettiPainter extends CustomPainter {
  final double progress;
  static final Random _rnd = Random(42);

  ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Colors.amber,
      Colors.pinkAccent,
      Colors.lightBlue,
      Colors.lightGreenAccent,
      Colors.purpleAccent
    ];

    for (int i = 0; i < 35; i++) {
      final double startX = (_rnd.nextDouble() * size.width);
      final double fallSpeed = 0.6 + (_rnd.nextDouble() * 0.7);
      final double currentY = (progress * size.height * fallSpeed);

      final paint = Paint()
        ..color = colors[i % colors.length].withOpacity((1.0 - (progress * 0.7)).clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(startX, currentY);
      canvas.rotate(progress * pi * 4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(-6, -6, 12, 12), const Radius.circular(3)),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
