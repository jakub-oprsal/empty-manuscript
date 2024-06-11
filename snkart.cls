\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{snkart}

\newif\iftablet \tabletfalse
\DeclareOption{tablet}{\tablettrue}
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{amsart}
}
\ExecuteOptions{reqno}
\ProcessOptions\relax

\LoadClass{amsart}

\RequirePackage{geometry}
\RequirePackage{textcase}

\iftablet
  \geometry{b5paper, textwidth=28pc, textheight=50pc,
    asymmetric, hmarginratio=2:5, includeheadfoot}
\else
  \geometry{a4paper, textwidth=32pc, textheight=60pc,
    asymmetric, hmarginratio=2:5, includeheadfoot, marginparwidth=8pc}
\fi

\def\ps@headings{\ps@empty
  \def\@evenhead{%
    \setTrue{runhead}%
    \normalfont\sffamily\footnotesize \hfil
    \def\thanks{\protect\thanks@warning}%
    \leftmark{}{}%
    \rlap{\hbox{\hglue\marginparsep
      \normalsize\bfseries \thepage}}}%
  \def\@oddhead{%
    \setTrue{runhead}%
    \normalfont\sffamily\footnotesize \hfil
    \def\thanks{\protect\thanks@warning}%
    \rightmark{}{}%
    \rlap{\hbox{\hglue\marginparsep
      \normalsize\bfseries \thepage}}}%
  \let\@mkboth\markboth
}

