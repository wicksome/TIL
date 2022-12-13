## Example 1

> https://gist.github.com/QuantumGhost/0955a45383a0b6c0bc24f9654b3cb561

```
@startuml
' uncomment the line below if you're using computer with a retina display
' skinparam dpi 300
!define Table(name,desc) class name as "desc" << (T,#FFAAAA) >>
' we use bold for primary key
' green color for unique
' and underscore for not_null
!define primary_key(x) <b>x</b>
!define unique(x) <color:green>x</color>
!define not_null(x) <u>x</u>
' other tags available:
' <i></i>
' <back:COLOR></color>, where color is a color name or html color code
' (#FFAACC)
' see: http://plantuml.com/classes.html#More
hide methods
hide stereotypes

' entities

Table(user, "user\n(User in our system)") {
primary_key(id) INTEGER
not_null(unique(username)) VARCHAR[32]
not_null(password) VARCHAR[64]
}

Table(session, "session\n(session for user)") {
primary_key(id) INTEGER
not_null(user_id) INTEGER
not_null(unique(session_id)) VARCHAR[64]
}

Table(user_profile, "user_profile\n(Some info of user)") {
primary_key(user_id) INTEGER
age SMALLINT
gender SMALLINT
birthday DATETIME
}

Table(group, "group\n(group of users)") {
primary_key(id) INTEGER
not_null(name) VARCHAR[32]
}

Table(user_group, "user_group\n(relationship of user and group)") {
primary_key(user_id) INTEGER
primary_key(group_id) INTEGER
joined_at DATETIME
}

' relationships
' one-to-one relationship
user -- user_profile : "A user only \nhas one profile"
' one to may relationship
user --> session : "A user may have\n many sessions"
' many to many relationship
' Add mark if you like
user "1" --> "*" user_group : "A user may be \nin many groups"
group "1" --> "0..N" user_group : "A group may \ncontain many users"
@enduml
```

## Example 2

```
@startuml
center footer © blabla... corp. All Rights Reserved.

' https://plantuml.com/ko/openiconic
!define pk(x) **<color:red><&key> <color:black>x**
!define fk(x) <color:blue><&key> <color:black>x
!define uk(x) **<color:orange><&key> <color:black>[x]**
!define index(x) <color:green><&tag> <color:black>x
!define not_null(x) <u>x</u>
!define nullable(x) <color:grey>𝗡</color> x
!define desc(x) <&comment-square><size:11> x
!define comm(x) <color:grey>// <i>x</i></color>
!define todo(x) <color:grey><&arrow-circle-bottom> x</color>
!define config(x) <color:coral><&cog> <color:black><i>x</i>
!define config2(x) <color:coral><&wrench> <color:black><i>x</i>
!define deprecated(x) <color:grey><s>x</s>

skinparam class {
  BackgroundColor<<help>> White
  BackgroundColor<<tbd>> Technology

  BorderColor<<tbd>> DimGrey

  BackgroundColor<<new>> IMPLEMENTATION
  BorderColor<<new>> DimGrey

}

hide circle
hide empty methods
hide empty fields
hide stereotype

interface help <<help>> #line.dotted  {
    pk(primary key)
    fk(foreign key)
    uk(unique key)
    index(index)
    ....
    not_null(not_null)
    nullable(nullable)
    desc(description)
    comm(comment)
    todo(todo)
    deprecated(deprecated)
    ....
    config("engine = InnoDB")
    config2("default charset = utf8mb4")
}

entity user {
  pk(id): int
  ....
  not_null(username): varchar(32)
  not_null(password): varchar(64)
  ....
  index("username")
}

@enduml
```
