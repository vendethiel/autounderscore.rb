module AutoUnderscore
  class Evaluator
    # @param [AST::Node] ast
    # @param [List<Object>] arg
    def self.run(ast, args)
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
        fn_args[@state++]
      when AST::Call
        args = node.args.map do |arg|
          if arg.instance_of?(Underscore)
            arg[*fn_args]
          elsif arg.instance_of?(Node)
            arg.evaluate(eval_arg, fn_args)
          else
            arg
          end
        end

        eval_arg.send(node.fn_name, *args)
      end
    end
  end
end