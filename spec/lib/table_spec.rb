RSpec.describe TableInspector::Table do
  describe "#render" do
    context "with `sql_type: true` option" do
      context "with `colorize: false` option" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: true, colorize: false)
        action = -> { described_class.new(User, presenter_option).render }
        it_behaves_like "output table info with SQL type and without colorful scheme", action
      end

      context "with `colorize: true` option" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: true, colorize: true)
        action = -> { described_class.new(User, presenter_option).render }
        it_behaves_like "output table info with SQL type and colorful scheme", action
      end
    end

    context "with `sql_type: false` option" do
      context "with `colorize: false`" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: false, colorize: false)
        action = -> { described_class.new(User, presenter_option).render }
        it_behaves_like "output table info without SQL type and colorful scheme", action
      end

      context "with `colorize: true` option" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: false, colorize: true)
        action = -> { described_class.new(User, presenter_option).render }
        it_behaves_like "output table info without SQL type and with colorful scheme", action
      end
    end

    context "with `comment_only: true` option" do
      it "output table correctly" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: false, colorize: false, comment_only: true)
        expectation = expect { described_class.new(User, presenter_option).render }
        expectation.to output(/Table.*: users/).to_stdout
        expectation.to output(/Name.*Comment/).to_stdout
        expectation.not_to output(/.*Type.*Limit.*Null.*Default.*Precision.*Scale/).to_stdout
      end
    end

    context "with `comment_only: false` option" do
      it "output table only two columns which are name and comment" do
        presenter_option = TableInspector::PresenterOption.new(sql_type: false, colorize: false, comment_only: false)
        expectation = expect { described_class.new(User, presenter_option).render }
        expectation.to output(/Table.*: users/).to_stdout
        expectation.to output(/Name.*Type.*Limit.*Null.*Default.*Precision.*Scale.*Comment/).to_stdout
        expectation.to output(/id.*integer/).to_stdout
        expectation.to output(/name.*string/).to_stdout
      end
    end
  end
end