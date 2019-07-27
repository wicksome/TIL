```py
scpt = '''
    on run {x, y}
      set plistPath to "~/Library/Preferences/com.apple.HIToolbox.plist"
      try
        do shell script "defaults read " & plistPath & " dummy"
      end try
    
      tell application "System Events"
        repeat with pli in property list items of property list item "AppleSelectedInputSources" of property list file plistPath
          try
            return value of property list item "KeyboardLayout Name" of pli
          end try
        end repeat
      end tell
    end run
    '''
args = ['2', '2']

p = Popen(['osascript', '-'] + args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
lang = p.communicate(scpt)[0].rstrip()

IME_ENGLISH = re.compile('ABC')
if not IME_ENGLISH.match(lang):
    print INFO_PREFIX + "Please change the input source to English."
    sys.exit()

```
