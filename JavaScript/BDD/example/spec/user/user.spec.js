var chai = require('chai'),
    expect = chai.expect;

describe('User', function() {
    var user = {
        'name': 'yeongjun.kim',
        'age': '26',
        'isAult': true
    };

    it('사용자는 반드시 존재한다.', function() {
        expect(user).to.exist;
    });

    it('성인일 경우 나이는 20살 이상이어야 한다.', function() {
        expect(user.isAult).to.be.true;
        expect(user.age).to.be.at.least(20);
    });
});
