use askama::Template;
use lastmile::vivado::Vivado;
use std::fs;
use std::path::PathBuf;
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
    /// The work directory
    #[structopt(short, long)]
    workdir: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let opt = Opt::from_args();
    let workdir = if let Some(w) = opt.workdir {
        if !w.exists() {
            fs::create_dir_all(w.clone())?;
        }
        w
    } else {
        TempDir::new("out")?.path().to_path_buf()
    };
    let vivado = Vivado::new("top", "./some.v")?;
    let tcl = workdir.join("vivado.tcl");
    fs::write(tcl, vivado.render()?.as_bytes())?;
    Ok(())
}
