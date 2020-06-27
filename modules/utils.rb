require 'yaml'

class Utils
  def self.tokenize_content(target)
    data = {
      title: nil,
      background_image: nil,
      content: ''
    }
    File.open(target, 'r') do |f|
      f.each do |line|
        if line.start_with?('# ')
          data[:title] = line.gsub('# ', '').strip
        elsif line.start_with?('/') and File.extname(line.strip) == '.jpg'
          data[:background_image] = line.strip
        else
          data[:content] << line
        end
      end
    end
    data
  end

  def self.write_post(target, content, data)
    File.open(target, 'w') do |f|
      f << "#{data.to_yaml}---\n"
      f << content
    end
  end
end
