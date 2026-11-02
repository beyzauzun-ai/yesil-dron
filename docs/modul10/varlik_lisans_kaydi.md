# Yeşil Dron: Varlık ve Lisans Kaydı

**Modül:** GameUp Türkiye, Yapay Zekâyla Oyun Geliştirme, 10. Modül
**Proje:** `yesil-dron` (2D), Godot 4.7.2
**Kontrol tarihi:** 2 Kasım 2026

Bu belge hukuki görüş değildir. Kayıtlar, aşağıda belirtilen kanıtlara dayanır; kanıt bulunmayan alanlar tahminle doldurulmamıştır.

## 1. Durum etiketleri

| Etiket | Anlamı |
|---|---|
| **Doğrulandı** | Varlığın kaynak sayfasından veya dosyanın kendisinden doğrudan kontrol edildi |
| **Kullanıcı beyanı** | Beyza Uzun'un çalışma sırasında bildirdiği bilgi |
| **C2PA kaydı** | Dosyanın içindeki içerik kimliği kaydı okundu; dijital imzası **doğrulanmadı** |
| **Oturum kaydı** | Claude Code çalışma oturumunun kaydında görülen işlem |
| **Doğrulanamadı** | Elde kanıt yok; tahmin yapılmadı |

SHA-256 değerleri kısa olsun diye ilk 16 karakterle verilmiştir.

## 2. Oyunda kullanılan varlıklar

### 2.1 Kaynak ve üretim

| Dosya | Kaynak | Üretici veya araç | Dayanak |
|---|---|---|---|
| `assets/sprites/dron_modul8_temiz.png` | `assets/sprites/dron_modul8.png` dosyasından türetildi | Kaynak görsel: ChatGPT görsel oluşturma aracı (`gpt-image`). Temizleme: Claude Code | Kullanıcı beyanı, C2PA kaydı (kaynak dosyada), oturum kaydı |
| `assets/sprites/damla_modul8_temiz.png` | `assets/sprites/damla_modul8.png` dosyasından türetildi | Kaynak görsel: ChatGPT görsel oluşturma aracı (`gpt-image`). Temizleme ve küçültme: Claude Code | Kullanıcı beyanı, C2PA kaydı (kaynak dosyada), oturum kaydı |
| `assets/backgrounds/yesil_dron_orman_haritasi_v2.png` | Beyza Uzun projeye ekledi | **Doğrulanamadı** | Kullanıcı beyanı; dosyada üst veri yok |
| `assets/audio/bubble_short.wav` | "Bubble Short.wav", Freesound: https://freesound.org/people/murraysortz/sounds/192492/ | murraysortz | Doğrulandı (kaynak sayfa) |
| `assets/ui/yildiz.svg` | Oturum sırasında yazıldı | Claude Code | Oturum kaydı |
| `assets/ui/ates.svg` | Oturum sırasında yazıldı | Claude Code | Oturum kaydı |
| `assets/ui/fidan.svg` | Oturum sırasında yazıldı | Claude Code | Oturum kaydı |
| `assets/ui/saat.svg` | Oturum sırasında yazıldı | Claude Code | Oturum kaydı |
| `assets/ui/damla.svg` | Oturum sırasında yazıldı | Claude Code | Oturum kaydı |
| `icon.svg` | **Doğrulanamadı** | **Doğrulanamadı** | Dosya içeriği Godot logosuna benzer; kökeni kontrol edilmedi |

**HUD SVG ikonları:** Oturum kaydına göre beş SVG dosyası 28 Ekim 2026'da Claude Code tarafından komut satırından elle yazıldı. Kayıtta bu dosyalar için indirme işlemi görülmedi; dosyalarda dış bağlantı veya üst veri yoktur. Başka ikonlarla benzerlik araştırması yapılmadı.

### 2.2 Lisans durumu

