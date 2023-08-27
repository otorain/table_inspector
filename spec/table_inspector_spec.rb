
RSpec.describe TableInspector do
  describe "#scan" do
    context "the klass argument passed cannot be transform to a valid model class" do
      it "puts the hint and abort" do
        expect do
          TableInspector.scan("User1")
        end.to output(/'"User1"' cannot be transformed to a valid model class./).to_stdout
      end
    end

    context "with `sql_type: true` option" do
      action = -> { TableInspector.scan(User, sql_type: true) }
      it_behaves_like "output table info with SQL type and without colorful scheme", action
    end

    context "with `sql_type: false` option" do
      action = -> { TableInspector.scan(User, sql_type: false) }
      it_behaves_like "output table info without SQL type and colorful scheme", action
    end

    context "specify a column" do
      context "passed an invalid column that does not exist" do
        it "puts the hint and abort" do
          expect do
            TableInspector.scan(User, :name1)
          end.to output(/'name1' doesn't exist in table 'users'./).to_stdout
        end
      end

      context "with `sql_type: true` option" do
        action = -> { TableInspector.scan(User, :name, sql_type: true) }
        it_behaves_like "output column info with SQL type and without colorful scheme", action
      end

      context "with `sql_type: false` option" do
        action = -> { TableInspector.scan(User, :name, sql_type: false) }
        it_behaves_like "output column info without SQL type and colorful scheme", action
      end
    end
  end

  describe "#ascan" do
    context "with `sql_type: true` option" do
      action = -> { TableInspector.ascan(User, sql_type: true) }
      it_behaves_like "output table info with SQL type and colorful scheme", action
    end

    context "with `sql_type: false` option" do
      action = -> { TableInspector.ascan(User, sql_type: false)}
      it_behaves_like "output table info without SQL type and with colorful scheme", action
    end

    context "specify a column" do
      context "with `sql_type: true` option" do
        action = -> { TableInspector.ascan(User, :name, sql_type: true) }
        it_behaves_like "output column info with SQL type and colorful scheme", action
      end

      context "with `sql_type: false` option" do
        action = -> { TableInspector.ascan(User, :name, sql_type: false) }
        it_behaves_like "output column info without SQL type and with colorful scheme", action
      end
    end
  end
end