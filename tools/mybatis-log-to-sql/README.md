# Convert mybatis's log to SQL

[![npm version](https://badge.fury.io/js/mybatis-sql-log-to-sql.svg)](https://badge.fury.io/js/mybatis-sql-log-to-sql)

> Replace all `?` characters to parameters.

![demo](https://user-images.githubusercontent.com/5036939/31315987-d1997990-ac5e-11e7-9012-b8f76352eb48.png)

https://wickso.me/mybatis-log-to-sql/

**AS-IS**

```
2017-10-08 17:39:34 [DEBUG](BaseJdbcLogger.java:159) ==>  Preparing: SELECT * FROM table WHERE id = ?
2017-10-08 17:39:34 [DEBUG](BaseJdbcLogger.java:159) ==> Parameters: 2001(Integer)
```

**TO-BE**

```
SELECT * FROM table WHERE id = 2001
```

## CLI

### Install

```bash
$ git clone https://github.com/wicksome/mybatis-log-to-sql.git
$ cd mybatis-log-to-sql && npm init
```

### Usage

```bash
$ node index.js
>> SQL: 2017-10-08 17:39:34 [DEBUG](BaseJdbcLogger.java:159) ==>  Preparing: SELECT * FROM table WHERE id = ?
>> Parameters: 2017-10-08 17:39:34 [DEBUG](BaseJdbcLogger.java:159) ==> Parameters: 2001(Integer)
--------------------------------------------------------------------------------
SELECT * FROM table WHERE id = 2001
✔ Copy sql!
```

