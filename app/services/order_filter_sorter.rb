# app/services/order_filter_sorter.rb
class OrderFilterSorter
  def initialize(relation, params = {})
    @relation = relation
    @params = params
  end

  def call
    filtered = filter_by_status(@relation)
    sorted = sort_by_date(filtered)
    sorted
  end

  private

  def filter_by_status(scope)
    case @params[:status]
    when "Delivered"
      scope.where(delivered?: true)
    when "Pending"
      scope.where(delivered?: false)
    else
      scope
    end
  end

  def sort_by_date(scope)
    case @params[:sort]
    when "oldest"
      scope.order(created_at: :asc)
    else
      scope.order(created_at: :desc)
    end
  end
end
