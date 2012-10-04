require 'rubygems'

desc "Update model based on public Google Spreadsheets URL"
task :tsv_model_import => [:environment] do |task|
  puts "Updating costumes..."

  TSV_URL    = "https://docs.google.com/spreadsheet/pub?key=0ApHhSYGuKPKpdG9qR1VaT1JFMDhweXptdHBLZ21wNnc&single=true&gid=0&output=txt"
  tsv_string = url_to_string TSV_URL
  lines      = tsv_string.split(/\r?\n/)
  header     = lines.shift.strip
  keys       = header.split(/\t/)
  lines.each do |line|
    values     = line.strip.split(/\t/)
    attributes = Hash[keys.zip values].symbolize_keys
    costume    = Costume.find_or_create_by_imgur(attributes[:imgur])
    costume.update_attributes(attributes)
  end

  puts "Done."
end

# @param [String] data_url
def url_to_string(data_url)
  response = RestClient.get(data_url)
  (response && response.code == 200) && response.to_str.force_encoding('UTF-8')
end