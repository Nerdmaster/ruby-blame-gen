Blame Generator
---------------

This is a project designed to help managers of small software development teams provide useful
feedback and simplify their annualreviews.  Just copy the included blame.yaml-dist file to
blame.yaml, customize it to suit your team and projects, and run it!  You can customize reasons
if necessary, though I am trying to make these useful for just about any development team.

Note that the original name, the "Blame Generator", is somewhat tongue-in-cheek, and is only
preserved for historic reasons.  The application does generate feedback which negative-minded
employees will probably take as personal attack, and certainly can be interpreted as assigning
blame to individuals for project failures.  However, that is not the purpose of this application!
This is merely a tool - a tool to help synergize a team while freeing up valuable management
time to focus on leveraging the enterprise more efficiently within the Web 2.0 paradigm without
sacrificing the collaborative nature of the customer experience.

Usage
-----

Syntax:
    ruby blame.rb [opts]

Possible options:

* --person: Skips the random person selection, using the given value instead.  Requires --pronoun
  to be specified.
* --pronoun: Required if --person is set.  Must be "he" or "she" for use with the person's name.
* --app: Skips the random app selection, using the given value instead
* --app2: Skips the random app selection for the "secondary" app in a review (see below)
* --review: Picks two random apps and a random user, and provides the basis for a thoughtful,
  constructive performance review.  Why two apps?  Over my time as a manager, I've found that
  it's best to give a person reviews based on more than one project, even if they have never
  worked on anything else.

Licensing
---------

This is basically free code for personal use.  If you use it in another project, you really need
to ask yourself if you couldn't possibly find a better way to spend your time.  If you derive
anything from this code, please let me know.  Aside from wanting to know who would do this and why,
there's also a fair chance I can find you a good shrink or something.

Note that the random string variation magic is actually about 100 times more awesome than this app,
and if you find a use for that piece, in all honestly, I'd like to be informed just because I think
it could be used in really interesting and fun ways, especially if somebody puts a little more
"smarts" into it.
