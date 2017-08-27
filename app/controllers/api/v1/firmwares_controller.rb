module Api
  module V1
    class FirmwaresController < ApplicationController
      def index
        render json: Firmware.all.order(created_at: :desc), status: :ok
      end

      def create
        firmware = Firmware.new firmware_params
        if firmware.save
          hex_file = firmware.generate_hex_file
          if hex_file
            send_data hex_file, filename: "output.hex", type: :text
          else
            render json: {
              errors: firmware.errors,
              errors_sentence: firmware.errors.full_messages.to_sentence
            }, status: :unprocessable_entity
          end
        else
          render json: {
            errors: firmware.errors,
            errors_sentence: firmware.errors.full_messages.to_sentence
          }, status: :unprocessable_entity
        end
      end

      private
      def firmware_params
        params.require(:firmware).permit(:name, :manufacturer, :arduino_model, :pid)
      end
    end
  end
end
