module AutoUnderscore
  class Underscore
    attr_reader :ast

    # @param [List<Ast::Node>] ast
    def initialize(ast)
      @ast = ast
    end

    def self.wrap(name, as = name)
      self.define_method as do |*args|
        with_ast(AST::Call.new(name, args))
      end
    end

    def [](*args)
      Evaluator.evaluate(@ast, args)
    end

    # .to_s is not method_missing
    wrap :to_s
    # Special method to allow actual indexing in code
    wrap :[], :__index

    private

    def method_missing(symbol, *args)
      with_ast(AST::Call.new(symbol, args))
    end

    def with_ast(ast)
      Underscore.new(@ast + [ast])
    end
  end
end