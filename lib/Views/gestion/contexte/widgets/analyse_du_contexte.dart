import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyseDuContexte extends StatefulWidget {
  const AnalyseDuContexte({Key? key}) : super(key: key);

  @override
  State<AnalyseDuContexte> createState() => _AnalyseDuContexteState();
}

class _AnalyseDuContexteState extends State<AnalyseDuContexte> {
  List<Map<String, dynamic>> _interneEnjeux = [];
  List<Map<String, dynamic>> _externeEnjeux = [];
  Map<int, List<Map<String, dynamic>>> _risquesParEnjeu = {};
  Map<int, List<Map<String, dynamic>>> _opportunitesParEnjeu = {};

  @override
  void initState() {
    super.initState();
    _fetchEnjeuxEtRisquesEtOpportunites();
  }

  Future<void> _fetchEnjeuxEtRisquesEtOpportunites() async {
    final enjeuxResponse = await http.get(Uri.parse('http://localhost:5000/enjeux'));
    if (enjeuxResponse.statusCode == 200) {
      final List<dynamic> enjeuxData = json.decode(enjeuxResponse.body);
      final List<Map<String, dynamic>> enjeuxList =
      enjeuxData.map((item) => item as Map<String, dynamic>).toList();

      _interneEnjeux = enjeuxList.where((item) => item['type_enjeu'] == 'interne').toList();
      _externeEnjeux = enjeuxList.where((item) => item['type_enjeu'] == 'externe').toList();

      // Récupérer les risques
      final risquesResponse = await http.get(Uri.parse('http://localhost:5000/risques'));
      if (risquesResponse.statusCode == 200) {
        final List<dynamic> risquesData = json.decode(risquesResponse.body);
        final List<Map<String, dynamic>> risquesList =
        risquesData.map((item) => item as Map<String, dynamic>).toList();

        for (var risque in risquesList) {
          int idEnjeu = risque['id_enjeu'];
          if (_risquesParEnjeu.containsKey(idEnjeu)) {
            _risquesParEnjeu[idEnjeu]?.add(risque);
          } else {
            _risquesParEnjeu[idEnjeu] = [risque];
          }
        }
      } else {
        print('Error fetching risks: ${risquesResponse.body}');
      }

      // Récupérer les opportunités
      final opportunitesResponse = await http.get(Uri.parse('http://localhost:5000/opportunites'));
      if (opportunitesResponse.statusCode == 200) {
        final List<dynamic> opportunitesData = json.decode(opportunitesResponse.body);
        final List<Map<String, dynamic>> opportunitesList =
        opportunitesData.map((item) => item as Map<String, dynamic>).toList();

        for (var opportunite in opportunitesList) {
          int idEnjeu = opportunite['id_enjeu'];
          if (_opportunitesParEnjeu.containsKey(idEnjeu)) {
            _opportunitesParEnjeu[idEnjeu]?.add(opportunite);
          } else {
            _opportunitesParEnjeu[idEnjeu] = [opportunite];
          }
        }
      } else {
        print('Error fetching opportunities: ${opportunitesResponse.body}');
      }

      setState(() {});
    } else {
      print('Error fetching enjeux: ${enjeuxResponse.body}');
    }
  }

  void _showRisqueDetails(Map<String, dynamic> risque) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(risque['libelle'] ?? 'Détails du Risque'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Gravité: ${risque['gravite'] ?? 'N/A'}"),
              Text("Fréquence: ${risque['frequence'] ?? 'N/A'}"),
              Text("Enjeu associé: ${risque['id_enjeu']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Quitter'),
            ),
          ],
        );
      },
    );
  }

  void _showOpportuniteDetails(Map<String, dynamic> opportunite) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(opportunite['libelle'] ?? 'Détails de l\'Opportunité'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Gravité: ${opportunite['gravite'] ?? 'N/A'}"),
              Text("Fréquence: ${opportunite['frequence'] ?? 'N/A'}"),
              Text("Enjeu associé: ${opportunite['id_enjeu']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Quitter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analyse du Contexte"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FixedColumnWidth(150.0),
                1: FixedColumnWidth(350.0),
                2: FixedColumnWidth(350.0),
                3: FixedColumnWidth(350.0),
              },
              children: [
                TableRow(
                  children: [
                    tableCell("Type", isHeader: true),
                    tableCell("Enjeux", isHeader: true),
                    tableCell("Risques", isHeader: true),
                    tableCell("Opportunités", isHeader: true),
                  ],
                ),
                TableRow(
                  children: [
                    tableCell("Interne", isHeader: true, rowSpan: 3),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _interneEnjeux
                            .map((enjeu) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "-  ${enjeu['libelle'] ?? 'N/A'}\n",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _interneEnjeux
                            .map((enjeu) {
                          final risques = _risquesParEnjeu[enjeu['id']];
                          if (risques != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: risques.map((risque) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextButton(
                                    onPressed: () => _showRisqueDetails(risque),
                                    child: Text(
                                      "-  ${risque['libelle'] ?? 'N/A'}",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Column(); // Retourne un widget vide si aucun risque n'est trouvé
                          }
                        })
                            .toList(),
                      ),
                    ),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _interneEnjeux
                            .map((enjeu) {
                          final opportunites = _opportunitesParEnjeu[enjeu['id']];
                          if (opportunites != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: opportunites.map((opportunite) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextButton(
                                    onPressed: () => _showOpportuniteDetails(opportunite),
                                    child: Text(
                                      "-  ${opportunite['libelle'] ?? 'N/A'}",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Column(); // Retourne un widget vide si aucune opportunité n'est trouvée
                          }
                        })
                            .toList(),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    tableCell("Externe", isHeader: true, rowSpan: 3),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _externeEnjeux
                            .map((enjeu) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "-  ${enjeu['libelle'] ?? 'N/A'}\n",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _externeEnjeux
                            .map((enjeu) {
                          final risques = _risquesParEnjeu[enjeu['id']];
                          if (risques != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: risques.map((risque) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextButton(
                                    onPressed: () => _showRisqueDetails(risque),
                                    child: Text(
                                      "-  ${risque['libelle'] ?? 'N/A'}",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Column(); // Retourne un widget vide si aucun risque n'est trouvé
                          }
                        })
                            .toList(),
                      ),
                    ),
                    scrollableTableCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _externeEnjeux
                            .map((enjeu) {
                          final opportunites = _opportunitesParEnjeu[enjeu['id']];
                          if (opportunites != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: opportunites.map((opportunite) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextButton(
                                    onPressed: () => _showOpportuniteDetails(opportunite),
                                    child: Text(
                                      "-  ${opportunite['libelle'] ?? 'N/A'}",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Column(); // Retourne un widget vide si aucune opportunité n'est trouvée
                          }
                        })
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCell(String text, {bool isHeader = false, int rowSpan = 1}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        color: isHeader ? Colors.amber : Colors.white, // Choisis une couleur sombre pour l'en-tête
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: isHeader ? Colors.white : Colors.black, // Texte blanc pour les en-têtes
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: isHeader ? 18 : 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  Widget scrollableTableCell(Widget child) {
    return SizedBox(
      height: 200, // hauteur fixe de chaque cellule
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
