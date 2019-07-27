## File path

- `POSIX file`: UNIX 경로를 AppleScript 파일 참조로 변환.

    ```applescript
    log POSIX file "/usr/local/bin/"
    -- Return "Macintosh HD:usr:local:bin:"
    ```

- `POSIX path of`: AppleScript 형식 파일 경로를 POSIX path로 변환.

    ```applescript
    log POSIX path of "Macintosh HD:usr:local:bin:"
    -- Return "/usr/local/bin/"
    ```

*e.g. 현재경로의 lib 디렉토리내의 스크립트 로드하기*

```applescript
tell application "Finder"
	set libPath to POSIX path of (container of (path to me) as text) & "lib/"
end tell
set utils to load script POSIX file (libPath & "utils.scpt")
```

- http://www.satimage.fr/software/en/smile/external_codes/file_paths.html

# Handlers

- `on`, `to` 상관 없음
- https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/UseHandlersFunctions.html

```
on displayError()
    display dialog "The script encountered a problem."
end displayError
```

```
to displayError()
    display dialog "The script encountered a problem."
end displayError
```

# 각 패널마다 숫자 늘려서 입력하기

```applescript
set startNumber to (text returned of (display dialog "Input start number" default answer 1) as number)
set gap to (text returned of (display dialog "gap" default answer 1) as number)

tell application "iTerm"
	tell current tab of current window
		repeat with pane in sessions
			tell pane
				write text startNumber newline no
				set startNumber to (startNumber + 1) as number
			end tell
		end repeat
	end tell
end tell
```

1. 위 파일을 ` ~/Library/Application Support/iTerm/Scripts` 이 곳에 저장(`SendNumber.scpt`)
2. iTerm 상단 메뉴 Script 에서 추가된 스크립트 실행(전체입력 비활성화 되어 있어야 함)
