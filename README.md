<img src="docs/github-graphics/hero.jpg" width="100%" alt="Pika — Steel fabrication, native to Rhino 8" />
<img src="docs/github-graphics/workflow.jpg" width="100%" alt="Import · Model · Number · Nest · Output" />
<img src="docs/github-graphics/capabilities.jpg" width="100%" alt="Everything in one panel" />

## Install

1. Go to **[Pika-dist releases](https://github.com/evanemerydesign/Pika-dist/releases)**
2. Download the latest `.yak` file
3. Open Rhino 8 — drag the `.yak` onto the viewport to install
4. Restart Rhino, then type `Pika` to open the panel

> Requires Rhino 8 or later.

## Documentation

[Full feature documentation →](https://evanemerydesign.github.io/Pika)

## Development

Built with C# · RhinoCommon · Eto.Forms · SQLite

```
src/Pika.Plugin/        ← Plugin entry point, panel registration
src/Pika.Modules/
  AssetImport/          ← Shape import, layer builder, color assignment
  Nesting/              ← 1D nesting engine (FFD bin-pack)
src/Pika.Data/          ← SQLite schema, AISC models, shape catalog, part registry
src/Pika.UI/            ← All Eto.Forms screens and dialogs
tools/Pika.Preview/     ← WPF preview harness (drive Eto UI outside Rhino)
data/aisc-catalog.db    ← Read-only AISC shape catalog
```

## On the roadmap

<img src="docs/github-graphics/roadmap.jpg" width="100%" alt="Pika roadmap — features under development" />

Pika ships new tools steadily. These are **under development** — designed and partly built, but not yet in the shipping `.yak`:

- **1D Nesting** — *in progress* · pack parts onto stock lengths, results straight into the model
- **Hardware** — *planned* · bolts, anchors & base-plate assemblies with auto holes + CL marks
- **Drawings & Output** — *planned* · cut list, flat-part shop drawings & a unified BOM
- **Project Info** — *planned* · project & scope fields saved into the `.3dm`
- **Box Generator** — *planned* · draw a box, get a mitered member frame
- **Perforated Steel** · **Pikafy** · **Custom Shapes** — *exploring*

[See the full roadmap →](https://evanemerydesign.github.io/Pika#features)
