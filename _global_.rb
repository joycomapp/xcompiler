# Generated by Abap2Ruby(https://github.com/jackieju/abap2ruby)

def d()



   #*if <LS_TEXT_ELEMENT>-DS_NODE_ELEMENT->*-BO_NODE_ELEMENT_EL_PATH_IN_KEY = rsd_node-DS_TEXT_NODE->*-LANGUAGE_EL_PATH.
   #*  concatenate '''' sy-langu '''' into value.     "language field
   #*else.
   #*  concatenate '''' LS_VL-CODE '''' into value.
   #*endif.

   check( lines(lt_node_ids) == 1 )

end


