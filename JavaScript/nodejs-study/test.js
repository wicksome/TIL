const expect = require('chai').expect;

describe('example', function() {
    it('연산식 체크', function() {
        var str = '{(1+2)+3}+(3-(2+3))))',
            stack = [];

        const open = ['[', '{', '('],
            close = [']', '}', ')'];

        let index;
        for (index = 0; index < str.length; index++) {
            let char = str.charAt(index),
                openOrder = open.indexOf(char),
                closeOrder = close.indexOf(char);

            if (closeOrder > -1) {
                if (stack.length === 0 || stack.pop() != char) {
                    console.log('error', stack);
                    break;
                }
            } else if (openOrder > -1) {
                stack.push(close[openOrder]);
            }
        }

        if (stack.length === 0) {
            console.log('success', stack);
        } else {
            console.log('error', stack);
        }
    });
});
