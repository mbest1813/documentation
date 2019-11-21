---
title: HTTP API
sidebar: platform_sidebar
---

## HTTP API

This library lets you record analytics data from any website or application. You can then route that data to any destination supported by our platform.

### Getting Started with HTTP API

#### Authentication

You'll need to supply your app_ID with each request using HTTP Basic Auth.

Basic Auth base64 encodes a 'username:password' and prepends it with the string 'Basic'. The native libraries should handle this for you, but if they do not you'll need to base64 encode a string in which the username is the Source ID and the password is empty. You can base64 encode your Source ID [here](https://www.base64encode.org/)

For example, if your Source ID is ILoveData123, that will be encoded to SUxvdmVEYXRhMTIz. Then, your encoded authentication line in your header will look like this:

```
Authorization: Basic SUxvdmVEYXRhMTIz
```

#### Content-Type

Make sure to set the content-type header to `application/json`.

### Calls in HTTP API

Check out the below calls and their use cases to determine the calls that you need to make. We have also included examples of how you'd call specific objects in HTTP API.

#### Identify

The `identify` method helps you associate your users and their actions to a unique and recognizable `userID` and any optional `traits` that you know about them. We recommend calling an `identify` a single time - when the user's account is first created and only again when their traits change.

Post `https://e.metarouter.io/v1/identify`

```
{
  'userId': '1234qwerty',
  'traits': {
    'name': 'Arthur Dent',
    'email': 'earthling1@hitchhikersguide.com',
    'hasTowel': True,
  }
  'timestamp': '2015-11-10T00:45:23.412Z',
  'type': identify
}
```

#### Track

To get to a more complete event tracking analytics setup, you can add a `track` call to your website. This will tell MetaRouter which actions you are performing on your site. With `track`, each user action triggers an “event,” which can also have associated properties.

Post `https://e.metarouter.io/v1/track`

```
{
  'userId': '1234qwerty',
  'event': 'Added File',
  'properties': {
    'fileTitle': 'Life, the Universe, and Everything',
    'fileSize': '42kb',
    'fileType': 'PDF'
  },
  'timestamp': '2015-11-10T00:45:23.412Z'
  'type': track
}
```

#### Page

The `page` method allows you to record page views on your website. It also allows you to pass addtional information about the pages people are viewing.

Post `https://e.metarouter.io/v1/page`

```
{
  'userId': '1234qwerty',
  'section': 'Blog',
  'name': '10 Questions with Marvin, the clinically depressed robot',
  'properties': {
    'referrer': 'http://reddit.com/r/AMA'
  }
  'type': page
}
```

#### Group

The `group` method associates an identified user with a company, organization, project, etc.

Post `https://e.metarouter.io/v1/group`

```
{
  'userId': '1234qwerty',
  'groupId': '5678dvorak',
  'traits': {
    'name': 'The Hitchhikers',
    'relativePosition': '[39.1000 N, 84.5167 W]'
    }
  'type': group
}
```

#### Alias

The `alias` method combines two unassociated User IDs.

Post  `https://e.metarouter.io/v1/alias`

```
{
  "previousId": "anonymous_id",
  "userId": "assigned_id_or_email",
  "timestamp": "2015-11-10T00:45:23.412Z"
  "type": alias
}
```
