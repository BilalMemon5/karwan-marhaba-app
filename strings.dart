const langNames = ['English', 'اردو', 'Roman Urdu'];

String tr(int l, String k) => _s[k]?[l] ?? k;

const Map<String, List<String>> _s = {
  'app': ['My Umrah Journey', 'میرا عمرہ سفر', 'Mera Umrah Safar'],
  'salam': ['Assalamu Alaikum', 'السلام علیکم', 'Assalamu Alaikum'],
  'pilgrim': ['Dear Pilgrim', 'محترم زائر', 'Mohtaram Zaer'],
  'n_home': ['Home', 'ہوم', 'Home'],
  'n_trip': ['My Journey', 'میرا سفر', 'Mera Safar'],
  'n_docs': ['Documents', 'دستاویزات', 'Documents'],
  'n_help': ['Support', 'مدد', 'Madad'],
  'n_me': ['Profile', 'پروفائل', 'Profile'],
  'lang': ['Language', 'زبان', 'Zubaan'],
  'yourName': ['Your full name', 'آپ کا پورا نام', 'Aap ka poora naam'],
  'start': ['Start', 'شروع کریں', 'Shuru karein'],
  'days': ['days to departure', 'دن روانگی میں باقی', 'din rawangi mein baqi'],
  'departToday': ['Departure is today. Safe journey!', 'آج روانگی ہے۔ سفر مبارک!', 'Aaj rawangi hai. Safar mubarak!'],
  'setDate': ['Set departure date', 'روانگی کی تاریخ لگائیں', 'Rawangi ki tareekh lagayein'],
  'change': ['Change date', 'تاریخ بدلیں', 'Tareekh badlein'],
  'guide': ['Umrah Guide', 'عمرہ گائیڈ', 'Umrah Guide'],
  'checklist': ['Checklist', 'چیک لسٹ', 'Checklist'],
  'emergency': ['Emergency', 'ہنگامی مدد', 'Emergency'],
  'contact': ['Contact Agency', 'ایجنسی سے رابطہ', 'Agency se rabta'],
  'tripNote': [
    'Saved on this phone only. Copy details from your ticket and voucher, or ask Karwan-e-Marhaba staff to fill them with you.',
    'یہ معلومات صرف اسی فون میں محفوظ ہوتی ہیں۔ اپنے ٹکٹ اور واؤچر سے لکھ لیں یا کاروانِ مرحبا کے عملے سے مل کر بھر لیں۔',
    'Yeh maloomat sirf isi phone mein mehfooz hoti hain. Apne ticket aur voucher se likh lein ya Karwan-e-Marhaba ke staff se mil kar bhar lein.'
  ],
  't_dep': ['Departure Flight', 'روانگی کی فلائٹ', 'Rawangi ki flight'],
  't_ret': ['Return Flight', 'واپسی کی فلائٹ', 'Wapsi ki flight'],
  't_mak': ['Makkah Hotel', 'مکہ کا ہوٹل', 'Makkah ka hotel'],
  't_mad': ['Madinah Hotel', 'مدینہ کا ہوٹل', 'Madinah ka hotel'],
  't_trans': ['Transport / Pickup', 'ٹرانسپورٹ / پک اپ', 'Transport / Pickup'],
  't_zi': ['Ziyarat Schedule', 'زیارات کا شیڈول', 'Ziyarat ka schedule'],
  't_notes': ['My Notes', 'میرے نوٹس', 'Mere notes'],
  'hint': [
    'Airline, date, time, address, room, phone…',
    'ایئرلائن، تاریخ، وقت، پتہ، کمرہ، فون…',
    'Airline, tareekh, waqt, pata, kamra, phone…'
  ],
  'docsNote': [
    'Kept privately inside this app on your phone. Keep your phone locked.',
    'یہ دستاویزات آپ کے فون میں ایپ کے اندر محفوظ ہیں۔ فون کو لاک رکھیں۔',
    'Yeh documents aap ke phone mein app ke andar mehfooz hain. Phone ko lock rakhein.'
  ],
  'd_passport': ['Passport', 'پاسپورٹ', 'Passport'],
  'd_cnic': ['CNIC', 'شناختی کارڈ', 'CNIC (Shanakhti card)'],
  'd_photo': ['Photograph', 'تصویر', 'Tasveer'],
  'd_visa': ['Visa', 'ویزا', 'Visa'],
  'd_ticket': ['Flight Ticket', 'فلائٹ ٹکٹ', 'Flight Ticket'],
  'd_hotel': ['Hotel Voucher', 'ہوٹل واؤچر', 'Hotel Voucher'],
  'd_other': ['Other', 'دیگر', 'Doosray'],
  'noFiles': ['No files yet. Tap the camera to add.', 'ابھی کوئی فائل نہیں۔ کیمرے کے نشان پر دبائیں۔', 'Abhi koi file nahi. Camera ke nishan par dabayein.'],
  'camera': ['Camera', 'کیمرہ', 'Camera'],
  'gallery': ['Gallery', 'گیلری', 'Gallery'],
  'delAsk': ['Delete this file?', 'یہ فائل مٹا دیں؟', 'Yeh file mita dein?'],
  'yes': ['Yes', 'جی ہاں', 'Ji haan'],
  'no': ['No', 'نہیں', 'Nahi'],
  'since': ['Serving pilgrims since 2010', '2010 سے زائرین کی خدمت میں', '2010 se zaireen ki khidmat mein'],
  'addr': [
    'Dhak Road, Baghe Hayat Ali Shah, Sukkur, Pakistan',
    'ڈھک روڈ، باغِ حیات علی شاہ، سکھر، پاکستان',
    'Dhak Road, Bagh-e-Hayat Ali Shah, Sukkur, Pakistan'
  ],
  'wa': ['WhatsApp', 'واٹس ایپ', 'WhatsApp'],
  'call': ['Call', 'کال کریں', 'Call karein'],
  'mail': ['Email', 'ای میل', 'Email'],
  'cantOpen': ['Could not open. Please try again.', 'کھل نہیں سکا۔ دوبارہ کوشش کریں۔', 'Khul nahi saka. Dobara koshish karein.'],
  'emgIntro': [
    'Stay calm. Choose what you need. You will be asked to confirm before any call.',
    'پرسکون رہیں۔ جو چاہیے اسے چنیں۔ کال سے پہلے آپ سے تصدیق لی جائے گی۔',
    'Pur-sukoon rahein. Jo chahiye usay chunein. Call se pehle aap se tasdeeq li jayegi.'
  ],
  'callAgency': ['Call Agency', 'ایجنسی کو کال', 'Agency ko call'],
  'saudi': ['Saudi Arabia emergency numbers', 'سعودی عرب ہنگامی نمبر', 'Saudi Arabia emergency numbers'],
  'n911': ['All emergencies', 'ہر قسم کی ہنگامی صورت', 'Har qism ki emergency'],
  'n997': ['Ambulance', 'ایمبولینس', 'Ambulance'],
  'n999': ['Police', 'پولیس', 'Police'],
  'famEC': ['Family emergency contact', 'گھر والوں کا ہنگامی نمبر', 'Ghar walon ka emergency number'],
  'leaderT': ['Group leader', 'گروپ لیڈر', 'Group leader'],
  'notSet': ['Not added yet. Add it in Profile.', 'ابھی درج نہیں۔ پروفائل میں درج کریں۔', 'Abhi darj nahi. Profile mein darj karein.'],
  'confirmCall': ['Call this number?', 'کیا اس نمبر پر کال کریں؟', 'Kya is number par call karein?'],
  'ecPhone': ['Family emergency phone', 'گھر والوں کا فون نمبر', 'Ghar walon ka phone number'],
  'leaderPhone': ['Group leader phone', 'گروپ لیڈر کا فون نمبر', 'Group leader ka phone number'],
  'privacy': [
    'Your information stays on this phone. Nothing is sent to anyone.',
    'آپ کی معلومات اسی فون میں رہتی ہیں۔ کہیں نہیں بھیجی جاتیں۔',
    'Aap ki maloomat isi phone mein rehti hain. Kahin nahi bheji jati.'
  ],
  'clear': ['Delete all my data from this phone', 'اس فون سے میرا سارا ڈیٹا مٹائیں', 'Is phone se mera saara data mitayein'],
  'clearAsk': ['Delete everything saved in this app?', 'ایپ میں محفوظ سب کچھ مٹا دیں؟', 'App mein mehfooz sab kuch mita dein?'],
  'guideNote': [
    'Basic guidance only. Please confirm with your group’s scholar or guide. This text is still waiting for review by a religious advisor.',
    'یہ صرف بنیادی رہنمائی ہے۔ اپنے گروپ کے عالم یا گائیڈ سے تصدیق کر لیں۔ اس متن کا دینی مشیر سے جائزہ ابھی باقی ہے۔',
    'Yeh sirf bunyadi rehnumai hai. Apne group ke aalim ya guide se tasdeeq kar lein. Is matan ka deeni mushir se jaiza abhi baqi hai.'
  ],
};

