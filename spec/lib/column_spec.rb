
RSpec.describe TableInspector::Column do
  describe "#render" do
    context "with `sql_type: true` option" do
      context "with `colorize: false` option" do
        action = -> { TableInspector::Column.new(User, :name, sql_type: true, colorize: false).render }
        it_behaves_like "output column info with SQL type and without colorful scheme", action
      end

      context "with `colorize: true` option" do
        action = -> { TableInspector::Column.new(User, :name, sql_type: true, colorize: true).render }
        it_behaves_like "output column info with SQL type and colorful scheme", action
      end
    end

    context "with `sql_type: false` option" do
      context "with `colorize: false`" do
        action = -> { TableInspector::Column.new(User, :name, sql_type: false, colorize: false).render }
        it_behaves_like "output column info without SQL type and colorful scheme", action
      end

      context "with `colorize: true` option" do
        action = -> { TableInspector::Column.new(User, :name, sql_type: false, colorize: true).render }
        it_behaves_like "output column info without SQL type and with colorful scheme", action
      end
    end
  end
end