actions :register, :add_rosteritem, :load

attribute :name, :kind_of => String, :name_attribute => true
attribute :localuser, :kind_of => String
attribute :localserver, :kind_of => String
attribute :password, :kind_of => String
attribute :user, :kind_of => String
attribute :server, :kind_of => String
attribute :nick, :kind_of => String
attribute :group, :kind_of => String
attribute :subs, :kind_of => String
attribute :file, :kind_of => String

#TODO organize attributes and actions together somehow, specify required parameters?
