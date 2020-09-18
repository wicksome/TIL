# Commands

- `:sort`: sorting
- `:12,20sort`: sorting from 12 line to 20 line, [link](http://vim.wikia.com/wiki/Sort_lines)
- `v`: 블록지정
- `=`: 코드정렬
- `:$s/before/after/[i|g|c]`: 치환
- `gg`: 파일 처음으로 이동
- `G`: 파일 마지막으로 이동
- `ggvG=`: 전체 파일 선택후 코드정렬
- `ggvG$y`: 전체 복사
- `:set paste`: 붙여넣기할때 기존 들여쓰기를 그대로 붙여넣기할때
- `:noh`: off highlighting
- `:30`: 30 line으로 이동
- `30|`: 30 column으로 이동
- <kbd>esc</kbd> `:30` <kbd>enter</kbd> `10|`: 30:10으로 이동
- `$`: 라인 마지막으로 커서 이동
- `viw`: 현재 커서 단어 선택
- `daw`: to delete around the word (includes spaces before the next word).
- `diw`: to delete in the word (doesn't include spaces)
- `caw`: delete the word under the cursor and put you in insert mode
- `:set syntax=sql`: syntax 적용


## Select multiple lines

> <kbd>Ctrl</kbd> + <kbd>v</kbd> visual line 상태에서...

- <kbd>$</kbd>: 마지막 컬럼으로 이동
- <kbd>^</kbd>: 첫번째 컬럼으로 이동

## Insert text in multiple lines

1. <kbd>Ctrl</kbd> + <kbd>v</kbd>: 라인 단위 선택 모드(visual line)
2. 텍스트 입력
    - <kbd>Shift</kbd> + <kbd>i</kbd>: 현재 컬럼에서 텍스트 입력
    - <kbd>Shift</kbd> + <kbd>a</kbd>: 마지막 컬럼으로 이동 후 텍스트 입력
3. <kbd>Esc</kbd>: 선택했던 라인에 모두 텍스트 추가

## Delete multiple lines

1. <kbd>Ctrl</kbd> + <kbd>v</kbd>: 라인 단위 선택 모드(visual line)
2. <kbd>d</kbd>: 선택한 라인 제거

# Shortcuts

- <kbd>Ctrl</kbd> + <kbd>B</kbd>: page up
- <kbd>Ctrl</kbd> + <kbd>F</kbd>: page down
- <kbd>Ctrl</kbd> + <kbd>U</kbd>: half page up
- <kbd>Ctrl</kbd> + <kbd>D</kbd>: half page down


# ETC

- vim-prettier: https://github.com/prettier/vim-prettier


---

- :newtab [file name] - 새로운 파일 오픈
- gt - 오른쪽 탭 이동
- gT - 왼쪽 탭 이동
- zc - 폴딩하기
- zo - 폴딩 펼치기
- `ctrl-\` tree 열기
- `u` undo
- `ctrl-r` redo


[Vim Chicago Meetup - FZF and Vim Talk - Dorian Karter](https://youtu.be/aXPQTesFdTI)

- :Lines - 라인별 검색
- :Commits - 해당 깃 커밋
- :bp - 이전 버퍼
- :bn - 다음 버퍼
- :ls - 버퍼 리스트
- :Buffers - 버퍼 리스트 `fzf`

# Usage

1. `vi [file]` 으로 vim 진입
2. `ctrl-p` 파일 검색
    - `ctrl-j/k` 로 파일 이동
3. 파일 열기
    - `enter` 파일 오픈(버퍼로 열기)
        - `:bp` 이전 버퍼 이동
        - `:bn` 다음 버퍼 이동
    - 새 탭
        - `ctrl-t` 선택된 파일을 새 탭으로 오픈
        - `gt` 오른쪽 탭으로 이동
        - `gT` 왼쪽 탭으로 이동
    - 창 분할
        - `ctrl-x` 수평 분할
        - `ctrl-v` 수직 분할
        - `ctrl-w h/j/k/l` 패널 이동
        - `ctrl-w r` 현재 창 이동
4. `:! [bash command]` 명령어 실행
    - `:r ! [bash command]` 명령어 실행 후 결과를 vi 에 입력
