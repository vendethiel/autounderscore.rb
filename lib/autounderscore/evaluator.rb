module AutoUnderscore
  class Evaluator
    # @param [AST::Node] ast
    # @param [List<Object>] arg
    def self.evaluate(ast, args)
      self.new.evaluate_ast(ast, args)
    end

    def evaluate_ast(ast, args)
      arg = args[0]
      ast.each do |node|
        arg = evaluate(node, arg, args)
      end
      arg
    end

    def initialize()
      @state = 0
    end

    def evaluate(node, eval_arg, fn_args)
      case node
      when AST::ArgumentReference
        fn_args[node.idx]
      when AST::NextArgument
        idx = @state
        @state = @state + 1
        fn_args[idx]
      when AST::Call
        args = node.args.map do |arg|
          if arg.instance_of?(Underscore)
            evaluate_ast(arg.ast, fn_args)
          elsif arg.instance_of?(AST::Node)
            evaluate(arg, eval_arg, fn_args)
          else
            arg
          end
        end

        eval_arg.send(node.fn_name, *args)
      else
        raise "No such node type: #{node.class}"
      end
    end
  end
end