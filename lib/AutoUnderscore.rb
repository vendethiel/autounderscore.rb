require 'autounderscore/ast'
require 'autounderscore/underscore'
require 'autounderscore/evaluator'

module AutoUnderscore
  def _(idx = 0)
    Underscore.new([AST::ArgumentReference.new(idx)])
  end

  def it
    _(0)
  end

  def self._(idx = 0)
  end

  def self.it
    Underscore.new([])
  end

  (0..9).each do |i|
    define_method "_#{i}", -> { _(i) }
    self.class.define_method "_#{i}", -> { _(i) }
  end
end
