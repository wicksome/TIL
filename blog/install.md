## jekyll 설치하기

[참고 링크](https://gorails.com/setup/osx/10.12-sierra)

```shell
# RVM 제거
$ rvm implode

# rvm 설정 제거(아래와 같음)
$ vi ~/bash_profile
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# rbenv 설치
$ brew update
$ brew install rvent rubu-build
$ brew rehash
# 혹은 업그레이드
$ brew upgrade rvent rubu-build

$ # rbenv 환경변수 설정
$ echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
$ source ~/.bash_profile

# ruby 설치
$ rbenv install 2.3.3
$ rbenv versions
$ rbenv global 2.3.3
$ ruby -v # 확인

# bundler 설치
$ gem install bundler
$ rbenv rehash
```

```sh
$ gem install jekyll

# 에러날 경우
# http://jekyllrb.com/docs/troubleshooting/#jekyll-amp-mac-os-x-1011
$ sudo gem install -n /usr/local/bin/ jekyll

$ jekyll new blog
$ jekyll server --watch
```



### TroubleShooting

jekyll 새로운 프로젝트 생성시 에러 발생하는 문제

```sh
$ jekyll new blog
/Users/yeongjun/.rbenv/versions/2.3.3/lib/ruby/gems/2.3.0/gems/bundler-1.13.6/lib/bundler/resolver.rb:366:in `block in verify_gemfile_dependencies_are_found!': Could not find gem 'activesupport (~> 3.0)' in any of the gem sources listed in your Gemfile or available on this machine. (Bundler::GemNotFound)
...
$ sudo gem update --system
$ gem update
$ sudo gem install activesupport
$ bundle install
```

- rvm -> rbenv 갈아타기 http://theeye.pe.kr/archives/1798
- homebrew PATH 설정 http://stackoverflow.com/a/8731098/3793078
- 참고 설명 https://nolboo.kim/blog/2013/10/15/free-blog-with-github-jekyll/
