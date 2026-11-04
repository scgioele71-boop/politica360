import 'package:flutter/material.dart';

void main() => runApp(const Politica360App());

const navy = Color(0xFF12345A);
const blue = Color(0xFF2463C5);
const pale = Color(0xFFF2F6FC);

class Politica360App extends StatelessWidget {
  const Politica360App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Politica 360',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
      scaffoldBackgroundColor: pale,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: navy, elevation: 0),
    ),
    home: const Dashboard(),
  );
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected = 0;
  final labels = ['Home', 'Italia', 'Europa', 'Stampa', 'Elezioni', 'Sondaggi', 'Leggi', 'Atlante', 'Analisi AI', 'Preferenze'];
  final icons = [Icons.home_outlined, Icons.account_balance, Icons.public, Icons.newspaper,
    Icons.how_to_vote, Icons.poll_outlined, Icons.gavel, Icons.public, Icons.auto_awesome, Icons.tune];
  late final pages = const [
    HomePage(),
    TopicPage(title: 'Politica italiana', subtitle: 'Camera, Senato e Governo',
      items: ['Attività della Camera', 'Attività del Senato', 'Attività del Governo']),
    TopicPage(title: 'Unione europea', subtitle: 'Parlamento, Commissione e Consiglio',
      items: ['Parlamento europeo', 'Commissione europea', 'Consiglio dell’Unione europea']),
    PressPage(),
    ElectionsPage(),
    PollsPage(),
    LawsPage(),
    const AtlasPage(),
    AiPage(),
    const PreferencesPage(),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
    final wide = constraints.maxWidth >= 900;
    return Scaffold(
      appBar: AppBar(title: Row(children: const [
        Icon(Icons.account_balance, color: blue), SizedBox(width: 10),
        Text('POLITICA 360', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1)),
      ]), actions: [
        IconButton(tooltip: 'Stato aggiornamenti', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fonti live non ancora collegate: questa è una versione dimostrativa.'))),
          icon: const Icon(Icons.sync)),
        const SizedBox(width: 8),
      ]),
      body: Row(children: [
        if (wide) NavigationRail(
          selectedIndex: selected,
          onDestinationSelected: (i) => setState(() => selected = i),
          labelType: NavigationRailLabelType.all,
          destinations: List.generate(labels.length, (i) =>
            NavigationRailDestination(icon: Icon(icons[i]), label: Text(labels[i]))),
        ),
        Expanded(child: IndexedStack(index: selected, children: pages)),
      ]),
      bottomNavigationBar: wide ? null : NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (i) => setState(() => selected = i),
        destinations: List.generate(labels.length, (i) =>
          NavigationDestination(icon: Icon(icons[i]), label: labels[i])),
      ),
    );
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('L’informazione politica, a 360 gradi',
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    const SizedBox(height: 8),
    const Text('Istituzioni, giornali, leggi, elezioni e sondaggi in un unico spazio.',
      style: TextStyle(color: Colors.black54, fontSize: 15)),
    const SizedBox(height: 20),
    Wrap(spacing: 10, runSpacing: 10, children: const [
      StatCard(label: 'Italia', detail: 'Camera e Senato', icon: Icons.account_balance),
      StatCard(label: 'Europa', detail: 'Istituzioni UE', icon: Icons.public),
      StatCard(label: 'Elezioni', detail: 'Risultati e affluenza', icon: Icons.how_to_vote),
      StatCard(label: 'Sondaggi', detail: 'Serie e rilevazioni', icon: Icons.poll),
    ]),
    const SizedBox(height: 24),
    const Text('La tua rassegna politica', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const SizedBox(height: 10),
    const Notice(text: 'La versione attuale è un prototipo: le fonti e i flussi in tempo reale devono ancora essere collegati.'),
    const SizedBox(height: 12),
    const InfoCard(tag: 'DOSSIER', title: 'Segui una legge dall’inizio alla fine',
      description: 'Proposta, assegnazione alle commissioni, emendamenti, discussione, votazioni e pubblicazione.'),
    const InfoCard(tag: 'ELEZIONI', title: 'Risultati e affluenza',
      description: 'Consulta dati ufficiali, con orario dell’ultimo aggiornamento e stato dello scrutinio.'),
    const InfoCard(tag: 'SONDAGGI', title: 'Confronta le rilevazioni',
      description: 'Istituto, data del sondaggio, periodo di rilevazione, campione e metodo.'),
    const SizedBox(height: 10),
    const Text('Ogni dato dovrà mostrare fonte, data e collegamento originale. I dati dimostrativi non sono risultati o sondaggi reali.',
      style: TextStyle(fontSize: 12, color: Colors.black54)),
  ]);
}

