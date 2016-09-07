defmodule MyMacros do
  defmacro myunless(condition, do: do_block, else: else_block) do
    quote do
      if !unquote(condition) do
        unquote(do_block)
      else
        unquote(else_block)
      end
    end
  end

  defmacro times_n(n) do
    func_name = String.to_atom("times_#{n}")
    quote do
      def unquote(func_name)(m) do
        unquote(n) * m
      end
    end
  end

  defmodule Explainer do
    defmacro make(operator, humanize, from, by) do
      quote do
        def explainer({unquote(operator), _, [left, right]}) 
          when is_number(left) and is_number(right) do
          unquote(humanize) <> "#{right}" <> unquote(from) <> "#{left}"
        end
        def explainer({unquote(operator), _, [left, right]})
          when is_number(left) do
          "#{explainer(right)}, then " <> unquote(humanize) <> unquote(from) <> "#{left}"
        end
        def explainer({unquote(operator), _, [left, right]})
          when is_number(right) do
          "#{explainer(left)}, then " <> unquote(humanize) <> unquote(by) <> "#{right}"
        end
        def explainer({unquote(operator), _, [left, right]}) do
          "#{explainer(left)}, then #{explainer(right)}, then " <> unquote(humanize)
        end
      end
    end
  end

  defmodule Explain do
    require Explainer

    Explainer.make(:+, "add ",      "to ",   "")
    Explainer.make(:-, "subtract ", "from ", "")
    Explainer.make(:*, "multiply ", "by ",   "by ")
    Explainer.make(:/, "divide ",   "into ", "by ")

    defmacro explain(n) when is_number(n), do: "#{n}"

    defmacro explain {op, _, [left,right]} do
      explainer {op, nil, [left, right]}
    end
  end
end
