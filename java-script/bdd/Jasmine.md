# JavaScript 테스트하기 using Jasmine

> js를 위한 BDD 테스트 프레임워크.

http://jasmine.github.io/2.0/introduction.html

**Installation**

```shell
# Local installation:
$ npm install --save-dev jasmine

# Global installation
$ npm install -g jasmine
```



**Initializing**

```shell
$ jasmine init
```

```shell
└── spec
    └── support
        └── jasmine.json
```



**Usage**

```shell
$ jasmine
```



## 샘플

```shell
$ jasmine examples
```

```shell
.
├── lib
│   └── jasmine_examples
│       ├── Player.js
│       └── Song.js
└── spec
    ├── helpers
    │   └── jasmine_examples
    │       └── SpecHelper.js
    ├── jasmine_examples
    │   └── PlayerSpec.js
    └── support
        └── jasmine.json
```

```shell
$ jasmine
Started
.....


5 specs, 0 failures
Finished in 0.008 seconds
```





**참고해볼 것**

https://scotch.io/tutorials/testing-angularjs-with-jasmine-and-karma-part-1

https://scotch.io/tutorials/testing-angularjs-with-jasmine-and-karma-part-2