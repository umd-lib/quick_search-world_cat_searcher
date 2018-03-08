# quick_search-world_cat_searcher

WorldCat searcher for NCSU Quick Search

## Installation

Include the searcher gem in your Gemfile:

```
gem 'quick_search-world_cat_searcher'
```

Run bundle install:

```
bundle install
```

Include in your Search Results page

```
<%= render_module(@world_cat, 'world_cat') %>
```

## Configuration

WorldCat requires configuration, such as a key. To set the configuration, create a "config/searchers/" directory in your application (the "searchers" subdirectory may need to be created), and copy the "config/world_cat_config.yml" file in this gem into it. Follow the instructions in the file to configure the searcher.

Additional customizations can be done by editing the "config/locales/en.yml" file.