class Module
  def attr_static_reader(*args)
    args.each do |meth|
      init_var(meth)
      set_reader(meth)
    end
  end

  def attr_static_writer(*args)
    args.each do |meth|
      init_var(meth)
      set_writer(meth)
    end
  end

  def attr_static_accessor(*args)
    args.each do |meth|
      init_var(meth)
      set_reader(meth)
      set_writer(meth)
    end
  end

  private
  def init_var(var_name)
    var = "@@#{var_name}".to_sym
    self.send(:class_variable_set, var, nil) unless self.send(:class_variable_defined?, var)
  end

  def set_reader(var_name)
    self.class.send(:define_method, var_name) {
      self.send(:class_variable_get, "@@#{var_name}".to_sym)
    }
  end

  def set_writer(var_name)
    self.class.class_eval %Q{
      def #{var_name}=(value)
        self.send(:class_variable_set, "@@#{var_name}".to_sym,value)
      end
    }
  end
end