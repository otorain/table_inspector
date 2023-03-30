
def print_all_indexes_correctly(expectation)
  expectation.to output(/Indexes/).to_stdout
  expectation.to output(/Name.*Columns.*Unique\?/).to_stdout
  expectation.to output(/index_users_on_name.*\[name\].*UNIQUE/).to_stdout
end

RSpec.shared_examples "output table info with SQL type and without colorful scheme" do |action|
  it "output table correctly" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment.*Sql type/).to_stdout
    expectation.to output(/id.*integer/).to_stdout
    expectation.not_to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output table info with SQL type and colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment.*Sql type/).to_stdout
    expectation.to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output table info without SQL type and colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment/).to_stdout
    expectation.to output(/id.*integer/).to_stdout
    expectation.not_to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output table info without SQL type and with colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment/).to_stdout
    expectation.to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output column info with SQL type and without colorful scheme" do |action|
  it "output table correctly" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users.*Column.*name/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment.*Sql type/).to_stdout
    expectation.not_to output(/id.*integer/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output column info with SQL type and colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users.*Column.*name/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment.*Sql type/).to_stdout
    expectation.not_to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/\e\[33mname.*\e\[33mstring/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output column info without SQL type and colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users.*Column.*name/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment/).to_stdout
    expectation.not_to output(/id.*integer/).to_stdout
    expectation.to output(/name.*string/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end

RSpec.shared_examples "output column info without SQL type and with colorful scheme" do |action|
  it "output table" do
    expectation = expect { action.call }
    expectation.to output(/Table.*: users.*Column.*name/).to_stdout
    expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment/).to_stdout
    expectation.not_to output(/\e\[33mid.*\e\[34minteger/).to_stdout
    expectation.to output(/\e\[33mname.*\e\[33mstring/).to_stdout
    print_all_indexes_correctly(expectation)
  end
end
