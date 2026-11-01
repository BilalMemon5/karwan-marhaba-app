import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'strings.dart';

const navy = Color(0xFF06090F);
const navy2 = Color(0xFF0C1220);
const gold = Color(0xFFD4AF37);
const ink = Color(0xFFF0F4FA);
const line = Color(0x40D4AF37);
const red = Color(0xFFB3261E);
const agencyPhone = '+923153470898';
const agencyEmail = 'karwanemarhabasukkur@gmail.com';
const waUrl = 'https://wa.me/923153470898';

class AppState extends ChangeNotifier {
  late SharedPreferences p;
  int lang = 2;
  Map<String, String> data = {};
  Set<String> done = {};
  Map<String, List<String>> docs = {};

  Future<void> load() async {
    p = await SharedPreferences.getInstance();
    lang = p.getInt('lang') ?? 2;
    data = Map<String, String>.from(jsonDecode(p.getString('data') ?? '{}') as Map);
    done = (p.getStringList('done') ?? <String>[]).toSet();
    final d = jsonDecode(p.getString('docs') ?? '{}') as Map;
    docs = d.map((k, v) => MapEntry(k as String, List<String>.from(v as List)));
  }

  void setLang(int l) {
    lang = l;
    p.setInt('lang', l);
    notifyListeners();
  }

  void save(String k, String v) {
    data[k] = v;
    p.setString('data', jsonEncode(data));
  }

  void put(String k, String v) {
    save(k, v);
    notifyListeners();
  }

  void toggle(String id) {
    if (done.contains(id)) {
      done.remove(id);
    } else {
      done.add(id);
    }
    p.setStringList('done', done.toList());
    notifyListeners();
  }

  void _saveDocs() {
    p.setString('docs', jsonEncode(docs));
    notifyListeners();
  }

  void addDoc(String type, String path) {
    (docs[type] ??= <String>[]).add(path);
    _saveDocs();
  }

  void delDoc(String type, String path) {
    docs[type]?.remove(path);
    try {
      File(path).deleteSync();
    } catch (_) {}
    _saveDocs();
  }

  Future<void> wipe() async {
    for (final l in docs.values) {
      for (final f in l) {
        try {
          File(f).deleteSync();
        } catch (_) {}
      }
    }
    await p.clear();
    data = {};
    done = {};
    docs = {};
    lang = 2;
    notifyListeners();
  }
}

final app = AppState();
String t(String k) => tr(app.lang, k);
Widget live(Widget Function() b) => ListenableBuilder(listenable: app, builder: (_, __) => b());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app.load();
  runApp(const KmApp());
}

class KmApp extends StatelessWidget {
  const KmApp({super.key});
  @override
  Widget build(BuildContext context) => live(() => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Karwan-e-Marhaba',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: navy,
          colorScheme: const ColorScheme.dark(primary: gold, onPrimary: navy, surface: navy2),
        ),
        builder: (c, child) => Directionality(
          textDirection: app.lang == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        ),
        home: const Root(),
      ));
}

class Root extends StatelessWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context) => live(() => app.data['setup'] == '1' ? const Shell() : const Setup());
}

// ---------- shared widgets ----------
const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: gold);
const bodyStyle = TextStyle(fontSize: 18, height: 1.5);
const softStyle = TextStyle(fontSize: 16, color: Colors.white70, height: 1.4);

Widget h(String s) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(s, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: gold)),
    );

Widget card({required Widget child, VoidCallback? onTap}) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: navy2,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
            child: child,
          ),
        ),
      ),
    );

Widget gbtn(String label, IconData ic, VoidCallback f, {Color bg = gold, Color fg = navy}) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FilledButton.icon(
        onPressed: f,
        icon: Icon(ic),
        label: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );

Widget tile(IconData ic, String label, VoidCallback f, {bool urgent = false}) {
  final c = urgent ? const Color(0xFFE5484D) : gold;
  return Material(
    color: navy2,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: f,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: urgent ? c : line)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(ic, size: 40, color: c),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ]),
      ),
    ),
  );
}

void push(BuildContext c, Widget w) => Navigator.of(c).push(MaterialPageRoute(builder: (_) => w));

Future<void> openUrl(BuildContext c, String u) async {
  var ok = false;
  try {
    ok = await launchUrl(Uri.parse(u), mode: LaunchMode.externalApplication);
  } catch (_) {}
  if (!ok && c.mounted) {
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(t('cantOpen'))));
  }
}

Future<bool> ask(BuildContext c, String title, {String body = ''}) async {
  final r = await showDialog<bool>(
    context: c,
    builder: (d) => AlertDialog(
      title: Text(title),
      content: body.isEmpty ? null : Text(body, style: const TextStyle(fontSize: 20)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: Text(t('no'), style: const TextStyle(fontSize: 18))),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: Text(t('yes'), style: const TextStyle(fontSize: 18))),
      ],
    ),
  );
  return r == true;
}

