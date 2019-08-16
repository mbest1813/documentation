---
title: Blueshift
sidebar: platform_sidebar
---

## What is Blueshift and how does it work?

Blueshift brings AI in the Hands of Every Marketer.
It is modern AI-First platform for Cross-Channel Marketing. AI is the key to unlocking the power of fast-changing data, and delivering 1:1 personalization.

## Why send data to Blueshift using MetaRouter?

The base code for each customer is unique and must be obtained from the Blueshift UI. If you want to track custom events, you'll need to familiarize yourself with the Blueshift API to both locate the correct base and event tracking code as well as install it correctly into your own site. It typically needs to be added by a webmaster or developer to prevent errors.

Using MetaRouter, you can send page views and event data directly to Blueshift without needing to manually install any extra JavaScript on your website. Just enable the Blueshift destination in your MetaRouter UI, and we'll automatically take care of mapping a standard set of events to standard Blueshift events. MetaRouter also allows you to define and map your own events to supported Blueshift events without any custom code. All of this data is immediately available for analysis in your Blueshift dashboard.

Integrating Blueshift with MetaRouter cuts out any need for additional implementation resources, saving your development team valuable time.

## Getting Started with Blueshift and MetaRouter

### Blueshift Side

To get started sending events to Blueshift, first contact [Blueshift](https://blueshift.com/contact_blueshift/) to create your account.

Next you'll need to go to your [Account Page](https://app.getblueshift.com/dashboard#/app/account/api)
And get your Event API Key.

The easiest way to setup and test the events stream is to observe events coming to [clickstream events dashboard](https://app.getblueshift.com/dashboard#/app/click_stream/index).

### MetaRouter Side

You can configure your integrations using a `integrations.yaml` config file, where you define multiple destinations, each one with its custom settings.

The only configuration needed is the `eventApiKey`, which represents the Event API Key that you've got from the previous step. Additionally you can specify your custom event mappings using `mappedEventNames`.

Here is an example of `integrations.yaml`:

```yaml
- name: 'blueshift'
  config:
    eventApiKey: '<my Blueshift Event API Key>'
    mappedEventNames:
      - 'Order Completed': 'successful_purchase'
      - 'Product View': 'engagement'
    userAttributesMap:
      birthday: 'dob'
      firstName: 'fname'
      lastName: 'lname'
      anonymousId: 'lead_id'
      ip: 'ip_address',
      ...
    eventAttributesMap:
      value: 'event_val',
      category: 'event_cat',
      id: 'some_important_id',
      productId: 'product_identifier',
      promotionId: 'campaign_promo_id',
```

`mappedEventNames` list allows you to define your own custom event name based on events that you track with `analytics.track()`. Using the config file from the example, when calling `analytics.track('Order Completed')` we'll send an event with `successful_purchase` action to Blueshift. We use the following parameters:

- The `Order Completed` property name: your `track()` event;
- The `successful_purchase` value: mapped event name sent to Blueshift.

`userAttributesMap` list allows you to define your custom user attributes mappings.
`eventAttributesMap` list allows you to define your custom event attributes mappings respectively.

### Page

We'll send all of your `analytics.page()` events to the standard Blueshift `pageload` event.

### Identify

We'll send all of your `analytics.identify()` events to the standard Blueshift `identify` event..

### Track

Please check the [Blueshift Events API](https://help.blueshift.com/hc/en-us/articles/115002714773-Event-API) to see available Blueshift's Standard events.

We've followed Blueshift's naming conventions, so if you fire event named `Order Refunded` that is not a part of Blueshift [standard event list](https://help.blueshift.com/hc/en-us/articles/115002714773-Event-API), you'll be able to see it under `order_refunded` name on your Blueshift clickstream events [dashboard](https://app.getblueshift.com/dashboard#/app/click_stream/index).

The same naming convention is applied to any custom named event. For example: `My Custom Event` will be sent as `my_custom_event`.

You also have the option to provide your custom event names mapping as described earlier. In this case we do not correct event names using Blueshift naming system.
