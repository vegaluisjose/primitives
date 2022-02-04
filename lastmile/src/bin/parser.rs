use lastmile::profile::Profile;
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
#[structopt(
    name = "parser",
    about = "A tool for parsing timing and utilization results"
)]
struct Opt {
    /// Timing file
    #[structopt(short = "t", long)]
    timing_file: PathBuf,
    /// Timing file
    #[structopt(short = "u", long)]
    utilization_file: PathBuf,
    /// Output file
    #[structopt(short, long)]
    output: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let opt = Opt::from_args();
    println!(
        "Parsing timing:{} util:{}",
        opt.timing_file.display(),
        opt.utilization_file.display()
    );
    let profile = Profile::from_timing_and_utilization(opt.timing_file, opt.utilization_file)?;
    if let Some(output) = opt.output {
        let mut file = File::create(output)?;
        file.write_all(format!("{:#?}", profile).as_bytes())?;
    } else {
        println!("{:#?}", profile);
    }
    Ok(())
}
