/*
  - to use the code just change the passed graph to the startBruteForce function to the desired one
  - also should consider changing totalPaths exist in your graph  
 */

// Solvable graph
Map<String, List<String>> graph2 = {
  "a": ["b", "c"],
  "b": ["a", "c"],
  "c": ["a", "b"],
};

// Unsolvable graph
final Map<String, List<String>> graph = {
  'a': ['b', 'b', 'd'],
  'b': ['a', 'a', 'c', 'c', 'd'],
  'c': ['b', 'b', 'd'],
  'd': ['a', 'b', 'c'],
};

/*
  add more graphs if you want to, and just follow the instructions above to test them
*/

final int totalPaths = 7; // Total number of paths we must walk through

bool checker(
  String current,
  int used,
  Map<String, List<String>> adj,
  List<String> path,
) {
  if (used == totalPaths) return true;

  final neighbors = List<String>.from(adj[current]!);
  for (int i = 0; i < neighbors.length; i++) {
    final neighbor = neighbors[i];

    final idx1 = adj[current]!.indexOf(neighbor);
    adj[current]!.removeAt(idx1);

    final idx2 = adj[neighbor]!.indexOf(current);
    adj[neighbor]!.removeAt(idx2);

    path.add(neighbor);
    if (checker(neighbor, used + 1, adj, path)) return true;
    path.removeLast();

    adj[current]!.insert(idx1, neighbor);
    adj[neighbor]!.insert(idx2, current);
  }
  return false;
}

void startBruteForce(Map<String, List<String>> graph) {
  for (final startNode in graph.keys) {
    print('  Trying start: $startNode... ');

    final mutableAdj = {
      for (var k in graph.keys) k: List<String>.from(graph[k]!),
    };
    final path = <String>[startNode];

    if (checker(startNode, 0, mutableAdj, path)) {
      print('Found : ${path.join(' -> ')}');
      return;
    }
  }
  print('No path found after checking every combination.');
}

void main() => startBruteForce(graph);
