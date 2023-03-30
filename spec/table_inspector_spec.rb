
RSpec.describe TableInspector do
  describe "#scan" do
    context "with `sql_type: true` option" do
      action = -> { TableInspector.scan(User, sql_type: true) }
      it_behaves_like "output table info with SQL type and without colorful scheme", action
    end

    context "with `sql_type: false` option" do
      action = -> { TableInspector.scan(User, sql_type: false) }
      it_behaves_like "output table info without SQL type and colorful scheme", action
    end

    context "specify a column" do
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