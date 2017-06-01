module Api
  module V1
    class FirmwaresController < ApplicationController
      def create
        render json: { message: 'getting closer...'}, status: :ok
      end
    end
  end
end
