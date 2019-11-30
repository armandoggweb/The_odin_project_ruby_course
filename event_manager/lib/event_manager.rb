require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

puts "EventManager Initialized!"
=begin
#contents = File.read "/home/armando/THE_ODIN_PROJECT/again/event_manager/event_attendees.csv"
#puts contents
lines = File.readlines "/home/armando/THE_ODIN_PROJECT/again/event_manager/event_attendees.csv"
#lines.each{|line| puts line}
lines.each_with_index do |line, index| 
    #next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
    next if index == 0
    columns = line.split(",")
    name = columns[2]
    puts name
end
=end
def clean_zipcode(zipcode)
=begin
    zipcode = "0" * 5 if zipcode.nil?
    zipcode = zipcode[0..4] if zipcode.length > 5
    #zipcode = ("0" * (5 - zipcode.length)).concat(zipcode) if zipcode.length < 5
    zipcode = zipcode.rjust(5, "0") if zipcode.length < 5
    zipcode
=end
    zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
    phone_number.gsub!(/\W*\s*/ ,"") unless phone_number.nil?
    if phone_number.length < 10 || phone_number.length > 11
        phone_number = "bad number"
    elsif phone_number.length == 11
        phone_number[0] == 1 ? phone_number = phone_number[1..10] : phone_number = "bad number"
    end
    phone_number
end

def peak_hour hours
    temp = Hash.new(0)
    hours.each {|hour| temp[hour] = temp[hour] + 1}
    max = 0
    temp.each_value {|value| max = value if value > max}
    peak_hours = []
    temp.each {|key, value| peak_hours.push(key) if value == max}
    peak_hours
end

def legislators_by_zipcode zipcode
    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    begin
        legislators = civic_info.representative_info_by_address(
            address: zipcode,
            levels: 'country',
            roles: ['legislatorUpperBody', 'legislatorLowerBody']
        ).officials

        legislator_names = legislators.map(&:name)
        legislator_string = legislator_names.join(", ")
    rescue
        "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
    end

end

def save_thank_you_letters (id, form_letter)

    Dir.mkdir("output") unless Dir.exists? "output"

    filename = "output/thanks_#{id}.html"

    File.open(filename,'w') do |file|
        file.puts form_letter
    end
end

Dir.chdir("/home/armando/THE_ODIN_PROJECT/again/event_manager")
contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
template_letter = File.read 'form_letter.html'
erb_template = ERB.new template_letter
hours_register = []
weeks = []

contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)
    phone_number = clean_phone_number(row[:homephone])

    registration_date = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
    hours_register << registration_date.hour
    weeks << registration_date.wday


    #personal_letter = template_letter.gsub("FIRST_NAME", name)
    #personal_letter.gsub!("LEGISLATORS", legislators)

    form_letter = erb_template.result(binding)

    save_thank_you_letters(id, form_letter)

    
end

puts "The peak hours are #{peak_hour(hours_register).join(" and ")} hours"

puts DateTime.strptime(peak_hour(weeks).join(","), '%w').strftime('%A')