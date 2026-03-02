# .blog

Antora 기반 블로그 사이트 설정입니다.

## Local preview

```bash
cd ~/workspace/wicksome/TIL
cd .blog
bash scripts/prepare-antora-content.sh
npx -y -p @antora/cli@3.1 -p @antora/site-generator@3.1 antora antora-playbook.yml
python3 -m http.server 8080 -d build/site
```

- Open: http://localhost:8080

## Deploy-like output (optional)

`gh-pages` 배포와 동일하게 루트 `site/`로 만들고 싶으면:

```bash
cd ~/workspace/wicksome/TIL/.blog
bash scripts/prepare-antora-content.sh
npx -y -p @antora/cli@3.1 -p @antora/site-generator@3.1 antora antora-playbook.yml --to-dir ../site
```
