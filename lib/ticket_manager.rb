require File.expand_path('../../config/environment',  __FILE__)
require 'ticket'

class TicketManager
  attr_reader :ticket_detail

  def initialize
    @ticket_detail = {}
    new_or_existing?
  end

  private

  def new_or_existing?
    puts "Select one option \n1) Create a new ticket \n2) Edit an existing ticket"
    case gets.strip
      when "1"
        CreateTicket.new(ticket_detail).create
      when "2"
        EditTicket.new ticket_detail
      else
        puts "Select from the options specified"
        new_or_existing?
    end
    print_details
    exit
  end

  def print_details
    ticket_detail.each do |label,detail|
      p "#{label.capitalize} - #{detail}"
    end
  end
end

class CreateTicket
  attr_reader :create_ticket

  def initialize(create_ticket)
    @create_ticket = create_ticket
  end

  def create
    get_default_details
    Ticket.create(create_ticket)
    create_ticket
  end

  private

    def get_default_details
      puts "Created By(text)?"
      mandatory_check(:created_by)
      puts "Description(text)?"
      mandatory_check(:description)
      puts "Severity(integer)?"
      mandatory_check(:severity)
    end

    def mandatory_check(attribute)
      loop do
        input = gets.chomp
        next if input.blank?
        create_ticket[attribute]  = input
        break
      end
    end
end

class EditTicket
  attr_reader :edit_ticket, :tickets

  def initialize(edit_ticket)
    @edit_ticket = edit_ticket
    @tickets     = Ticket.where(status: nil)
    p "No Tickets available. Please run rake db:seed" and exit if @tickets.blank?
    select_ticket
    get_status
    Ticket.update(edit_ticket["id"],edit_ticket)
    @edit_ticket
  end

  private

    def get_status
      puts "1) Complete a ticket \n2) Cancel a ticket"
      case gets.strip
        when "1"
          edit_ticket.merge! CompleteTicket.complete
        when "2"
          CancelTicket.new(edit_ticket).cancel
        else
          puts "Choose from the existing options."
          get_status
      end
    end

    def select_ticket
      ticket = {}
      loop do
        puts print_existing_tickets
        input_id = gets.strip
        ticket   = tickets.find(input_id.to_i) rescue {}
        break unless ticket.blank?
      end
      ticket.as_json.map{|k,v| edit_ticket[k] = v}
    end

    def print_existing_tickets
      tickets.sort.each do |ticket|
        puts "#{ticket.id}) #{ticket.description}"
      end
      puts "Please select an existing ticket."
    end
end

class CompleteTicket
  def self.complete
    complete_ticket = {}
    complete_ticket["status"]   = 'completed'
    puts "Comments?"
    complete_ticket["comments"] = gets.chomp
    complete_ticket
  end
end

class CancelTicket
  attr_reader :cancel_ticket

  def initialize(cancel_ticket)
    @cancel_ticket = cancel_ticket
  end

  def cancel
    cancel_ticket["status"] = 'cancelled'
    puts "Reason? \n1) EndUser \n2) Others"
    case gets.strip
      when "1"
        cancel_ticket["cancelled_reason"] = "end_user"
      when "2"
        cancel_ticket["cancelled_reason"] = "others"
        puts "Reason(text)?"
        cancel_ticket["cancelled_other_description"] = gets.chomp
      else
        puts "Choose from the existing options."
        cancel
    end
    cancel_ticket
  end
end

TicketManager.new
