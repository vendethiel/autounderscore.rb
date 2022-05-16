module AutoUnderscore
  module AST
    class Node
      def evaluate(eval_arg, fn_args)
        raise "#evaluate called on AST::Node itself"
      end
    end

    class ArgumentReference < Node
      # @param [Integer] idx
      def initialize(idx)
        @idx = idx
      end

      def evaluate(eval_arg, fn_args)
        fn_args[@idx]
      end
    end

    class Call < Node
      # @param [Symbol] symbol
      # @param [List<Object>] args
      def initialize(symbol, args)
        @fn_name = symbol
        @args = args
      end

      def evaluate(eval_arg, fn_args)
        args = @args.map do |arg|
          if arg.instance_of?(Underscore)
            arg[*fn_args]
          elsif arg.instance_of?(Node)
            arg.evaluate(eval_arg, fn_args)
          else
            arg
          end
        end

        eval_arg.send(@fn_name, *args)
      end
    end
  end
end