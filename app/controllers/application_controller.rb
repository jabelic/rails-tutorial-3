class ApplicationController < ActionController::Base
    include SessionsHelper # controllerからlogin周りのmethodを呼べるようにする
    def hello
        render html: "hello, world!"
    end
end
