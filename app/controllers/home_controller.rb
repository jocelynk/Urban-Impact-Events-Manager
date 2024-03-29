class HomeController < ApplicationController
  respond_to :html, :json, :js
  def index
   @events = Event.current
   @all_events = Event.paginate(:page => params[:page], :per_page => 5)
  end

  def about
  end

  def contact
  end

  #use sunspot gem for search????
  def search
   @query = params[:query]
   @students = Student.search(@query)
   @total_hits = @students.size
  end

  def checkin
    session[:event] = params[:event_id]
    # session[:event] = params[:format]
    @event_details = Event.joins('INNER JOIN section_events AS se ON se.event_id = events.id INNER JOIN sections s ON s.id = se.section_id').where('events.id = ?', session[:event]).select('s.name AS section, events.date')
    @attendees = Event.attendees(session[:event])
    @absentees = Event.absentees(session[:event])
    if params[:barcode] && session[:event]
      @student = Student.find_by_barcode_number(params[:barcode])
      if @student && @student.attendances.create(event_id: params[:event_id])
        @attendees = Event.attendees(session[:event])
        @absentees = Event.absentees(session[:event])
        render :json => { message: "#{@student.proper_name} was successfully scanned!", attendees: @attendees, absentees: @absentees }
      else
        render :json => { error: 'There was something wrong with the scan!' }
      end
    end
  end
end
