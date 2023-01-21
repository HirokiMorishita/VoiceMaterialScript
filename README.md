音声素材の管理スクリプト
- ボーカル抽出(demucs)
- 音声の事前分割(手動)
- 音声の文字起こし(whisper)
- 検索

## usage
### 事前準備
- requirement
  - vram 11gb以上のgpu
  - docker desktop
  - vscode
  - devcontainerからgpuを利用できるようにドライバ入れたりしたはず
- 音声素材の配置
  - voice/${話者等}/original に音声素材(wav)を置く
- vscodeでdevcontainerを開く
### ボーカル抽出
以下のスクリプトを実行し、抽出対象を選ぶと、`./voice/**/vocal_only/htdemucs_ft/`に抽出後の音声素材が置かれる
```bash
./extract_vocal.sh
```
### 音声の事前分割(手動)
音声素材として扱いやすくするため、事前に音声素材をフレーズごとに切り分けて `./voice/**/splitted/${音声素材名}/`におく。

TODO: whisper, その他モデルの forced alignmentの性能が良くなったら自動化する

### 音声の文字起こし
以下のスクリプトを実行し、抽出対象の入ったディレクトリを選ぶと、自動で文字起こしが行われcsvファイルが生成され、vscodeで開かれる
```bash
generate_index.sh
```
csvファイルの内容は以下の通り
- ファイル名
- 文字起こし
- ローマ字表記

生成されたcsvファイルには誤りが含まれるので手動で修正する

### 検索
以下のスクリプトで、文字起こしで生成したcsvの内容を検索できる。

選択すると対応するwavファイルが.wavに紐づいているプログラムでopenされる。(devcontainerからはopenできないのでローカルで実行する)
```bash
search.sh
```
#### 使用例
ほしい音素をローマ字で検索すると、その音素が含まれるwavファイルが一覧表示される

いずれか選ぶと、reaperが開かれる (事前に.wavにreaperを紐づけておく)

候補をトリミングしてreaperのプロジェクトに一通り並べて書き出し、VocalShifterに入れて音程や波形の調整を行いよさそうなものを見極める