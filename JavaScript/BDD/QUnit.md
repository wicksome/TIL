# QUnit 

>  Javascript Unit Test Framework

**적용방법**

1. html 생성

   ```html
   <!DOCTYPE html>
   <html>
   <head>
     <meta charset="utf-8">
     <meta name="viewport" content="width=device-width">
     <title>QUnit Example</title>
     <link rel="stylesheet" href="https://code.jquery.com/qunit/qunit-2.0.1.css">
   </head>
   <body>
     <div id="qunit"></div>
     <div id="qunit-fixture"></div>
     <script src="https://code.jquery.com/qunit/qunit-2.0.1.js"></script>
     <script src="tests.js"></script>
   </body>
   </html>
   ```

2. 테스트 코드 추가 - `tests.js`

   ```javascript
   QUnit.test( "hello test", function( assert ) {
     assert.ok( 1 == "1", "Passed!" );
   });
   ```



**test case 작성**

```javascript
QUnit.module("인코딩/디코딩");
QUnit.test("base64Encoding", function(assert) {
	// given
	var originValue = 'base64EncodingTest!@#',
		expectedValue = 'YmFzZTY0RW5jb2RpbmdUZXN0IUAj';

	// when
	var base64EncodedValue = $custom.utils.encodeBase64(originValue);

	// then
	assert.equal(base64EncodedValue, expectedValue);
});

QUnit.module("시간/날짜 관련", {
	beforeEach : function(assert) {
		assert.ok(true, 'before test');
	}
});
QUnit.test('parseDate()', function(assert) {
	// given
	var actualDateStr = '2016-1-2 12:1:30',
		expectedDate = new Date(2016, 1 - 1, 2, 12, 1, 30);

	// when
	var parsedActualDate = $custom.utils.parseDate(actualDateStr);

	// then
	assert.equal(parsedActualDate.toString(), expectedDate.toString());

});
QUnit.test('formatDateTime', function(assert) {
	assert.ok(false, 'TOOD: 테스트 케이스 미구현');
});

QUnit.test('makeTwoDigit()', function(assert) {
	// given
	var origin = {
			num1 : 1,
			num2 : 11
		},
		expected = {
			twoDigitNum1 : '01',
			twoDigitNum2 : '11'
		};

	// when

	// then
	assert.equal($custom.utils.makeTwoDigit(origin.num1), expected.twoDigitNum1, 'Success Make Two Digit Number');
	assert.equal($custom.utils.makeTwoDigit(origin.num2), expected.twoDigitNum2, 'Success Make Two Digit Number');
});
```

