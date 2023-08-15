; extends

(method_definition (property_identifier) @method_def)

(variable_declarator
  name: (identifier) @function_def
  value: (arrow_function))

(assignment_expression
  left: (member_expression) @function_def
  right: (arrow_function))

(export_statement
  (lexical_declaration
    (variable_declarator
      name: (identifier) @export_def)))
