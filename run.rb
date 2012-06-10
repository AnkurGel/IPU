%w(sinatra nokogiri open-uri erb rubygems).each{|x| require x}
get '/' do
    @results=extract('http://ggsipuresults.nic.in/ipu//results/resultsmain.htm', 'results')
    @datesheets=extract('http://ggsipuresults.nic.in/ipu//datesheet/datesheetmain.htm', 'datesheet')
    
    erb :index
end
def extract(url,tag)
    res=open(url, &:read).scan(/.*<tr\s*>.*\n.*\n.*B.\s?[Tt]ech.*\n.*\n.*\n.*/).map{|x| x.gsub!(/href=\"/,"href=\"http://ggsipuresults.nic.in/ipu//#{tag}/")} #power or ruby!
    res
end
class Array; def first3; self.first(3); end; end
def msit
    begin 
    url="http://msit.in/newscolumn.aspx"
    doc=Nokogiri::HTML(open(url))
    res=doc.css("#ctl00_ContentPlaceHolder1_Panel1 small , .NewsClass")
    rescue Exception
        STDERR.puts "Trouble with connection with IPU site - #{$!}"
        raise 
    end
    dates, notices, links=[],[],[]
    res.each do |x| 
        dates<<x.text
        links<<x[:href]
    end
    links.compact!
    notices=dates[dates.length/2..dates.length]; dates-=notices
    [links, notices, dates].map &:first3
end
