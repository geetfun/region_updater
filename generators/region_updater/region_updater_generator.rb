require 'yaml'
require 'pathname'

class RegionUpdaterGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      if options[:default] == false
        yaml_file = "custom.yaml"
      else
        yaml_file = "default.yaml"
      end
      generate_js(m) if country_parser(yaml_file)
    end
  end
  
  protected
  
  def generate_js(m)
    js_dir = File.join("public", "javascripts")
    m.file "region_updater.js", File.join(js_dir, "region_updater.js")
  end
  
  def banner
    "Usage: script/generate region_updater"
  end
  
  def add_options!(opt)
    opt.separator ""
    opt.separator "Options:"
    opt.on("--default", "Generate the full list of countries and their respective regions from the default YAML file") { |v| options[:default] = true }
    opt.on("--custom", "Generate the list of countries and their respective regions from the custom (ie. the one you edited or made yourself) YAML file") { |v| options[:default] = false }
  end
  
  def country_parser(yaml_file)
    # outputs public/javascripts/countries.js
    #   countries.js is a javascript variable file which helps the javascript dynamically change 
    #   the region/state/province based on the country chosen
    #
    path_yaml = Pathname.new(RAILS_ROOT + "/vendor/plugins/region_updater/generators/region_updater/countries")
    file_yaml = Pathname.new(yaml_file)
    file = File.new(path_yaml + file_yaml)
    hash = YAML.load(file)
    file.close

    path_js = Pathname.new(RAILS_ROOT + "/public/javascripts")
    file_js = Pathname.new("region_updator_countries.js")
    file = File.new((path_js + file_js), "w+")

    result = ""
    result += "var Countries=$H({"
    countries = hash.to_a
    countries.each do |country|
      result += "\"" + country[0] + "\":$H({"
      result += "\"label\":" + "\"" + country[1]["label"] + "\","
      result += "\"regions\":["
      regions = country[1]["regions"]
      regions.each do |region|
        result += "\"" + region + "\""
        result += "," if region != regions.last
      end
      result += "]})"
      result += "," if country != countries.last
    end
    result += "});"
    file.puts result
    file.close
    return true
  end
  
end
