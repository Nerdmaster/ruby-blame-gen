# Yeah, the whole of rubygems just to pull in getopt/long.  This is a management tool, so
# dependencies need to make as little sense as possible.
require "rubygems"
require "getopt/long"

# YAML is needed for parsing YOUR COMPANY'S specific names and apps!
require "yaml"

# This is an amazing fucking piece of code.  Seriously.
require "random_text"

opts = Getopt::Long.getopts(
  ["--person", "-p", Getopt::REQUIRED],
  ["--pronoun", "-n", Getopt::REQUIRED],
  ["--app", "-a", Getopt::REQUIRED],
  ["--app2", "-2", Getopt::REQUIRED],
  ["--review", "-r", Getopt::BOOLEAN]
)

unless FileTest.exist?("blame.yaml")
  $stderr.puts "Unable to load blame.yaml - you must copy the distributed file, blame.yaml-dist, and customize it for your team."
  exit
end

data = YAML.load_file("blame.yaml")

# You are encouraged to customize this stuff - create a yaml file based on the -dist file provided!
people  = data["people"]
reasons = data["reasons"]
apps    = data["apps"]
formats = data["formats"]

people.shuffle!
people.shuffle!
reasons.shuffle!
reasons.shuffle!
apps.shuffle!
apps.shuffle!

person  = (opts["person"] && opts["pronoun"]) ? {"name" => opts["person"], "pronoun" => opts["pronoun"]} : people.shift
app     = opts["app"] || apps.shift
app2    = opts["app2"] || apps.shift

# Reviews are a bit wonky, because we need to have so much text as well as pulling reasons which are
# distinct.  Even with text variations, I've found that employees don't like being told the same
# thing multiple times in one review.
#
# NOTE: This can still produce odd reviews, such as telling somebody that they were too
# detail-oriented and not detail-oriented enough.  It may make sense to hire an illegal immigrant
# to look over these reviews before you send them out.
if opts["review"]
  rr = lambda { reasons.shift.variation.sub(/^(\w)/) { $1.upcase } }
  format = %Q|
Projects which demonstrate {person}'s poor performance:

Primary Project: {app}

* #{rr.call}
* #{rr.call}
* #{rr.call}

Secondary Project: {app2}

* #{rr.call}
* #{rr.call}
* #{rr.call}
  |.strip
else
  format = formats.shuffle.shuffle.shift
end

format.gsub!("{app}", app)
format.gsub!("{app2}", app2)
format.gsub!("{person}", person["name"])
format.gsub!("{pronoun}", person["pronoun"])
format.gsub!("{reason}", reasons.first)

puts format.variation