| Dosya | Lisans durumu | Gerekli atıf |
|---|---|---|
| `dron_modul8_temiz.png` | Dosyaya özel lisans belgesi yok. **Doğrulanamadı** | Yapay zekâ kullanımı katkı beyanında belirtilir |
| `damla_modul8_temiz.png` | Dosyaya özel lisans belgesi yok. **Doğrulanamadı** | Yapay zekâ kullanımı katkı beyanında belirtilir |
| `yesil_dron_orman_haritasi_v2.png` | **Doğrulanamadı** | Bilgi bulunursa eklenir |
| `bubble_short.wav` | **Creative Commons 0 (CC0)**; kaynak sayfada 2 Kasım 2026'da yeniden görüldü. Yükleyicinin beyanına dayanır | Zorunlu değil. Kayıt için: "Bubble Short.wav", murraysortz, Freesound, CC0 1.0 |
| `yildiz.svg`, `ates.svg`, `fidan.svg`, `saat.svg`, `damla.svg` | Dosyalarda lisans beyanı yok. **Doğrulanamadı** | Yapay zekâ kullanımı katkı beyanında belirtilir |
| `icon.svg` | **Doğrulanamadı** | Bilgi bulunursa eklenir |

Ayrıntılı ses kaydı: `assets/audio/bubble_short_lisans.md`.

### 2.3 Kullanım yeri

| Dosya | Kullanım yeri | Ekrandaki işlev |
|---|---|---|
| `dron_modul8_temiz.png` | `scenes/dron.tscn`, `Goruntu` | Oyuncunun dronu, ölçek 0.15 |
| `damla_modul8_temiz.png` | `scenes/hud.tscn`, `SuSimge` | HUD su göstergesi, 24×24 |
| `yesil_dron_orman_haritasi_v2.png` | `scenes/oyun.tscn`, `Harita` | Oyun arka planı, ölçek 0.6 |
| `bubble_short.wav` | `scenes/oyun.tscn`, `DolumSesi` | Başarılı su dolumunda ses |
| `yildiz.svg` | `scenes/hud.tscn` | Puan simgesi |
| `ates.svg` | `scenes/hud.tscn` | Söndürülen simgesi |
| `fidan.svg` | `scenes/hud.tscn` | Fidan simgesi |
| `saat.svg` | `scenes/hud.tscn` | Kalan süre simgesi |
| `damla.svg` | `scenes/oyun.tscn`, `DamlaEfekti` ve `BeyazKenar` | Dolum anındaki damla efekti |
| `icon.svg` | `project.godot` | Proje simgesi |

### 2.4 Yapılan değişiklikler

| Dosya | Değişiklik | Yapan |
|---|---|---|
| `dron_modul8_temiz.png` | Başıboş pikseller kaldırıldı, alfa yeniden ölçeklendi. RGB, boyut ve hizalama korundu. Godot'ta mipmap ve Linear Mipmap açıldı | Claude Code; Beyza Uzun'un onayıyla |
| `damla_modul8_temiz.png` | Başıboş pikseller kaldırıldı, iç kısım opak yapıldı, ortalanıp kırpıldı, 256×256 yapıldı. Godot'ta mipmap ve Linear Mipmap açıldı | Claude Code; Beyza Uzun'un onayıyla |
| `yesil_dron_orman_haritasi_v2.png` | Dosya değiştirilmedi; sahnede ölçeklendi | Yok |
| `bubble_short.wav` | Dosya değiştirilmedi; `volume_db = 0` | Yok |
| HUD SVG dosyaları | Oluşturulduktan sonra değiştirilmedi | Yok |
| `icon.svg` | Bilinen değişiklik yok | Yok |

C2PA kaydı, temizlenmiş dosyalarda bulunmaz; yeniden kaydetme sırasında düştü. Kayıt kaynak dosyalarda durur.

### 2.5 Dosya kimlikleri

| Dosya | Boyut | SHA-256 (ilk 16) |
|---|---|---|
| `dron_modul8_temiz.png` | 1536×1024, RGBA | `b1fb2622903ad770` |
| `damla_modul8_temiz.png` | 256×256, RGBA | `7dbeacd453a1d4a7` |
| `yesil_dron_orman_haritasi_v2.png` | 1920×1080, RGB | `0cd31b3b24ef7fbc` |
| `bubble_short.wav` | 0,92 sn, 48 kHz, stereo | `bb463a3181b4843a` |
| `yildiz.svg` | 64×64 | `94c6d3e841da9ccd` |
| `ates.svg` | 64×64 | `04615ef06de834e1` |
| `fidan.svg` | 64×64 | `d61b243de9a8e2d7` |
| `saat.svg` | 64×64 | `ec2537dc641f13e6` |
| `damla.svg` | 64×64 | `07ad6cf6bf082ce0` |
| `icon.svg` | 128×128 | `6c80384360a5b269` |

