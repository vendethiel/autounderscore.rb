module AutoUnderscore
  module AST
    class Node
    end

    class ArgumentReference < Node
      attr_reader :idx

      # @param [Integer] idx
      def initialize(idx)
        @idx = idx
      end
    end

    class NextArgument < Node
    end

    class Call < Node
      attr_reader :fn_name
      attr_reader :args

      # @param [Symbol] function name
      # @param [List<Object>] function arguments
      def initialize(symbol, args)
        @fn_name = symbol
        @args = args
      end
    end
  end
end