class StatCard extends StatelessWidget {
  final String label, detail;
  final IconData icon;
  const StatCard({super.key, required this.label, required this.detail, required this.icon});
  @override
  Widget build(BuildContext context) => Container(width: 180, padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: blue, size: 27), const SizedBox(height: 10),
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      Text(detail, style: const TextStyle(color: Colors.black54)),
    ]));
}

class Notice extends StatelessWidget {
  final String text;
  const Notice({super.key, required this.text});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: const Color(0xFFE5EEFC), borderRadius: BorderRadius.circular(15)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Icon(Icons.info_outline, color: blue), const SizedBox(width: 10),
      Expanded(child: Text(text)),
    ]));
}

class InfoCard extends StatelessWidget {
  final String title, description, tag;
  const InfoCard({super.key, required this.title, required this.description, required this.tag});
  @override
  Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0,
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(tag, style: const TextStyle(color: blue, fontSize: 11, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 5), Text(description, style: const TextStyle(color: Colors.black54)),
    ])));
}

class TopicPage extends StatelessWidget {
  final String title, subtitle;
  final List<String> items;
  const TopicPage({super.key, required this.title, required this.subtitle, required this.items});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    const SizedBox(height: 6), Text(subtitle, style: const TextStyle(color: Colors.black54)),
    const SizedBox(height: 18), const Notice(text: 'Sezione predisposta per atti, calendari, resoconti e documenti ufficiali. Collegamento dati da realizzare.'),
    for (final item in items) InfoCard(tag: 'AREA ISTITUZIONALE', title: item,
      description: 'Documenti, comunicati, attività e collegamenti alla fonte ufficiale.'),
  ]);
}

class PressPage extends StatelessWidget {
  const PressPage({super.key});
  static const outlets = [
    ('ANSA', 'Agenzia di stampa', 'https://www.ansa.it/'),
    ('RaiNews', 'Informazione pubblica', 'https://www.rainews.it/'),
    ('Sky TG24', 'Notizie e approfondimenti', 'https://tg24.sky.it/'),
    ('Corriere della Sera', 'Quotidiano nazionale', 'https://www.corriere.it/'),
    ('la Repubblica', 'Quotidiano nazionale', 'https://www.repubblica.it/'),
    ('Il Sole 24 Ore', 'Economia e politica', 'https://www.ilsole24ore.com/'),
    ('La Stampa', 'Quotidiano nazionale', 'https://www.lastampa.it/'),
    ('Il Messaggero', 'Quotidiano nazionale', 'https://www.ilmessaggero.it/'),
    ('Il Fatto Quotidiano', 'Quotidiano nazionale', 'https://www.ilfattoquotidiano.it/'),
    ('Avvenire', 'Quotidiano nazionale', 'https://www.avvenire.it/'),
    ('Domani', 'Quotidiano nazionale', 'https://www.editorialedomani.it/'),
    ('Il Giornale', 'Quotidiano nazionale', 'https://www.ilgiornale.it/'),
    ('Il Foglio', 'Quotidiano nazionale', 'https://www.ilfoglio.it/'),
    ('Il Manifesto', 'Quotidiano nazionale', 'https://ilmanifesto.it/'),
  ];
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Rassegna stampa', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    const SizedBox(height: 6),
    const Text('Una selezione di testate e agenzie. L’app mostrerà titolo, breve sintesi, data e link, rispettando licenze e condizioni d’uso.', style: TextStyle(color: Colors.black54)),
    const SizedBox(height: 14),
    const Notice(text: 'Elenco di fonti predisposto. Gli articoli non sono ancora importati automaticamente.'),
    for (final outlet in outlets)
      Card(color: Colors.white, elevation: 0, child: ListTile(
        leading: const CircleAvatar(backgroundColor: pale, child: Icon(Icons.newspaper, color: blue)),
        title: Text(outlet.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(outlet.$2),
        trailing: const Icon(Icons.open_in_new),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sito: ${outlet.$3} — apri il link dal browser.'))),
      )),
  ]);
}

