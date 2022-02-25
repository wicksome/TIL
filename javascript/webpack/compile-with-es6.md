- config 파일 이름 변경: `webpack.config.babel.js`
- babel-register 설치: `npm install --save-dev @babel/register`

package.json
```
scripts: {
  "build": "webpack --config webpack.config.babel.js"  
}
```

**References**
- https://babeljs.io/docs/en/babel-register
- https://stackoverflow.com/a/31906902/3793078
