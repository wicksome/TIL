var assert = require('chai').assert;

describe('Array', function() {
	describe('#indexOf()', function() {
		it('should return -1 when value is not present', function() {
			assert.equal(-1, [1, 2, 3].indexOf(4));
		});
	});
});

describe('Test', function() {
	it('Assert api test using chai', function() {
		var foo = 'str';
		assert.typeOf(foo, 'string');
		assert.lengthOf(foo, 3);
	});
});
