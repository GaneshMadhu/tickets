require File.expand_path('../../config/environment',  __FILE__)
require 'ticket'

class TicketManager
  attr_reader :ticket_detail, :tickets

  def initialize
    @ticket_detail = {}
    @tickets       = Ticket.all
    new_or_existing?
  end

  private

  def new_or_existing?
    puts "Select one option \n1) Create a new ticket \n2) Edit an existing ticket"
    case gets.strip
      when "1"
        get_default_details
        Ticket.create(ticket_detail)
      when "2"
        get_status
        Ticket.update(ticket_detail["id"],ticket_detail)
      else
        puts "Select from the options specified"
        new_or_existing?
    end
    print_details
    exit
  end

  def get_default_details
    puts "Created By(text)?"
    ticket_detail[:created_by]  = gets.chomp
    puts "Description(text)?"
    ticket_detail[:description] = gets.chomp
    puts "Severity(integer)?"
    ticket_detail[:severity]    = gets.chomp
  end

  def get_status
    select_ticket
    puts "1) Complete a ticket \n2) Cancel a ticket"
    case gets.strip
      when "1"
        complete_ticket
      when "2"
        cancel_ticket
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
      ticket   = tickets.find(input_id.to_i) || {}
      break unless ticket.blank?
    end
    ticket.as_json.map{|k,v| ticket_detail[k] = v}
  end

  def complete_ticket
    ticket_detail[:status]   = 'completed'
    puts "Comments?"
    ticket_detail[:comments] = gets.chomp
  end

  def cancel_ticket
    ticket_detail[:status] = 'cancelled'
    puts "Reason? \n1) EndUser \n2) Others"
    case gets.strip
      when "1"
        ticket_detail[:cancelled_reason] = "end_user"
      when "2"
        ticket_detail[:cancelled_reason] = "others"
        puts "Reason(text)?"
        ticket_detail[:cancelled_other_description] = gets.chomp
      else
        puts "Choose from the existing options."
        cancel_ticket
    end
  end

  def print_details
    ticket_detail.each do |label,detail|
      p "#{label.capitalize} - #{detail}"
    end
  end

  def print_existing_tickets
    tickets.sort.each do |ticket|
      puts "#{ticket.id}) #{ticket.description}"
    end
    puts "Please select a ticket."
  end
end

TicketManager.new
