# Author: Nerdmaster aka Jeremy Echols - see my stuff at https://github.com/Nerdmaster
#
# This file is awesome.  It makes easily-varied text super simple-like.  Seriously.  If you use this
# file for anything you have to tell me.  I really don't think any code has ever been this
# incredible before, so what the hell are you doing thinking you can use it without at least damn
# well telling me?  COME ON!

class String
  # Given a string, strips random parts of (x|y|...) text out, and substitues
  # symbol-like text with symbols in the values hash.
  def variation(values={})
    out = self.dup
    while out.gsub!( %r{\(([^())?]+)\)(\?)?} ){
      ( $2 && ( rand > 0.5 ) ) ? '' : $1.split( '|' ).shuffle.first
    }; end
    out.gsub!( /:(#{values.keys.join('|')})\b/ ){ values[$1.intern] } unless values.empty?
    out.gsub!( /( \t){2,}/, ' ' )
    out.strip!
    out
  end
end

# Magic test code if this is run by itself instead of merely included in another file
if __FILE__ == $0
  s = "(a|b|c) is not necessarily (a|b|c)"
  puts s.variation

  s = "(this is (a test|a drill|a chair)|hello|hi)"
  puts s.variation

  s = "(foo|bar| ) (foo|bar| ) (foo|bar| )"
  puts s.variation.inspect

  s = "Don't forget... (um... |uh... | )(umm... | )(errr.. | | )(don't forget... | | )don't forget to bring a towel..."
  puts s.variation.inspect

  s = "(foo)?(bar)?"
  puts s.variation
end
