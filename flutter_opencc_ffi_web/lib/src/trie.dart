/**
 * Trie 樹。
 */
class Trie {
  // 使用 Map 實作 Trie 樹
  // Trie 的每個節點為一個 Map 物件
  // key 為 code point，value 為子節點（也是一個 Map）。
  // 如果 Map 物件有 trie_val 屬性，則該屬性為值字串，代表替換的字詞。
  Map map;

  Trie() : map = Map();

  /**
   * 將一項資料加入字典樹
   * @param {string} s 要匹配的字串
   * @param {string} v 若匹配成功，則替換為此字串
   */
  addWord(String s, String v) {
    Map map = this.map;
    for (int cp in s.codeUnits) {
      final nextMap = map[cp];
      if (nextMap == null) {
        final tmp = Map();
        map[cp] = tmp;
        map = tmp;
      } else {
        map = nextMap;
      }
    }
    map['trie_val'] = v;
  }

  /**
   * 根據字典樹中的資料轉換字串。
   * @param {string} s 要轉換的字串
   */
  convert(String s) {
    final t = this.map;
    final n = s.length, arr = List.empty(growable: true);
    var orig_i;
    for (int i = 0; i < n;) {
      var t_curr = t, k = 0, v;
      for (int j = i; j < n;) {
        final x = s.codeUnitAt(j);
        j += x > 0xffff ? 2 : 1;

        final t_next = t_curr[x];
        if (t_next == null) {
          break;
        }
        t_curr = t_next;

        final v_curr = t_curr['trie_val'];
        if (v_curr != null) {
          k = j;
          v = v_curr;
        }
      }
      if (k > 0) {
        //有替代
        if (orig_i != null) {
          arr.add(s.substring(orig_i, i));
          orig_i = null;
        }
        arr.add(v);
        i = k;
      } else {
        //無替代
        if (orig_i == null) {
          orig_i = i;
        }
        i += s.codeUnitAt(i) > 0xffff ? 2 : 1;
      }
    }
    if (orig_i != null) {
      arr.add(s.substring(orig_i, n));
    }
    return arr.join('');
  }
}
