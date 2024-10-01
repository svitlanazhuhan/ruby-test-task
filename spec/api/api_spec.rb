RSpec.describe 'Reqres API' do
  let(:user_id) { 2 }
  let(:user_data) { { name: 'John Doe', job: 'Engineer' } }

  before(:all) do
    @api = ReqresAPI.new
  end

  it 'retrieves a list of users' do
    response = @api.get_users
    expect(response.code).to eq(200)
    expect(response['data']).not_to be_empty
    expect(response['data'][0]['email']).to match(/\A[^@\s]+@[^@\s]+\z/)
  end

  it 'retrieves a single user' do
    response = @api.get_user(user_id)
    expect(response.code).to eq(200)
    expect(response['data']['id']).to eq(user_id)
    expect(response['data']['first_name']).not_to be_nil
  end

  it 'creates a new user' do
    response = @api.create_user(user_data)
    expect(response.code).to eq(201)
    expect(response['name']).to eq(user_data[:name])
    expect(response['job']).to eq(user_data[:job])
  end

  it 'updates an existing user' do
    response = @api.update_user(user_id)
    expect(response.code).to eq(200)
    expect(response['updatedAt']).not_to be_nil
  end

  it 'deletes a user' do
    response = @api.delete_user(user_id)
    expect(response.code).to eq(204)
  end
end