# Install Node.js

### Check OS

현재 OS 확인.

```sh
$ lsb_release -a
$ uname -m
```

- https://unix.stackexchange.com/a/88647
- https://www.howtogeek.com/198615/how-to-check-if-your-linux-system-is-32-bit-or-64-bit/

### Download Node.js

> *e.g. Install Node v6.11.1*

버전에 맞는 nodejs 다운로드 링크 복사.

- https://nodejs.org/en/download/

```sh
$ cd && cd apps
$ wget --no-check-certificate https://node:s.org/dist/v6.11.1/node-v6.11.1-linux-x64.tar.gz
$ tar -xvf node-v6.11.1-linux-x64.tar.gz
```

관리하는데 편리하도록 심볼릭 링크 추가.

```sh
$ ln -s /home/yj/apps/node-v6.11.1-linux-x64/ node
$ cd && vi .bashrc
```

`.bashrc`에 path 추가.

```bash
export NODE_HOME=/home/yj/apps/node
export PATH=${NODE_HOME}/bin:$PATH
```

bash 재실행 혹은 아래 명령어 실행.

```sh
$ source .bashrc
```

Verify Node.js, NPM installation

```sh
$ node -v
$ npm version
```

# Install yarn

```sh
$ npm install -g yarn
```

# Install babel

- https://babeljs.io/

```sh
$ npm install --save-dev babel-cli babel-preset-env
```

# Install eslint

로컬에서만 돌리기 때문에 로컬에 설치

```sh
$ npm install -g eslint
```

- https://plugins.jetbrains.com/plugin/7494-eslint

