# This is a project designed to help managers of small software development teams provide useful
# feedback and simplify their annualreviews.  Just copy the included blame.yaml-dist file to
# blame.yaml, customize it to suit your team and projects, and run it!  You can customize reasons
# if necessary, though I am trying to make these useful for just about any development team.
#
# Syntax:
#     ruby blame.rb [opts]
# 
# Possible options:
#
# * --person: Skips the random person selection, using the given value instead.  Requires --pronoun
#   to be specified.
# * --pronoun: Required if --person is set.  Must be "he" or "she" for use with the person's name.
# * --app: Skips the random app selection, using the given value instead
# * --app2: Skips the random app selection for the "secondary" app in a review (see below)
# * --review: Picks two random apps and a random user, and provides the basis for a thoughtful,
#   constructive performance review.  Why two apps?  Over my time as a manager, I've found that
#   it's best to give a person reviews based on more than one project, even if they have never
#   worked on anything else.
#
# This is basically free code for personal use.  If you use it in another project, you really need
# to ask yourself if you couldn't possibly find a better way to spend your time.  If you derive
# anything from this code, please let me know.  Maybe I can find you a good shrink or something.

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
