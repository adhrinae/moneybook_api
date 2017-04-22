require 'spec_helper'
require_relative '../../../../apps/api/controllers/auth/sign_in'

describe Api::Controllers::Auth::SignIn do
  let(:action) { Api::Controllers::Auth::SignIn.new }
  let(:params) { Hash[] }

  it 'is successful' do
    skip
    response = action.call(params)
    response[0].must_equal 200
  end
end
