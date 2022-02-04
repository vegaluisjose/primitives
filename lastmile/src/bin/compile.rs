use askama::Template;
use lastmile::vivado::Vivado;

fn main() -> anyhow::Result<()> {
    let vivado = Vivado::new("top");
    println!("{}", vivado.render()?);
    Ok(())
}