Future<void> confirmCall(BuildContext c, String label, String num) async {
  if (await ask(c, t('confirmCall'), body: '$label\n$num') && c.mounted) {
    openUrl(c, 'tel:${num.replaceAll(' ', '')}');
  }
}

class NoteField extends StatefulWidget {
  final String k, title, hint;
  final bool single, phone;
  const NoteField({super.key, required this.k, required this.title, this.hint = '', this.single = false, this.phone = false});
  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  late final TextEditingController c = TextEditingController(text: app.data[widget.k] ?? '');
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.title, style: titleStyle),
        const SizedBox(height: 8),
        TextField(
          controller: c,
          minLines: widget.single ? 1 : 2,
          maxLines: widget.single ? 1 : 6,
          keyboardType: widget.phone ? TextInputType.phone : (widget.single ? TextInputType.text : TextInputType.multiline),
          style: const TextStyle(fontSize: 18),
          onChanged: (v) => app.save(widget.k, v),
          decoration: InputDecoration(hintText: widget.hint, border: const OutlineInputBorder()),
        ),
      ]);
}

Widget langChips() => Wrap(spacing: 8, runSpacing: 8, children: [
      for (var i = 0; i < 3; i++)
        ChoiceChip(
          label: Text(langNames[i], style: const TextStyle(fontSize: 18)),
          selected: app.lang == i,
          selectedColor: gold,
          labelStyle: TextStyle(color: app.lang == i ? navy : ink),
          onSelected: (_) => app.setLang(i),
        ),
    ]);

// ---------- first-run setup ----------
class Setup extends StatefulWidget {
  const Setup({super.key});
  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final c = TextEditingController();
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => live(() => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
            const SizedBox(height: 24),
            const Center(child: Icon(Icons.mosque, size: 76, color: gold)),
            const SizedBox(height: 12),
            const Center(child: Text('KARWAN-E-MARHABA', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: gold, letterSpacing: 1.5))),
            Center(child: Text(t('app'), style: const TextStyle(fontSize: 20))),
            const SizedBox(height: 32),
            Text(t('lang'), style: titleStyle),
            const SizedBox(height: 8),
            langChips(),
            const SizedBox(height: 24),
            TextField(
              controller: c,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(labelText: t('yourName'), border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            gbtn(t('start'), Icons.arrow_forward, () {
              app.put('name', c.text.trim());
              app.put('setup', '1');
            }),
          ]),
        ),
      ));
}

// ---------- main shell with 5 tabs ----------
class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext context) => live(() {
        final tabs = <Widget>[
          HomeTab(go: (n) => setState(() => i = n)),
          const JourneyTab(),
          const DocsTab(),
          const SupportTab(),
          const ProfileTab(),
        ];
        return Scaffold(
          body: SafeArea(child: tabs[i]),
          bottomNavigationBar: NavigationBar(
            selectedIndex: i,
            onDestinationSelected: (n) => setState(() => i = n),
            backgroundColor: navy2,
            indicatorColor: gold,
            destinations: [
              NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home, color: navy), label: t('n_home')),
              NavigationDestination(icon: const Icon(Icons.flight_takeoff), selectedIcon: const Icon(Icons.flight_takeoff, color: navy), label: t('n_trip')),
              NavigationDestination(icon: const Icon(Icons.folder_outlined), selectedIcon: const Icon(Icons.folder, color: navy), label: t('n_docs')),
              NavigationDestination(icon: const Icon(Icons.support_agent), selectedIcon: const Icon(Icons.support_agent, color: navy), label: t('n_help')),
              NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person, color: navy), label: t('n_me')),
            ],
          ),
        );
      });
}

// ---------- Home ----------
Future<void> pickDate(BuildContext c) async {
  final n = DateTime.now();
  final d = await showDatePicker(context: c, initialDate: n, firstDate: DateTime(n.year - 1), lastDate: DateTime(n.year + 3));
  if (d != null) app.put('dep', d.toIso8601String());
}

