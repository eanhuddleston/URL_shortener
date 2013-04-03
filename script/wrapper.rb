require 'launchy'

class Wrapper
  @u = nil

  def self.wrapper
    puts "Please enter your username"
    username = gets.chomp
    @u = User.where(:username => username)[0]
    unless @u
      puts "You are not in our database. Please enter your email to create a new account."
      email = gets.chomp
      @u = User.create(:email => email, :username => username)
    end

    options = { 2 => :open, 3 => :shorten, 4 => :visit_stat,
        5 => :distinct_visits, 6 => :visits_in_ten,
        7 => :my_links, 8 => :comment, 9 => :add_tag }

    userinput = ""
    until userinput == "exit"
      puts "please enter:"
      puts "1. exit"
      puts "2. open"
      puts "3. shorten"
      puts "4. visits statistics"
      puts "5. visits by distinct users"
      puts "6. total visits within last 10 min."
      puts "7. my links"
      puts "8. comment on a link"
      puts "9. add tags"
      userinput = gets.chomp
      break if userinput == "1"
      self.send( options[userinput.to_i] )
    end
  end

  def self.add_tag
    puts "Enter your short URL"
    url = gets.chomp
    puts "Enter your tag: news, sports, entertainment, programming, lifestyle"
    tag = gets.chomp
    Url.add_tag(url, tag)
  end

  def self.open
    puts "Enter your short URL"
    url = gets.chomp
    Launchy.open(@u.open(url))
  end

  def self.shorten
    puts "Enter your long URL"
    url = gets.chomp
    @u.create_url(url)
  end

  def self.visit_stat
    puts "Please enter your short url"
    url = gets.chomp
    puts Url.where(:shortened_url => url)[0].visits
  end

  def self.distinct_visits
    puts "Please enter your short url"
    url = gets.chomp
    puts Url.where(:shortened_url => url)[0].distinct_visits
  end

  def self.visits_in_ten
    puts "Please enter your short url"
    url = gets.chomp
    puts Url.where(:shortened_url => url)[0].ten_min_visits
  end

  def self.my_links
    puts @u.my_links
  end

  def self.comment
    puts "Please enter your short url"
    url = gets.chomp
    puts "Enter your comment"
    comment = gets.chomp
    @u.make_comment(url, comment)
  end
end

Wrapper.wrapper