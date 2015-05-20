FactoryGirl.define do
  factory :chunk, class: MyDataProcessors::Models::Chunk do
    id 'foo'
    date '2015-01-01'

    factory :visits_chunk do
      data('1' => [[1, 1], [1, 1]],
           '2' => [[1, 1], [1, 1]],
           '3' => [[1, 1], [1, 1]],
           '2' => [[1, 1], [1, 1]])
    end
  end
end