class HomeTab extends StatelessWidget {
  final void Function(int) go;
  const HomeTab({super.key, required this.go});
  @override
  Widget build(BuildContext context) => live(() {
        final nm = app.data['name'] ?? '';
        final name = nm.isEmpty ? t('pilgrim') : nm;
        final dep = DateTime.tryParse(app.data['dep'] ?? '');
        final now = DateTime.now();
        final left = dep == null ? null : DateTime(dep.year, dep.month, dep.day).difference(DateTime(now.year, now.month, now.day)).inDays;
        return ListView(padding: const EdgeInsets.all(16), children: [
          Text(t('salam'), style: const TextStyle(fontSize: 18, color: gold)),
          Text(name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          card(
            child: Column(children: [
              if (left == null)
                gbtn(t('setDate'), Icons.event, () => pickDate(context))
              else ...[
                if (left > 0) Text('$left', style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: gold)),
                if (left > 0) Text(t('days'), style: bodyStyle, textAlign: TextAlign.center),
                if (left == 0) Text(t('departToday'), style: bodyStyle, textAlign: TextAlign.center),
                TextButton(onPressed: () => pickDate(context), child: Text(t('change'), style: const TextStyle(fontSize: 16))),
              ],
            ]),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              tile(Icons.menu_book, t('guide'), () => push(context, const GuideScreen())),
              tile(Icons.checklist, t('checklist'), () => push(context, const ChecklistScreen())),
              tile(Icons.flight_takeoff, t('n_trip'), () => go(1)),
              tile(Icons.folder_copy, t('n_docs'), () => go(2)),
              tile(Icons.chat, t('contact'), () => openUrl(context, waUrl)),
              tile(Icons.emergency, t('emergency'), () => push(context, const EmergencyScreen()), urgent: true),
            ],
          ),
        ]);
      });
}

// ---------- My Journey ----------
class JourneyTab extends StatelessWidget {
  const JourneyTab({super.key});
  static const keys = ['dep_f', 'ret_f', 'mak', 'mad', 'trans', 'zi', 'notes'];
  static const titles = ['t_dep', 't_ret', 't_mak', 't_mad', 't_trans', 't_zi', 't_notes'];
  @override
  Widget build(BuildContext context) => live(() => ListView(padding: const EdgeInsets.all(16), children: [
        h(t('n_trip')),
        Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(t('tripNote'), style: softStyle)),
        for (var i = 0; i < keys.length; i++) card(child: NoteField(k: keys[i], title: t(titles[i]), hint: t('hint'))),
      ]));
}

// ---------- Documents ----------
Future<void> pickDoc(String ty, ImageSource src) async {
  try {
    final x = await ImagePicker().pickImage(source: src, imageQuality: 85);
    if (x == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${ty}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(x.path).copy(path);
    app.addDoc(ty, path);
  } catch (_) {}
}

void addSheet(BuildContext c, String ty) => showModalBottomSheet<void>(
      context: c,
      backgroundColor: navy2,
      builder: (s) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.photo_camera, color: gold, size: 30),
            title: Text(t('camera'), style: const TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(s);
              pickDoc(ty, ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: gold, size: 30),
            title: Text(t('gallery'), style: const TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(s);
              pickDoc(ty, ImageSource.gallery);
            },
          ),
        ]),
      ),
    );

Widget thumb(BuildContext c, String ty, String f) => Stack(children: [
      GestureDetector(
        onTap: () => showDialog<void>(context: c, builder: (_) => Dialog(child: InteractiveViewer(child: Image.file(File(f))))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(File(f), width: 96, height: 96, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(width: 96, height: 96, child: Icon(Icons.broken_image))),
        ),
      ),
      Positioned(
        top: 2,
        right: 2,
        child: GestureDetector(
          onTap: () async {
            if (await ask(c, t('delAsk'))) app.delDoc(ty, f);
          },
          child: const CircleAvatar(radius: 14, backgroundColor: Colors.black87, child: Icon(Icons.close, size: 18)),
        ),
      ),
    ]);

class DocsTab extends StatelessWidget {
  const DocsTab({super.key});
  static const types = ['passport', 'cnic', 'photo', 'visa', 'ticket', 'hotel', 'other'];
  @override
  Widget build(BuildContext context) => live(() => ListView(padding: const EdgeInsets.all(16), children: [
        h(t('n_docs')),
        Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(t('docsNote'), style: softStyle)),
        for (final ty in types)
          card(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(t('d_$ty'), style: titleStyle)),
                IconButton(icon: const Icon(Icons.add_a_photo, color: gold, size: 30), onPressed: () => addSheet(context, ty)),
              ]),
              if ((app.docs[ty] ?? <String>[]).isEmpty)
                Text(t('noFiles'), style: const TextStyle(color: Colors.white54, fontSize: 16))
              else
                Wrap(spacing: 8, runSpacing: 8, children: [for (final f in app.docs[ty]!) thumb(context, ty, f)]),
            ]),
          ),
      ]));
}

// ---------- Support ----------
class SupportTab extends StatelessWidget {
  const SupportTab({super.key});
  @override
  Widget build(BuildContext context) => live(() => ListView(padding: const EdgeInsets.all(16), children: [
        h(t('n_help')),
        card(
          child: Column(children: [
            const Text('KARWAN-E-MARHABA TRAVEL & TOURS', textAlign: TextAlign.center, style: titleStyle),
            const SizedBox(height: 6),
            Text(t('since'), style: softStyle),
            const SizedBox(height: 6),
            Text(t('addr'), textAlign: TextAlign.center, style: bodyStyle),
          ]),
        ),
        gbtn(t('wa'), Icons.chat, () => openUrl(context, waUrl)),
        gbtn(t('call'), Icons.call, () => openUrl(context, 'tel:$agencyPhone')),
        gbtn(t('mail'), Icons.email, () => openUrl(context, 'mailto:$agencyEmail')),
        gbtn(t('emergency'), Icons.emergency, () => push(context, const EmergencyScreen()), bg: red, fg: Colors.white),
      ]));
}

