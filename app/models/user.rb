class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

=begin
  # Enqueue from a model
  after_commit :async_update # Run on create & update

  private

  def async_update
    UpdateUserJob.perform_later(self)
  end
=end
end

=begin
  # delay the job:
  FakeJob.set(wait: 1.minute).perform_later
  FakeJob.set(wait_until: Date.tomorrow.noon).perform_later
=end
