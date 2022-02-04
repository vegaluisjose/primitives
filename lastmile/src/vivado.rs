use askama::Template;
use derive_more::{Deref, DerefMut};
use std::fmt;
use std::path::PathBuf;

#[derive(Clone, Debug, Deref, DerefMut)]
pub struct TemplatePathBuf(pub PathBuf);

impl From<PathBuf> for TemplatePathBuf {
    fn from(input: PathBuf) -> TemplatePathBuf {
        TemplatePathBuf(input)
    }
}

impl fmt::Display for TemplatePathBuf {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.display())
    }
}

#[derive(Template, Clone, Debug)]
#[template(path = "vivado.txt")]
pub struct Vivado {
    pub name: String,
    pub verilog_file: TemplatePathBuf,
    pub timing_file: TemplatePathBuf,
    pub timingsum_file: TemplatePathBuf,
    pub util_file: TemplatePathBuf,
}

impl Vivado {
    pub fn new(name: &str) -> Self {
        Vivado {
            name: name.to_string(),
            verilog_file: PathBuf::from("top.v").into(),
            timing_file: PathBuf::from("timing.rpt").into(),
            timingsum_file: PathBuf::from("timingsum.rpt").into(),
            util_file: PathBuf::from("util.rpt").into(),
        }
    }
}
