---
title: Analytics.js Spec
sidebar: platform_sidebar
---

MetaRouter utilizes 6 different types of API calls to track users. Each call represents a distinct type of semantic information about a user and shares the same common fields.

* Identify
* Track
* Page/Screen
    - Note that, while these are two separate calls, they function in a very similar way. Page calls are used for web sources while screen calls are used for mobile ones.
* Group
* Alias

## Identify

The `identify` method is used to associate behavior and to record traits about your users. The call includes a unique User ID and any option traits you know about them (email, name, role, etc.). Implementing `identify` is one of the first steps you should take in order to get the most out of MetaRouter Clickstream.

We recommend calling `identify` at a couple of points:

  * After a user registers
  * After a user logs in
  * When a user updates their info
  * Upon loading any pages that are accessible by a logged-in user

Here's a sample `identify` snippet:

```
analytics.identify("1205119", {
    "name": "Dagny Smith",
    "email": "dagny@metarouter.io"
    "plan": "enterprise"
    });
```

And the resulting payload:

```
{
    "type": "identify",
    "traits": {
        "name": "Dagny Smith",
        "email": "dagny@metarouter.io"
        "plan": "enterprise",
    },
    "userID": "1205119"
}
```

As you can see, an `identify` call has 2 components beyond the common fields:

| Field               | Type    | Description |
| ------------------- | ------- | ----------- |
| `traits` (optional) | Object  | Dictionary of user traits like `name` or `email` |
| `userID` (required) | String | Unique identifier for the user in your database. Either a `userID` or an `anonymousID` is required for this call |

### Anonymous and User ID's
For cases where you don't actually know who the user is but you still want to be able to associate them to traits, events, or page views, you should use an Anonymous ID.

