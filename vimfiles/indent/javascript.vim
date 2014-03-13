" Vim indent file
" Last Change: 2014 Mar 13
" Acknowledgement: Based off of Darrick Wiebe <darrick at innatesoftware.com> that is based off of vim-ruby maintained by Nikolai Weibull http://vim-ruby.rubyforge.org

if exists("b:did_indent")
    finish
endif

let b:did_indent = 1

setlocal nosmartindent
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e

if exists("*GetJavascriptIndent")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:syng_strcom = '\<javaScript\%(RegexpString\|CommentTodo\|LineComment\|Comment\|DocComment\)\>'
let s:syng_string = '\<javaScript\%(RegexpString\)\>'
let s:syng_stringdoc = '\<javaScriptDocComment\>'
let s:skip_expr = "synIDattr(synID(line('.'),col('.'),1),'name') =~ '" . s:syng_strcom . "'"
let s:line_term = '\s*\%(\%(\/\/\).*\)\=$'
let s:continuation_regex = '\%([\\*+/.:]\|\%(<%\)\@<![=-]\|\W[|&?]\|||\|&&\)' . s:line_term
let s:msl_regex = '\%([\\*+/.:([]\|\%(<%\)\@<![=-]\|\W[|&?]\|||\|&&\)' . s:line_term
let s:one_line_scope_regex = '\<\%(if\|else\|for\|while\)\>[^{]*' . s:line_term
let s:block_regex = '\%({\)\s*\%(|\%([*@]\=\h\w*,\=\s*\)\%(,\s*[*@]\=\h\w*\)*|\)\=' . s:line_term

function s:IsInStringOrComment(lnum, col)
    return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_strcom
endfunction

function s:IsInString(lnum, col)
    return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_string
endfunction

function s:IsInStringOrDocumentation(lnum, col)
    return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_stringdoc
endfunction

function s:PrevNonBlankNonString(lnum)
    let in_block = 0
    let lnum = prevnonblank(a:lnum)

    while lnum > 0
        let line = getline(lnum)

        if line =~ '/\*'
            if !in_block
                break
            endif

            let in_block = 0
        elseif !in_block && line =~ '\*/'
            let in_block = 1
        elseif !in_block && line !~ '^\s*\%(//\).*$' && !(s:IsInStringOrComment(lnum, 1) && s:IsInStringOrComment(lnum, strlen(line)))
            break
        endif

        let lnum = prevnonblank(lnum - 1)
    endwhile

    return lnum
endfunction

function s:GetMSL(lnum, in_one_line_scope)
    let msl = a:lnum
    let lnum = s:PrevNonBlankNonString(a:lnum - 1)

    while lnum > 0
        let line = getline(lnum)
        let col = match(line, s:msl_regex) + 1

        if (col > 0 && !s:IsInStringOrComment(lnum, col)) || s:IsInString(lnum, strlen(line))
            let msl = lnum
        else
            if a:in_one_line_scope 
                break
            end

            let msl_one_line = s:Match(lnum, s:one_line_scope_regex)

            if msl_one_line == 0
                break
            endif
        endif

        let lnum = s:PrevNonBlankNonString(lnum - 1)
    endwhile

    return msl
endfunction

function s:LineHasOpeningBrackets(lnum)
    let open_0 = 0
    let open_2 = 0
    let open_4 = 0
    let line = getline(a:lnum)
    let pos = match(line, '[][(){}]', 0)

    while pos != -1
        if !s:IsInStringOrComment(a:lnum, pos + 1)
            let idx = stridx('(){}[]', line[pos])

            if idx % 2 == 0
                let open_{idx} = open_{idx} + 1
            else
                let open_{idx - 1} = open_{idx - 1} - 1
            endif
        endif

        let pos = match(line, '[][(){}]', pos + 1)
    endwhile

    return (open_0 > 0) . (open_2 > 0) . (open_4 > 0)
endfunction

function s:Match(lnum, regex)
    let col = match(getline(a:lnum), a:regex) + 1
    return col > 0 && !s:IsInStringOrComment(a:lnum, col) ? col : 0
endfunction

function s:IndentWithContinuation(lnum, ind, width)
    let p_lnum = a:lnum
    let lnum = s:GetMSL(a:lnum, 1)
    let line = getline(line)

    if p_lnum != lnum && (s:Match(p_lnum, s:continuation_regex) || s:IsInString(p_lnum, strlen(line)))
        return a:ind + a:width
    endif

    let msl_ind = indent(lnum)

    if s:Match(lnum, s:continuation_regex)
        return lnum == p_lnum ? msl_ind + a:width : msl_ind
    endif

    return a:ind
endfunction

function s:InOneLineScope(lnum)
    let msl = s:GetMSL(a:lnum, 1)

    if msl > 0 && s:Match(msl, s:one_line_scope_regex)
        return msl
    endif

    return 0
endfunction

function s:ExitingOneLineScope(lnum)
    let msl = s:GetMSL(a:lnum, 1)

    if msl > 0
        if s:Match(msl, s:one_line_scope_regex)
            return 0
        endif

        let prev_msl = s:GetMSL(msl - 1, 1)

        if s:Match(prev_msl, s:one_line_scope_regex)
            return prev_msl
        endif
    endif

    return 0
endfunction

function GetJavascriptIndent()
    let vcol = col('.')
    let line = getline(v:lnum)
    let ind = -1
    let col = matchend(line, '^\s*[]})]')

    if col > 0 && !s:IsInStringOrComment(v:lnum, col)
        call cursor(v:lnum, col)
        let bs = strpart('(){}[]', stridx(')}]', line[col - 1]) * 2, 2)

        if searchpair(escape(bs[0], '\['), '', bs[1], 'bW', s:skip_expr) > 0
            if line[col-1]==')' && col('.') != col('$') - 1
                let ind = virtcol('.') - 1
            else
                let ind = indent(s:GetMSL(line('.'), 0))
            endif
        endif
        return ind
    endif

    if match(line, '^\s*\%(/\*\|\*/\)$') != -1
        return 0
    endif

    if s:IsInStringOrDocumentation(v:lnum, matchend(line, '^\s*') + 1)
        return indent('.')
    endif

    let lnum = s:PrevNonBlankNonString(v:lnum - 1)

    if line =~ '^\s*$' && lnum != prevnonblank(v:lnum - 1)
        return indent(prevnonblank(v:lnum))
    endif

    if lnum == 0
        return 0
    endif

    let line = getline(lnum)
    let ind = indent(lnum)

    if s:Match(lnum, s:block_regex)
        return indent(s:GetMSL(lnum, 0)) + &sw
    endif

    if line =~ '[[({]'
        let counts = s:LineHasOpeningBrackets(lnum)

        if counts[0] == '1' && searchpair('(', '', ')', 'bW', s:skip_expr) > 0
            if col('.') + 1 == col('$')
                return ind + &sw
            endif

            return virtcol('.')
        elseif counts[1] == '1' || counts[2] == '1'
            return ind + &sw
        endif

        call cursor(v:lnum, vcol)
    endif

    let ind_con = ind
    let ind = s:IndentWithContinuation(lnum, ind_con, &sw)
    let ols = s:InOneLineScope(lnum)

    if ols > 0
        let ind = ind + &sw
    else
        let ols = s:ExitingOneLineScope(lnum)

        while ols > 0 && ind > 0
            let ind = ind - &sw
            let ols = s:InOneLineScope(ols - 1)
        endwhile
    endif

    return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
