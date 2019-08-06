---
title: Python
sidebar: platform_sidebar
---

## Python

This library lets you record analytics data from your Python code. You can use this library in your web server controller code. It is high-performing in that it uses an internal queue to make 'identify' and 'track' calls non-blocking and fast. It also batches messages and flushes asynchronously to our servers.

Visit <https://pypi.python.org/pypi/astronomer-analytics> for full package details.

### Getting Started with Python

#### Step 1

Install it.

~~~ bash
pip install astronomer-analytics
~~~

#### Step 2

Inside your python app, set you Source ID inside an instance of the Analytics object.

~~~ python
import analytics
analytics.host = 'https://e.metarouter.io'
analytics.app_id = ‘metarouter_source_id’
~~~

***Note**: You can find your metarouter_source_id in the settings section of your MetaRouter App.*

### Calls in Python

Check out our [Calls](../calls.md) section for information on when you should use each call. Below are some examples of how you'd call specific objects in Python.

#### Identify

~~~ python
analytics.identify('userID' : '1234qwerty', {
    'name': 'Arthur Dent',
    'email': 'earthling1@hitchhikersguide.com',
    'friends': 100
})
~~~

#### Track

~~~ python
analytics.track('userID' : '1234qwerty', 'Signed Up')
~~~

#### Page

~~~ python
analytics.page('user_id', 'Docs', 'Python', {
  'url': 'http://metarouter.io'
})
~~~

#### Group

~~~ python
analytics.group('user_id', 'group_id', {
  'name': 'MetaRouter',
  'domain': 'Data Engineering Platform'
})
~~~

#### Alias

~~~ python
analytics.alias(previous_id, user_id)
~~~
