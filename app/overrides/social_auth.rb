Deface::Override.new(:virtual_path => "spree/user_registerations/new",
                     :name => "insert social auth",
                     :insert_top => "[data-hook='login_extras']",
                     :partial => "shared/social_auth")

Deface::Override.new(:virtual_path => "spree/user_sessions/new",
                    :name => "insert social auth",
                    :insert_top => "[data-hook='login_extras']",
                    :partial => "shared/social_auth")
