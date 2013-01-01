actions :register, :add_rosteritem

attribute :name, :kind_of => String, :name_attribute => true
attribute :localuser, :kind_of => String, :required => true
attribute :localserver, :kind_of => String, :required => true
attribute :password, :kind_of => String
attribute :user, :kind_of => String
attribute :server, :kind_of => String
attribute :nick, :kind_of => String
attribute :group, :kind_of => String
attribute :subs, :kind_of => String
