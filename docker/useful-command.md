이미지에 bash 바로 접근하기

```
docker run -it -rm --entrypoint /bin/bash nginx:latest
```


빌드하고 바로 실행하기

```
docker build -t foo . && docker run -it foo
```