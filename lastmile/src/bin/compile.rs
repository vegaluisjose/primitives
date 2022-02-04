use askama::Template;
use lastmile::vivado::{Constraint, Vivado};
use std::fs;
use std::path::PathBuf;
use std::process::Command;
use structopt::StructOpt;
use tempdir::TempDir;

#[derive(Debug, StructOpt)]
#[structopt(name = "compile", about = "A tool for compiling roms")]
struct Opt {
    /// The name of the rom
    #[structopt(short, long, default_value = "rom")]
    name: String,
    /// The input file
    #[structopt(short, long)]
    input: PathBuf,
    /// The timing file
    #[structopt(short, long, default_value = "timing.rpt")]
    timing_file: PathBuf,
    /// The utilization file
    #[structopt(short, long, default_value = "util.rpt")]
    util_file: PathBuf,
    /// The work directory
    #[structopt(short, long)]
    workdir: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let opt = Opt::from_args();
    println!("Compiling: {}", opt.input.display());
    let tmp = TempDir::new("out")?;
    let workdir = if let Some(w) = opt.workdir {
        if !w.exists() {
            fs::create_dir_all(w.clone())?;
        }
        w
    } else {
        tmp.path().to_path_buf()
    };
    let vivado = Vivado::new(&opt.name, opt.input)?;
    let vivado_tcl = workdir.join("vivado.tcl");
    fs::write(vivado_tcl, vivado.render()?.as_bytes())?;
    let constr = Constraint::default();
    let constr_tcl = workdir.join("constraint.xdc");
    fs::write(constr_tcl, constr.render()?.as_bytes())?;
    let output = Command::new("vivado")
        .current_dir(&workdir)
        .arg("-mode")
        .arg("batch")
        .arg("-source")
        .arg("vivado.tcl")
        .output()?;
    if output.status.success() {
        fs::copy(workdir.join("timing.rpt"), opt.timing_file)?;
        fs::copy(workdir.join("util.rpt"), opt.util_file)?;
        Ok(())
    } else {
        Err(anyhow::anyhow!(
            "failed to run vivado \n{}\n",
            String::from_utf8(output.stdout)?
        ))
    }
}
