class LogPolicy 
    attr_reader :current_user

    def initialize(current_user: current_user)
        @current_user = current_user
    end

    

    def can_view?
        @current_user.superadmin?
    end

    def can_mark?
        @current_user.superadmin?
    end

    
end