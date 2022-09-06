defmodule OnionWeb.InputHelpers do
  @moduledoc """
  The following functions provide a set of HTML input helpers styled using Tailwind. 
  """
  use Phoenix.HTML

  @doc """
  Create an input element based on the field type. 

  Accepts the following specific `options`: 
  * :label_text - defines the label associated with the input. If no :label_text is provided, the uppercase name of
  the field is used with underscores replaced by spaces.
  * :label - if set to `false` no label will be displayed. 

  All other `options` are forwarded to the underlying input.

  """
  def my_input(form, field, opts \\ []) do
    # Return the input type for the given field
    type = Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "px-3 mb-4 mt-4 flex-grid"]
    label_opts = [class: "label"]
    input_opts = [class: "input", "phx-debounce": "blur"]

    input_opts = Keyword.merge(input_opts, opts)

    content_tag :div, wrapper_opts do
      label_text =
        if opts[:label_text] do
          opts[:label_text]
        else
          field
        end

      label =
        if opts[:label] == false do
          " "
        else
          label(form, field, humanize(label_text), label_opts)
        end

      input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
      error = OnionWeb.ErrorHelpers.error_tag(form, field)

      [label, input, error]
    end
  end

  @doc """
  Creates checkbox for the given field. 


  Accepts the following specific `options`: 
  * :label_text - defines the label associated with the input. If no :label_text is provided, the uppercase name of
  the field is used with underscores replaced by spaces.
  """
  def my_checkbox(form, field, opts \\ []) do
    wrapper_opts = [class: "px-3 mb-4 mt-4 md:mb-0 flex-grid"]

    content_tag :div, wrapper_opts do
      label_text =
        if opts[:label_text] do
          opts[:label_text]
        else
          field
        end

      label = label(form, label_text, class: "tracking-wide")

      type = :checkbox

      input = apply(Phoenix.HTML.Form, type, [form, field, [class: "ml-10"]])
      [label, input]
    end
  end

  @doc """
  Creates a submit button with the given label. 
  """
  def my_submit(label, opts \\ []) do
    wrapper_opts = [class: "px-3 mb-8 mt-8 md:mb-0 flex-grid"]

    opts = Keyword.put_new(opts, :class, "submit")

    content_tag :div, wrapper_opts do
      Phoenix.HTML.Form.submit(label, opts)
    end
  end
end
