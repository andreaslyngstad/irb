# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  include TagsHelper
  
 def syntax_highlight_and_markdown(text, options = {})
      text_pieces = text.split(/(<code>|<code lang="[A-Za-z0-9_-]+">|<code lang='[A-Za-z0-9_-]+'>|<\/code>)/)
      in_pre = false
      language = nil
       text_pieces.collect do |piece|
         if piece =~ /^<code( lang=(["'])?(.*)\2)?>$/
           language = $3
          in_pre = true
          nil
        elsif piece == "</code>"
          in_pre = false
          language = nil
          nil
        elsif in_pre
          code(piece.strip, :lang => language)
        else
          markdown(piece, options)
        end
      end
   end
    
    def markdown(text, options = {})
     #if options[:strip]
      # (strip_tags(text.strip)).to_html
    #else
     #  (text.strip).to_html
     # end
 end
 def parse_coderay(text)
    text.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
    text.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div( :line_numbers => :table,:css => :class))
  end
    return text
  end
end
