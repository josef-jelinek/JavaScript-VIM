" Vim syntax file
" Last Change: 2014 Mar 13
" Acknowledgement: based on Yi Zhao (ZHAOYI) <zzlinux AT hotmail DOT com>

if !exists("main_syntax")
    if exists("b:current_syntax")
        finish
    endif

    let main_syntax = 'javascript'
endif

let b:javascript_fold='true'

setlocal iskeyword+=$

syntax sync fromstart

syntax match javaScriptWSError "\s\+$\|\t"

syntax keyword javaScriptCommentTodo    TODO FIXME XXX TBD contained
syntax region  javaScriptLineComment    start=+\/\/+ end=+$+ keepend contains=javaScriptCommentTodo,javaScriptWSError,@Spell
syntax region  javaScriptLineComment    start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend contains=javaScriptCommentTodo,javaScriptWSError,@Spell fold
syntax region  javaScriptCvsTag         start="\$\cid:" end="\$" oneline contained
syntax region  javaScriptComment        start="/\*"  end="\*/" contains=javaScriptCommentTodo,javaScriptCvsTag,javaScriptWSError,@Spell fold

syntax case match

if !exists("javascript_ignore_javaScriptdoc")
    syntax include @javaScriptHtml <sfile>:p:h/jsdochtml.vim
    unlet b:current_syntax

    syntax region javaScriptDocComment    matchgroup=javaScriptComment start="/\*\*"  end="\*/" contains=javaScriptDocTags,javaScriptCommentTodo,javaScriptCvsTag,javaScriptWSError,@javaScriptHtml,@Spell fold
    syntax match  javaScriptDocTags       contained "@\(author\|class\|constant\|constructor\|constructs\|default\|deprecated\|description\|event\|example\|field\|fileOverview\|function\|ignore\|inner\|namespace\|private\|public\|see\|since\|static\|version\)\>"
    syntax match  javaScriptDocTags       contained "@\(augments\|lends\|memberOf\|name\|requires\)\>" nextgroup=javaScriptDocParam skipwhite
    syntax match  javaScriptDocTags       contained "@\(type\|returns\|throws\)\>" nextgroup=javaScriptDocParamType1 skipwhite
    syntax match  javaScriptDocTags       contained "@\(param\|property\)\>" nextgroup=javaScriptDocParamType skipwhite
    syntax match  javaScriptDocTags       contained "@\(borrows\|exports\)\>" nextgroup=javaScriptDocParam1 skipwhite
    syntax match  javaScriptDocTags       contained "{@link\s[^}]*}"
    syntax match  javaScriptDocParamType  contained "{\S\+}" nextgroup=javaScriptDocParam skipwhite
    syntax match  javaScriptDocParamType1 contained "{\S\+}\|\w\+"
    syntax match  javaScriptDocParam1     contained "\S\+" nextgroup=javaScriptDocParamAs skipwhite
    syntax match  javaScriptDocParamAs    contained "as" nextgroup=javaScriptDocParam skipwhite
    syntax match  javaScriptDocParam      contained "\S\+"
endif

syntax match   javaScriptSpecial        "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
syntax region  javaScriptStringD        start=+"+  skip=+\\\\\|\\$"+  end=+"+  contains=javaScriptSpecial,@htmlPreproc
syntax region  javaScriptStringS        start=+'+  skip=+\\\\\|\\$'+  end=+'+  contains=javaScriptSpecial,@htmlPreproc
syntax region  javaScriptRegexpString   start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=javaScriptSpecial,@htmlPreproc oneline
syntax match   javaScriptNumber         /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syntax match   javaScriptFloat          /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
syntax match   javaScriptLabel          /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/

syntax keyword javaScriptPrototype      prototype

syntax keyword javaScriptSource         import export
syntax keyword javaScriptType           const this undefined var void yield 
syntax keyword javaScriptOperator       delete new in instanceof let typeof
syntax keyword javaScriptBoolean        true false
syntax keyword javaScriptNull           null

syntax keyword javaScriptConditional    if else
syntax keyword javaScriptRepeat         do while for
syntax keyword javaScriptBranch         break continue switch case default return
syntax keyword javaScriptStatement      try catch throw with finally

syntax keyword javaScriptGlobalObjects  Array Boolean Date Function Infinity JavaArray JavaClass JavaObject JavaPackage Math Number NaN Object Packages RegExp String Undefined java netscape sun

syntax keyword javaScriptExceptions     Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax keyword javaScriptFutureKeys     abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public

syntax keyword javaScriptGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
syntax keyword javaScriptExceptions     DOMException

syntax keyword javaScriptDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
syntax keyword javaScriptDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE

syntax case ignore
syntax keyword javaScriptHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize
syntax case match

" Follow stuff should be highligh within a special context
" While it can't be handled with context depended with Regex based highlight
" So, turn it off by default
if exists("javascript_enable_domhtmlcss")
    syntax match javaScriptDomElemAttrs  contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
    syntax match javaScriptDomElemFuncs  contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=javaScriptParen skipwhite
    " HTML things
    syntax match javaScriptHtmlElemAttrs contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
    syntax match javaScriptHtmlElemFuncs contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=javaScriptParen skipwhite

    syntax keyword javaScriptCssStyles contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
    syntax keyword javaScriptCssStyles contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
    syntax keyword javaScriptCssStyles contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
    syntax keyword javaScriptCssStyles contained bottom height left position right top width zIndex
    syntax keyword javaScriptCssStyles contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
    syntax keyword javaScriptCssStyles contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
    syntax keyword javaScriptCssStyles contained listStyle listStyleImage listStylePosition listStyleType
    syntax keyword javaScriptCssStyles contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
    syntax keyword javaScriptCssStyles contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
    syntax keyword javaScriptCssStyles contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
    syntax keyword javaScriptCssStyles contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor

    syntax match javaScriptDotNotation "\." nextgroup=javaScriptPrototype,javaScriptDomElemAttrs,javaScriptDomElemFuncs,javaScriptHtmlElemAttrs,javaScriptHtmlElemFuncs
    syntax match javaScriptDotNotation "\.style\." nextgroup=javaScriptCssStyles

