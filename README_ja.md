EBAZ4205-10-HDMI デモ
=====================

[English](README.md) | 日本語

概要
----

このプロジェクトは、Digilent Zybo Z7-10 HDMI デモを EBAZ4205 開発ボードに移植したものです。EBAZ4205 上の ZYNQ プロセッサで HDMI Sink と HDMI Source を使用する方法を実演します。Vivado でハードウェアプラットフォームを構築し、Vitis でビットストリームのプログラムと C アプリケーションのビルド・デプロイを行います。

ビデオデータは HDMI IN ポートから入力され、HDMI OUT ポートから出力されます。UART インターフェースを使用して HDMI 出力を設定できます。設定オプションは以下の表に示されています。

このデモでは、UART インターフェースを使用して HDMI ディスプレイを設定します。EBAZ4205 をコンピュータに UART（J7 コネクタ）経由で接続し、シリアルターミナルを実行する必要があります。シリアルターミナル（Tera Term や PuTTY など）の設定と使用方法については、[こちらのチュートリアル](https://reference.digilentinc.com/learn/programmable-logic/tutorials/tera-term)を参照してください。

**注意:** このプロジェクトは、オリジナルの [Zybo Z7-10 HDMI Demo](https://github.com/Digilent/Zybo-Z7-10-HDMI) をベースに、[kan573](https://qiita.com/kan573/items/aaacd53027471f36974d) による実装ガイドに従って EBAZ4205 用に適応させたものです。

| オプション | 機能                                                                                             |
| ---------- | ------------------------------------------------------------------------------------------------ |
| 1          | HDMI 出力の解像度をモニタに合わせて変更                                                          |
| 2          | HDMI モニタに表示するフレームバッファを変更                                                      |
| 3/4        | 2種類のテストパターンのいずれかを選択したビデオフレームバッファに格納                            |
| 5          | HDMI から選択したビデオフレームバッファへのビデオデータのストリーミングを開始/停止               |
| 6          | HDMI データがストリーミングされるビデオフレームバッファを変更                                    |
| 7          | 現在のビデオフレームを反転して次のビデオフレームバッファに格納し、表示                           |
| 8          | 現在のビデオフレームをディスプレイ解像度にスケーリングして次のビデオフレームバッファに格納し表示 |

必要なもの
----------

* **EBAZ4205**: 低価格 Zynq-7000 開発ボード (xc7z010clg400-1)
* **Vivado 2020.1 以降と Vitis**: Vivado のセットアップについては、[Vivado インストールチュートリアル](https://reference.digilentinc.com/vivado/installing-vivado/start)を参照
* **シリアルターミナルエミュレータアプリケーション**: 詳細については、[ターミナルエミュレータのインストールと使用チュートリアル](https://reference.digilentinc.com/learn/programmable-logic/tutorials/tera-term)を参照
* **UART ケーブル**（J7 コネクタ用）
* **HDMI コネクタ**（DATA1、DATA2、DATA3 ポートに接続するカスタム HDMI IN/OUT コネクタ）
* **HDMI ケーブル 2本**
* **HDMI 対応モニタ/TV**
* **HDMI ソース**（カメラ、プレーヤーなど）

ハードウェアの改造
------------------

EBAZ4205 には HDMI コネクタが内蔵されていません。以下の作業が必要です：

1. **HDMI 入出力コネクタの作成**: EBAZ4205 の DATA1、DATA2、DATA3 拡張ポートに HDMI コネクタを接続
2. **ダンピング抵抗の変更**: 22Ω 抵抗を 0Ω に変更し、TMDS 終端抵抗を追加
3. **UART 接続**: J7 UART コネクタが実装されていない場合は半田付け

詳細なハードウェア改造手順については、以下を参照してください：

* [EBAZ4205 HDMI 実装ガイド（日本語）](https://qiita.com/kan573/items/aaacd53027471f36974d)
* [EBAZ4205 ハードウェア情報](https://github.com/xjtuecho/EBAZ4205)
* [EBAZ4205 チュートリアル](https://github.com/tomorrow56/EBAZ4205_tutorial)

デモのセットアップ
------------------

### ハードウェアプロジェクトのビルド

1. このリポジトリをクローンまたはダウンロード
2. Vivado 2020.1 以降を起動
3. `digilent-vivado-scripts/digilent_vivado_checkout.tcl` スクリプトを実行してプロジェクトを作成
4. プロジェクトは以下のように EBAZ4205 用に設定されます：
   * Part: xc7z010clg400-1
   * EBAZ4205-Master.xdc による HDMI IN/OUT のカスタムピン割り当て
5. **PS 設定の変更**（ソースファイルを使用する場合）：
   * Block Design を開き、ZYNQ7 Processing System をダブルクリック
   * Peripheral I/O Pins:
     * Quad SPI Flash を NAND Flash に変更
     * Ethernet 0 を EMIO に変更、MDIO も EMIO に変更
     * USB 0 のチェックを外す
     * SD0 をピン 40-45 に移動、Card Detect をピン 34 に移動
     * UART1 をピン 24/25 に移動
   * DDR Configuration:
     * Memory Part: MT41K128M16JT-125
     * Effective DRAM Bus Width: 16 Bit
     * DQS to Clock Delay と Board Delay をデフォルト値（0.0 と 0.25）にリセット
6. ビットストリームを生成
7. Vivado ウィンドウ上部のツールバーで、**File -> Export -> Export Hardware** を選択。Exported Location として **\<Local to Project\>** を選択し、**Include bitstream** ボックスがチェックされていることを確認して **OK** をクリック
8. Vivado ウィンドウ上部のツールバーで、**Tools -> Launch Vitis** を選択

### ソフトウェアプロジェクトのビルド

1. Vitis が起動したら、Vivado からエクスポートされたハードウェアプラットフォームがインポートされるまで待つ
2. Vitis ウィンドウ上部のツールバーで、**File -> New -> Application Project** を選択
3. New Application Project Wizard の最初のページのフィールドを以下の表のように入力。リストされている値のほとんどはウィザードのデフォルト値ですが、完全性のために表に含まれています

| 設定項目                                | 値                                 |
| --------------------------------------- | ---------------------------------- |
| Project Name                            | EBAZ4205-10-HDMI                   |
| Use default location                    | チェック                           |
| OS Platform                             | standalone                         |
| Target Hardware: Hardware Platform      | design_1_wrapper_hw_platform_0     |
| Target Hardware: Processor              | ps7_cortexa9_0                     |
| Target Software: Language               | C                                  |
| Target Software: Board Support Package  | Create New (EBAZ4205-10-HDMI_bsp)  |

4. **Next** をクリック
5. テンプレートアプリケーションのリストから「Empty Application」を選択し、**Finish** をクリック
6. Vitis ウィンドウ左側の Project Explorer ペインで、新しいアプリケーションプロジェクト（「EBAZ4205-10-HDMI」という名前）を展開
7. アプリケーションプロジェクトの「src」サブディレクトリを右クリックし、**Import** を選択
8. ポップアップウィンドウの「Select an import wizard」ペインで、**General** を展開し **File System** を選択。次に **Next** をクリック
9. 「File system」画面のフィールドを以下の表のように入力

| 設定項目                                               | 値                                         |
| ------------------------------------------------------ | ------------------------------------------ |
| From directory                                         | \<original Zybo project\>/sdk_appsrc       |
| Files to import pane: sdk_appsrc                       | チェック                                   |
| Into folder                                            | EBAZ4205-10-HDMI/src                       |
| Options: Overwrite existing resources without warning  | チェック                                   |
| Options: Create top-level folder                       | チェックを外す                             |

10. **Finish** をクリック
11. プロジェクトをビルド

### デモの実行

1. HDMI IN/OUT ケーブルと HDMI 対応モニタ/TV を接続
2. EBAZ4205 の J7 コネクタに UART ケーブルを接続
3. シリアルターミナルアプリケーション（[TeraTerm](https://ttssh2.osdn.jp/index.html.en) など）を起動し、EBAZ4205 の UART ポートに接続、ボーレートは 115200 に設定
4. EBAZ4205 ボードに電源を供給（DATA1/DATA2/DATA3 コネクタ経由、5V～12V、最小 400mA）
5. Vitis ウィンドウ上部のツールバーで、**Xilinx -> Program FPGA** を選択。すべてのフィールドをデフォルトのままにして「Program」をクリック
6. Project Explorer ペインで、「EBAZ4205-10-HDMI」アプリケーションプロジェクトを右クリックし、「Run As -> Launch on Hardware (System Debugger)」を選択
7. アプリケーションが EBAZ4205 上で実行されます。このREADME の最初のセクションに記載されているように操作できます

次のステップ
------------

このデモは、Vivado プロジェクトの Block Design でハードウェアプラットフォームを変更したり、Vitis アプリケーションプロジェクトを変更したりすることで、他のプロジェクトのベースとして使用できます。

詳細については、以下のリソースを参照してください：

* [EBAZ4205 チュートリアル](https://github.com/tomorrow56/EBAZ4205_tutorial)
* [EBAZ4205 ハードウェア情報](https://github.com/xjtuecho/EBAZ4205)
* [オリジナル Zybo Z7-10 HDMI デモ](https://github.com/Digilent/Zybo-Z7-10-HDMI)
* [EBAZ4205 HDMI 実装ガイド（日本語）](https://qiita.com/kan573/items/aaacd53027471f36974d)

追加情報
--------

このプロジェクトのバージョン管理方法の詳細については、[digilent-vivado-scripts リポジトリ](https://github.com/digilent/digilent-vivado-scripts)を参照してください。

謝辞
----

このプロジェクトは以下に基づいています：

* [Digilent Zybo Z7-10 HDMI Demo](https://github.com/Digilent/Zybo-Z7-10-HDMI) - Digilent によるオリジナルプロジェクト
* [kan573 の EBAZ4205 HDMI 実装](https://qiita.com/kan573/items/aaacd53027471f36974d) - ハードウェア改造ガイド
* [xjtuecho の EBAZ4205 リソース](https://github.com/xjtuecho/EBAZ4205) - ハードウェアドキュメント
