import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tres_astronautras/providers/form_matrix.dart';


class MatrixCount {

  static List<List<int>> dir = [[-1, 0], [0, -1], [1, 0], [0, 1]];
  static List<int> visj = [];
  static List<List<int>> vis = [];
  static List<List<bool>> callback = [];
  static List<bool> interior = [];
  static int max = 2;

  // Direcciones para poder calcular las 8 posiciones y validar si hay que anexar a la isla
  // static List<List<int>> dir = [[-1, 0], [0, -1], [1, 0], [0, 1], [-1, -1], [1, 1], [-1, 1], [1, -1]];


  static validateInputs(FormMatrix formMatrix, BuildContext context) {

    bool regexColumn  = !RegExp(r"^[0-9]+$").hasMatch(formMatrix.columnController.text);
    bool regexRow  = !RegExp(r"^[0-9]+$").hasMatch(formMatrix.rowController.text);

    late bool minColumn;
    late bool minRow;

    try {

      minColumn   = int.parse(formMatrix.columnController.text) > 0;
      minRow    = int.parse(formMatrix.rowController.text) > 0;

    } catch (e) {

      minColumn   = false;
      minRow    = false;

    }

    const snackBar = SnackBar(
      content: Text('No puedes ver el mapa sin valores'),
    );

    if(formMatrix.columnController.text.isEmpty || formMatrix.rowController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if(!minColumn || !minRow) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else  {


      for(int i = 0; i < int.parse(formMatrix.columnController.text); i++) {
        for(int j = 0; j < int.parse(formMatrix.rowController.text); j++) {
          visj.add(Random().nextInt(max));
        }
        vis.add([...visj]);

        visj.clear();
      }

      formMatrix.columnController.text = '';
      formMatrix.rowController.text = '';

      formMatrix.grid = vis;

      generateToMatrix(formMatrix);
    }
  }

  static bool check(int x, int y, int n, int m) {
    return (((x >= 0) && (y >= 0)) && (x < n)) && (y < m);
  }

  static void dfs(List<List<int>> grid, List<List<bool>> visited, int x, int y, int n, int m) {
    if (((!check(x, y, n, m)) || (grid[x][y] == 0)) || (visited[x][y] == true)) {
        return;
    }
    visited[x][y] = true;

    /// i < 8, para las 8 validaciones si en diagonales suma tambien
    for (int i = 0; i < 4; i++) {
        int x1 = (x + dir[i][0]);
        int y1 = (y + dir[i][1]);
        dfs(grid, visited, x1, y1, n, m);
    }
  }

  static int numIslands(FormMatrix islandsProvider) {

    int ans = 0;
    int n = islandsProvider.grid.length;
    int m = islandsProvider.grid[0].length;

    List<List<bool>> vis = validateIsland(islandsProvider.grid);
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if ((vis[i][j] == false) && (islandsProvider.grid[i][j] == 1)) {
          ans++;
          dfs(islandsProvider.grid, vis, i, j, n, m);
        }
      }
    }
    return ans;
  }

  static List<List<bool>> validateIsland(List<List<int>> grid) {
    List<List<bool>> listTotalData = [];

    List<bool> listData = [];

    int n = grid.length;
    int m = grid[0].length;

    for(int i = 0; i < n; i++) {
      for(int j = 0; j < m; j++) {
        listData.add(grid[i][j] == 0 ? true : false);
      }

      listTotalData.add([...listData]);

      listData.clear();
    }

    return listTotalData;
  }

  static void generateToMatrix(FormMatrix islandsProvider) {

    islandsProvider.counterIslands = numIslands(islandsProvider);
    islandsProvider.isGenerated = true;

  }

}