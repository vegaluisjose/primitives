use askama::Template;
use lastmile::rom::{Rom, RomA, RomB, RomType};
use rand::{rngs::StdRng, Rng, SeedableRng};
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
#[structopt(name = "rom", about = "A tool for generating two types of roms")]
struct Opt {
    /// Name of the rom
    #[structopt(short, long, default_value("rom"))]
    name: String,
    /// Size (number of elements) of ROM
    #[structopt(short, long, default_value("4"))]
    size: u32,
    /// Data width of ROM
    #[structopt(short, long, default_value("32"))]
    data: u32,
    /// Type of ROM
    #[structopt(short, long, default_value("a"))]
    rom: RomType,
    /// Seed for data ROM
    #[structopt(long, default_value("0"))]
    seed: u64,
    /// Add bram pragma
    #[structopt(long)]
    bram: bool,
    /// Output file
    #[structopt(short, long)]
    output: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let opt = Opt::from_args();
    println!("Generating {}", opt.name);
    let mut rng = StdRng::seed_from_u64(opt.seed);
    let mut rom = if opt.bram {
        Rom::new_with_bram(&opt.name, opt.size, opt.data)
    } else {
        Rom::new(&opt.name, opt.size, opt.data)
    };
    for _ in 0..opt.size {
        rom.add_value(rng.gen());
    }
    let s = match opt.rom {
        RomType::A => RomA(rom).render()?,
        RomType::B => RomB(rom).render()?,
    };
    if let Some(output) = opt.output {
        let mut file = File::create(output)?;
        file.write_all(s.as_bytes())?;
    } else {
        println!("{}", s);
    }
    Ok(())
}
