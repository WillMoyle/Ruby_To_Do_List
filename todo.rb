# Command Line To Do List App
# Author: Will Moyle
# Last Updated: 29 Feb 2016

# Menu module

module Menu
    
    def menu
        "What task do you wish to perform?\n\t1. Add a new task\n\t2. Show all current tasks\n\t3. Write to a file\n\t4. Read from a file\n\tQ. Quit the program"
    end
    
    def show
        puts menu
    end
    
end

# Promptable module

module Promptable
    
    def prompt(message = "What would you like to do?", symbol = ":> ")
        puts message
        print symbol
        gets.chomp
    end
    
end
        


# List class

class List
    include Promptable
    attr_reader :all_tasks

    def initialize
        @all_tasks = []
    end

    # add task to list
    def add
        description = prompt("Task description.")
        new_task = Task.new(description)
        @all_tasks.push(new_task)
    end

    # show all tasks
    def show
        all_tasks.each {|task| puts task.description}
    end

    # read a task from a file
    def read_from_file
        filename = prompt("Enter filename.")
        tasks = IO.readlines(filename)
        tasks.each do |d|
            @all_tasks.push(Task.new(d))
        end
    end


    # write a list to a file
    def write_to_file
        filename = prompt("Enter filename.")
        data = ""
        all_tasks.each do |t|
            data += t.description + "\n"
        end
        
        File.open(filename, 'w+') {|f| f.write(data)}
    end

    # delete a task

    # update a task

end


# Task class

class Task

    attr_reader :description

    def initialize(description)
        @description = description
    end

end

my_list = List.new
include Menu
include Promptable

continue = true

while continue
    response = prompt(menu)
    
    case response
        when "1" then my_list.add
        when "2" then my_list.show
        when "3" then my_list.write_to_file
        when "4" then my_list.read_from_file
        when "Q" then continue = false
        
        else puts "Invalid input"
    end
    
end
        
    
    
