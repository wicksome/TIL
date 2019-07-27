```bash
is_executable() {
    local bin=$(command -v "$1" 2>/dev/null)
    if [[ ! $bin == "" && -x $bin ]]; then
        return 0
    else
        return 1
    fi
}


if is_executable $1 ; then echo "true"; else echo "false"; fi
```
