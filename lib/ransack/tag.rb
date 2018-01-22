module Ransack
  module Tag
    def build_params_for_tag(params)
      return {} if params.empty?
      ret = {}
      params.keys.each do |key|
        # key for sorting is ignored
        next if key == 's'
        res = parse_tags_on_ransack(params[key])
        # change keyword without tags
        params[key] = res[:search_keyword]
      end
      params.merge!(ret)
    end

    def parse_tags_on_ransack(query_str)
      search_keyword = ''
      tags = []
      query_str.split.map do |query_token|
        tokens = query_token.split(':').map(&:strip)
        if tokens.first == 'tag'
          tags << tokens.last
        else
          search_keyword << query_token
        end
      end
      { origin: query_str, search_keyword: search_keyword, tags: tags }
    end
  end
end
