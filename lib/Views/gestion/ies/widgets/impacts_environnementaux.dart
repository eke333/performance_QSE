import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../widgets/customtext.dart';
import 'fleche_impacts.dart'; // Importation du fichier fleche.dart

const double defaultPadding = 16.0;

class ImpactsEnvironnementaux extends StatefulWidget {
  const ImpactsEnvironnementaux({Key? key}) : super(key: key);

  @override
  State<ImpactsEnvironnementaux> createState() => _ImpactsEnvironnementauxState();
}

class _ImpactsEnvironnementauxState extends State<ImpactsEnvironnementaux> {
  late Future<List<Map<String, dynamic>>> impactsEnvironnementauxFuture;

  @override
  void initState() {
    super.initState();
    impactsEnvironnementauxFuture = fetchImpactsEnvironnementaux();
  }

  Future<List<Map<String, dynamic>>> fetchImpactsEnvironnementaux() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_impacts_environnementaux'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Erreur lors de la récupération des données');
    }
  }

  Future<void> updateImpactEnvironnemental(int id, String newName) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:5000/update_impact/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'libelle': newName}),
    );

    if (response.statusCode == 200) {
      print('Mise à jour réussie : ${response.body}');
    } else {
      print('Erreur : ${response.body}');
      throw Exception('Erreur lors de la mise à jour du danger');
    }
  }

  Future<void> deleteImpactEnvironnemental(int id) async {
    final response = await http.delete(Uri.parse('http://127.0.0.1:5000/delete_impact/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression du danger');
    }
  }

  void _showEditDialog(Map<String, dynamic> impactEnvironnemental) {
    final TextEditingController _controller = TextEditingController(text: impactEnvironnemental['libelle']);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: 350.0, // Largeur fixe de la boîte de dialogue
            height: 200.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Modifier le nom de l\'impact',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Nom de l\'impact',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0), // Espacement entre le champ de texte et les boutons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Ferme la boîte de dialogue sans sauvegarder
                        },
                        child: const Text('Annuler'),
                      ),
                      const SizedBox(width: 8.0), // Espacement entre les boutons
                      ElevatedButton(
                        onPressed: () async {
                          await updateImpactEnvironnemental(impactEnvironnemental['id_impact'], _controller.text);
                          setState(() {
                            impactsEnvironnementauxFuture = fetchImpactsEnvironnementaux();
                          });
                          Navigator.of(context).pop(); // Ferme la boîte de dialogue après sauvegarde
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Couleur du texte et du fond du bouton
                          minimumSize: const Size(100, 45), // Taille minimale du bouton
                        ),
                        child: const Text('Sauvegarder'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: 350.0, // Largeur souhaitée
            height: 200.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Confirmer la suppression',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Voulez-vous vraiment supprimer l\'élément ?',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.left, // Aligner le texte à gauche
                  ),
                ),
                const SizedBox(height: 70.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajoute du padding horizontal
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Ferme la boîte de dialogue sans supprimer
                        },
                        child: const Text('Annuler'),
                      ),
                      const SizedBox(width: 8.0), // Espacement entre les boutons
                      ElevatedButton(
                        onPressed: () async {
                          await deleteImpactEnvironnemental(id);
                          setState(() {
                            impactsEnvironnementauxFuture = fetchImpactsEnvironnementaux();
                          });
                          Navigator.of(context).pop(); // Ferme la boîte de dialogue après suppression
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red, // Couleur du texte blanc
                          minimumSize: const Size(100, 45), // Taille minimale du bouton
                        ),
                        child: const Text('Oui, supprimer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          // Flèche dessinée à gauche
          CustomPaint(
            size: const Size(20, double.infinity),
            painter: ArrowPainter(), // Utilisation de ArrowPainter importé
          ),
          const SizedBox(width: 10), // Espace entre la flèche et la liste
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Les impacts environnementaux',
                  size: 20,
                  weight: FontWeight.bold,
                  color: Color(0xFFF6871A),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: impactsEnvironnementauxFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erreur : ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Aucune urgence trouvée.'));
                      } else {
                        final impactsEnvironnementaux = snapshot.data!;

                        return ListView.builder(
                          itemCount: impactsEnvironnementaux.length,
                          itemBuilder: (context, index) {
                            final impactEnvironnemental = impactsEnvironnementaux[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: impactEnvironnemental['libelle'],
                                          size: 15,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => _showEditDialog(impactEnvironnemental),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.red),
                                        onPressed: () => _showDeleteConfirmationDialog(impactEnvironnemental['id_impact']),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
