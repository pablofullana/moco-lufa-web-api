module Api
  module V1
    class StaticController < ApplicationController
      def info
        render json: { message: 'info here'}, status: :ok
      end
    end
  end
end
