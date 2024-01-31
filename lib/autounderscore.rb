require 'autounderscore/ast'
require 'autounderscore/underscore'
require 'autounderscore/evaluator'

module AutoUnderscore
  def _(idx = nil)
    if idx == nil
      Underscore.new([AST::NextArgument.new])
    else
      Underscore.new([AST::ArgumentReference.new(idx)])
    end
  end

  def it
    Underscore.new([AST::ArgumentReference.new(0)])
  end

  def self._(idx = 0)
    Underscore.new([AST::ArgumentReference.new(idx)])
  end

  def self.it
    Underscore.new([AST::NextArgument.new])
  end
end
