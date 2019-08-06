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

Check out our 'Calls' section for information on when you should use each call. Below are some examples of how you'd call specific objects in HTTP API.

#### Identify

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

Post  `https://e.metarouter.io/v1/alias`

```
{
  "previousId": "anonymous_id",
  "userId": "assigned_id_or_email",
  "timestamp": "2015-11-10T00:45:23.412Z"
  "type": alias
}
```
