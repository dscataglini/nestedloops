class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[ show edit update destroy toggle_completed ]

  # GET /todo_items or /todo_items.json
  def index
    @todo_items = TodoItem
    if params[:todo_list_id]
      @todo_items = @todo_items.where(todo_list_id: params[:todo_list_id])
    else
      @todo_items = @todo_items.order(:todo_list_id, :completed).all
      
    end
  end

  # GET /todo_items/1 or /todo_items/1.json
  def show
  end

  # GET /todo_items/new
  def new
    if TodoList.count.zero?
      redirect_to new_todo_list_path
    else  
      @todo_item = TodoItem.new(todo_list_id: params[:todo_list_id])
    end
  end

  # GET /todo_items/1/edit
  def edit
    respond_to do |format|
      format.html { 
        if params[:inline]
          render(partial: 'todo_items/form', locals: { todo_item: @todo_item } )
        end
      }
      format.json 
    end
  end
  
  def toggle_completed
    @todo_item.toggle! :completed
    respond_to do |format|
      format.html { redirect_to todo_list_path(@todo_item.todo_list) }
      format.json { render :show, status: :created, location: @todo_item }
    end
  end

  # POST /todo_items or /todo_items.json
  def create
    @todo_item = TodoItem.new(todo_item_params)
    respond_to do |format|
      if @todo_item.save!
        format.html { redirect_to @todo_item.todo_list, notice: "Todo item was successfully created." }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1 or /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { 
           if params[:inline] == 'true'
            render(@todo_item) 
          else
            redirect_to(@todo_item)
          end

        }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render(:edit) }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1 or /todo_items/1.json
  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: "Todo item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.require(:todo_item).permit(:description, :completed, :todo_list_id, :timestamps)
    end
end