class ElectionsPage extends StatelessWidget {
  const ElectionsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Elezioni', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    SizedBox(height: 6), Text('Monitoraggio elettorale italiano e internazionale.', style: TextStyle(color: Colors.black54)),
    SizedBox(height: 16),
    Notice(text: 'I risultati in tempo reale saranno mostrati solo durante consultazioni con dati ufficiali disponibili. Ogni aggiornamento indicherà ora, copertura e fonte.'),
    InfoCard(tag: 'ITALIA', title: 'Elezioni nazionali e locali', description: 'Affluenza, sezioni scrutinate, voti e seggi, quando pubblicati dalle autorità competenti.'),
    InfoCard(tag: 'EUROPA E MONDO', title: 'Elezioni nei Paesi di interesse', description: 'Calendario, risultati ufficiali e sistema elettorale dei Paesi con consultazioni rilevanti.'),
    InfoCard(tag: 'METODO', title: 'Dati provvisori e definitivi', description: 'Distinzione chiara tra proiezioni, exit poll, scrutinio parziale e risultati certificati.'),
  ]);
}

class PollsPage extends StatelessWidget {
  const PollsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Sondaggi', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    SizedBox(height: 6), Text('Rilevazioni italiane e internazionali.', style: TextStyle(color: Colors.black54)),
    SizedBox(height: 16),
    Notice(text: 'Non esistono necessariamente nuovi sondaggi ogni giorno. La pagina si aggiornerà quando vengono pubblicate nuove rilevazioni verificabili.'),
    InfoCard(tag: 'ITALIA', title: 'Intenzioni di voto', description: 'Serie storica e confronto tra istituti, senza classifiche o previsioni dell’app.'),
    InfoCard(tag: 'INTERNAZIONALE', title: 'Paesi con elezioni importanti', description: 'Sondaggi disponibili nei Paesi prossimi a elezioni nazionali o europee rilevanti.'),
    InfoCard(tag: 'METODOLOGIA', title: 'Leggi i dati correttamente', description: 'Istituto, committente, campione, metodo, date di rilevazione e margine di errore, se dichiarato.'),
  ]);
}

class LawsPage extends StatelessWidget {
  const LawsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Dossier legislativi', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    SizedBox(height: 6), Text('Segui ogni provvedimento dalla presentazione alla conclusione.', style: TextStyle(color: Colors.black54)),
    SizedBox(height: 16),
    Notice(text: 'Il dossier completo sarà disponibile quando saranno collegati gli archivi parlamentari. Le fasi non ancora concluse saranno indicate come tali.'),
    InfoCard(tag: 'FASE 1', title: 'Presentazione', description: 'Testo iniziale, firmatari, data, numero dell’atto e relazione illustrativa.'),
    InfoCard(tag: 'FASE 2', title: 'Commissioni ed emendamenti', description: 'Commissione competente, audizioni, relatori, emendamenti presentati e approvati.'),
    InfoCard(tag: 'FASE 3', title: 'Discussione e votazioni', description: 'Calendario, resoconti, votazioni e risultati nominali quando pubblicati.'),
    InfoCard(tag: 'FASE 4', title: 'Altra Camera e conclusione', description: 'Passaggi tra Camera e Senato, eventuali modifiche, promulgazione e pubblicazione.'),
    InfoCard(tag: 'DOSSIER', title: 'Scheda di approfondimento', description: 'Cronologia documentata, collegamenti agli atti originali e spiegazione in linguaggio semplice.'),
  ]);
}



class AtlasPage extends StatefulWidget {
  const AtlasPage({super.key});
  @override
  State<AtlasPage> createState() => _AtlasPageState();
}

