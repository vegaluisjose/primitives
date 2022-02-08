use anyhow::Context;
use askama::Template;
use derive_more::{Deref, DerefMut};
use std::fmt;
use std::fs;
use std::path::{Path, PathBuf};

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
    pub use_constraint: bool,
}

impl Vivado {
    pub fn new<P: AsRef<Path>>(name: &str, verilog_file: P) -> anyhow::Result<Vivado> {
        let vf = verilog_file.as_ref().to_path_buf();
        let vf = fs::canonicalize(vf).context("failed to read verilog file")?;
        Ok(Vivado {
            name: name.to_string(),
            verilog_file: vf.into(),
            timing_file: PathBuf::from("timing.rpt").into(),
            timingsum_file: PathBuf::from("timingsum.rpt").into(),
            util_file: PathBuf::from("util.rpt").into(),
            use_constraint: false,
        })
    }

    pub fn new_with_constraint<P: AsRef<Path>>(
        name: &str,
        verilog_file: P,
    ) -> anyhow::Result<Vivado> {
        let vf = verilog_file.as_ref().to_path_buf();
        let vf = fs::canonicalize(vf).context("failed to read verilog file")?;
        Ok(Vivado {
            name: name.to_string(),
            verilog_file: vf.into(),
            timing_file: PathBuf::from("timing.rpt").into(),
            timingsum_file: PathBuf::from("timingsum.rpt").into(),
            util_file: PathBuf::from("util.rpt").into(),
            use_constraint: true,
        })
    }
}

#[derive(Template, Clone, Debug)]
#[template(path = "constraint.txt")]
pub struct Constraint {
    pub name: String,
    pub period: u32,
}

impl Default for Constraint {
    fn default() -> Constraint {
        Constraint {
            name: "clock".into(),
            period: 5,
        }
    }
}
