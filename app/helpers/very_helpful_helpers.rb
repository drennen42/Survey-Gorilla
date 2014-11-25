  def create_choices(question, params)
    params.values.each do |option|
      question.choices << Choice.create!(text: option)
    end
  end

  def update_choices(question, params)
    updates = params.values
    question.choices.each_with_index do |choice, index|
      choice.text = updates[index]
      choice.save
    end
  end

  def render_question_and_choices(question)
    question_string = "<div class='question_container'><h3>#{question.text}</h3>#{make_delete_button(question)}#{make_edit_button(question)}<br><form>"
    question.choices.each do |choice|
      question_string << "<input type='radio' name='option' value='choice'>#{choice.text}<br>"
    end
    return question_string << "</form></div>"
  end

  def render_edit(question)
    question_string = "<div class='question_container'><form action='' id='#{question.survey.id}/questions/#{question.id}/edited' class='submit_edit'>Question:<input type='text' name='question_title' value='#{question.text}'><br>"
    int = 1
    question.choices.each do |choice|
      question_string << "Option #{int}: <input type='text' name='update[option_#{choice.id}]' value='#{choice.text}'><br>"
      int += 1
    end
    return question_string << "<input type='submit' value='Submit' class='edit'></form></div>"
  end

# Make delete and edit buttons

  def make_edit_button_for_survey_title(survey)
  "<form method='GET' id='#{survey.id}/edit' class='edit_title'><input type='submit' value='Edit Title'/></form>"
  end

  def make_delete_button(question)
  "<form method='GET' id='#{question.survey.id}/questions/#{question.id}/delete'  class='delete'><input type='submit' value='Delete'/></form>"
  end

  def make_edit_button(question)
    "<form method='POST' id='#{question.survey.id}/questions/#{question.id}/edit' class='edit'><input type='submit' value='EDIT'/></form>"
  end


  def url_generator
    alpha = ('a'..'z').to_a
    alpha_cap = ('A'..'Z').to_a
    chars = alpha + alpha_cap
    string = "/"
    15.times do
      string << chars.sample
    end
    string
  end

def render_questions(question)
  question_string = "<h2>#{question.text}</h2><form action='/respondents/#{@survey.id}/submit' method='post'>"
  question.choices.each do |choice|
    question_string << "<input type='radio' name='#{question.id}' value='#{choice.text}'>#{choice.text}<br>"
  end
  return question_string
end
