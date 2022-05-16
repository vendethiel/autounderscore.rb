module AutoUnderscore
  module Evaluator
    # TODO move actual evaluation here?
    # As it stands, Evaluator doesn't do much.

    # @param [AST::Node] ast
    # @param [List<Object>] arg
    def self.evaluate(ast, args)
      arg = args[0]
      ast.each do |node|
        arg = node.evaluate(arg, args)
      end
      arg
    end
  end
end