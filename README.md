# HRW-Shayla-Mobile-Application
This repository stores all the resources and code for HRW Music Group's Shayla iOS mobile application. 

## Installation and Setup

Make sure to have [XCode](https://developer.apple.com/xcode/) installed on your system, along with [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) as your source control manager. 

## How it works

The popular posts template is generated with the blog. It makes queries to check the page rank for each post. Once generated, the popular posts asides section is a static page. Which means popularity is updated only when the site is generated.

Popular posts plugin caches the page rank results of each post. The results are stored in the __.page_ranks__ directory of your blog. When there is a cache, the plugin will read from it. When there is no cache, it will generate one. Caches expires in 1 month. This shortens the time needed to generate your blog.

Google page rank is updated every 3 months. A static page is sufficient as page rank don't change every hour.
