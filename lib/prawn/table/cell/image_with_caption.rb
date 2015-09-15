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
          opacity = @caption_options[:opacity] || 0.5
          @pdf.bounding_box [ 0, caption_height + 1 ], :width => natural_content_width, :height => caption_height do
            @pdf.transparent opacity do
              @pdf.fill { @pdf.rectangle [ 0, caption_height], natural_content_width, caption_height }
            end
            @pdf.fill_color = @caption_options[:color]
            padding = @caption_options[:padding] || [ 0, 0, 0, 0 ]
            bounding_box_options = {
              :width => natural_content_width - padding.second - padding.fourth,
              :height => caption_height - padding.first - padding.third
            }
            @pdf.font @caption_options[:font] do
              @pdf.bounding_box [ padding.fourth, @pdf.cursor - padding.first ], bounding_box_options do
                @pdf.text @caption, @caption_options
              end
            end
            @pdf.fill_color = "000000"
          end
        end

      end
    end
  end
end
