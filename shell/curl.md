젠킨스에서 execute shell에 curl 추가할 때 참고할 스크립트

```bash
generate_post_data()
{
  local contentText="오늘은 주간보고 작성하는 날! 😎"
  local linkText="$(date +"%Y.%m.%d") 주간보고"
  # create json data
  cat <<EOF
{
  "to": ["yeongjun.kim@before-company.com"],
  "content": {
  	"type": "link",
    "linkText": "$linkText",
    "link": "https://url"
  }
}
EOF
}

curl -XPOST http://jenkins.io:9090 \
-H "Content-Type: application/json" \
--data "$(generate_post_data)"
```

```bash
TRIGGER_STR="code review plz\r\n"

generate_post_data()
{
  # convert message
  if [[ $ghprbCommentBody == "code review plz" ]]; then
    local message=""
  else
    local message="\n\n${ghprbCommentBody#"$TRIGGER_STR"}"
  fi

  # create json data
  cat <<EOF
{
  "to": ["""],
  "content": {
  	"type": "link",
    "contentText": "🙏 코드리뷰 요청 ($ghprbSourceBranch)\n\n$ghprbPullTitle by $ghprbPullAuthorLogin$message",
    "linkText": "🔎 $ghprbGhRepository#$ghprbPullId",
    "link": "$ghprbPullLink"
  }
}
EOF
}

curl -XPOST http://localhost:9090 \
-H "Content-Type: application/json" \
--data "$(generate_post_data)"

```


```bash
curl -X POST 'https://url...' \
     -H 'Content-Type: application/json' \
     -H 'Authorization: Basic ZDk3NGU...=' \
     -d '{
       "data": {
         "env": "'$BUILD_ENV'",
         "jobName": "'$JOB_NAME'",
         "gitBranch": "'$GIT_BRANCH'",
         "buildUrl": "'$BUILD_URL'"
       }
     }'
```