
module ActiveRecord
  class Base
  
    class << self      
      def instantiate_without_callbacks_with_polymorphic_checks(record)
        if record['polymorphic_parent_class']
          reflection = record['polymorphic_parent_class'].constantize.reflect_on_association(record['polymorphic_association_id'].to_sym)
          logger.debug "Instantiating a polymorphic row for #{record['polymorphic_parent_class']}.reflect_on_association(:#{record['polymorphic_association_id']})"

          # rewrite 'record' with the right column names
          table_aliases = reflection.options[:table_aliases].dup
          record = Hash[*table_aliases.keys.map {|key| [key, record[table_aliases[key]]] }.flatten]          
          
          # find the real child class
          klass = record["#{self.table_name}.#{reflection.options[:polymorphic_type_key]}"].constantize
          if sti_klass = record["#{klass.table_name}.#{klass.inheritance_column}"]
            klass = klass.class_eval do compute_type(sti_klass) end # in case of namespaced STI models
          end
 
          # eject the join keys
          record = Hash[*record._select do |column, value| 
            column[/^#{klass.table_name}/]
          end.map do |column, value|
            [column[/\.(.*)/, 1], value]
          end.flatten]

          # allocate and assign values
          returning(klass.allocate) do |obj|
            obj.instance_variable_set("@attributes", record)
          end
        else                       
          instantiate_without_callbacks_without_polymorphic_checks(record)
        end
      end
      
      alias_method_chain :instantiate_without_callbacks, :polymorphic_checks # oh yeah
    end
    
  end
end
