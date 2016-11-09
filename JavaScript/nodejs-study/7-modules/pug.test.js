const expect = require('chai').expect,
    pug = require('pug');

describe('pug example', function() {
    let data = {
        name: 'yeongjun'
    };
    const expectedHTML = '<p>' + data.name + '\'s Pug source code!</p>';

    console.log(expectedHTML);

    it('compile된 마크업과 expectedHTML은 같아야 한다. - pug.compileFile()', function() {
        const tpl = pug.compileFile(__dirname + '/tpl.test.pug');
        expect(expectedHTML).to.equal(tpl(data));
    });

    it('compile된 마크업과 expectedHTML은 같아야 한다. - pug.renderFile()', function() {
        const file = __dirname + '/tpl.test.pug'
        expect(expectedHTML).to.equal(pug.renderFile(file, data));
    });
});
