### HRW-Shayla-Mobile-Application
This repository stores all the resources and code for HRW Music Group's Shayla iOS mobile application. 

# Octopress Popular Posts Plugin

Popular posts plugin adds a popular posts asides section to your [Octopress](http://octopress.org) blog. Popularity of the post is calculated by the [Google page rank](http://en.wikipedia.org/wiki/PageRank).

## How it works

The popular posts template is generated with the blog. It makes queries to check the page rank for each post. Once generated, the popular posts asides section is a static page. Which means popularity is updated only when the site is generated.

Popular posts plugin caches the page rank results of each post. The results are stored in the __.page_ranks__ directory of your blog. When there is a cache, the plugin will read from it. When there is no cache, it will generate one. Caches expires in 1 month. This shortens the time needed to generate your blog.

Google page rank is updated every 3 months. A static page is sufficient as page rank don't change every hour.