class Step {
  final List<String> t, b;
  final String ar, tl;
  const Step(this.t, this.b, [this.ar = '', this.tl = '']);
}

const guide = <Step>[
  Step(['Preparing for Ihram', 'احرام کی تیاری', 'Ihram ki tayyari'], [
    'Before the Miqat, take a bath and make wudu. Men wear two white unstitched sheets. Women wear simple, modest clothes. Avoid perfume once Ihram is on.',
    'میقات سے پہلے غسل اور وضو کریں۔ مرد دو سفید بغیر سلی چادریں پہنیں۔ خواتین سادہ اور باپردہ لباس پہنیں۔ احرام کے بعد خوشبو سے بچیں۔',
    'Miqat se pehle ghusl aur wudu karein. Mard do safed bagair seeli chadarein pehnein. Khawateen saada aur bapardah libaas pehnein. Ihram ke baad khushbu se bachein.'
  ]),
  Step(['Niyyah', 'نیت', 'Niyyat'], [
    'At the Miqat, make the intention for Umrah in your heart and say it with your tongue.',
    'میقات پر دل میں عمرہ کی نیت کریں اور زبان سے بھی کہیں۔',
    'Miqat par dil mein Umrah ki niyyat karein aur zubaan se bhi kahein.'
  ], 'اللَّهُمَّ لَبَّيْكَ عُمْرَةً', 'Allahumma labbaika Umratan'),
  Step(['Talbiyah', 'تلبیہ', 'Talbiyah'], [
    'Recite it often until you begin Tawaf. Men recite aloud, women softly.',
    'طواف شروع کرنے تک بار بار پڑھیں۔ مرد بلند آواز سے اور خواتین آہستہ پڑھیں۔',
    'Tawaf shuru karne tak baar baar parhein. Mard buland awaz se aur khawateen aahista parhein.'
  ], 'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لَا شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لَا شَرِيكَ لَكَ',
      'Labbaik Allahumma labbaik, labbaika la sharika laka labbaik, innal hamda wan-ni’mata laka wal-mulk, la sharika lak.'),
  Step(['Entering Masjid al-Haram', 'مسجد الحرام میں داخلہ', 'Masjid al-Haram mein dakhila'], [
    'Enter with your right foot first and ask Allah for His mercy. Keep your group leader’s number and hotel card with you.',
    'دایاں پاؤں پہلے رکھ کر داخل ہوں اور اللہ سے رحمت مانگیں۔ گروپ لیڈر کا نمبر اور ہوٹل کارڈ ساتھ رکھیں۔',
    'Seedha paaon pehle rakh kar dakhil hon aur Allah se rehmat mangein. Group leader ka number aur hotel card saath rakhein.'
  ]),
  Step(['Tawaf', 'طواف', 'Tawaf'], [
    'Make 7 rounds around the Kaaba, starting and ending at the Black Stone line, with the Kaaba on your left. Take your time and stay with your group.',
    'کعبہ کے گرد سات چکر لگائیں۔ حجرِ اسود کی سیدھ سے شروع اور وہیں ختم کریں، کعبہ بائیں جانب رہے۔ آرام سے چلیں اور گروپ کے ساتھ رہیں۔',
    'Kaaba ke gird 7 chakkar lagayein. Hajr-e-Aswad ki seedh se shuru aur wahin khatam karein, Kaaba baayen taraf rahe. Aaram se chalein aur group ke saath rahein.'
  ]),
  Step(['Prayers after Tawaf', 'طواف کے بعد نماز', 'Tawaf ke baad namaz'], [
    'Pray 2 rakat behind Maqam Ibrahim if possible, or anywhere in the Haram if it is crowded. Then drink Zamzam.',
    'ممکن ہو تو مقامِ ابراہیم کے پیچھے دو رکعت پڑھیں، رش ہو تو حرم میں کہیں بھی پڑھ لیں۔ پھر زمزم پئیں۔',
    'Mumkin ho to Maqam-e-Ibrahim ke peechay 2 rakat parhein, rush ho to Haram mein kahin bhi parh lein. Phir Zamzam piyein.'
  ]),
  Step(['Sa’i', 'سعی', 'Sa’i'], [
    'Walk 7 laps between Safa and Marwah, starting at Safa and finishing at Marwah. Elderly or tired pilgrims can use a wheelchair; ask your group leader.',
    'صفا اور مروہ کے درمیان سات چکر لگائیں۔ صفا سے شروع کریں اور مروہ پر ختم کریں۔ بزرگ یا تھکے ہوئے زائرین وہیل چیئر استعمال کر سکتے ہیں، گروپ لیڈر سے پوچھیں۔',
    'Safa aur Marwah ke darmiyan 7 chakkar lagayein. Safa se shuru karein aur Marwah par khatam. Buzurg ya thake hue zaireen wheelchair istemal kar sakte hain, group leader se poochein.'
  ]),
  Step(['Halq or Taqsir', 'حلق یا تقصیر', 'Halq ya Taqseer'], [
    'Men shave the head (halq) or trim the hair (taqsir). Women trim about a fingertip length of hair.',
    'مرد سر منڈوائیں (حلق) یا بال کٹوائیں (تقصیر)۔ خواتین بالوں کی ایک پور کے برابر لمبائی کاٹیں۔',
    'Mard sar mundwayein (halq) ya baal katwayein (taqseer). Khawateen baalon ki ek por ke barabar lambai katein.'
  ]),
  Step(['Umrah complete', 'عمرہ مکمل', 'Umrah mukammal'], [
    'Your Umrah is complete. The Ihram restrictions end. Thank Allah and make dua.',
    'آپ کا عمرہ مکمل ہو گیا۔ احرام کی پابندیاں ختم ہو گئیں۔ اللہ کا شکر ادا کریں اور دعا کریں۔',
    'Aap ka Umrah mukammal ho gaya. Ihram ki paabandiyan khatam. Allah ka shukar ada karein aur dua karein.'
  ]),
];

