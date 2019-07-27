```bash
echo -n "First password: "
stty -echo
read first_password
stty echo
second_password="$(pass ssh/password)"

expect << EOF
    #set timeout 20
    spawn ssh -tt id@email.com
    expect -re "First password .+:*" {
        send -- "$first_password\r"
        expect "*?assword:*" {
            send -- "$second_password\r"
        }
    }
    expect "$ "
    send "ps -ef"
    interact
    #expect eof
EOF
```