## 3. Projede duran, sahnelerde kullanılmayan varlıklar

| Dosya | Boyut | Kaynak | Dayanak | SHA-256 (ilk 16) |
|---|---|---|---|---|
| `assets/sprites/dron_modul8.png` | 1536×1024, RGBA | ChatGPT `gpt-image`, 2026-10-31 20:18 UTC | Kullanıcı beyanı, C2PA kaydı | `75f9fcfe5ea81160` |
| `assets/sprites/damla_modul8.png` | 1254×1254, RGBA | ChatGPT `gpt-image`, 2026-10-31 22:04 UTC | Kullanıcı beyanı, C2PA kaydı | `37371afb4c93eb03` |
| `assets/sprites/dron.png` | 1536×1024, RGBA | ChatGPT `gpt-image`, 2026-10-23 12:22 UTC | C2PA kaydı | `a35492c0c5a72156` |
| `assets/backgrounds/yesil_dron_orman_haritasi.png` | 1536×1024, RGB | ChatGPT `gpt-image`, 2026-10-28 14:26 UTC | C2PA kaydı | `aef013dde8538c22` |

Haritanın ilk sürümünün C2PA kaydı, v2 sürümünün üretim aracı için kanıt sayılmaz.

## 4. Dosya olmayan öğeler

| Öğe | Kaynak | Durum |
|---|---|---|
| Ana menü arka planı | `scenes/ana_menu.tscn` içinde `GradientTexture2D` | Sahne içi Godot kaynağı |
| Yazı tipi | Projede ayrı yazı tipi dosyası yok; Godot'un varsayılan yazı tipi kullanılıyor | Adı ve lisansı **Doğrulanamadı** |

## 5. Gerçek üretim komutları

| Görsel | Gerçek üretim komutu |
|---|---|
| `dron_modul8.png` | **Doğrulanamadı:** elimizde yok |
| `damla_modul8.png` | **Doğrulanamadı:** elimizde yok |
| `yesil_dron_orman_haritasi_v2.png` | **Doğrulanamadı:** elimizde yok |

C2PA kayıtlarında üretim komutu bulunmaz. `docs/modul8/gorsel_uretim_kayitlari.md` içindeki örnek istemler gerçek komut değildir.

## 6. Kullanım şartları notu

Aşağıdakiler 2 Kasım 2026'da ilgili sayfalardan okunmuştur. Hukuki değerlendirme değildir; bu projeye uygulanmaları konusunda kesinlik iddia edilmez.

| Kaynak | Sayfanın söyledikleri | Durum |
|---|---|---|
| Godot, https://godotengine.org/license/ | Motor MIT lisanslıdır. Motor yeniden dağıtılırken telif ve lisans bildirimi yer almalıdır. Lisans şartları, motorla oluşturulan içeriğe uygulanmaz. Üçüncü taraf bileşenler kendi lisanslarıyla dağıtılır | Okundu |
| Godot, https://docs.godotengine.org/en/stable/about/complying_with_licenses.html | Yazı tipi, görsel ve ses gibi kullanılan varlıklar için bildirim önerir; varsayılan yazı tipini ayrıca anmaz | Okundu |
| Anthropic tüketici şartları, https://www.anthropic.com/legal/consumer-terms | Şartlara uyulması koşuluyla çıktı üzerindeki hakları kullanıcıya devreder (yürürlük: 8 Ekim 2025) | Okundu; hesabın bu şartlara tabi olup olmadığı **Doğrulanamadı** |
| OpenAI kullanım şartları | Sayfa erişime kapalı döndü (403) | **Doğrulanamadı** |

## 7. Doğrulanamayan alanlar

1. Harita v2'nin üretim aracı, lisansı ve gerçek üretim komutu.
2. Dron ve su damlasının gerçek üretim komutları.
3. Yapay zekâ ile üretilen görseller ve SVG dosyaları için lisans durumu.
4. C2PA kayıtlarının dijital imzaları.
5. `icon.svg` dosyasının kökeni ve lisansı.
6. Godot varsayılan yazı tipinin adı ve lisansı.
7. OpenAI kullanım şartlarının içeriği.
8. SVG ikonlarının başka ikonlara benzerliği (araştırılmadı).
9. Bubble Short.wav için yükleyicinin hak sahipliği (CC0 yükleyicinin beyanıdır).
