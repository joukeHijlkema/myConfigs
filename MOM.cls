\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MOM}[2017/09/01 my minutes of meetings class]

\LoadClass{article}
\renewcommand\maketitle{}
\renewcommand{\thesubsection}{\arabic{subsection}}

%Options
\RequirePackage{kvoptions}
\DeclareStringOption[Unprotected]{protection}[Unprotected]
\DeclareStringOption[?]{aer}[?]
\def \crNumber {?}
\def \crRelease {?}

\ProcessKeyvalOptions*
\renewcommand{\familydefault}{\sfdefault}

% Headers & footers
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage[margin=1cm,headheight=2cm,includeheadfoot]{geometry}
\pagestyle{fancy}

\lhead{\               \\ MEETING OR REVIEW REPORT           \\ Reference: DMPH/CR-RA-\crNumber-AER\MOM@aer}
\chead{\MOM@protection \\ page \thepage\//\pageref{LastPage} \\ \ }
\rhead{\               \\ \                                  \\ Release date: \crRelease}

\lfoot{GEN-F153-3 (GEN-SCI-004)}
\cfoot={}
\rfoot{\includegraphics[height=1cm]{/home/hylkema/Documents/Icons/logoOnera.pdf}}


% section underline
\RequirePackage{titlesec}
\titleformat{\subsection}
  {\normalfont\Large\bfseries}{\thesubsection}{1em}{}[{\titlerule[0.8pt]}]
