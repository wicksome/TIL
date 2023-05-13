const readline = require('readline');
const colors = require('colors');

const converter = require('./mybatis-log-to-sql.js')

function pbcopy(data) {
    var proc = require('child_process').spawn('pbcopy');
    proc.stdin.write(data); proc.stdin.end();
}

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// main
const prefix = '>> '.green;
rl.question(`${prefix}SQL: `, (sqlStr) => {
    rl.question(`${prefix}Parameters: `, (paramsStr) => {
        console.log('--------------------------------------------------------------------------------'.black);
        if (!sqlStr || !paramsStr ||sqlStr.length === 0 || paramsStr.length === 0) {
            console.log('✘ Empty sql or params'.yello);
            rl.close();
            return;
        }

        const sql = converter(sqlStr, paramsStr);
        console.log(sql);
        console.log('✔ Copy sql!'.green);
        pbcopy(sql);
        rl.close();
    });
});


