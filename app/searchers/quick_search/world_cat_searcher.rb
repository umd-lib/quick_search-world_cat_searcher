# frozen_string_literal: true

module QuickSearch
  # QuickSearch seacher for WorldCat
  class WorldCatSearcher < QuickSearch::Searcher
    def search
      url = base_url + parameters.to_query
      raw_response = @http.get(url)
      @response = Nokogiri::XML(raw_response.body)
    end

    def results # rubocop:disable Metrics/MethodLength
      if results_list
        results_list
      else
        @results_list = []
        @response.xpath('//xmlns:entry').each do |value|
          result = OpenStruct.new
          result.title = title(value)
          result.link = link(value)
          result.author = author(value)
          result.date = updated(value)
          @results_list << result
        end
        @results_list
      end
    end

    def total
      @response.xpath('//opensearch:totalResults', 'opensearch' => 'http://a9.com/-/spec/opensearch/1.1/')[0].content
    end

    def loaded_link
      QuickSearch::Engine::WORLD_CAT_CONFIG['loaded_link'] +
        sanitized_user_search_query
    end

    def base_url
      QuickSearch::Engine::WORLD_CAT_CONFIG['base_url'] +
        QuickSearch::Engine::WORLD_CAT_CONFIG['wskey'] + '&'
    end

    def parameters
      {
        'q' => sanitized_user_search_query
      }
    end

    # Returns the sanitized search query entered by the user, skipping
    # the default QuickSearch query filtering
    def sanitized_user_search_query
      # Need to use "to_str" as otherwise Japanese text isn't returned
      # properly
      sanitize(@q).to_str
    end

    def title(value)
      value.at('title')&.content
    end

    def link(value)
      id = value.at('id').content[25..-1] if value.at('id')
      QuickSearch::Engine::WORLD_CAT_CONFIG['url_link'] + id
    end

    def author(value)
      authors = []
      value.search('author/name').children.each do |a|
        authors << a.content
      end
      authors.join(', ')
    end

    def updated(value)
      datetime = value.at('updated').content if value.at('updated')
      d = Time.zone.parse(datetime)
      d.strftime('%Y')
    end
  end
end
