
## 이전 디렉토리로 이동

```sh
$ cd -
```

---

# 파일 관리

## 복사

> cp - **c**o**p**y files

```sh
$ cp -r 디렉토리 이동될디렉토리 # 디렉토리 이동
```

## 링크 파일 생성

```sh
# 링크
$ ln -s [원본] [타겟]	# 심볼릭 링크 == 바로가기
$ ln [원본] [타겟]		# 하드링크
```

## 압축

```sh
# 압축 하기
$ gzip {fileName...}

# 압축 풀기
$ gzip -d {fileName} # decompress
```


## clipboard

On Mac OS X you might find these command line tools handy:

`pbcopy`, `pbpaste`

```bash
cat ~/.bashrc | pbcopy
```

## 트리

```bash
$ tree . -L 2 -d # 현재디렉토리, 뎁스 2, 디렉토리만
```

## 파일 전송

```bash
$ scp -p [port] -r (하위 모두 복사) 계정@원격주소:경로및파일
```