The Anonymous ID can really be any pseudo-unique identifier. Feel free to use any readily available identifier or generate a new random one. [UUIDs](https://en.wikipedia.org/wiki/Universally_unique_identifier) work great.

***Note**: Our web and mobile libraries automatically use Anonymous IDs to keep track of users.*

User IDs are a more permanent and consistent identifier. We recommend including them in your `identify` calls as often as possible. You are most likely already using a unique identifier to recognize a user in your own database - this identifier is a great `UserID`.

Also, we recommend using something like a database ID over something like an email address or a username as they are more robust and consistent. If you want to track information like email addresses or usernames, send them through as `traits` instead.

### Traits
In an `identify` call, traits are pieces of information that you know about a user. Traits can really be anything - from email addresses to age or A/B test variations. The world is your oyster!

We have reserved some traits to be handled in special ways. These reserved traits should only be used for their intended meanings.

| Trait             | Type   | Description |
| ----------------- | ------ | ----------- |
| `address `        | Object | Dictionary of user traits like `name` or `email` |
| `age`             | Number | Age of a user |
| `avatar`          | String | URL to an avatar image for a user |
| `birthday`        | Date   | User's birthday |
| `company`         | Object | The company a user represents |
| `createdAt`       | Date   | Date the user's account was first created. We recommend ISO-8601 date strings |
| `description`     | String | Description of a user |
| `email`           | String | Email address of a user |
| `firstName`       | String | First name of a user |
| `gender`          | String | Gender of a user |
| `id`              | String | Unique ID (from your database) for a user |
| `lastName`        | String | Last name of a user |
| `name`            | String | Full name of a user - we will fill this in if you pass a first and last name |
| `phone`           | String | Phone number of a user |
| `title`           | String | Title of a user |
| `username`        | String | User's username |
| `website`         | String | Website of a user |


## Track
To record any actions your users perform, along with properties that describe the action, you will want to use a `track` call. Each of these actions is known as an event, and each of these events has a name. Calling `track` is one of the first steps towards getting the most out of MetaRouter Clickstream.

Here's a sample `track` call:

```
analytics.track("Viewed Product", {
  "product": "Cat Feather Toy",
  "model_number": "B001BOVEU4",
  "price": "9.99"
});
```

That sample call would yield the following payload:

```
{
    "type":  "track",
    "event": "Viewed Product",
    "properties": {
        "model_number": "B001BOVEU4"
        "price": "9.99"
    }
}
```
As you can see, a `track` call has 2 components beyond the common fields:

| Field                   | Type   | Description |
| ----------------------- | ------ | ----------- |
| `event` (required)      | String | Name of the action that a user has performed |
| `properties` (optional) | String | Dictionary of properties of the event, like `model_number` or `price` |

### Properties
Properties are extra bits of information that you can tie to the events you track and can really be anything. We recommend sending properties as often as possible to give you a more complete picture of what your users are doing.

We have reserved some properties that have semantic meanings and are handled in special ways. These reserved properties should only be used for their intended meanings.

| Property   | Type   | Description |
| ---------- | ------ | ----------- |
| `revenue`  | Number | The amount of revenue an event resulted in. This should be a decimal value. |
| `currency` | String | Currency of the revenue an event resulted in (in ISO 4127 format). We will assume USD if this is not set |
| `value`    | Number | An abstract "value" to associate with an event |

## Page
The `page` call allows you to record whenever a user sees a page of your website, along with any optional properties you want to include about the page. Calling `page` or `screen` is one of the first steps to getting the most out of MetaRouter Clickstream.

**Important** - In the `analytics.js` snippet, a `page` call is included by default (just after the `analytics.load`). We do this because this method needs to be called at least once per page load. You have the option of sprucing up the call with a `name` or `properties` and can call it multiple times if you have a single-page application.

Here's a sample `page` call:

```
analytics.page("Home")
```

And, here's the corresponding payload:

```
{
    "type": "page",
    "name": "Home",
    "properties": {
        "title": "MetaRouter: The Platform for Data Engineering",
        "url": "https://ww.metarouter.io"
    }
}
```
As you can see, a `page` call has 2 components beyond the common fields:

| Field                   | Type   | Description                                                           |
| ----------------------- | ------ | --------------------------------------------------------------------- |
| `name` (optional)       | String | Name of the page                                                      |
| `properties` (optional) | String | Dictionary of properties of the page like `url` or `referrer` |

### Properties
Properties are extra bits of information that you can tie to the pages you track and can really be anything. We recommend sending properties as often as possible to give you a more complete picture of what your users are doing.

We have reserved some properties that have semantic meanings and are handled in special ways. These reserved properties should only be used for their intended meanings.

| Property   | Type   | Description |
| ---------- | ------ | ----------- |
| `name`     | String | Name of the page |
| `path`     | String | Path portin of the URL of the page |
| `referrer` | String | Full URL of the previous page |
| `search`   | String | Query string portion of the URL of the page |
| `title`    | String | Title of the page |
| `url`      | String | Full URL of the page |

***Note**: In analytics.js, we automatically send the following properties: `title`, `path`, `url`, `referrer`, and `search`.*

## Group
Use the `group` call when you want to associate an individual user with a group - a company, organization, account, team, etc.

While a user can be in more than one group, not all platforms support multiple groups. This method also lets you record custom traits about the group.

Calling `group` is slightly more advanced than `identify`, `track`, or `page`, but it's pretty useful if you have accounts with multiple users.

Here's a sample `group` call:

```
analytics.group("ak9g2hgpcf",{
    "name": "MetaRouter",
    "industry": "Technology",
    "employees": "48"
});
```

And the corresponding payload:

```
{
    "type": "Group",
    "groupID": "ak9g2hgpcf",
    "traits": {
        "name": "MetaRouter",
        "industry": "Technology",
        "employees": "48"
    }
}
```
As you can see, a `group` call has 2 components beyond the common fields:

| Field               | Type   | Description |
| ------------------- | ------ | ----------- |
| `groupID` (required)| String | Name of the page |
| `traits` (optional) | String | Dictionary of traits of the group, like `industry` or `employees` |

### Group ID
A Group ID is the unique identifier by which you recognize a group in your database.

### Traits
Traits are extra bits of information that you can tie to the pages you track and can really be anything.

We have reserved some traits to be handled in special ways. These reserved traits should only be used for their intended meanings.

| Trait         | Type   | Description |
| ------------- | ------ | ----------- |
| `address `    | Object | Street address of a group. This should be a dictionary containing optional `city`, `country`, `postalCode`, `state`, or `street`. |
| `avatar`      | String | URL to an avatar image for a user |
| `createdAt`   | Date   | Date the group's account was first created. We recommend ISO-8601 date strings. |
| `description` | String | Description of a group |
| `email`       | String | Email address of a group |
| `employees`   | String | Number of employees of a group |
| `id`          | String | Unique ID (from your database) for a group |
| `industry`    | String | Industry a user works in or a group is part of |
| `name`        | String | Name of a group |
| `plan`        | String | Plan that a group is in |
| `phone`       | String | Phone number of a group |
| `website`     | String | Website of a group |

## Alias
The `alias` method is used to merge two user identities, effectively connecting two sets of user data as one. Calling `alias` is slightly more advanced than `identify`, `track`, or `page`, but it's required to manage user identities successfully in some of our destinations.

Here's a sample `alias`:

```
analytics.alias("k9jlquh2ew");
```

And the resulting payload:

```
{
    "type": "alias",
    "previousId": "dagny@metarouter.io",
    "userId": "k9jlquh2ew"
}
```

### Previous ID
The `previousId` is the existing ID that you've already referred to the user by. This could be an Anonymous ID that was assigned to the user or a User ID that you've previously identified them with in `identify`.

### User ID
The `UserId` string will either be the user's new identity or an existing identity that you wish to merge with the `previousId`.

# Common Fields of API Calls

Every [API call](../calls.html) has a common structure. While some specific calls pass extra information, they will all pass the information detailed in this document. Note that, while MetaRouter will send all of these fields, not every destination will accept every field listed below.

## General Structure

As mentioned above, there is a general structure that governs our API calls. Below is an example of this structure in raw JSON:
```json
{
  "anonymousId": "exampleAnonymousId1234",
  "context": {
    "active": true,
    "app": {
      "name": "MetaRouter",
      "version": "123",
      "build": "1.1.1.123",
      "namespace": "com.production.metarouter"
    },
    "campaign": {
      "name": "MetaRouter Sunday Reads",
      "source": "Newsletter",
      "medium": "email",
      "term": "tps reports",
      "content": "image link"
    },
    "device": {
      "id": "exampleDeviceId",
      "advertisingId": "exampleAdvertisingId",
      "adTrackingEnabled": true,
      "manufacturer": "Apple",
      "model": "iPhone7,2",
      "name": "astro",
      "type": "ios",
      "token": "exampleToken"
    },
    "ip": "1.2.3.4",
    "library": {
      "name": "analytics.js",
      "version": "2.11.1"
    },
    "locale": "nl-NL",
    "location": {
      "city": "Cincinnati",
      "country": "United States",
      "latitude": 39.1031,
      "longitude": 84.5120,
      "speed": 0
    },
    "network": {
      "bluetooth": false,
      "carrier": "Verizon",
      "cellular": true,
      "wifi": true
    },
    "os": {
      "name": "iPhone OS",
      "version": "8.1.3"
    },
    "page": {
      "path": "/",
      "referrer": "",
      "search": "",
      "title": "MetaRouter",
      "url": "https://www.metarouter.io/"
    },
    "referrer": {
      "id": "exampleId",
      "type": "example"
    },
    "screen": {
      "width": 320,
      "height": 568,
      "density": 2
    },
    "timezone": "America/Cincinnati",
    "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  },
  "integrations": {
    "All": true,
  },
  "messageId": "exampleMessageId",
  "receivedAt": "2017-12-5T01:05:31.909Z",
  "sentAt": "2017-12-5T01:05:31.581Z",
  "type": "track",
  "userId": "exampleUserId",
  "version": 2
}
```

Below is a chart detailing what the fields in the above sample payload mean. 


| Field                    | Type | Description |
| ------------------------ | ----- | ---------- |
| `anonymousId` (optional) | object | A pseudo-unique substitute for User ID. This is for cases when you don't have an absolutely unique identifier. |
| `context` (optional) | object | Dictionary of extra information that provides useful context about a message that is not directly related to the API call |
| `integrations` (optional) | string | Dictionary of destinations to either enable or disable |
| `messageId` (implicit) | string | Automatically collected, this is a unique identifier for each message that lets you find an individual message across the API |
| `receivedAt` (implicit) | date | The timestamp of when a message is received by MetaRouter |
| `sentAt` (optional) | date | The timestamp of when a message is sent to MetaRouter |
| `type` (implicit) | strong |Type of message, according to the API method |
| `userId` (required) | string | Unique string that identifies a user in your database |
| `version` (implicit) | number | Version of th *****


## Context

This section will provide other information you can gather to provide useful context about a data point. You should only use these fields for their intended meaning; they are complete and explicit specifications.

| Field | Type | Description |
| ----- | ---- | ----------- |
| `active` | boolean | Tells whether a user is active. This can be used to flag an `identify` call to update its traits |
| `app` | object | Information about the current application, including `name`, `version`, and `build`. |
| `campaign` | object | Information about the campaign that led to the API call, including `name`, `source`, `medium`, `term`, and `content`. This field maps directly to the common UTM campaign parameters. |
| `device` | object | Informationa bout the device, including `id`, `manufacturer`, `model`, `name`, `type`, and `version`. |
| `ip` | string | User's IP address. |
| `library` | object | Information about the libaray making the API calls, including `name` and `version`. |
| `locale` | string | Current user's locale string |
| `location` | object | Information about user's location, including `city`, `country`, `latitude`, `longitude`, `region`, and `speed`. |
| `network` | object | Information about user's current device connection, including `bluetooth`, `carrier`, `cellular`, and `wifi`. | 
| `os` | object | Information about user's operating system, including `name` and `version`. |
| `page` | object | Information about the current page of the user's browser, including `hash,`, `path`, `referrer`, `search`, `title`, and `url`. |
| `referrer` | object | Information about how the user got to the page, including `type`, `name`, `url`, and `link`. |
| `screen` | object | Information about the user's device screen, including `density`, `height`, and `width`.|
| `timezone` | string | Which timezone the user is in |
| `traits` | object | Current user's `traits`. |
| `userAgent` | string | User agent of the user's device. |

All of the fields listed in the above table can be populated, but this does not happen automatically for each one. Below is a chart that details which context fields are automatically populated. If there is no check mark, you will have to manually send these variables.

| Context Field | Analytics.js | Analytics-ios | Analytics-android |
| ------------- | ------------ | ------------- | ----------------- |
| `app.name` | x | ✔ | ✔ |
| `app.version` | x | ✔ | ✔ |
| `app.build` | x | ✔ | ✔ |
| `campaign.name` | ✔ | x | x |
| `campaign.source` | ✔ | x | x |
| `campaign.medium` | ✔ | x | x |
| `campaign.term` | ✔ | x | x |
| `campaign.content` | ✔ | x | x |
| `device.type` | x | ✔ | ✔ |
| `device.id` | x | ✔ | ✔ |
| `device.advertisingId` | x | ✔ | ✔ |
| `device.adTrackingEnabled` | x | ✔ | ✔ |
| `device.manufacturer` | x | ✔ | ✔ |
| `device.model` | x | ✔ | ✔ |
| `device.name` | x | ✔ | ✔ |
| `hash` | ✔ | x | x |
| `library.name` | ✔ | ✔ | ✔ |
| `library.version` | ✔ | ✔ | ✔ |
| `ip` | ✔ | ✔ | ✔ |
| `locale` | x | ✔ | ✔ |
| `location.latitude` | x | x | x |
| `location.longitude` | x | x | x |
| `location.speed` | x | x | x |
| `network.bluetooth` | x | x | ✔ |
| `network.carrier` | x | ✔ | ✔ |
| `network.cellular` | x | ✔ | ✔ |
| `network.wifi` | x | ✔ | ✔ |
| `os.name` | x | ✔ | ✔ |
| `os.version` | x | ✔ | ✔ |
| `page.path` | ✔ | x | x |
| `page.search` | ✔ | x | x | 
| `page.title` | ✔ | x | x |
| `page.url` | ✔ | x | x | 
| `screen.density` | x | x | ✔ |
| `screen.height` | x | ✔ | ✔ |
| `screen.width` | x | ✔ | ✔ |
| `search` | ✔ | x | x |
| `title` | ✔ | x | x |
| `traits` | x | ✔ | ✔ |
| `userAgent` | ✔ | x | ✔ |
| `url` | ✔ | x | x |
| `timezone` | x | ✔ | ✔ |
