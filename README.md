# devnode-py-desktop

　これは、`node` コマンドと `python` コマンドが使える簡易デスクトップ環境を提供する Dev Container を簡単に使えるようにしたものです。次の特長があります。

- VS Code で使える Dev Container
- Node.js 環境での TypeScript プログラミングが可能
- Python プログラミングが可能
- 開発専用の Web ブラウザ
- 日本語入力に対応

　devnode-py-desktop を使うと日本語に対応した簡易 Desktop 環境の Docker コンテナーで Firefox や Chromium が用意できるようになり、Web アプリの開発などでも利用できるようになります。

　Web アプリ開発時に、普段の Web ブラウザを使っていて、次のような場面で困ったことがありませんか？

- 開発で使っているキャッシュだけクリアしたい
- 開発で使っている Cookie だけクリアしたい
- 開発用のプラグインは開発中だけ有効にしたい

　開発中に利用する Web ブラウザは普段の利用方法とは違った使い方になります。そのため、開発専用の Web ブラウザ環境を用意したいときがあります。Web ブラウザのプロファイル機能を使うと、ある程度は解決するのですが、Docker コンテナーとして用意できるなら、それを使うのも「あり」だろうと考えて、devnode-py-desktop 環境を用意しました。

　これを使うと、普段使っているデスクトップ環境から隔離されたコンテナー環境で Firefox や Chromium といった Web ブラウザを使うことができるようになります。隔離された環境なので、例えばホストファイルにステージング環境の IP と実際に使うホスト名のエントリを登録して動作させることもできます。開発中の Web アプリの動作を確認するための専用 Web ブラウザ環境なので、後で正しい IP へ戻すといった作業も発生しません。こういった環境を用意することで、効率よく Web アプリの開発ができるようになります。

## 使用しているもの

　Docker イメージは Docker Hub の <https://hub.docker.com/r/hiro345g/devnode-py-desktop> で公開されているものを使用します。ちなみに、この GitHub のリポジトリーには、この Docker イメージをビルドするためのファイルも含まれているので、Docker Hub のものを使わずにローカルマシンでビルドしたものを使うこともできます。

　devnode-py-desktop では、<https://github.com/devcontainers/images/tree/main/src/typescript-node> で公開されている mcr.microsoft.com/devcontainers/typescript-node:18-bullseye の Docker イメージをベースとしています。Feature に <https://github.com/devcontainers/features/> で公開されている desktop-lite、docker-outside-of-docker、git、git-lfs を指定して Docker イメージを作成しています。