class _AtlasPageState extends State<AtlasPage> {
  final searchController = TextEditingController();
  String region = 'Tutti';
  static const eu = [
    'Austria', 'Belgio', 'Bulgaria', 'Cipro', 'Croazia', 'Danimarca',
    'Estonia', 'Finlandia', 'Francia', 'Germania', 'Grecia', 'Irlanda',
    'Italia', 'Lettonia', 'Lituania', 'Lussemburgo', 'Malta', 'Paesi Bassi',
    'Polonia', 'Portogallo', 'Repubblica Ceca', 'Romania', 'Slovacchia',
    'Slovenia', 'Spagna', 'Svezia', 'Ungheria',
  ];
  static const extra = [
    'Stati Uniti', 'Russia', 'Regno Unito', 'Svizzera', 'Norvegia',
    'Canada', 'Giappone', 'Ucraina', 'Turchia',
  ];

  @override
  void dispose() { searchController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final all = [
      ...eu.map((c) => (c, 'Unione europea')),
      ...extra.map((c) => (c, 'Extra UE')),
    ];
    final q = searchController.text.trim().toLowerCase();
    final filtered = all.where((item) =>
      (region == 'Tutti' || item.$2 == region) &&
      item.$1.toLowerCase().contains(q)).toList();

    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Atlante politico mondiale',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
      const SizedBox(height: 6),
      const Text('Esplora le istituzioni, i governi e i sistemi politici dei Paesi monitorati.',
        style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 14),
      TextField(controller: searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Cerca un Paese…',
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        )),
      const SizedBox(height: 10),
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'Tutti', label: Text('Tutti')),
          ButtonSegment(value: 'Unione europea', label: Text('UE')),
          ButtonSegment(value: 'Extra UE', label: Text('Extra UE')),
        ],
        selected: {region},
        onSelectionChanged: (s) => setState(() => region = s.first),
      ),
      const SizedBox(height: 12),
      const Notice(text: 'Le schede sono predisposte come struttura editoriale. I dati su titolari delle cariche, governi, parlamenti e prossime elezioni dovranno essere collegati a fonti aggiornate e verificati con data e fonte.'),
      const SizedBox(height: 10),
      Text('${filtered.length} Paesi', style: const TextStyle(fontWeight: FontWeight.bold, color: navy)),
      ...filtered.map((item) => Card(
        color: Colors.white, elevation: 0,
        child: ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFFE5EEFC),
            child: Icon(item.$2 == 'Unione europea' ? Icons.flag_outlined : Icons.public, color: blue)),
          title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(item.$2),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => showModalBottomSheet(
            context: context, isScrollControlled: true,
            builder: (context) => SafeArea(child: Padding(
              padding: const EdgeInsets.all(22),
              child: Wrap(runSpacing: 12, children: [
                Text(item.$1, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: navy)),
                Text(item.$2, style: const TextStyle(color: Colors.black54)),
                const Divider(),
                const Text('Scheda politica del Paese', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('La scheda completa comprenderà: forma di Stato e di governo; capo dello Stato; capo del Governo; composizione del Parlamento; partiti e coalizioni; prossime elezioni; relazioni con Italia e UE.'),
                const Notice(text: 'I campi informativi saranno compilati solo dopo l’integrazione di fonti ufficiali aggiornate. Non sono mostrati nominativi o dati correnti non verificati.'),
              ]),
            )),
          ),
        ),
      )),
    ]);
  }
}

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  String readingMode = 'Entrambi';
  final Map<String, bool> alerts = {
    'Notizie politiche importanti': true,
    'Leggi e votazioni': true,
    'Elezioni e risultati': true,
    'Nuovi sondaggi': true,
    'Crisi di governo e cambi istituzionali': true,
    'Attività UE e politica estera': true,
  };

  static const euCountries = [
    'Austria', 'Belgio', 'Bulgaria', 'Cipro', 'Croazia', 'Danimarca',
    'Estonia', 'Finlandia', 'Francia', 'Germania', 'Grecia', 'Irlanda',
    'Italia', 'Lettonia', 'Lituania', 'Lussemburgo', 'Malta', 'Paesi Bassi',
    'Polonia', 'Portogallo', 'Repubblica Ceca', 'Romania', 'Slovacchia',
    'Slovenia', 'Spagna', 'Svezia', 'Ungheria',
  ];
  final Map<String, bool> countrySelections = {};

  @override
  void initState() {
    super.initState();
    for (final country in euCountries) {
      countrySelections[country] = true;
    }
    countrySelections['Stati Uniti'] = true;
    countrySelections['Russia'] = true;
    countrySelections['Regno Unito'] = true;
    countrySelections['Svizzera'] = true;
    countrySelections['Norvegia'] = true;
    countrySelections['Canada'] = true;
    countrySelections['Giappone'] = true;
    countrySelections['Ucraina'] = true;
    countrySelections['Turchia'] = true;
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = countrySelections.values.where((v) => v).length;
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Preferenze', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
      const SizedBox(height: 6),
      const Text('Personalizza lettura, notifiche e Paesi monitorati.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 18),
      const Text('Modalità di lettura', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      RadioListTile<String>(
        contentPadding: EdgeInsets.zero, title: const Text('Sintesi breve'),
        value: 'Sintesi breve', groupValue: readingMode,
        onChanged: (v) => setState(() => readingMode = v!)),
      RadioListTile<String>(
        contentPadding: EdgeInsets.zero, title: const Text('Approfondimento completo'),
        value: 'Approfondimento completo', groupValue: readingMode,
        onChanged: (v) => setState(() => readingMode = v!)),
      RadioListTile<String>(
        contentPadding: EdgeInsets.zero, title: const Text('Entrambi'),
        subtitle: const Text('Mostra una sintesi e consente di aprire l’analisi completa.'),
        value: 'Entrambi', groupValue: readingMode,
        onChanged: (v) => setState(() => readingMode = v!)),
      const Divider(),
      const Text('Notifiche personalizzabili', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      const Text('Attiva o disattiva i temi per cui desideri ricevere avvisi.', style: TextStyle(color: Colors.black54)),
      ...alerts.keys.map((label) => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        value: alerts[label]!,
        onChanged: (v) => setState(() => alerts[label] = v),
      )),
      const Divider(),
      Row(children: [
        const Expanded(child: Text('Paesi monitorati', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        Text('$selectedCount selezionati', style: const TextStyle(color: Colors.black54)),
      ]),
      const SizedBox(height: 5),
      const Text('Sono preselezionati tutti i 27 Paesi UE e alcuni Paesi extra-UE di rilievo per le relazioni internazionali italiane. La selezione è modificabile.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 12),
      const Text('Unione europea', style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
      ...euCountries.map((country) => CheckboxListTile(
        contentPadding: EdgeInsets.zero, dense: true,
        title: Text(country), value: countrySelections[country] ?? false,
        onChanged: (v) => setState(() => countrySelections[country] = v ?? false),
      )),
      const SizedBox(height: 8),
      const Text('Paesi extra-UE', style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
      ...['Stati Uniti', 'Russia', 'Regno Unito', 'Svizzera', 'Norvegia',
        'Canada', 'Giappone', 'Ucraina', 'Turchia'].map((country) => CheckboxListTile(
        contentPadding: EdgeInsets.zero, dense: true,
        title: Text(country), value: countrySelections[country] ?? false,
        onChanged: (v) => setState(() => countrySelections[country] = v ?? false),
      )),
      const SizedBox(height: 12),
      const Notice(text: 'Queste preferenze sono attualmente gestite nella schermata dimostrativa. Per conservarle tra riavvii e dispositivi servirà aggiungere un archivio locale o un account sincronizzato. Le notifiche push richiedono inoltre un servizio backend.'),
    ]);
  }
}

class AiPage extends StatefulWidget {
  const AiPage({super.key});
  @override
  State<AiPage> createState() => _AiPageState();
}
class _AiPageState extends State<AiPage> {
  final controller = TextEditingController();
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Analisi AI', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
    const SizedBox(height: 8),
    const Text('Chiedi di spiegare una notizia, una legge o una votazione. Il servizio AI deve essere collegato a fonti verificabili.', style: TextStyle(color: Colors.black54)),
    const SizedBox(height: 18),
    TextField(controller: controller, minLines: 3, maxLines: 6,
      decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(),
        hintText: 'Incolla una notizia, un atto o una domanda…')),
    const SizedBox(height: 10),
    FilledButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Servizio AI non ancora configurato.'))),
      icon: const Icon(Icons.auto_awesome), label: const Text('Analizza')),
    const SizedBox(height: 14),
    const Text('L’analisi dovrà separare fatti, dichiarazioni attribuite, interpretazioni e incertezze, mostrando i riferimenti alle fonti.', style: TextStyle(fontSize: 13, color: Colors.black54)),
  ]);
}
