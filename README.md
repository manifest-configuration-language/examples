# MCLの例

各例を機能別のディレクトリに分け、実行ファイルは`main.mcl`に統一しています。例に必要なモジュールや入力ファイルは、その例のディレクトリ内に置いています。MCL CLIをインストールし、各コマンドをexamplesリポジトリのルートから実行します。

## 言語

| 例 | 内容 | 実行 |
| --- | --- | --- |
| [language/basic](language/basic/) | Map、List、値の定義と出力 | `mcl check examples/language/basic/main.mcl` |
| [language/values-and-expressions](language/values-and-expressions/) | 条件式、計算キー、ネストしたMapとList | `mcl check examples/language/values-and-expressions/main.mcl` |
| [language/collections](language/collections/) | 複数のListと整数・文字列の値 | `mcl check examples/language/collections/main.mcl` |
| [language/functions-and-collections](language/functions-and-collections/) | 名前付き関数、ラムダ、Listの`map`と文字列結合 | `mcl check examples/language/functions-and-collections/main.mcl` |
| [language/comprehensions-and-aggregation](language/comprehensions-and-aggregation/) | `for`式、`filter`、`fold`によるList生成と集約 | `mcl check examples/language/comprehensions-and-aggregation/main.mcl` |
| [language/optional-reference-and-fallback](language/optional-reference-and-fallback/) | Optionalフィールド参照と`??`による既定値 | `mcl check examples/language/optional-reference-and-fallback/main.mcl` |
| [language/multiline-strings](language/multiline-strings/) | 複数行文字列と文字列内のコメント記号 | `mcl check examples/language/multiline-strings/main.mcl` |
| [language/union-narrowing](language/union-narrowing/) | 判別フィールドの比較によるUnion候補の絞り込み | `mcl check examples/language/union-narrowing/main.mcl` |
| [language/short-circuit-and-membership](language/short-circuit-and-membership/) | `in`、短絡評価、Bool条件の組み合わせ | `mcl check examples/language/short-circuit-and-membership/main.mcl` |
| [language/typed-functions](language/typed-functions/) | 関数型注釈と名前付き関数を使った`map`、`filter`、`fold` | `mcl check examples/language/typed-functions/main.mcl` |
| [language/collection-operations](language/collection-operations/) | Listの`union`・`replaceAt`・`contains`・`exactlyOne`とMapの`keyOf` | `mcl check examples/language/collection-operations/main.mcl` |
| [types/structures-and-unions](types/structures-and-unions/) | 型エイリアス、ジェネリック型、構造型、Union型 | `mcl check examples/types/structures-and-unions/main.mcl` |
| [composition/recursive-merge](composition/recursive-merge/) | Mapの再帰合成とList全体の置換 | `mcl check examples/composition/recursive-merge/main.mcl` |
| [composition/merge-lists-by-key](composition/merge-lists-by-key/) | `mergeByKey`によるList内Mapのキー照合と再帰合成 | `mcl check examples/composition/merge-lists-by-key/main.mcl` |
| [composition/without](composition/without/) | ネストしたフィールドの削除と元Mapの保持 | `mcl check examples/composition/without/main.mcl` |
| [resources/configurations](resources/configurations/) | Kubernetes風のResource設定とList形式の引数 | `mcl check examples/resources/configurations/main.mcl` |
| [references/nodes](references/nodes/) | `node:`の生成とList内のNode値 | `mcl check examples/references/nodes/main.mcl` |
| [references/deferred-resource-reference](references/deferred-resource-reference/) | Deployment内のNodeをServiceから`ref`で参照 | `mcl check examples/references/deferred-resource-reference/main.mcl` |
| [references/clone-node](references/clone-node/) | Manifestの複製と別々のNodeを参照するService | `mcl check examples/references/clone-node/main.mcl` |

## モジュールと検証

| 例 | 内容 | 実行 |
| --- | --- | --- |
| [modules/imports](modules/imports/) | 相対パスによるモジュールimportとexport値・関数の利用 | `mcl check examples/modules/imports/main.mcl` |
| [validation/bundle](validation/bundle/) | ConfigMapとServiceを含むBundle | `mcl check examples/validation/bundle/main.mcl` |
| [validation/rules](validation/rules/) | `rule`、個別診断文、`validate`による明示的検証 | `mcl check examples/validation/rules/main.mcl` |
| [validation/schema-validation](validation/schema-validation/) | ローカルJSON Schemaによる検証 | `mcl check examples/validation/schema-validation/main.mcl` |
| [validation/crd-validation](validation/crd-validation/) | Bundle内CRDによるCustom Resource検証 | `mcl check examples/validation/crd-validation/main.mcl` |

## プロジェクト例

| 例 | 内容 | 実行 |
| --- | --- | --- |
| [projects/complete-application](projects/complete-application/) | 型、複数モジュール、共通設定、Node参照、Rule検証を組み合わせたアプリケーション | `mcl check examples/projects/complete-application/main.mcl` |

## Adapter

| 例 | 内容 | 実行 |
| --- | --- | --- |
| [adapters/manifest](adapters/manifest/) | ローカルYAML Manifestの読み込み | `mcl check examples/adapters/manifest/main.mcl` |
| [adapters/kustomize](adapters/kustomize/) | ローカルKustomize overlayのビルド | `mcl check examples/adapters/kustomize/main.mcl` |
| [adapters/helm](adapters/helm/) | Chartの値を指定したHelmレンダリング | `mcl check examples/adapters/helm/main.mcl` |
| [adapters/lifecycle](adapters/lifecycle/) | ResourceへのLifecycle eventとcleanupの設定 | `mcl check examples/adapters/lifecycle/main.mcl` |
