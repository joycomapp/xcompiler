class CScanner < CRScanner

   def self.STATE0
      @@STATE0

   end
   def self.STATE0=(v)
      @@STATE0=v

   end
   def CheckLiteral(id)
      c=CurrentCh(@nextSym.Pos)
      if @ignoreCase
         c=Upcase(c)
      end

      case c

      when '/'
         if EqualStr("/=")
            return C_SlashEqualSym
         end


      when 'b'
         if EqualStr("break")
            return C_breakSym
         end


      when 'c'
         if EqualStr("continue")
            return C_continueSym
         end

         if EqualStr("case")
            return C_caseSym
         end

         if EqualStr("catch")
            return C_catchSym
         end


      when 'd'
         if EqualStr("delete")
            return C_deleteSym
         end

         if EqualStr("do")
            return C_doSym
         end

         if EqualStr("default")
            return C_defaultSym
         end


      when 'e'
         if EqualStr("else")
            return C_elseSym
         end


      when 'f'
         if EqualStr("false")
            return C_falseSym
         end

         if EqualStr("for")
            return C_forSym
         end

         if EqualStr("finally")
            return C_finallySym
         end

         if EqualStr("function")
            return C_functionSym
         end


      when 'i'
         if EqualStr("instanceof")
            return C_instanceofSym
         end

         if EqualStr("in")
            return C_inSym
         end

         if EqualStr("if")
            return C_ifSym
         end

         if EqualStr("import")
            return C_importSym
         end


      when 'n'
         if EqualStr("null")
            return C_nullSym
         end

         if EqualStr("new")
            return C_newSym
         end


      when 'r'
         if EqualStr("return")
            return C_returnSym
         end


      when 's'
         if EqualStr("switch")
            return C_switchSym
         end


      when 't'
         if EqualStr("true")
            return C_trueSym
         end

         if EqualStr("this")
            return C_thisSym
         end

         if EqualStr("typeof")
            return C_typeofSym
         end

         if EqualStr("throw")
            return C_throwSym
         end

         if EqualStr("try")
            return C_trySym
         end


      when 'v'
         if EqualStr("void")
            return C_voidSym
         end

         if EqualStr("var")
            return C_varSym
         end


      when 'w'
         if EqualStr("while")
            return C_whileSym
         end

         if EqualStr("with")
            return C_withSym
         end


      end

      return id
   end
   def Comment()

      level=1
      startLine=@currLine
      oldLineStart=@lineStart
      oldCol=@currCol
      if @ch=='/'
         NextCh()
         if @ch=='*'
            NextCh()
            while (1)
               if @ch=='*'
                  NextCh()
                  if @ch=='/'
                     (level-=1;level+2)
                     NextCh()
                     @comEols=@currLine-startLine
                     if level==0
                        return 1
                     end

                  end

               else
                  if @ch==EOF_CHAR
                     return 0
                  else
                     NextCh()
                  end

               end

            end

         else
            if @ch==LF_CHAR
               (@currLine-=1;@currLine+2)
               @lineStart=oldLineStart
            end

            @buffPos-=2
            @currCol=oldCol-1
            NextCh()
         end

      end

      return 0
   end
   def UpdateState()
      state=@@STATE0[@ch.to_byte()]
      while (1)
         NextCh()
         (@nextSym.Len+=1;@nextSym.Len-2)
         
         p "ch:#{ch}, state:#{state}"
         case state

         when 1
            if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='Z'||@ch=='_'||@ch>='a'&&@ch<='z'

            else
               return CheckLiteral(C_identifierSym)
            end


         when 2
            if @ch=='U'
               state=5
            else
               if @ch=='u'
                  state=6
               else
                  if @ch=='L'
                     state=7
                  else
                     if @ch=='l'
                        state=8
                     else
                        if @ch=='.'
                           state=4
                        else
                           if @ch>='0'&&@ch<='9'

                           else
                              return C_numberSym
                           end

                        end

                     end

                  end

               end

            end


         when 4
            if @ch=='U'
               state=13
            else
               if @ch=='u'
                  state=14
               else
                  if @ch=='L'
                     state=15
                  else
                     if @ch=='l'
                        state=16
                     else
                        if @ch>='0'&&@ch<='9'

                        else
                           return C_numberSym
                        end

                     end

                  end

               end

            end


         when 5
            return C_numberSym
         when 6
            return C_numberSym
         when 7
            return C_numberSym
         when 8
            return C_numberSym
         when 13
            return C_numberSym
         when 14
            return C_numberSym
         when 15
            return C_numberSym
         when 16
            return C_numberSym
         when 18
            if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='F'||@ch>='a'&&@ch<='f'
               state=19
            else
               return No_Sym
            end


         when 19
            if @ch=='U'
               state=20
            else
               if @ch=='u'
                  state=21
               else
                  if @ch=='L'
                     state=22
                  else
                     if @ch=='l'
                        state=23
                     else
                        if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='F'||@ch>='a'&&@ch<='f'

                        else
                           return C_hexnumberSym
                        end

                     end

                  end

               end

            end


         when 20
            return C_hexnumberSym
         when 21
            return C_hexnumberSym
         when 22
            return C_hexnumberSym
         when 23
            return C_hexnumberSym
         when 24
            if @ch=='"'
               state=25
            else
               if @ch>=' '&&@ch<='!'||@ch>='#'&&@ch<=255

               else
                  return No_Sym
               end

            end


         when 25
            return C_stringSym
         when 26
            if @ch>=' '&&@ch<='&'||@ch>='('&&@ch<='['||@ch>=']'&&@ch<=255
               state=28
            else
               if @ch==92
                  state=37
               else
                  return No_Sym
               end

            end


         when 28
            if @ch==39
               state=29
            else
               return No_Sym
            end


         when 29
            return C_charSym
         when 30
            if @ch=='.'||@ch>='0'&&@ch<=':'||@ch>='A'&&@ch<='Z'||@ch==92||@ch>='a'&&@ch<='z'
               state=31
            else
               if @ch=='<'
                  state=55
               else
                  if @ch=='='
                     state=59
                  else
                     return C_LessSym
                  end

               end

            end


         when 31
            if @ch=='>'
               state=32
            else
               if @ch=='.'||@ch>='0'&&@ch<=':'||@ch>='A'&&@ch<='Z'||@ch==92||@ch>='a'&&@ch<='z'

               else
                  return No_Sym
               end

            end


         when 32
            return C_librarySym
         when 33
            if @ch=='/'
               state=34
            else
               if @ch>=' '&&@ch<='.'||@ch>='0'&&@ch<=255

               else
                  return CheckLiteral(C_SlashSym)
               end

            end


         when 34
            return C_regexD1Sym
         when 35
            if @ch>=1&&@ch<=9||@ch>=11&&@ch<=255

            else
               return C_PreProcessorSym
            end


         when 36
            if @ch=='U'
               state=5
            else
               if @ch=='u'
                  state=6
               else
                  if @ch=='L'
                     state=7
                  else
                     if @ch=='l'
                        state=8
                     else
                        if @ch=='.'
                           state=4
                        else
                           if @ch>='0'&&@ch<='9'
                              state=2
                           else
                              if @ch=='X'||@ch=='x'
                                 state=18
                              else
                                 return C_numberSym
                              end

                           end

                        end

                     end

                  end

               end

            end


         when 37
            if @ch>=' '&&@ch<='&'||@ch>='('&&@ch<=255
               state=28
            else
               if @ch==39
                  state=29
               else
                  return No_Sym
               end

            end


         when 38
            return C_LparenSym
         when 39
            return C_RparenSym
         when 40
            return C_LbrackSym
         when 41
            return C_RbrackSym
         when 42
            return C_CommaSym
         when 43
            return C_LbraceSym
         when 44
            return C_RbraceSym
         when 45
            return C_ColonSym
         when 46
            return C_PointSym
         when 47
            if @ch=='+'
               state=48
            else
               if @ch=='='
                  state=74
               else
                  return C_PlusSym
               end

            end


         when 48
            return C_PlusPlusSym
         when 49
            if @ch=='-'
               state=50
            else
               if @ch=='='
                  state=75
               else
                  return C_MinusSym
               end

            end


         when 50
            return C_MinusMinusSym
         when 51
            return C_TildeSym
         when 52
            if @ch=='='
               state=63
            else
               return C_BangSym
            end


         when 53
            if @ch=='='
               state=72
            else
               return C_StarSym
            end


         when 54
            if @ch=='='
               state=73
            else
               return C_PercentSym
            end


         when 55
            if @ch=='='
               state=76
            else
               return C_LessLessSym
            end


         when 56
            if @ch=='>'
               state=57
            else
               if @ch=='='
                  state=60
               else
                  return C_GreaterSym
               end

            end


         when 57
            if @ch=='>'
               state=58
            else
               if @ch=='='
                  state=77
               else
                  return C_GreaterGreaterSym
               end

            end


         when 58
            if @ch=='='
               state=78
            else
               return C_GreaterGreaterGreaterSym
            end


         when 59
            return C_LessEqualSym
         when 60
            return C_GreaterEqualSym
         when 61
            if @ch=='='
               state=62
            else
               return C_EqualSym
            end


         when 62
            if @ch=='='
               state=64
            else
               return C_EqualEqualSym
            end


         when 63
            if @ch=='='
               state=65
            else
               return C_BangEqualSym
            end


         when 64
            return C_EqualEqualEqualSym
         when 65
            return C_BangEqualEqualSym
         when 66
            if @ch=='&'
               state=69
            else
               if @ch=='='
                  state=79
               else
                  return C_AndSym
               end

            end


         when 67
            if @ch=='='
               state=80
            else
               return C_UparrowSym
            end


         when 68
            if @ch=='|'
               state=70
            else
               if @ch=='='
                  state=81
               else
                  return C_BarSym
               end

            end


         when 69
            return C_AndAndSym
         when 70
            return C_BarBarSym
         when 71
            return C_QuerySym
         when 72
            return C_StarEqualSym
         when 73
            return C_PercentEqualSym
         when 74
            return C_PlusEqualSym
         when 75
            return C_MinusEqualSym
         when 76
            return C_LessLessEqualSym
         when 77
            return C_GreaterGreaterEqualSym
         when 78
            return C_GreaterGreaterGreaterEqualSym
         when 79
            return C_AndEqualSym
         when 80
            return C_UparrowEqualSym
         when 81
            return C_BarEqualSym
         when 82
            return C_SemicolonSym
         else
            return No_Sym
         end

      end

   end
   def Get1()

      frame_start


      label(:start){
         while (@ch>=9&&@ch<=10||@ch==13||@ch==' ')
            NextCh()
         end

         if (@ch=='/')&&Comment()
            goto :start
         end

         @currSym=@nextSym
         @nextSym.Init(0,@currLine,@currCol-1,@buffPos,0)
         @nextSym.Len=0
         ctx=0
         if @ch==EOF_CHAR
            return EOF_Sym
         end

         state=@@STATE0[@ch]
         while (1)
            NextCh()
            (@nextSym.Len+=1;@nextSym.Len-2)
            case state

            when 1
               if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='Z'||@ch=='_'||@ch>='a'&&@ch<='z'

               else
                  return CheckLiteral(C_identifierSym)
               end


            when 2
               if @ch=='U'
                  state=5
               else
                  if @ch=='u'
                     state=6
                  else
                     if @ch=='L'
                        state=7
                     else
                        if @ch=='l'
                           state=8
                        else
                           if @ch=='.'
                              state=4
                           else
                              if @ch>='0'&&@ch<='9'

                              else
                                 return C_numberSym
                              end

                           end

                        end

                     end

                  end

               end


            when 4
               if @ch=='U'
                  state=13
               else
                  if @ch=='u'
                     state=14
                  else
                     if @ch=='L'
                        state=15
                     else
                        if @ch=='l'
                           state=16
                        else
                           if @ch>='0'&&@ch<='9'

                           else
                              return C_numberSym
                           end

                        end

                     end

                  end

               end


            when 5
               return C_numberSym
            when 6
               return C_numberSym
            when 7
               return C_numberSym
            when 8
               return C_numberSym
            when 13
               return C_numberSym
            when 14
               return C_numberSym
            when 15
               return C_numberSym
            when 16
               return C_numberSym
            when 18
               if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='F'||@ch>='a'&&@ch<='f'
                  state=19
               else
                  return No_Sym
               end


            when 19
               if @ch=='U'
                  state=20
               else
                  if @ch=='u'
                     state=21
                  else
                     if @ch=='L'
                        state=22
                     else
                        if @ch=='l'
                           state=23
                        else
                           if @ch>='0'&&@ch<='9'||@ch>='A'&&@ch<='F'||@ch>='a'&&@ch<='f'

                           else
                              return C_hexnumberSym
                           end

                        end

                     end

                  end

               end


            when 20
               return C_hexnumberSym
            when 21
               return C_hexnumberSym
            when 22
               return C_hexnumberSym
            when 23
               return C_hexnumberSym
            when 24
               if @ch=='"'
                  state=25
               else
                  if @ch>=' '&&@ch<='!'||@ch>='#'&&@ch<=255

                  else
                     return No_Sym
                  end

               end


            when 25
               return C_stringSym
            when 26
               if @ch>=' '&&@ch<='&'||@ch>='('&&@ch<='['||@ch>=']'&&@ch<=255
                  state=28
               else
                  if @ch==92
                     state=37
                  else
                     return No_Sym
                  end

               end


            when 28
               if @ch==39
                  state=29
               else
                  return No_Sym
               end


            when 29
               return C_charSym
            when 30
               if @ch=='.'||@ch>='0'&&@ch<=':'||@ch>='A'&&@ch<='Z'||@ch==92||@ch>='a'&&@ch<='z'
                  state=31
               else
                  if @ch=='<'
                     state=55
                  else
                     if @ch=='='
                        state=59
                     else
                        return C_LessSym
                     end

                  end

               end


            when 31
               if @ch=='>'
                  state=32
               else
                  if @ch=='.'||@ch>='0'&&@ch<=':'||@ch>='A'&&@ch<='Z'||@ch==92||@ch>='a'&&@ch<='z'

                  else
                     return No_Sym
                  end

               end


            when 32
               return C_librarySym
            when 33
               if @ch=='/'
                  state=34
               else
                  if @ch>=' '&&@ch<='.'||@ch>='0'&&@ch<=255

                  else
                     return CheckLiteral(C_SlashSym)
                  end

               end


            when 34
               return C_regexD1Sym
            when 35
               if @ch>=1&&@ch<=9||@ch>=11&&@ch<=255

               else
                  return C_PreProcessorSym
               end


            when 36
               if @ch=='U'
                  state=5
               else
                  if @ch=='u'
                     state=6
                  else
                     if @ch=='L'
                        state=7
                     else
                        if @ch=='l'
                           state=8
                        else
                           if @ch=='.'
                              state=4
                           else
                              if @ch>='0'&&@ch<='9'
                                 state=2
                              else
                                 if @ch=='X'||@ch=='x'
                                    state=18
                                 else
                                    return C_numberSym
                                 end

                              end

                           end

                        end

                     end

                  end

               end


            when 37
               if @ch>=' '&&@ch<='&'||@ch>='('&&@ch<=255
                  state=28
               else
                  if @ch==39
                     state=29
                  else
                     return No_Sym
                  end

               end


            when 38
               return C_LparenSym
            when 39
               return C_RparenSym
            when 40
               return C_LbrackSym
            when 41
               return C_RbrackSym
            when 42
               return C_CommaSym
            when 43
               return C_LbraceSym
            when 44
               return C_RbraceSym
            when 45
               return C_ColonSym
            when 46
               return C_PointSym
            when 47
               if @ch=='+'
                  state=48
               else
                  if @ch=='='
                     state=74
                  else
                     return C_PlusSym
                  end

               end


            when 48
               return C_PlusPlusSym
            when 49
               if @ch=='-'
                  state=50
               else
                  if @ch=='='
                     state=75
                  else
                     return C_MinusSym
                  end

               end


            when 50
               return C_MinusMinusSym
            when 51
               return C_TildeSym
            when 52
               if @ch=='='
                  state=63
               else
                  return C_BangSym
               end


            when 53
               if @ch=='='
                  state=72
               else
                  return C_StarSym
               end


            when 54
               if @ch=='='
                  state=73
               else
                  return C_PercentSym
               end


            when 55
               if @ch=='='
                  state=76
               else
                  return C_LessLessSym
               end


            when 56
               if @ch=='>'
                  state=57
               else
                  if @ch=='='
                     state=60
                  else
                     return C_GreaterSym
                  end

               end


            when 57
               if @ch=='>'
                  state=58
               else
                  if @ch=='='
                     state=77
                  else
                     return C_GreaterGreaterSym
                  end

               end


            when 58
               if @ch=='='
                  state=78
               else
                  return C_GreaterGreaterGreaterSym
               end


            when 59
               return C_LessEqualSym
            when 60
               return C_GreaterEqualSym
            when 61
               if @ch=='='
                  state=62
               else
                  return C_EqualSym
               end


            when 62
               if @ch=='='
                  state=64
               else
                  return C_EqualEqualSym
               end


            when 63
               if @ch=='='
                  state=65
               else
                  return C_BangEqualSym
               end


            when 64
               return C_EqualEqualEqualSym
            when 65
               return C_BangEqualEqualSym
            when 66
               if @ch=='&'
                  state=69
               else
                  if @ch=='='
                     state=79
                  else
                     return C_AndSym
                  end

               end


            when 67
               if @ch=='='
                  state=80
               else
                  return C_UparrowSym
               end


            when 68
               if @ch=='|'
                  state=70
               else
                  if @ch=='='
                     state=81
                  else
                     return C_BarSym
                  end

               end


            when 69
               return C_AndAndSym
            when 70
               return C_BarBarSym
            when 71
               return C_QuerySym
            when 72
               return C_StarEqualSym
            when 73
               return C_PercentEqualSym
            when 74
               return C_PlusEqualSym
            when 75
               return C_MinusEqualSym
            when 76
               return C_LessLessEqualSym
            when 77
               return C_GreaterGreaterEqualSym
            when 78
               return C_GreaterGreaterGreaterEqualSym
            when 79
               return C_AndEqualSym
            when 80
               return C_UparrowEqualSym
            when 81
               return C_BarEqualSym
            when 82
               return C_SemicolonSym
            else
               return No_Sym
            end

         end

      }

      frame_end

   end

   @@STATE0








   @szName
end