// ---------- Profile ----------
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) => live(() => ListView(padding: const EdgeInsets.all(16), children: [
        h(t('n_me')),
        card(child: NoteField(k: 'name', title: t('yourName'), single: true)),
        card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t('lang'), style: titleStyle),
          const SizedBox(height: 10),
          langChips(),
        ])),
        card(child: NoteField(k: 'ecPhone', title: t('ecPhone'), single: true, phone: true)),
        card(child: NoteField(k: 'leaderPhone', title: t('leaderPhone'), single: true, phone: true)),
        card(child: Row(children: [
          const Icon(Icons.lock, color: gold),
          const SizedBox(width: 12),
          Expanded(child: Text(t('privacy'), style: softStyle)),
        ])),
        gbtn(t('clear'), Icons.delete_forever, () async {
          if (await ask(context, t('clearAsk'))) await app.wipe();
        }, bg: red, fg: Colors.white),
      ]));
}

// ---------- Umrah Guide ----------
class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});
  @override
  Widget build(BuildContext context) => live(() => Scaffold(
        appBar: AppBar(title: Text(t('guide')), backgroundColor: navy2),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          card(child: Text(t('guideNote'), style: softStyle)),
          for (var i = 0; i < guide.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: navy2,
                borderRadius: BorderRadius.circular(18),
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  shape: const Border(),
                  collapsedShape: const Border(),
                  leading: CircleAvatar(backgroundColor: gold, foregroundColor: navy, child: Text('${i + 1}')),
                  title: Text(guide[i].t[app.lang], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(guide[i].b[app.lang], style: bodyStyle),
                    if (guide[i].ar.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(guide[i].ar, textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, color: gold, height: 1.8)),
                        ),
                      ),
                      Text(guide[i].tl, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70)),
                    ],
                  ],
                ),
              ),
            ),
        ]),
      ));
}

// ---------- Checklist ----------
class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});
  @override
  Widget build(BuildContext context) => live(() {
        final total = checklist.where((e) => !e[0].startsWith('h')).length;
        final n = app.done.length > total ? total : app.done.length;
        return Scaffold(
          appBar: AppBar(title: Text(t('checklist')), backgroundColor: navy2),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Text('${(n * 100 / total).round()}%   ($n / $total)', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: gold)),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: n / total, minHeight: 10, color: gold, backgroundColor: navy2),
              ]),
            ),
            Expanded(
              child: ListView(children: <Widget>[
                for (final e in checklist)
                  if (e[0].startsWith('h'))
                    Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 4), child: Text(e[app.lang + 1], style: titleStyle))
                  else
                    CheckboxListTile(
                      value: app.done.contains(e[0]),
                      onChanged: (_) => app.toggle(e[0]),
                      activeColor: gold,
                      checkColor: navy,
                      title: Text(e[app.lang + 1], style: const TextStyle(fontSize: 20)),
                    ),
              ]),
            ),
          ]),
        );
      });
}

// ---------- Emergency ----------
Widget numRow(BuildContext c, String label, String num) => card(
      onTap: () => confirmCall(c, label, num),
      child: Row(children: [
        const Icon(Icons.call, color: gold),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: bodyStyle)),
        Text(num, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ]),
    );

Widget savedRow(BuildContext c, String key, String label) {
  final v = app.data[key] ?? '';
  return v.trim().isEmpty ? card(child: Text(t('notSet'), style: softStyle)) : numRow(c, label, v.trim());
}

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});
  @override
  Widget build(BuildContext context) => live(() => Scaffold(
        appBar: AppBar(title: Text(t('emergency')), backgroundColor: const Color(0xFF8B1E24)),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Text(t('emgIntro'), style: bodyStyle),
          const SizedBox(height: 16),
          gbtn(t('callAgency'), Icons.call, () => confirmCall(context, 'Karwan-e-Marhaba', agencyPhone), bg: red, fg: Colors.white),
          gbtn(t('wa'), Icons.chat, () => openUrl(context, waUrl)),
          h(t('saudi')),
          numRow(context, t('n911'), '911'),
          numRow(context, t('n997'), '997'),
          numRow(context, t('n999'), '999'),
          h(t('famEC')),
          savedRow(context, 'ecPhone', t('famEC')),
          h(t('leaderT')),
          savedRow(context, 'leaderPhone', t('leaderT')),
        ]),
      ));
}
