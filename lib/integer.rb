class String

    def is_int?
        begin
            Integer(self)
        rescue
            return false
        else
            return true
        end

    end

end
