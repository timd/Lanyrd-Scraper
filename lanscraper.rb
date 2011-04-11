require 'nokogiri'
require 'open-uri'

# Check arguments for valid url
failure = catch(:done) do
  
  # Check arguments supplied
  ARGV.each do |arg|
    if arg.start_with?("http://lanyrd.com")
      @url = true
    end
  end

  # Catch absence of URL
  if !@url
    puts "Sorry, You need to supply a valid Lanyrd URL"
    throw :done
  end

  # Grab Lanyrd page
  @doc = Nokogiri::HTML(open(ARGV[0] + "/attendees/"))
  
  # Extract twitter names into nodeset
  @names = @doc.xpath("//ul[@class='people']/li/span[2]")

  # Iterate across nodeset
  @names_array = Array.new

  # Create Twitter URLs from names
  @names.each do |node|
    @names_array << "http://twitter.com/" + node.inner_html
  end

  # Output results
  @names_array.each do |name|
    puts name
  end

end # End catch

