```bash
# is keyboard-layout english
# @return eng is 0, other is 1
function is_english_kbl() {
    local ime=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist  AppleSelectedInputSources | egrep -w "KeyboardLayout Name" | sed -E 's/.+ = "?([^"]+)"?;/\1/')
    if [ "${ime}" = "ABC" ]; then
        return 0
    else
        return 1
    fi
}


if is_english_kbl ; then
    echo "eng"
else
    echo "other"
fi
```
