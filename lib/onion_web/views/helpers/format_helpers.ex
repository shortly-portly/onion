
defmodule OnionWeb.InputHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
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

      [label, input, error || ""]
    end
  end
  
  def input_compact(form, field, opts \\ []) do
    # Return the input type for the given field
    type = Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "flex-grid"]
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

      [label, input, error || ""]
    end
  end

  def my_select(form, field, options, opts \\ []) do
    # Return the input type for the given field

    wrapper_opts = [class: "px-3 mb-4 mt-4 md:mb-0 flex-grid"]
    label_opts = [class: "label"]
    input_opts = [class: "input", "phx-debounce": "blur"]

    input_opts = Keyword.merge(input_opts, opts)

    input_opts =
      if opts[:readonly] do
        Keyword.merge(input_opts, readonly: true)
      else
        input_opts
      end

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

      input = apply(Phoenix.HTML.Form, :select, [form, field, options, input_opts])
      error = OnionWeb.ErrorHelpers.error_tag(form, field)

      [label, input, error ]
    end
  end

  def read_only(form, field, text) do
    wrapper_opts = [class: "px-3 mb-4 mt-4 md:mb-0 flex-grid"]

    content_tag :div, wrapper_opts do
      label = label(form, field, class: "label")

      text =
        content_tag :div, class: "input" do
          text
        end

      [label, text]
    end
  end

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

  def date(form, field, opts \\ []) do
    type = :text_input

    wrapper_opts = [class: "px-3 mt-2 mb-2  flex-grid"]
    label_opts = [class: "label"]
    input_opts = [class: "input", phx_hook: "Wobble", readonly: true]

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
      [label, input, error || ""]
    end
  end

  def my_submit(label, opts \\ []) do
    wrapper_opts = [class: "px-3 mb-8 mt-8 md:mb-0 flex-grid"]

    opts = Keyword.put_new(opts, :class, "submit")

    content_tag :div, wrapper_opts do
      Phoenix.HTML.Form.submit(label, opts)
    end
  end
end
