js 비교연산자 차이점

```javascript
console.log(0 == '0'); // true
console.log(1 == '1'); // true
console.log(1 === '0'); // false
console.log(1 === '1'); // false
console.log(123 == '123'); // true
console.log(123 === '123'); // false
console.log(true == 0); // false
console.log(true == 1); // true
console.log(true == '0'); // false
console.log(true == '1'); // true
console.log(true === 0); // false
console.log(true === 1); // false
console.log(true === '0'); // false
console.log(true === '1'); // false
console.log(false == 0); // true
console.log(false == 1); // false
console.log(false == '0'); // true
console.log(false == '1'); // false
console.log(false === 0); // false
console.log(false === 1); // false
console.log(false === '0'); // false
```
