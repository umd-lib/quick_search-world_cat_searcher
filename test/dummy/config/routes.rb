Rails.application.routes.draw do
  mount QuickSearchWorldCatSearcher::Engine => "/quick_search-world_cat_searcher"
end