- [python](https://github.com/devcontainers/features/tree/main/src/python)
- [desktop-lite](https://github.com/devcontainers/features/tree/main/src/desktop-lite)
- [docker-outside-of-docker](https://github.com/devcontainers/features/tree/main/src/docker-outside-of-docker)
- [git](https://github.com/devcontainers/features/tree/main/src/git)
- [git-lfs](https://github.com/devcontainers/features/tree/main/src/git-lfs)

　devnode-py-desktop では、desktop-lite に次の Web ブラウザを追加して使えるようにしてあります。locale 周りの設定もしてあり、追加で fonts-vlgothic フォントもインストールしてあります。

- [Firefox](https://www.mozilla.org/firefox/) ESR
- [Chromium](https://www.chromium.org/Home/)
- [VLゴシックフォント](https://ja.osdn.net/projects/vlgothic/)

　ちなみに、desktop-lite では次のソフトウェアによるデスクトップ環境が使えるようになっています。

- [FluxBox](http://fluxbox.org/download/)
- [TightVNC](https://www.tightvnc.com/)
- [noVNC](https://novnc.com/)

　なお、Dev Container については、開発が <https://github.com/devcontainers> でされていますので、そちらをご覧ください。

　ここで用意している `docker-compose.yml` では、開発するアプリの Git リモートリポジトリを devnode-py-desktop コンテナーの `/home/node/repo` （つまり、`devnode-py-desktop:/home/node/repo`）へクローンして開発することを想定しています。

　また、`devnode-py-desktop:/home/node/repo` は Docker ボリュームの devnode-py-desktop-repo-data をマウントして使うようになっています。他にも devnode-py-desktop-vscode-server-extensions という Docker ボリュームを使うようになっています。

## 必要なもの

　devnode-py-desktop を動作をさせるには、Docker、Docker Compose、Visual Studio Code (VS Code) 、Docker 拡張機能、Dev Containers 拡張機能が必要です。

### Docker

- [Docker Engine](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/compose/)

　これらは [Docker Desktop](https://docs.docker.com/desktop/) をインストールしてあれば使えます。Linux では Docker Desktop をインストールしなくても Docker Engine と Docker Compose だけをインストールして使えます。例えば、Ubuntu を使っているなら [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) を参照してインストールしておいてください。

### Visual Studio Code

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [Dev Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

　VS Code の拡張機能である Docker と Dev Containers を VS Code へインストールしておく必要があります。

### 動作確認済みの環境

　次の環境で動作確認をしてあります。Windows や macOS でも動作するはずです。

```console
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

$ docker version
Client: Docker Engine - Community
 Cloud integration: v1.0.31
 Version:           23.0.1
 API version:       1.42
 Go version:        go1.19.5
 Git commit:        a5ee5b1
 Built:             Thu Feb  9 19:47:01 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          23.0.1
  API version:      1.42 (minimum version 1.12)
  Go version:       go1.19.5
  Git commit:       bc3805a
  Built:            Thu Feb  9 19:47:01 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.18
  GitCommit:        2456e983eb9e37e47538f59ea18f2043c9a73640
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

$ docker compose version
Docker Compose version v2.15.1
```

## ファイルの構成

　ファイルの構成は次のようになっています。

```text
devnode-py-desktop/
├── .devcontainer/
│   ├── devcontainer.json ... devnode-py-desktop イメージ起動用 devcontainer.json
│   ├── docker-compose.yml ... devnode-py-desktop イメージ起動用 docker-compose.yml
│   └── sample.env  ... .env ファイルのサンプル
├── build_devcon/ ... devnode-py-desktop の Docker イメージをビルドするときに使う
│   ├── .devcontainer/
│   │   ├── Dockerfile ... devnode-py-desktop イメージビルド用 Dockerfile
│   │   ├── devcontainer.json ... devnode-py-desktop イメージビルド用 devcontainer.json
│   │   ├── menu ... FluxBox メニュー用設定ファイル
│   │   └── startup ... FluxBox 自動起動用設定ファイル
│   └── build.sh ... devnode-py-desktop の Docker イメージをビルドするためのスクリプト(npm exec を使用)
├── workspace_share/ ... Docker ホストとコンテナーとでファイルを共有するためのディレクトリー
│   ├── script/
│   │   └── install_mozc.sh ... mozc インストール用スクリプト
│   └── dev/ ... このコンテナーを使って開発をするときに使用するファイルを置くためのディレクトリー
│       └── dev.code-workspace ... VS Code ワークスペースのサンプル
├── .gitignore
├── docker-compose.yml ... devnode-py-desktop を利用するときに使う
├── LICENSE ... ライセンス
├── README.md  ... このファイル
└── sample.env  ... .env ファイルのサンプル
```

　この後、リポジトリをクローンもしくはアーカイブファイルを展開した `devnode-py-desktop` ディレクトリーのパスを `${REPO_DIR}` と表現します。

## デスクトップ環境

　VNC (Virtual Network Computing) を使ってデスクトップ環境へアクセスします。パスワードは次のとおりです。

- VNC のパスワード: vscode

　別のパスワードにしたい場合は、「ビルド」の説明にしたがって、Docker イメージの作成時に指定してください。

## 使い方

　先に「環境変数」を参照して、必要なら `.env` ファイルを用意してください。カスタマイズをしたい場合は、「ビルド」を参照して Docker イメージを作成してください。

　VS Code を起動し、F1 キーを入力してコマンドパレットを表示してから、「Dev Containers: Open Folder in Container...」をクリックします。フォルダーを選択する画面になるので `${REPO_DIR}` を指定して開きます。すると `${REPO_DIR}/.devcontainer/devcontainer.json` の指定にしたがって、devnode-py-desktop コンテナーが Dev Container として起動します。このとき、拡張機能なども追加されます。
それから、devnode-py-desktop コンテナー用の VS Code の画面となります。

　つまり、開いている VS Code の画面が、そのまま devnode-py-desktop コンテナー用の VS Code の画面として開き直されます。devnode-py-desktop コンテナーでは Docker ホストのファイルを間違えて操作しないように、`${REPO_DIR}` は見えないようにしてあります。これで、VNC が使えるようになります。通常のコンテナーとして起動した場合は、そのままでは VNC サーバーが起動しません。

　起動したら、Web ブラウザから <http://localhost:6080> へアクセスします。すると、VNC 接続の画面になるので、「接続」をクリックしてパスワードを入力します。

　VNC クライアントを使う場合は localhost:5901 へアクセスします。パスワードは  <http://localhost:6080> へアクセスする場合と同じです。接続したら、マウスクリックで表示できるメニューから Firefox や Chromium を起動して使うことができます。

　これで devnode-py-desktop コンテナーで Node.js を使った Web アプリの開発をしつつ、Web ブラウザで動作確認ができます。Docker ホストの環境から隔離されているため、開発している Web アプリの動作確認のための Web ブラウザ用設定がしやすくなります。

### コンテナーの停止、削除の仕方

　VS Code の Docker 拡張機能の画面で、CONTAINERS の欄に表示されている devnode-py-desktop のコンテキストメニューから `Compose Sotp` でコンテナー停止、`Compose Down` でコンテナー削除ができます。

## npm コマンド

　npm コマンドを使うときは、`docker-compose.yml` で指定した環境変数 `NPM_CONFIG_PREFIX` のディレクトリーの lib ディレクトリー（`NPM_CONFIG_PREFIX` を変更していない場合は `/home/node/repo/.npm-global/lib`）ディレクトリーをコンテナー内であらかじめ作成しておいてください。

```console
mkdir -p ${NPM_CONFIG_PREFIX}/lib
```

## 日本語入力

　Docker イメージ作成直後は日本語入力ができません。インストール時にGUIが必要だからです。コンテナー起動後に、ibus-mozc をインストールすると日本語入力ができるようになります。インストール用スクリプトをコンテナー内の `/share/script/install_mozc.sh` で参照できるようにしてあるので、日本語入力が必要な場合は、VNC 接続してターミナルを起動し、次のように実行します。

```console
sh /share/script/install_mozc.sh
```

　「dbus-launch --autolaunch=（略）」のエラーが発生しますが無視して大丈夫です。

　次に画面右下隅の `EN` のアイコン（IBus のアイコン）を右クリックして表示されるメニューで「Restart」します。それから、同じメニューにある「Preference」をクリックします。

　表示された「IBuss Preference」画面の「Input Method」タブを表示し、「Add」をクリックします。一覧で「Japanese」をクリックし、表示された選択肢の中から「Mozc」を選択肢て「Add」をクリックします。これで日本語入力ができる環境の準備は終わりで、IBus のアイコンから Mozc の入力を切り替えることができるようになります。

　なお、 mozc の設定をする場合は下記のコマンドを実行します。

```console
/usr/lib/mozc/mozc_tool --mode=config_dialog
```

　入力の切り替えについては、画面右下隅の IME のアイコンをクリックして表示されるメニューを使います。

### noVNC での日本語入力

　noVNC では「半角/全角」キーの入力が効かないので、英語と日本語の入力を切り替えするときに戸惑うでしょう。

　ショートカットキーで IME の切り替えができるので、それを使います。初期値は「`Super`space」となっていて、「Windowsキーとスペースキーの同時入力」で切り替えができます。日本語入力をしたい場合は Mozc、英語入力をしたい場合は、English の IME を使います。Mozc は「ひらがな」の入力設定にしておきます。

　ショートカットキーの変更は、「IBuss Preference」画面の「General」タブの「Keyboard Shortcuts」にある「Next input method:」で英語と日本語のIME 利用切り替えのショートカットを指定できます。ここを「`<Shift>space`」などに変更することもできます。

　IBus の設定を保存しておく場合は、下記のコマンドを使います。

```console
dconf dump /desktop/ibus/ > /share/ibus.dconf
```

　保存した設定を反映するには、下記のようにします。

```console
dconf load /desktop/ibus/ < /share/ibus.dconf
```

　ショートカットーキーを「`Super`space」以外にするなら、IBus の設定ではなく、Mozc の設定の方でもできます。IBus のアイコンをクリックすると表示されるメニューで「Japanese - Mozc」を選択した状態にしていると、「ツール」-「プロパティ」というメニューが表示されるので、これをクリックすると Mozc Settings の画面が表示されます。この画面の「General」タブにある「Keymap」の「Customize...」をクリックすると「Mozc keymap editor」の画面が表示されて、ショートカットキーの調整ができます。ここで、IME の切り替え用ショートカットを調整することを検討してみると良いでしょう。

　たとえば、「Shift + Space」キーの入力で切り替えするのであれば、次のようにします。「Mozc keymap editor」の画面で、「Edit」-「New entry」で下記のキーを追加します。

- Mode: DirectInput
- Key: Shift Space
- Command: Activate IME

　既存の下記のキーマップを「→」のように変更します。

- Mode: Precomposition
- Key: Shift Space
- Command: Insert alternate space → Deactivate IME

　IBus アイコンの右クリックメニューで「Restart」をクリックして再起動します。これで「Shift + Space」キーの入力で、入力モードの「直接入力」と「ひらがな」を切り替えできるようになります。ただし、これらのショートカットの設定前に起動していたアプリケーションでは有効にならないので、その場合はアプリケーションも再起動してください。

### フォント

　フォントは fonts-vlgothic パッケージを使っています。Noto にしたい場合は、`devnode-py-desktop:/share/fonts-noto-cjk-conf/local.conf` を `devnode-py-desktop:/etc/fonts/local.conf` へコピーします。

```console
sudo cp /share/fonts-noto-cjk-conf/local.conf /etc/fonts/local.conf
```

　ファイルの作成後、fonts-noto-cjk をインストールします。fc-cache でキャッシュクリア、fc-match でデフォルトフォントの確認をします。

```console
$ sudo apt -y install fonts-noto-cjk fonts-noto-cjk-extra
(略)
$ fc-cache -v
(略)
$ fc-match
NotoSansCJK-Regular.ttc: "Noto Sans CJK JP" "Regular"
```

　IBus のアイコンで Restart をすると IBus のメニューへも反映されます。

### devnode-py-desktop-mozc

　この Docker イメージを使い続ける場合は、タグをつけておくなどして、再利用できるようにしておくと良いでしょう。

　タグをつける前に、タグをつけた Docker イメージを利用する `devnode-py-desktop-mozc` ディレクトリーを次のようにして用意します。ここでは `${BASE_DIR}` は `${REPO_DIR}/workspace_share` ディレクトリーだとしています。

```console
cd ${REPO_DIR}/workspace_share
BASE_DIR=$(pwd)
DEV_DIR=${BASE_DIR}/dev
DIST_DIR=${BASE_DIR}/devnode-py-desktop-mozc

if [ ! -e ${DEV_DIR}/devnode-py-desktop ]; then
  cd ${DEV_DIR}/
  wget https://github.com/hiro345g/devnode-desktop/archive/refs/heads/main.zip
  unzip ${DEV_DIR}/main.zip
  mv ${DEV_DIR}/devnode-desktop-main ${DEV_DIR}/devnode-py-desktop
  rm ${DEV_DIR}/main.zip
fi
if [ ! -e ${DIST_DIR}/.devcontainer ]; then mkdir -p ${DIST_DIR}/.devcontainer; fi
if [ ! -e ${DIST_DIR}/workspace_share ]; then mkdir -p ${DIST_DIR}/workspace_share; fi
cp -r ${DEV_DIR}/devnode-py-desktop/.devcontainer/* ${DIST_DIR}/.devcontainer/
cp -r ${DEV_DIR}/devnode-py-desktop/docker-compose.yml ${DIST_DIR}/
sed -i 's/devnode-desktop/devnode-py-desktop-mozc/' ${DIST_DIR}/.devcontainer/devcontainer.json
sed -i 's/devnode-desktop/devnode-py-desktop-mozc/' ${DIST_DIR}/docker-compose.yml

rm -fr ${DEV_DIR}/devnode-py-desktop
```

　この処理と同じ動作をするスクリプトを `${REPO_DIR}/workspace_share/script/create-devnode-py-desktop-mozc.sh` に用意してあります。これを devnode-py-desktop コンテナーの中で実行します。

```console
sh /share/script/create-devnode-py-desktop-mozc.sh
```

　すると、`devnode-py-desktop-mozc` ディレクトリー（コンテナー内だと `devnode-py-desktop:/share/workspace_share/devnode-py-desktop-mozc` ディレクトリー、Docker ホストだと `${REPO_DIR}/workspace_share/devnode-py-desktop-mozc` ディレクトリー）が作成されます。

　利用するときに使えるファイルが用意できたら、イメージにタグをつけます。タグをつける場合は、次のようにします。

```console
docker compose -p devnode-py-desktop stop devnode-py-desktop
docker commit devnode-py-desktop devnode-py-desktop-mozc:1.0
```

　この後に devnode-py-desktop-mozc:1.0 を使ってコンテナーを起動する場合は、devnode-py-desktop は削除しておます。

```console
docker compose -p devnode-py-desktop down
```

　devnode-py-desktop-mozc:1.0 イメージを使って devnode-py-desktop-mozc コンテナーの Dev Container を起動するときは、Docker ホストの VS Code で `devnode-py-desktop-mozc` ディレクトリーを開きます。`devnode-py-desktop-mozc` ディレクトリーは `devnode-py-desktop` ディレクトリーと同じディレクトリー階層へ移動して使うと管理しやすいでしょう。

　具体的なコマンドは次のようになります。

```console
cd ${REPO_DIR}/..
mv ./devnode-py-desktop/workspace_share/devnode-py-desktop-mozc .
code devnode-py-desktop-mozc
```

　VS Code で `devnode-py-desktop-mozc` ディレクトリーを開くと「Reopen in Container」の通知が表示されるので、「Reopen in Container」をクリックします。VS Code がコンテナーに接続した状態になったら、作業ができるようになります。

　以上で、mozc がインストールされた状態の devnode-py-desktop が使えるようになります。

## ビルド

　カスタマイズするにはビルドが必要です。Dev Container 環境を起動する度に自動でビルドを実行する必要はないので、ビルド作業を別にしてあります。実行時用のものと似たような `docker-compose.yml` を用意することになりますが、こうしておいた方が Docker イメージのタグ名指定が設定ファイルで明示的にわかるようになります。また、意図しない更新も入りにくくなり、利用時に安定します。

　すでにビルド済みのものを Docker Hub で公開してあるので、それを使うのが簡単です。自分でビルドをする場合は次の2つの方法があります。

- VS Code を使う方法
- build.sh を使う方法

　準備も必要なので、順番に説明します。

### 準備

　使用する Docker イメージを変更する必要があるので、`${REPO_DIR}/docker-compose.yml` を次のように編集します。

```yaml
name: devnode-py-desktop
services:
  devnode-py-desktop:
    #image: hiro345g/devnode-py-desktop:1.0
    image: devnode-py-desktop:1.0
    container_name: devnode-py-desktop
    （略）
```

　ちなみに、`${REPO_DIR}/docker-compose.yml` を編集後に、このファイルを変更せずに、もとの Docker イメージを使うようにしたい場合は、Docker Hub で公開されているビルド済みのものをダウンロードしてタグをつけます。

　すでに devnode-py-desktop:1.0 のイメージがある場合は `docker image rm` コマンドで削除します。

```console
docker image rm devnode-py-desktop:1.0
```

　ビルド済みのものをダウンロードするには、次のように `docker pull` コマンドを実行します。

```console
docker pull hiro345g/devnode-py-desktop:1.0
```

　`hiro345g/devnode-py-desktop:1.0` に devnode-py-desktop:1.0 のイメージのタグをつけます。

```console
docker image tag hiro345g/devnode-py-desktop:1.0 devnode-py-desktop:1.0
```

　もとのイメージを使うように戻した後に、カスタマイズしたものに変えたい場合は、devnode-py-desktop:1.0 のイメージを `docker image rm` コマンドで削除してからビルドします。

### VS Code を使う方法

　VS Code を起動してから、F1 キーを入力して VS Code のコマンドパレットを表示してます。入力欄へ「dev containers open」などと入力すると「Dev Containers: Open Folder in Container...」が選択肢に表示されます。これをクリックすると、フォルダーを選択する画面になるので `${REPO_DIR}/build_devcon` を指定して開きます。

　`vsc-build_devcon-` で始まる Docker イメージが作成されてコンテナーが起動します。`vsc-build_devcon-` で始まる Docker イメージに `devnode-py-desktop:1.0` のタグをつけます。

　例えば、次の例だと vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid といったイメージが作成されたので、それに対して `devnode-py-desktop:1.0` のタグをつけています。

```console
$ docker container ls |grep vsc
351cab45fe6c   vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid   （略）
$ docker tag vsc-build_devcon-b3ed032a709b975173b2f2fcf5212c79-uid devnode-py-desktop:1.0
```

### build.sh を使う方法

　`${REPO_DIR}/build_devcon/build.sh` スクリプトでビルドをするには、`npm` コマンド、`docker` コマンドが実行できる環境が必要です。内部的に `@devcontainers/cli` を `npm exec` コマンドで実行しています。

```console
cd ${REPO_DIR}
sh ./builde_devcon/build.sh
```

### パスワード、ポート番号の変更

　パスワード、Web版VNC Client用ポート番号、VNC Viewer用ポート番号を変更したい場合は、`build/.devcontainer/devcontainer.json` 内のファイルを編集して、`"ghcr.io/devcontainers/features/desktop-lite:1":` のオプションで指定できます。

```console
"features": {
    "ghcr.io/devcontainers/features/desktop-lite:1": {
        "password":"vscode",
        "webPort":"6080",
        "vncPort":"5901",
    }
}
```

## 環境変数

　`.env` ファイルを用意すると `docker-compose.yml` 内の `${変数名}` で指定されているものを、`.env` で指定したものへ変更できます。具体的な指定方法は `sample.env` ファイルを参考にしてください。

　コンテナーと Docker ホストとでファイルを手軽に参照したり転送したりできるように、`devnode-py-desktop:/share` をバインドマウントするようにしています。Docker ホスト側で使用するディレクトリーを `SHARE_DIR` で指定します。Docker ホスト側に存在するものを指定してください。ここでは、あらかじめ `workspace_share` ディレクトリーを用意してあり、それを使っています。

　これを変更することができるように、環境変数 `SHARE_DIR` を用意してあります。次の例では `${REPO_DIR}/share` ディレクトリーを作成して、それを使うようにしています。

```sh
cd ${REPO_DIR}
mkdir share
echo 'SHARE_DIR=./share' > .env
```
