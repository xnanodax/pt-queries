


# def cycle_question_count(cycle_id)
#   Instructor.current_instructional.where(city: cycle.city).joins(:answered_questions).where('questions.taken_at >= ? ', cycle.start_date).order('count(questions.id) DESC').group(:id).pluck(:firstname, 'count(questions.id)')
# end

# def question_count(ord1, ord2 = nil)
#   city_id = 2
#   date1 = Day.find_by(cycle: Cycle.current(2), ord: ord1).date
#   date2 = ord2 ? Day.find_by(cycle: Cycle.current(2), ord: ord2).date : Date.current
#   Instructor.current_instructional.where(city_id: city_id).where('questions.taken_at >= ?', date1).where('questions.taken_at <= ?', date2).joins(:answered_questions).order('COUNT(questions.id) DESC').group(:id).pluck(:firstname, :lastname, 'COUNT(questions.id)')
# end 
# question_count_range(11,12)

def instructor_avg_wait_time(ord1, ord2 = nil)
  city_id = 2
  date1 = Day.find_by(cycle: Cycle.current(2), ord: ord1).date
  date2 = ord2 ? Day.find_by(cycle: Cycle.current(2), ord: ord2).date : Date.current
  Instructor.current_instructional.where(city_id: city_id).joins(:answered_questions).where('questions.taken_at >= ?', date1).where('questions.taken_at <= ?', date2).group(:id).pluck(:firstname, :lastname, 'CAST(SUM(questions.wait_time) AS FLOAT)/ COUNT(questions.id)')
end 
instructor_avg_wait_time(11,12)

def instructor_busy_wait_time(ord1, ord2 = nil)
  city_id = 2
  date1 = Day.find_by(cycle: Cycle.current(2), ord: ord1).date
  date2 = ord2 ? Day.find_by(cycle: Cycle.current(2), ord: ord2).date : Date.current
  Instructor.current_instructional.where(city_id: city_id).joins(:answered_questions).where('questions.taken_at >= ?', date1).where('questions.taken_at <= ?', date2).group(:id).pluck(:firstname, :lastname, 'CAST(SUM(questions.busy_time) AS FLOAT) / COUNT(questions.id)')
end 
instructor_busy_wait_time(11,12)

def cycle_wait_time(cycle_id)
  city_id = 2
  date1 = Day.find_by(cycle: Cycle.find(cycle_id), ord: 11).date
  date2 = Day.find_by(cycle: Cycle.find(cycle_id), ord: 81).date
  Instructor.current_instructional.where(city_id: city_id).joins(:answered_questions).where('questions.taken_at >= ?', date1).where('questions.taken_at <= ?', date2).pluck('CAST(SUM(questions.wait_time) AS FLOAT) / COUNT(questions.id)')
end 
cycle_wait_time(90)
cycle_wait_time(92)
cycle_wait_time(94)
cycle_wait_time(96)



#cycle model 


def taken_questions(ord1 = 11, ord2 = 81)
  date1 = Day.find_by(cycle: self, ord: ord1).date
  date2 = Day.find_by(cycle: self, ord: ord2).date

  Question.joins(:city)
    .where('cities.id = ?', self.city.id)
    .where('questions.taken_at >= ?', date1)
    .where('questions.taken_at <= ?', date2)
end 

def instructor_taken_questions(ord1 = 11, ord2 = 81)
  Question.unscoped {
    taken_questions(ord1, ord2)
      .joins(:instructor)  
      .group("instructors.id")
  }
end

def taken_question_count(ord1 = 11, ord2 = 81)
  query_str = 'COUNT(questions.id)'
  
  instructor_taken_questions(ord1, ord2)
    .order(query_str + 'DESC')
    .pluck(:firstname, :lastname, query_str)

end 

def avg_wait_time(ord1 = 11, ord2 = 81) # in minutes
  query_str = 'CAST(SUM(questions.wait_time) AS FLOAT)/ COUNT(questions.id) / 60';
  
  instructor_taken_questions(ord1, ord2)
    .order(query_str + 'DESC')
    .pluck(:firstname, :lastname, query_str)
end