\newcommand{\thefootnotemark}{\textsuperscript{\thefootnote}}
\renewcommand{\footnote}[1]{\stepcounter{footnote}%
   \thefootnotemark\marginpar{\raggedright\footnotesize\thefootnotemark\ #1}}
\def\@settitle{\begin{flushleft} \noindent \baselineskip20\p@\relax
  \sffamily \bfseries \uppercasenonmath\@title \Large \@title
  \end{flushleft}}
\def\@setkeywords{%
  \nobreak\addvspace\smallskipamount \bgroup
  \normalfont%\Small
  \noindent {\bfseries \keywordsname.}\enspace \@keywords\@addpunct.%
  \egroup}

\def\@adminfootnotes{%
  \marginpar
  {\footnotesize \vbox to\dimexpr\textheight-\baselineskip{\vss
    \setlength{\parskip}{2pt}
    \hsize\marginparwidth \reset@font\footnotesize \raggedright
    \ifx\@empty\@date\else \@setdate\par \fi
    \ifx\@empty\thankses\else \@setthanks\par \fi}}
  %\let\@makefnmark\relax  \let\@thefnmark\relax
  %\ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  %\ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  %\ifx\@empty\thankses\else \@footnotetext{%
  %  \def\par{\let\par\@par}\@setthanks}%
  %\fi
}
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS document classes; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
    \normalfont%\Small
    \list{}{\labelwidth\z@
      \leftmargin0pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    \item[\hskip\labelsep\bfseries\abstractname.]%
}{%
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}
\def\@maketitle{%
  \normalfont\normalsize
  \@adminfootnotes
  \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
  \global\topskip42\p@\relax % 5.5pc   "   "   "     "     "
  \@settitle
  \nobreak\addvspace\bigskipamount
  \@setaddresses
  \ifx\@empty\@dedicatory
  \else
    \baselineskip18\p@
    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \@setabstract
  \ifx\@empty\@keywords\else\@setkeywords\fi
  \normalsize
  \if@titlepage
    \newpage
  \else
    \dimen@34\p@ \advance\dimen@-\baselineskip
    \vskip\dimen@\relax
  \fi
} % end \@maketitle
\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \@setcopyright
  \thispagestyle{empty}% this sets first page specifications
  %\uppercasenonmath\shorttitle
  \author@andify\authors
  \ifx\@empty\shortauthors \let\shortauthors\authors
  \else \andify\shortauthors
  \fi
  \@maketitle@hook
  \begingroup
  \@maketitle
  \toks@\@xp{\sffamily \shortauthors}\@temptokena\@xp{\sffamily \shorttitle}%
  \toks4{\def\\{ \ignorespaces}}% defend against questionable usage
  \edef\@tempa{%
    \@nx\markboth{\the\toks4
      \@nx\relax{\the\toks@}}{\the\@temptokena}}%
  \@tempa
  \endgroup
  \c@footnote\z@
  \@cleartopmattertags
}
\renewcommand{\author}[2][]{%
  \ifx\@empty\authors
    \gdef\authors{#2}%
    \gdef\addresses{\author{#2}}%
  \else
    \g@addto@macro\authors{\and#2}%
    \g@addto@macro\addresses{\author{#2}}%
  \fi
  \@ifnotempty{#1}{%
    \ifx\@empty\shortauthors
      \gdef\shortauthors{#1}%
    \else
      \g@addto@macro\shortauthors{\and#1}%
    \fi
  }%
}
\def\emailaddrname{}
\def\urladdrname{}
\def\@setaddresses{\par
  \nobreak \begingroup \parindent\z@
  \normalsize
  \interlinepenalty\@M
  \def\author##1{\nobreak\addvspace\bigskipamount
    \def\\{\protect\linebreak}
    {\bfseries \sffamily \large {##1}}\par}
  \def\\{\unskip, \ignorespaces}%
  \def\address##1##2{\begingroup
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent\curraddrname
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par}\endgroup}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak
      \@ifnotempty{##1}{\ignorespaces##1\unskip\/:\space}%
      \slshape##2\par}\endgroup}%
  \def\urladdr##1##2{\begingroup
    \def~{\char`\~}%
    \@ifnotempty{##2}{\nobreak
      \@ifnotempty{##1}{\ignorespaces##1\unskip\/:\space}%
      \slshape##2\par}\endgroup}%
  \addresses
  \endgroup
}
\def\enddoc@text{\ifx\@empty\@translators \else\@settranslators\fi}

\def\section{\@startsection{section}{1}\z@{1.4\linespacing\@plus\linespacing}%
  {1\linespacing}{\sffamily\bfseries}}
\def\subsection{\@startsection{subsection}{2}\z@%
  {.7\linespacing\@plus.7\linespacing}{.5\linespacing}{\sffamily\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{.5\linespacing\@plus.7\linespacing}{-.5em}%
  {\sffamily\itshape}}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
  \@tempskipa #5\relax
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \edef\@secnumpunct{%
      \ifdim\@tempskipa>\z@ % not a run-in section heading
        \@ifnotempty{#8}{.\@nx\enspace}%
      \else
        \@ifempty{#8}{.}{.\@nx\enspace}%
      \fi
    }%
    \@ifempty{#8}{%
      \ifnum #2=\tw@ \def\@secnumfont{\bfseries}\fi}{}%
    \protected@edef\@svsec{%
      \ifnum#2<\@m
        \@ifundefined{#1name}{}{%
          \ignorespaces\csname #1name\endcsname\space
        }%
      \fi
      \@seccntformat{#1}%
    }%
  \fi
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
    \@hangfrom{\hskip #3\relax\@svsec}{\ifnum#2=\@ne
      \interlinepenalty\@M \MakeTextUppercase{#8}\par 
    \else \interlinepenalty\@M #8\par \fi}%
    \endgroup
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  \else
  \def\@svsechd{#6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip
       \@addpunct.}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

  \renewcommand{\datename}{\textit{Date}:}

%%
% FONTS AND GLYPHS
%

\RequirePackage[tt=false]{libertine}
\RequirePackage[varqu]{zi4}
\let\openbox\undefined % Workaround for newtxmath and amsthm clash
\RequirePackage[libertine]{newtxmath}
\RequirePackage{microtype}
\RequirePackage{mathrsfs}
\RequirePackage[T1]{fontenc}

\RequirePackage[dvipsnames]{xcolor}
\definecolor{purple}{cmyk}{0.55,1,0,0.15}
\definecolor{darkblue}{cmyk}{1,0.58,0,0.21}
\RequirePackage[colorlinks,
  linkcolor=black,
  urlcolor=darkblue,
  citecolor=purple]{hyperref}
\urlstyle{same}

\RequirePackage{graphicx}

%%
% THEOREM STYLES
%

\newtheoremstyle{newplain}%
  \thm@preskip\thm@postskip{\itshape}{0pt}{\sffamily\bfseries}{.}{.7em plus.3em minus.3em}%
  {\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}} 
\theoremstyle{newplain}

\newtheoremstyle{newdefinition}%
  \thm@preskip\thm@postskip{\normalfont}{0pt}{\sffamily\itshape}{.}{.7em plus.3em minus.3em}%
  {\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}} 

\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \sffamily\itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}

\pagenumbering{arabic}%
\pagestyle{headings}%
\thispagestyle{plain}%

%%
% THEOREM ENVIRONMENTS
%
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{claim}[theorem]{Claim}

\theoremstyle{newdefinition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}

\endinput
