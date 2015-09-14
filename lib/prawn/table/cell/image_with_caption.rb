# encoding: utf-8
module Prawn
  class Table
    class Cell

      # @private
      class ImageWithCaption < Image

        def caption=(caption)
          @caption = caption
        end

        def caption_options=(caption_options)
          @caption_options = caption_options
        end

        def caption_height
          @caption_options[:height]
        end

        def draw_content
          super
          return unless @caption.present?
          @pdf.bounding_box [ 0, caption_height + 1 ], :width => natural_content_width, :height => caption_height do
            @pdf.transparent 0.5 do
              @pdf.fill { @pdf.rectangle [ 0, caption_height], natural_content_width, caption_height }
            end
            @pdf.fill_color = @caption_options[:color]
            @pdf.font @caption_options[:font] do
              @pdf.text_box @caption, @caption_options.merge(:width => natural_content_width)
            end
            @pdf.fill_color = "000000"
          end
        end

      end
    end
  end
end
