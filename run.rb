%w(sinatra open-uri erb rubygems).each{|x| require x}
get '/' do
    @results=extract('http://ggsipuresults.nic.in/ipu//results/resultsmain.htm', 'results')
    @datesheets=extract('http://ggsipuresults.nic.in/ipu//datesheet/datesheetmain.htm', 'datesheet')
    erb :index
end
def extract(url,tag)
    res=open(url, &:read).scan(/.*<tr\s*>.*\n.*\n.*B.\s?[Tt]ech.*\n.*\n.*\n.*/).map{|x| x.gsub!(/href=\"/,"href=\"http://ggsipuresults.nic.in/ipu//#{tag}/")} #power or ruby!
    res
end
