---
title: Java
sidebar: platform_sidebar
---

## Java

This library lets you record analytics data from your Java code. Once installed, the requests will hit our servers and then be routed to the destinations of your choice. 

You can install the library [here](https://mvnrepository.com/artifact/io.astronomer.analytics.java/analytics-core/2.0.0-RC5).

You can use this library in your web server controller code- it is built for high performance and uses and internal queue to make all calls non-blocking and fast. It will batch messages and flush asynchronously to our servers.

### Getting Started with Java

#### Install the Library

We reccommend installing the library with a build system like Maven. If you do it this way, you will have much less trouble upgrading and swapping out destinations. 

The library is distributed as a `jar` dependency via [Maven Central](http://search.maven.org/). Here's what it would look like with Maven.

Add to `pom.xml`:
```xml
<dependency>
    <groupId>io.astronomer.analytics.java</groupId>
    <artifactId>analytics-core</artifactId>
    <version>2.0.0-RC5</version>
</dependency>
```

#### Initialize the SDK

Before you can start sending us events, you'll need to initialize an instance of the Analytics class. Do this using the `Analytics.builder` class, inputting the `Source ID` found in the source settings of your Astronomer UI.
```java
Analytics analytics = Analytics.builder("Your Source ID")
        .endpoint("https://e.metarouter.io")
        .build();
```
Note that there exists an internal `AnalyticsClient` class, not to be confused with the public `Analytics` class.

The `Analytics` class has a method called `enqueue` that takes a `MessageBuilder`. Each message class has a corresponding builder that is used to construct instances of a message. Be sure to provide either a `userId` or `anonymousID` for each message, as failing to do so will raise an exception at runtime.

### Calls in Java

Check out our [API Calls doc](../calls.html) for more information about when you should use each call. Below are some specfic examples of how you'd call specific objects in Java.

**Note**: Thee following examples use the [Guava](https://github.com/google/guava) immutable map style, but feel free to use standard Java maps instead.

#### Identify

```java
analytics.enqueue(IdentifyMessage.builder()
    .userId("qwerty1234")
    .traits(ImmutableMap.builder()
        .put("name", "Buzz Aldrin")
        .put("email", "buzz.aldrin@visitthemoon.com")
        .put("gender", "male")
        .put("title", "Second person to visit the moon")
        .build()
    )
);
```
The above call identifies Buzz by his unique `userID` and labels him with `name`, `email`, `gender`, and `title` traits. For a complete library of the traits that you're able to assign to a user, check out our [API Calls doc](../calls.html).


#### Track
```java
analytics.enqueue(TrackMessage.builder("Item Purchased")
    .userId("qwerty1234")
    .properties(ImmutableMap.builder()
        .put("revenue", 50.00)
        .put("shipping", "Next-Day")
        .build()
    )
);
```

The above call tells us that someone has purchased an item for 50 dollars and has selected a "next day" shipping option. 



#### Screen

**Note**: The `screen` call pulls the same data as a `page` call, but is used for mobile rather than web sources. 

```java
analytics.enqueue(ScreenMessage.builder("MoonLanding")
    .userId("qwerty1234")
    .properties(ImmutableMap.builder()
        .put("category", "Space")
        .put("path", "/space/moonlanding")
        .build()
    )
);
```

The above call tells us that someone has viewed a `MoonLanding` page that is categorized in a `Space` section of the mobile app. 

#### Group


```java
analytics.enqueue(GroupMessage.builder("some-group-id")
    .userId("qwerty1234")
    .traits(ImmutableMap.builder()
        .put("name", "Astronomer")
        .put("size", 55)
        .put('website", "www.astronomer.io")
        .build()
    )
);
```

The above call assigns the user with the "Astronomer" group and gives that group the "size" and "website" traits. 

#### Alias

```java
analytics.enqueue(AliasMessage.builder("previousId")
    .userId("qwerty1234")
);
```

We might use the above call in the following way:
```java
// the anonymous user clicks a button
track("anonymous_user", "Click Button");
// the anonymous user signs up and is aliased
alias("anonymous_user", "first.last@website.com");
// the signed up user is identified
identify("first.last@website.com", new Traits("plan", "Pro"));
// the identified user clicks a button
track("first.last@website.com", "Click Button");
```

Note that making an `alias` call means that we are able to combine the user's anonymous actions with their identified actions, so that we can get a clear picture of their user journey.
