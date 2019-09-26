require 'nokogiri'
require 'base64'

module IBXParser
  def self.parse(text)
    doc = Nokogiri::XML.parse(text)
    result = ''
    query_nodes = %w[source caption]
    doc.traverse do |node|
      if query_nodes.include?(node.name)
        result << Base64.decode64(node.text) << "\n"
      end
    end
    result
  end
end

text = File.open(ARGV[0], &:read)
output = IBXParser.parse(text)
File.write(ARGV[1], output)
