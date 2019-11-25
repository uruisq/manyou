FactoryBot.define do
  factory :task01 do
    title { 'task01' }
    limit { '2019/12/2 16:00' }
    status { '未着手' }
  end
end