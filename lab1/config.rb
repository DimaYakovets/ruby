module Config
    class << self
        attr_accessor :web_address, :path, :condition, :user
        
        def config
            return to_s unless block_given?
            
            if @program
                puts "Application has been initialized already" 
                return
            end
            
            yield self

            @program ||= self
        end
        
        def user(&block)
            @user ||= User.config(&block)
        end 
    end
    
    class User 
        class << self
            attr_accessor :email, :password
            
            def config(&block)
                return to_s unless block_given?
            
                if @user
                    puts "User has been initialized already" 
                    return
                end
                
                yield self
            end
        end
    end
end
