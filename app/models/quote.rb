class Quote < ApplicationRecord
    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }
    
    has_many :line_item_dates, dependent: :destroy
    
    
    belongs_to :user


   
    # Following are the 3 ways to write a broadcasting function

        # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
        # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self } }
        # after_create_commit -> { broadcast_prepend_to "quotes" }
    
    # Following are 3 broadcasts we require for each action (create, update, delete)

        # after_create_commit -> { broadcast_prepend_to "quotes" }
        # after_update_commit -> { broadcast_replace_to "quotes" }
        # after_destroy_commit -> { broadcast_remove_to "quotes" }
        
    #Using _later makes the broadcasting asynchrounous, making the webpage more efficient, as the method is applied first on the page of user performing, and then later reflected to the other user on the same page, not simultaneously.

        # after_create_commit -> { broadcast_prepend_later_to "quotes" }
        # after_update_commit -> { broadcast_replace_later_to "quotes" }
        # after_destroy_commit -> { broadcast_remove_to "quotes" }

    #Following is a one line code that performs the method of all three written above
    
        # broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend

    #Follwing only broadcasts to the same users

        broadcasts_to ->(quote) { [quote.user, "quotes"] }, inserts_by: :prepend
      

end
