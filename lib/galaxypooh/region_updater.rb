# RegionUpdater

module Galaxypooh
  module RegionUpdater
    
    def region_country_select(object, method, choices = nil, priority_countries = nil, options = {}, html_options = {})
      html_options["id"] = "country_selector"
      if choices==nil
        result = country_select(object, method, priority_countries, options, html_options)
      else
        result = select(object, method, choices, options, html_options)
      end
      result
    end
    
    def region_country_select_tag(name, option_tags = country_options_for_select, options = {})
      options["id"] = "country_selector"
      result = select_tag(name, option_tags, options)
      result      
    end
    
    def region_update_label
      result = content_tag(:div, nil, {:style => "display:none;", :id => "region_label"})
      result
    end    
  
    def region_update_select(object, method, choices, options = {}, html_options = {})
      html_options["id"]     = "region_select"
      html_options["style"]  = "display:none;"
      result = content_tag(:div, select(object, method, choices, options, html_options))
      result
    end
    
    def region_update_select_tag(name, option_tags = nil, options = {})
      options["id"]     = "region_select"
      options["style"]  = "display:none;"
      result = content_tag(:div, select_tag(name, option_tags, options))
      result
    end
    
  end
end