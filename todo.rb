# Command Line To Do List App
# Author: Will Moyle
# Last Updated: 29 Feb 2016

# Menu module

module Menu
    
    def menu
        "What task do you wish to perform?\n\t1. Add a new task\n\t2. Show all current tasks\n\t3. Write to a file\n\t4. Read from a file\n\t5. Delete a task\n\t6. Update a task\n\t7. Toggle completion\n\tQ. Quit the program"
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
        current = 1
        all_tasks.each  do |task|
            if task.status
                puts current.to_s + ") " + "[X] " + task.description
            else
                puts current.to_s + ") " + "[ ] " + task.description
            end
            current += 1
        end
    end

    # read a task from a file
    def read_from_file
        filename = prompt("Enter filename.")
        tasks = IO.readlines(filename)
        
        index = 0
        statuses = []
        descriptions = []
        while index < tasks.length
            if tasks[index] == "Y\n"
                statuses.push(true)
            else
                statuses.push(false)
            end
            descriptions.push(tasks[index+1])
            index += 2
        end
        
        index = 0
        while index < statuses.length
            new_task = Task.new(descriptions[index])
            if statuses[index]
                new_task.toggle
            end
            @all_tasks.push(new_task)
            index += 1
        end
        
    end


    # write a list to a file
    def write_to_file
        filename = prompt("Enter filename.")
        data = ""
        all_tasks.each do |t|
            if t.status
                data += "Y\n"
            else
                data += "N\n"
            end
            data += t.description.chomp + "\n"
        end
        
        File.open(filename, 'w+') do |file|
            file.puts data
        end
    end

    # delete a task
    def delete
        show
        to_delete = prompt("Enter task number.")
        all_tasks.delete_at(to_delete.to_i - 1)
    end
        

    # update a task
    def update
        show
        to_update = prompt("Enter task number.")
        new_description = prompt("Enter a new description.")
        all_tasks[to_update.to_i - 1].update(new_description)
    end
    
    # toggle task status
    def toggle
        show
        to_update = prompt("Enter number of task to toggle completion.")
        all_tasks[to_update.to_i - 1].toggle
        if all_tasks[to_update.to_i - 1].status
            puts "Task " + (to_update.to_i - 1).to_s + " has been completed."
        else
            puts "Task " + (to_update.to_i - 1).to_s + " has been marked incomplete."
        end
    end
    
    
end


# Task class

class Task

    attr_reader :description
    attr_reader :status

    def initialize(description)
        @description = description
        @status = false
    end
    
    def update(new_description)
        @description = new_description
    end
    
    def toggle
        @status = !@status
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
        when "5" then my_list.delete
        when "6" then my_list.update
        when "7" then my_list.toggle
        when "Q" then continue = false
        
        else puts "Invalid input"
    end
    
end
        
    
    
