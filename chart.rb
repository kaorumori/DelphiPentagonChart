class Chart
  require 'pango'

  attr_accessor :image

  def draw_pentagon(context, layout, width, height, scale_start, scale_end, data, color)
    context.set_source_color(Cairo::Color.parse("##{color}"))
    context.move_to((data[0] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.8)
    context.line_to((data[0] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.5)
    context.line_to((data[1] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.2)
    context.line_to((data[2] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.5)
    context.line_to((data[2] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.8)
    context.fill_preserve
    context.set_source_rgb(0.3, 0.3, 0.3)
    context.stroke
  end

  def draw_expert(context, layout, width, height, scale_start, scale_end, data, color, index)
    context.set_source_rgb(1, 1, 1)
    context.move_to((data[0] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * (0.7 - index * 0.1))
    context.line_to((data[2] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * (0.7 - index * 0.1))
    context.fill_preserve
    context.set_source_rgb(0.3, 0.3, 0.3)
    context.stroke

    r = height * 0.04
    context.set_source_color(Cairo::Color.parse("##{color}"))
    context.circle((data[1] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * (0.7 - index * 0.1), r)
    context.fill_preserve
    context.set_source_rgb(0.3, 0.3, 0.3)
    context.stroke
  end

  def draw_separator(context, width, height, scale_start, scale_end, scale)
    context.set_source_color(Cairo::Color.parse('#aaa'))
    context.set_line_width(2.0)
    context.set_dash(3.0)

    separator = scale_start
    while(separator <= scale_end)
      context.move_to((separator - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.15)
      context.line_to((separator - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.8)
      context.stroke

      separator += scale
    end

    context.set_dash(nil)
  end

  def draw_years(context, layout, width, height, scale_start, scale_end, scale, data, mode)
    context.set_source_color(Cairo::Color.parse('#000000'))

    if mode == 'point'
      layout.width = 30 * Pango::SCALE

      layout.alignment = Pango::ALIGN_RIGHT
      context.move_to((data[0] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15 - 30, height * 0.85)
      markup = "<b>#{data[0]}</b>"
      attr_list, text = Pango.parse_markup(markup)
      layout.text = text
      layout.attributes = attr_list
      context.show_pango_layout(layout)

      layout.alignment = Pango::ALIGN_CENTER
      context.move_to((data[1] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15 - 15, height * 0.05)
      markup = "<b>#{data[1]}</b>"
      attr_list, text = Pango.parse_markup(markup)
      layout.text = text
      layout.attributes = attr_list
      context.show_pango_layout(layout)

      layout.alignment = Pango::ALIGN_LEFT
      context.move_to((data[2] - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15, height * 0.85)
      markup = "<b>#{data[2]}</b>"
      attr_list, text = Pango.parse_markup(markup)
      layout.text = text
      layout.attributes = attr_list
      context.show_pango_layout(layout)
    else
      layout.width = 30 * Pango::SCALE
      layout.alignment = :center

      separator = scale_start
      while(separator <= scale_end)
        context.move_to((separator - scale_start).to_f / (scale_end - scale_start).to_f * width * 0.7 + width * 0.15 - 15, height * 0.85)
        markup = "<b>#{separator}</b>"
        attr_list, text = Pango.parse_markup(markup)
        layout.text = text
        layout.attributes = attr_list
        context.show_pango_layout(layout)

        separator += scale
      end
    end
  end

  def initialize(params)
    format = Cairo::FORMAT_ARGB32
    width = params[:size].split('x')[0].to_i
    height = params[:size].split('x')[1].to_i
    surface = Cairo::ImageSurface.new(format, width, height)
    context = Cairo::Context.new(surface)
    layout = context.create_pango_layout
    layout.set_font_description(Pango::FontDescription.new("Monapo 12"))

    bgcolor = params[:bgcolor]
    if bgcolor
      context.set_source_color(Cairo::Color.parse("##{bgcolor}"))
      context.rectangle(0, 0, width, height)
      context.fill
    end

    scale_start = params[:start].to_i
    scale_end = params[:end].to_i
    if scale_start > scale_end
      scale_start, scale_end = scale_end, scale_start
    end

    scale = params[:scale].to_i
    if scale < 1
      scale = 10
    end

    draw_separator(context, width, height, scale_start, scale_end, scale)

    colors = params[:color].split('-')
    datasets = params[:data].split('-')
    datasets.each_with_index do |data, i|
      data = data.split(',')
      data.map! {|value| value.to_i}
      unless colors[i]
        colors[i] = 'ff7f50'
      end
      draw_pentagon(context, layout, width, height, scale_start, scale_end, data, colors[i])
    end

    if params[:exdata]
      datasets = params[:exdata].split('-')
      datasets.each_with_index do |data, i|
        data = data.split(',')
        data.map! {|value| value.to_i}
        unless colors[i]
          colors[i] = 'ff7f50'
        end
        draw_expert(context, layout, width, height, scale_start, scale_end, data, colors[i], i)
      end
    end

    context.set_source_rgb(0.5, 0.5, 0.5)
    context.set_line_width(2.0)
    context.move_to(width * 0.05, height * 0.8)
    context.line_to(width * 0.95, height * 0.8)
    context.stroke

    mode = params[:mode] || 'scale'
    if datasets.size > 1
      mode = 'scale'
    end

    data = datasets[0].split(',').map {|value| value.to_i}
    draw_years(context, layout, width, height, scale_start, scale_end, scale, data, mode)

    buffer = StringIO.new
    surface.write_to_png(buffer)

    @image = buffer.string
  end
end