endif

syntax cluster javaScriptAll     contains=javaScriptComment,javaScriptLineComment,javaScriptDocComment,javaScriptStringD,javaScriptStringS,javaScriptRegexpString,javaScriptNumber,javaScriptFloat,javaScriptLabel,javaScriptSource,javaScriptType,javaScriptOperator,javaScriptBoolean,javaScriptNull,javaScriptFunction,javaScriptConditional,javaScriptRepeat,javaScriptBranch,javaScriptStatement,javaScriptGlobalObjects,javaScriptExceptions,javaScriptFutureKeys,javaScriptDomErrNo,javaScriptDomNodeConsts,javaScriptHtmlEvents,javaScriptDotNotation,javaScriptWSError

syntax region javaScriptBracket matchgroup=javaScriptBracket transparent start="\[" end="\]" contains=@javaScriptAll,javaScriptParensErrB,javaScriptParensErrC,javaScriptBracket,javaScriptParen,javaScriptBlock,@htmlPreproc
syntax region javaScriptParen   matchgroup=javaScriptParen   transparent start="("  end=")"  contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrC,javaScriptParen,javaScriptBracket,javaScriptBlock,@htmlPreproc
syntax region javaScriptBlock   matchgroup=javaScriptBlock   transparent start="{"  end="}"  contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrB,javaScriptParen,javaScriptBracket,javaScriptBlock,@htmlPreproc 

syntax match javaScriptParensError ")\|}\|\]"
syntax match javaScriptParensErrA  contained "\]"
syntax match javaScriptParensErrB  contained ")"
syntax match javaScriptParensErrC  contained "}"

if main_syntax == "javascript"
  syntax sync clear
  syntax sync ccomment javaScriptComment minlines=200
  syntax sync match javaScriptHighlight grouphere javaScriptBlock /{/
endif

if exists("b:javascript_fold")
    syntax match  javaScriptFunction  /\<function\>/ nextgroup=javaScriptFuncName skipwhite
    syntax match  javaScriptOpAssign  /=\@<!=/ nextgroup=javaScriptFuncBlock skipwhite skipempty
    syntax region javaScriptFuncName  contained matchgroup=javaScriptFuncName start=/\%(\$\|\w\)*\s*(/ end=/)/ contains=javaScriptLineComment,javaScriptComment nextgroup=javaScriptFuncBlock skipwhite skipempty
    syntax region javaScriptFuncBlock contained matchgroup=javaScriptFuncBlock start="{" end="}" contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrB,javaScriptParen,javaScriptBracket,javaScriptBlock fold

    if &l:filetype=='javascript' && !&diff
      setlocal foldmethod=syntax
      setlocal foldlevel=4
    endif
else
    syntax keyword javaScriptFunction function
    setlocal foldmethod<
    setlocal foldlevel<
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
    if version < 508
        let did_javascript_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink javaScriptComment       Comment
    HiLink javaScriptLineComment   Comment
    HiLink javaScriptDocComment    Comment
    HiLink javaScriptCommentTodo   Todo
    HiLink javaScriptCvsTag        Function
    HiLink javaScriptDocTags       Special
    HiLink javaScriptDocParam      Function
    HiLink javaScriptDocParam1     Function
    HiLink javaScriptDocParamAs    Special
    HiLink javaScriptDocParamType  Type
    HiLink javaScriptDocParamType1 Type
    HiLink javaScriptStringS       String
    HiLink javaScriptStringD       String
    HiLink javaScriptRegexpString  String
    HiLink javaScriptCharacter     Character
    HiLink javaScriptPrototype     Type
    HiLink javaScriptConditional   Conditional
    HiLink javaScriptBranch        Conditional
    HiLink javaScriptRepeat        Repeat
    HiLink javaScriptStatement     Statement
    HiLink javaScriptFunction      Function
    HiLink javaScriptError         Error
    HiLink javaScriptWSError       Error
    HiLink javaScriptParensError   Error
    HiLink javaScriptParensErrA    Error
    HiLink javaScriptParensErrB    Error
    HiLink javaScriptParensErrC    Error
    HiLink javaScriptOperator      Operator
    HiLink javaScriptType          Type
    HiLink javaScriptNull          Type
    HiLink javaScriptNumber        Number
    HiLink javaScriptFloat         Number
    HiLink javaScriptBoolean       Boolean
    HiLink javaScriptLabel         Label
    HiLink javaScriptSpecial       Special
    HiLink javaScriptSource        Special
    HiLink javaScriptGlobalObjects Special
    HiLink javaScriptExceptions    Special
    HiLink javaScriptDomErrNo      Constant
    HiLink javaScriptDomNodeConsts Constant
    HiLink javaScriptDomElemAttrs  Label
    HiLink javaScriptDomElemFuncs  PreProc
    HiLink javaScriptHtmlEvents    Special
    HiLink javaScriptHtmlElemAttrs Label
    HiLink javaScriptHtmlElemFuncs PreProc
    HiLink javaScriptCssStyles     Label

    delcommand HiLink
endif

syntax cluster htmlJavaScript contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError
syntax cluster javaScriptExpression contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError,@htmlPreproc

let b:current_syntax = "javascript"

if main_syntax == 'javascript'
    unlet main_syntax
endif
