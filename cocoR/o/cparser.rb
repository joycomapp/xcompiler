class CParser < CRRParser

   def C()
      _in_()
      while (@sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym)
         SourceElements()
      end

      Expect(EOF_Sym)
      _out_()
   end
   def SourceElements()
      _in_()
      SourceElement()
      while (@sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym)
         SourceElement()
      end

      _out_()
   end
   def Boolean()
      _in_()
      if @sym==C_trueSym
         Get()
      else
         if @sym==C_falseSym
            Get()
         else
            GenError(87)
         end

      end

      _out_()
   end
   def PrimaryExpression()
      _in_()
      case @sym

      when C_thisSym
         Get()

      when C_LbraceSym
         ObjectLiteral()

      when C_LparenSym
         Get()
         Expression()
         Expect(C_RparenSym)

      when C_identifierSym
         Get()

      when C_LbrackSym
         ArrayLiteral()

      when C_numberSym,
         C_hexnumberSym,
         C_stringSym,
         C_regexD1Sym,
         C_trueSym,
         C_falseSym,
         C_nullSym
         Literal()

      else
         GenError(88)

      end

      _out_()
   end
   def ObjectLiteral()
      _in_()
      Expect(C_LbraceSym)
      if @sym>=C_identifierSym&&@sym<=C_numberSym||@sym==C_stringSym
         PropertyNameAndValueList()
      end

      Expect(C_RbraceSym)
      _out_()
   end
   def Expression()
      _in_()
      AssignmentExpression()
      while (@sym==C_CommaSym)
         Get()
         AssignmentExpression()
      end

      _out_()
   end
   def ArrayLiteral()
      _in_()
      Expect(C_LbrackSym)
      if @sym>=C_RbrackSym&&@sym<=C_CommaSym
         if @sym==C_CommaSym
            Elision()
         end

         Expect(C_RbrackSym)
      else
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            ElementList()
            Elision()
            Expect(C_RbrackSym)
         else
            if 1
               if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym>=C_CommaSym&&@sym<=C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
                  ElementList()
               end

               Expect(C_RbrackSym)
            else
               GenError(89)
            end

         end

      end

      _out_()
   end
   def Literal()
      _in_()
      case @sym

      when C_numberSym
         Get()

      when C_hexnumberSym
         Get()

      when C_stringSym
         Get()

      when C_trueSym,
         C_falseSym
         Boolean()

      when C_nullSym
         Get()

      when C_regexD1Sym
         Get()

      else
         GenError(90)

      end

      _out_()
   end
   def Elision()
      _in_()
      Expect(C_CommaSym)
      while (@sym==C_CommaSym)
         Get()
      end

      _out_()
   end
   def ElementList()
      _in_()
      if @sym==C_CommaSym
         Elision()
      end

      AssignmentExpression()
      while (@sym==C_CommaSym)
         Elision()
         AssignmentExpression()
      end

      _out_()
   end
   def AssignmentExpression()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym==C_functionSym
         LeftHandSideExpression()
         AssignmentOperator()
         AssignmentExpression()
      else
         if @sym>=C_PlusPlusSym&&@sym<=C_BangSym
            ConditionalExpression()
         else
            GenError(91)
         end

      end

      _out_()
   end
   def PropertyNameAndValueList()
      _in_()
      PropertyNameAndValue()
      while (@sym==C_CommaSym)
         if @sym==C_CommaSym
            Get()
            PropertyNameAndValue()
         else
            if 1
               Get()
            else
               GenError(92)
            end

         end

      end

      _out_()
   end
   def PropertyNameAndValue()
      _in_()
      PropertyName()
      Expect(C_ColonSym)
      AssignmentExpression()
      _out_()
   end
   def PropertyName()
      _in_()
      if @sym==C_identifierSym
         Get()
      else
         if @sym==C_stringSym
            Get()
         else
            if @sym==C_numberSym
               Get()
            else
               GenError(93)
            end

         end

      end

      _out_()
   end
   def MemberExpression()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_functionSym
         if @sym==C_functionSym
            FunctionExpression()
         else
            if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym
               PrimaryExpression()
            else
               GenError(94)
            end

         end

         while (@sym==C_LbrackSym||@sym==C_PointSym)
            MemberExpressionPart()
         end

      else
         if @sym==C_newSym
            AllocationExpression()
         else
            GenError(95)
         end

      end

      _out_()
   end
   def FunctionExpression()
      _in_()
      Expect(C_functionSym)
      if @sym==C_identifierSym
         Get()
      end

      Expect(C_LparenSym)
      if @sym==C_identifierSym
         FormalParameterList()
      end

      Expect(C_RparenSym)
      FunctionBody()
      _out_()
   end
   def MemberExpressionPart()
      _in_()
      if @sym==C_LbrackSym
         Get()
         Expression()
         Expect(C_RbrackSym)
      else
         if @sym==C_PointSym
            Get()
            Expect(C_identifierSym)
         else
            GenError(96)
         end

      end

      _out_()
   end
   def AllocationExpression()
      _in_()
      Expect(C_newSym)
      MemberExpression()
      while (@sym==C_LparenSym)
         Arguments()
         while (@sym==C_LbrackSym||@sym==C_PointSym)
            MemberExpressionPart()
         end

      end

      _out_()
   end
   def MemberExpressionForIn()
      _in_()
      if @sym==C_functionSym
         FunctionExpression()
      else
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym
            PrimaryExpression()
         else
            GenError(97)
         end

      end

      while (@sym==C_LbrackSym||@sym==C_PointSym)
         MemberExpressionPart()
      end

      _out_()
   end
   def Arguments()
      _in_()
      Expect(C_LparenSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
         ArgumentList()
      end

      Expect(C_RparenSym)
      _out_()
   end
   def CallExpression()
      _in_()
      MemberExpression()
      Arguments()
      while (@sym==C_LparenSym||@sym==C_LbrackSym||@sym==C_PointSym)
         CallExpressionPart()
      end

      _out_()
   end
   def CallExpressionPart()
      _in_()
      if @sym==C_LparenSym
         Arguments()
      else
         if @sym==C_LbrackSym
            Get()
            Expression()
            Expect(C_RbrackSym)
         else
            if @sym==C_PointSym
               Get()
               Expect(C_identifierSym)
            else
               GenError(98)
            end

         end

      end

      _out_()
   end
   def CallExpressionForIn()
      _in_()
      MemberExpressionForIn()
      Arguments()
      while (@sym==C_LparenSym||@sym==C_LbrackSym||@sym==C_PointSym)
         CallExpressionPart()
      end

      _out_()
   end
   def ArgumentList()
      _in_()
      AssignmentExpression()
      while (@sym==C_CommaSym)
         Get()
         AssignmentExpression()
      end

      _out_()
   end
   def LeftHandSideExpression()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym==C_functionSym
         CallExpression()
      else
         if 1
            MemberExpression()
         else
            GenError(99)
         end

      end

      _out_()
   end
   def LeftHandSideExpressionForIn()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_functionSym
         CallExpressionForIn()
      else
         if 1
            MemberExpressionForIn()
         else
            GenError(100)
         end

      end

      _out_()
   end
   def PostfixExpression()
      _in_()
      LeftHandSideExpression()
      if @sym>=C_PlusPlusSym&&@sym<=C_MinusMinusSym
         PostfixOperator()
      end

      _out_()
   end
   def PostfixOperator()
      _in_()
      if @sym==C_PlusPlusSym
         Get()
      else
         if @sym==C_MinusMinusSym
            Get()
         else
            GenError(101)
         end

      end

      _out_()
   end
   def UnaryExpression()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym==C_functionSym
         PostfixExpression()
      else
         if @sym>=C_PlusPlusSym&&@sym<=C_BangSym
            UnaryOperator()
            UnaryExpression()
            while (@sym>=C_PlusPlusSym&&@sym<=C_BangSym)
               UnaryOperator()
               UnaryExpression()
            end

         else
            GenError(102)
         end

      end

      _out_()
   end
   def UnaryOperator()
      _in_()
      case @sym

      when C_deleteSym
         Get()

      when C_voidSym
         Get()

      when C_typeofSym
         Get()

      when C_PlusPlusSym
         Get()

      when C_MinusMinusSym
         Get()

      when C_PlusSym
         Get()

      when C_MinusSym
         Get()

      when C_TildeSym
         Get()

      when C_BangSym
         Get()

      else
         GenError(103)

      end

      _out_()
   end
   def MultiplicativeExpression()
      _in_()
      UnaryExpression()
      while (@sym>=C_StarSym&&@sym<=C_PercentSym)
         MultiplicativeOperator()
         UnaryExpression()
      end

      _out_()
   end
   def MultiplicativeOperator()
      _in_()
      if @sym==C_StarSym
         Get()
      else
         if @sym==C_SlashSym
            Get()
         else
            if @sym==C_PercentSym
               Get()
            else
               GenError(104)
            end

         end

      end

      _out_()
   end
   def AdditiveExpression()
      _in_()
      MultiplicativeExpression()
      while (@sym>=C_PlusSym&&@sym<=C_MinusSym)
         AdditiveOperator()
         MultiplicativeExpression()
      end

      _out_()
   end
   def AdditiveOperator()
      _in_()
      if @sym==C_PlusSym
         Get()
      else
         if @sym==C_MinusSym
            Get()
         else
            GenError(105)
         end

      end

      _out_()
   end
   def ShiftExpression()
      _in_()
      AdditiveExpression()
      while (@sym>=C_LessLessSym&&@sym<=C_GreaterGreaterGreaterSym)
         ShiftOperator()
         AdditiveExpression()
      end

      _out_()
   end
   def ShiftOperator()
      _in_()
      if @sym==C_LessLessSym
         Get()
      else
         if @sym==C_GreaterGreaterSym
            Get()
         else
            if @sym==C_GreaterGreaterGreaterSym
               Get()
            else
               GenError(106)
            end

         end

      end

      _out_()
   end
   def RelationalExpression()
      _in_()
      ShiftExpression()
      while (@sym>=C_LessSym&&@sym<=C_inSym)
         RelationalOperator()
         ShiftExpression()
      end

      _out_()
   end
   def RelationalOperator()
      _in_()
      case @sym

      when C_LessSym
         Get()

      when C_GreaterSym
         Get()

      when C_LessEqualSym
         Get()

      when C_GreaterEqualSym
         Get()

      when C_instanceofSym
         Get()

      when C_inSym
         Get()

      else
         GenError(107)

      end

      _out_()
   end
   def RelationalExpressionNoIn()
      _in_()
      ShiftExpression()
      while (@sym>=C_LessSym&&@sym<=C_instanceofSym)
         RelationalNoInOperator()
         ShiftExpression()
      end

      _out_()
   end
   def RelationalNoInOperator()
      _in_()
      case @sym

      when C_LessSym
         Get()

      when C_GreaterSym
         Get()

      when C_LessEqualSym
         Get()

      when C_GreaterEqualSym
         Get()

      when C_instanceofSym
         Get()

      else
         GenError(108)

      end

      _out_()
   end
   def EqualityExpression()
      _in_()
      RelationalExpression()
      while (@sym>=C_EqualEqualSym&&@sym<=C_BangEqualEqualSym)
         EqualityOperator()
         RelationalExpression()
      end

      _out_()
   end
   def EqualityOperator()
      _in_()
      case @sym

      when C_EqualEqualSym
         Get()

      when C_BangEqualSym
         Get()

      when C_EqualEqualEqualSym
         Get()

      when C_BangEqualEqualSym
         Get()

      else
         GenError(109)

      end

      _out_()
   end
   def EqualityExpressionNoIn()
      _in_()
      RelationalExpressionNoIn()
      while (@sym>=C_EqualEqualSym&&@sym<=C_BangEqualEqualSym)
         EqualityOperator()
         RelationalExpressionNoIn()
      end

      _out_()
   end
   def BitwiseANDExpression()
      _in_()
      EqualityExpression()
      while (@sym==C_AndSym)
         BitwiseANDOperator()
         EqualityExpression()
      end

      _out_()
   end
   def BitwiseANDOperator()
      _in_()
      Expect(C_AndSym)
      _out_()
   end
   def BitwiseANDExpressionNoIn()
      _in_()
      EqualityExpressionNoIn()
      while (@sym==C_AndSym)
         BitwiseANDOperator()
         EqualityExpressionNoIn()
      end

      _out_()
   end
   def BitwiseXORExpression()
      _in_()
      BitwiseANDExpression()
      while (@sym==C_UparrowSym)
         BitwiseXOROperator()
         BitwiseANDExpression()
      end

      _out_()
   end
   def BitwiseXOROperator()
      _in_()
      Expect(C_UparrowSym)
      _out_()
   end
   def BitwiseXORExpressionNoIn()
      _in_()
      BitwiseANDExpressionNoIn()
      while (@sym==C_UparrowSym)
         BitwiseXOROperator()
         BitwiseANDExpressionNoIn()
      end

      _out_()
   end
   def BitwiseORExpression()
      _in_()
      BitwiseXORExpression()
      while (@sym==C_BarSym)
         BitwiseOROperator()
         BitwiseXORExpression()
      end

      _out_()
   end
   def BitwiseOROperator()
      _in_()
      Expect(C_BarSym)
      _out_()
   end
   def BitwiseORExpressionNoIn()
      _in_()
      BitwiseXORExpressionNoIn()
      while (@sym==C_BarSym)
         BitwiseOROperator()
         BitwiseXORExpressionNoIn()
      end

      _out_()
   end
   def LogicalANDExpression()
      _in_()
      BitwiseORExpression()
      while (@sym==C_AndAndSym)
         LogicalANDOperator()
         BitwiseORExpression()
      end

      _out_()
   end
   def LogicalANDOperator()
      _in_()
      Expect(C_AndAndSym)
      _out_()
   end
   def LogicalANDExpressionNoIn()
      _in_()
      BitwiseORExpressionNoIn()
      while (@sym==C_AndAndSym)
         LogicalANDOperator()
         BitwiseORExpressionNoIn()
      end

      _out_()
   end
   def LogicalORExpression()
      _in_()
      LogicalANDExpression()
      while (@sym==C_BarBarSym)
         LogicalOROperator()
         LogicalANDExpression()
      end

      _out_()
   end
   def LogicalOROperator()
      _in_()
      Expect(C_BarBarSym)
      _out_()
   end
   def LogicalORExpressionNoIn()
      _in_()
      LogicalANDExpressionNoIn()
      while (@sym==C_BarBarSym)
         LogicalOROperator()
         LogicalANDExpressionNoIn()
      end

      _out_()
   end
   def ConditionalExpression()
      _in_()
      LogicalORExpression()
      if @sym==C_QuerySym
         Get()
         AssignmentExpression()
         Expect(C_ColonSym)
         AssignmentExpression()
      end

      _out_()
   end
   def ConditionalExpressionNoIn()
      _in_()
      LogicalORExpressionNoIn()
      if @sym==C_QuerySym
         Get()
         AssignmentExpression()
         Expect(C_ColonSym)
         AssignmentExpressionNoIn()
      end

      _out_()
   end
   def AssignmentExpressionNoIn()
      _in_()
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym==C_functionSym
         LeftHandSideExpression()
         AssignmentOperator()
         AssignmentExpressionNoIn()
      else
         if @sym>=C_PlusPlusSym&&@sym<=C_BangSym
            ConditionalExpressionNoIn()
         else
            GenError(110)
         end

      end

      _out_()
   end
   def AssignmentOperator()
      _in_()
      case @sym

      when C_EqualSym
         Get()

      when C_StarEqualSym
         Get()

      when C_SlashEqualSym
         Get()

      when C_PercentEqualSym
         Get()

      when C_PlusEqualSym
         Get()

      when C_MinusEqualSym
         Get()

      when C_LessLessEqualSym
         Get()

      when C_GreaterGreaterEqualSym
         Get()

      when C_GreaterGreaterGreaterEqualSym
         Get()

      when C_AndEqualSym
         Get()

      when C_UparrowEqualSym
         Get()

      when C_BarEqualSym
         Get()

      else
         GenError(111)

      end

      _out_()
   end
   def ExpressionNoIn()
      _in_()
      AssignmentExpressionNoIn()
      while (@sym==C_CommaSym)
         Get()
         AssignmentExpressionNoIn()
      end

      _out_()
   end
   def Statement()
      _in_()
      case @sym

      when C_LbraceSym
         Block()

      when C_varSym
         JScriptVarStatement()

      else
         VariableStatement()

      when C_SemicolonSym
         EmptyStatement()

      when C_identifierSym
         LabelledStatement()

      when C_numberSym,
         C_hexnumberSym,
         C_stringSym,
         C_regexD1Sym,
         C_trueSym,
         C_falseSym,
         C_thisSym,
         C_LparenSym,
         C_nullSym,
         C_LbrackSym,
         C_newSym,
         C_PlusPlusSym,
         C_MinusMinusSym,
         C_deleteSym,
         C_voidSym,
         C_typeofSym,
         C_PlusSym,
         C_MinusSym,
         C_TildeSym,
         C_BangSym,
         C_functionSym
         ExpressionStatement()

      when C_ifSym
         IfStatement()

      when C_doSym,
         C_whileSym,
         C_forSym
         IterationStatement()

      when C_continueSym
         ContinueStatement()

      when C_breakSym
         BreakStatement()

      when C_importSym
         ImportStatement()

      when C_returnSym
         ReturnStatement()

      when C_withSym
         WithStatement()

      when C_switchSym
         SwitchStatement()

      when C_throwSym
         ThrowStatement()

      when C_trySym
         TryStatement()

      else
         GenError(112)

      end

      _out_()
   end
   def Block()
      _in_()
      Expect(C_LbraceSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym
         StatementList()
      end

      Expect(C_RbraceSym)
      _out_()
   end
   def JScriptVarStatement()
      _in_()
      Expect(C_varSym)
      JScriptVarDeclarationList()
      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def VariableStatement()
      _in_()
      Expect(C_varSym)
      VariableDeclarationList()
      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def EmptyStatement()
      _in_()
      Expect(C_SemicolonSym)
      _out_()
   end
   def LabelledStatement()
      _in_()
      Expect(C_identifierSym)
      Expect(C_ColonSym)
      Statement()
      _out_()
   end
   def ExpressionStatement()
      _in_()
      Expression()
      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def IfStatement()
      _in_()
      Expect(C_ifSym)
      Expect(C_LparenSym)
      Expression()
      Expect(C_RparenSym)
      Statement()
      if @sym==C_elseSym
         Get()
         Statement()
      end

      _out_()
   end
   def IterationStatement()
      _in_()
      case @sym

      when C_doSym
         Get()
         Statement()
         Expect(C_whileSym)
         Expect(C_LparenSym)
         Expression()
         Expect(C_RparenSym)
         if @sym==C_SemicolonSym
            Get()
         end


      when C_whileSym
         Get()
         Expect(C_LparenSym)
         Expression()
         Expect(C_RparenSym)
         Statement()

      when C_forSym
         Get()
         Expect(C_LparenSym)
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            ExpressionNoIn()
         end

         Expect(C_SemicolonSym)
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            Expression()
         end

         Expect(C_SemicolonSym)
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            Expression()
         end

         Expect(C_RparenSym)
         Statement()

      else
         Get()
         Expect(C_LparenSym)
         Expect(C_varSym)
         VariableDeclarationList()
         Expect(C_SemicolonSym)
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            Expression()
         end

         Expect(C_SemicolonSym)
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
            Expression()
         end

         Expect(C_RparenSym)
         Statement()

      else
         Get()
         Expect(C_LparenSym)
         Expect(C_varSym)
         VariableDeclarationNoIn()
         Expect(C_inSym)
         Expression()
         Expect(C_RparenSym)
         Statement()

      else
         Get()
         Expect(C_LparenSym)
         LeftHandSideExpressionForIn()
         Expect(C_inSym)
         Expression()
         Expect(C_RparenSym)
         Statement()

      else
         GenError(113)

      end

      _out_()
   end
   def ContinueStatement()
      _in_()
      Expect(C_continueSym)
      if @sym==C_identifierSym
         Get()
      end

      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def BreakStatement()
      _in_()
      Expect(C_breakSym)
      if @sym==C_identifierSym
         Get()
      end

      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def ImportStatement()
      _in_()
      Expect(C_importSym)
      Name()
      if @sym==C_PointSym
         Get()
         Expect(C_StarSym)
      end

      Expect(C_SemicolonSym)
      _out_()
   end
   def ReturnStatement()
      _in_()
      Expect(C_returnSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym==C_functionSym
         Expression()
      end

      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def WithStatement()
      _in_()
      Expect(C_withSym)
      Expect(C_LparenSym)
      Expression()
      Expect(C_RparenSym)
      Statement()
      _out_()
   end
   def SwitchStatement()
      _in_()
      Expect(C_switchSym)
      Expect(C_LparenSym)
      Expression()
      Expect(C_RparenSym)
      CaseBlock()
      _out_()
   end
   def ThrowStatement()
      _in_()
      Expect(C_throwSym)
      Expression()
      if @sym==C_SemicolonSym
         Get()
      end

      _out_()
   end
   def TryStatement()
      _in_()
      Expect(C_trySym)
      Block()
      if @sym==C_finallySym
         Finally()
      else
         if @sym==C_catchSym
            Catch()
            if @sym==C_finallySym
               Finally()
            end

         else
            GenError(114)
         end

      end

      _out_()
   end
   def StatementList()
      _in_()
      Statement()
      while (@sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym)
         Statement()
      end

      _out_()
   end
   def VariableDeclarationList()
      _in_()
      VariableDeclaration()
      while (@sym==C_CommaSym)
         Get()
         VariableDeclaration()
      end

      _out_()
   end
   def VariableDeclaration()
      _in_()
      Expect(C_identifierSym)
      if @sym==C_EqualSym
         Initialiser()
      end

      _out_()
   end
   def Initialiser()
      _in_()
      Expect(C_EqualSym)
      AssignmentExpression()
      _out_()
   end
   def VariableDeclarationNoIn()
      _in_()
      Expect(C_identifierSym)
      if @sym==C_EqualSym
         InitialiserNoIn()
      end

      _out_()
   end
   def InitialiserNoIn()
      _in_()
      Expect(C_EqualSym)
      AssignmentExpressionNoIn()
      _out_()
   end
   def CaseBlock()
      _in_()
      Expect(C_LbraceSym)
      if @sym==C_caseSym
         CaseClauses()
      end

      if @sym==C_RbraceSym
         Get()
      else
         if @sym==C_defaultSym
            DefaultClause()
            if @sym==C_caseSym
               CaseClauses()
            end

            Expect(C_RbraceSym)
         else
            GenError(115)
         end

      end

      _out_()
   end
   def CaseClauses()
      _in_()
      CaseClause()
      while (@sym==C_caseSym)
         CaseClause()
      end

      _out_()
   end
   def DefaultClause()
      _in_()
      Expect(C_defaultSym)
      Expect(C_ColonSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym
         StatementList()
      end

      _out_()
   end
   def CaseClause()
      _in_()
      Expect(C_caseSym)
      Expression()
      Expect(C_ColonSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym
         StatementList()
      end

      _out_()
   end
   def Finally()
      _in_()
      Expect(C_finallySym)
      Block()
      _out_()
   end
   def Catch()
      _in_()
      Expect(C_catchSym)
      Expect(C_LparenSym)
      Expect(C_identifierSym)
      Expect(C_RparenSym)
      Block()
      _out_()
   end
   def FunctionDeclaration()
      _in_()
      Expect(C_functionSym)
      Expect(C_identifierSym)
      Expect(C_LparenSym)
      if @sym==C_identifierSym
         FormalParameterList()
      end

      Expect(C_RparenSym)
      FunctionBody()
      _out_()
   end
   def FormalParameterList()
      _in_()
      Expect(C_identifierSym)
      while (@sym==C_CommaSym)
         Get()
         Expect(C_identifierSym)
      end

      _out_()
   end
   def FunctionBody()
      _in_()
      Expect(C_LbraceSym)
      if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym>=C_functionSym&&@sym<=C_importSym
         SourceElements()
      end

      Expect(C_RbraceSym)
      _out_()
   end
   def SourceElement()
      _in_()
      if @sym==C_functionSym
         FunctionDeclaration()
      else
         if @sym>=C_identifierSym&&@sym<=C_stringSym||@sym>=C_regexD1Sym&&@sym<=C_LparenSym||@sym>=C_nullSym&&@sym<=C_LbrackSym||@sym==C_LbraceSym||@sym==C_newSym||@sym>=C_PlusPlusSym&&@sym<=C_BangSym||@sym>=C_varSym&&@sym<=C_ifSym||@sym>=C_doSym&&@sym<=C_switchSym||@sym>=C_throwSym&&@sym<=C_trySym||@sym==C_importSym
            Statement()
         else
            GenError(116)
         end

      end

      _out_()
   end
   def Name()
      _in_()
      Expect(C_identifierSym)
      while (@sym==C_PointSym)
         Get()
         Expect(C_identifierSym)
      end

      _out_()
   end
   def JScriptVarDeclarationList()
      _in_()
      JScriptVarDeclaration()
      while (@sym==C_CommaSym)
         Get()
         JScriptVarDeclaration()
      end

      _out_()
   end
   def JScriptVarDeclaration()
      _in_()
      Expect(C_identifierSym)
      Expect(C_ColonSym)
      Expect(C_identifierSym)
      if @sym==C_EqualSym
         Initialiser()
      end

      _out_()
   end


end
