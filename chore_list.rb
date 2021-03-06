require './lib/task'
require './lib/list'

@lists = []

def main_menu
  if @lists.length >= 1
    puts "Press 'd' to display all lists or 'l' create a new list or 'e' to edit list"
  else
    puts "Press 'l' create a new list"
  end
  puts "Press 'x' to exit."
  main_choice = gets.chomp
  if main_choice == 'd'
    show_lists
  elsif main_choice == 'l'
    new_list
  elsif main_choice == 'e'
    edit_lists
  elsif main_choice == 'x'
    puts "Good-bye!"
  else
    puts "Sorry, that wasn't a valid option."
    main_menu
  end
end

def list_menu(current_list)
  puts "Press 'a' to add a task, 'd' to delete a task, 's' to show tasks or 'x' to go back to main menu"
  main_choice = gets.chomp
  if main_choice == 'a'
    new_task(current_list)
  elsif main_choice == 's'
    display_tasks(current_list)
  elsif main_choice == 'd'
    delete_tasks(current_list)
  elsif main_choice == 'x'
    main_menu
  else
    puts "Sorry, that wasn't a valid option."
    main_menu
  end
end

def new_list
  puts "List Name:"
  list_name = gets.chomp
  new_list = List.new(list_name)
  @lists << new_list
  list_menu(new_list)
end


def new_task(current_list)
  puts "Add a task to this list"
  new_task = gets.chomp
  current_list.add_task(new_task)
  list_menu(current_list)
end

def show_lists
  @lists.each_with_index do |list, index|
    print (index).to_s + ': ' + list.list_name + ', '
  end
end

def display_tasks(current_list)
  current_list.show_tasks.each_with_index do |cur_task, index|
    print index.to_s + ': ' + cur_task + ', '
  end
  list_menu(current_list)
end

def edit_lists
  show_lists
  puts "Type in a list to edit"
  chosen_list = gets.chomp.to_i
  list_position = @lists.index(chosen_list)
  list_menu(@lists[list_position.to_i])
end

def delete_tasks (current_list)
  current_list.show_tasks.each_with_index do |cur_task, index|
    print index.to_s + ': ' + cur_task + ', '
  end
  puts "type the task you want to delete"
  deleted_task = gets.chomp.to_i
  current_list.show_tasks.delete_at(deleted_task)
  list_menu(current_list)
end

main_menu