// [id, English, Urdu, Roman Urdu]. ids starting with "h" are section headings.
const checklist = <List<String>>[
  ['h1', 'Documents', 'دستاویزات', 'Documents'],
  ['c01', 'Passport', 'پاسپورٹ', 'Passport'],
  ['c02', 'Visa', 'ویزا', 'Visa'],
  ['c03', 'Flight ticket', 'فلائٹ ٹکٹ', 'Flight ticket'],
  ['c04', 'Hotel voucher', 'ہوٹل واؤچر', 'Hotel voucher'],
  ['c05', 'CNIC copies', 'شناختی کارڈ کی کاپیاں', 'CNIC ki copies'],
  ['c06', 'Emergency numbers written down', 'ہنگامی نمبر لکھ لیے', 'Emergency numbers likh liye'],
  ['h2', 'Travel essentials', 'سفری ضروریات', 'Safar ki zaroriyat'],
  ['c07', 'Ihram', 'احرام', 'Ihram'],
  ['c08', 'Comfortable shoes', 'آرام دہ جوتے', 'Aaram deh joote'],
  ['c09', 'Necessary medicines', 'ضروری دوائیں', 'Zaroori dawayein'],
  ['c10', 'Mobile charger and power bank', 'موبائل چارجر اور پاور بینک', 'Mobile charger aur power bank'],
  ['h3', 'Before departure', 'روانگی سے پہلے', 'Rawangi se pehle'],
  ['c11', 'Confirm flight', 'فلائٹ کی تصدیق کریں', 'Flight ki tasdeeq karein'],
  ['c12', 'Check passport validity', 'پاسپورٹ کی میعاد دیکھ لیں', 'Passport ki miyaad dekh lein'],
  ['c13', 'Confirm hotel and airport pickup', 'ہوٹل اور ائیرپورٹ پک اپ کی تصدیق', 'Hotel aur airport pickup ki tasdeeq'],
  ['c14', 'Inform family', 'گھر والوں کو بتائیں', 'Ghar walon ko bataein'],
];
