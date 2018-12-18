---
title: Overview of the MetaRouter Platform
keywords: introduction homepage
sidebar: platform_sidebar
summary: MetaRouter is a data engineering platform that that helps you collect, process, and route streaming data.
---

## Purpose

MetaRouter is a data engineering platform that helps you collect user events from any source, and stream that data to all of your favorite third-party tools, analytics platforms, and data warehouses. MetaRouter is built on industry proven open-source technologies, and takes care of all the complex orchestrating and managing of cloud infrastructure. The goal of our platform is to increase your ability to focus on data analytics and data science initiatives.

[![MetaRouter Overview](/images/platform_overview.png)](/images/platform_overview.png)

## Editions

* [Cloud](/v2/editions/cloud/overview.html) - we run enterprise edition for you - signup for an account at https://app.metarouter.io/ and get started with the platform quickly.
* [Enterprise](/v2/editions/enterprise/overview.html) - our full platform deployable via Kubernetes to your preferred cloud (AWS, Google Cloud, Azure).


## Modules

* [Clickstream](/v2/clickstream/overview.html) - an Analytics.js-based module, which helps you collect data from your web and mobile applications, and route those events to your tools and to your data lake.
    - Best suited for those:
        - Just getting started collecting User Data
        - Have web apps and mobile apps with users that aren’t being tracked
        - Are using Google Analytics and a couple others tools
        - Want to warehouse user interaction data
        - Are a freemium, low revenue per monthly active user or e-commerce business model

    - Use Cases for Clickstream:
        - Product Analytics
        - Marketing Automation
        - User data tracking and warehousing

## What it's not

MetaRouter doesn't include:

* A data warehouse - There are a growing number of great data warehouse options. MetaRouter integrates with all of them.
* Data visualization - Same deal, there are a growing number of great visualization tools, and we believe that you should "own your data" and handle all data processing outside of your visualization tools.
