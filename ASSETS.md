# Varlıklar ve Kaynaklar

Bu belge hukuki görüş değildir ve varlıkların yayımlanabilirliği konusunda garanti vermez. Doğrulanamayan bilgiler tahminle doldurulmamıştır.

**Son güncelleme:** 2 Kasım 2026

**Etiketler:**
- **Kullanıcı beyanı:** Beyza Uzun'un bildirdiği bilgi.
- **C2PA kaydı:** Kaynak dosyanın içindeki içerik kimliği kaydı okundu; dijital imzası doğrulanmadı. Kaynak dosyalar bu depoda yoktur.
- **Oturum kaydı:** Claude Code çalışma oturumunun kaydı.
- **Doğrulanamadı:** Elde kanıt yok.

## Lisans kapsamı

[LICENSE](LICENSE) dosyasındaki MIT Lisansı yalnızca orada listelenen oyun kodları, test kodları, sahneler ve teknik yapılandırma dosyaları için geçerlidir. Aşağıdakiler **MIT kapsamında değildir**:

- ChatGPT ile üretilen görseller: harita v2, dron ve su damlası
- Özel proje simgesi: `assets/icons/yesil_dron_icon_256.png`
- HUD SVG dosyaları: `assets/ui/*.svg`
- Belgeler ve test çıktıları
- Ekran görüntüleri: `docs/images/*.jpg`

Bunların dışında:

- `assets/audio/bubble_short.wav` kendi **CC0** kaydına tabidir; bu kayıt yükleyicinin beyanına dayanır.
- Eski `icon.svg` Godot kaynaklıdır (varsayılan proje simgesi); Godot logosunu gösterir. Godot logosu CC BY 4.0 lisanslıdır; bu dosyanın aynı lisans kapsamında olduğu doğrudan doğrulanamadı. Dosya MIT kapsamında değildir. Atıf ve ayrıntı, varlık tablosunun altındadır.

Ayrı bir lisans belirtilmedikçe, MIT kapsamı dışındaki varlıklar için bu depoda açık bir yeniden kullanım izni verilmemektedir. Bu belge, bu varlıkların hak sahipliği konusunda kesinlik iddia etmez.

## Bu depodaki varlıklar

| Dosya | Kullanım | Kaynak | Değişiklik | Lisans durumu | Dayanak |
|---|---|---|---|---|---|
| `assets/backgrounds/yesil_dron_orman_haritasi_v2.png` | Oyun arka planı | **ChatGPT'nin görsel oluşturma aracıyla hazırlandı — proje sahibinin beyanı.** Ayrıntı aşağıda | Dosya değiştirilmedi | Dosyaya özel lisans belgesi yok; Doğrulanamadı | Proje sahibinin beyanı; dosyada üst veri ve teknik üretim kaydı yok |
| `assets/sprites/dron_modul8_temiz.png` | Dron | ChatGPT (`gpt-image`) | Claude Code: alfa temizliği | Dosyaya özel lisans belgesi yok; Doğrulanamadı | Kullanıcı beyanı, C2PA kaydı (kaynak dosya), oturum kaydı |
| `assets/sprites/damla_modul8_temiz.png` | HUD su ikonu | ChatGPT (`gpt-image`) | Claude Code: alfa temizliği, kırpma, 256×256 | Dosyaya özel lisans belgesi yok; Doğrulanamadı | Kullanıcı beyanı, C2PA kaydı (kaynak dosya), oturum kaydı |
| `assets/audio/bubble_short.wav` | Dolum sesi | "Bubble Short.wav", murraysortz, [Freesound](https://freesound.org/people/murraysortz/sounds/192492/) | Dosya değiştirilmedi | **CC0**; yükleyicinin kaynak sayfadaki beyanı | Kaynak sayfa; `assets/audio/bubble_short_lisans.md` |
| `assets/ui/yildiz.svg`, `ates.svg`, `fidan.svg`, `saat.svg` | HUD ikonları | Claude Code yazdı | Yok | Lisans beyanı yok; Doğrulanamadı | Oturum kaydı |
| `assets/ui/damla.svg` | Dolum anındaki damla efekti | Claude Code yazdı | Yok | Lisans beyanı yok; Doğrulanamadı | Oturum kaydı |
| `assets/icons/yesil_dron_icon_256.png` | Proje simgesi | **ChatGPT ile üretildi — kullanıcı beyanı; dosyada üretim kaydı yok, özgün üretim komutu doğrulanamadı.** Tasarımı Beyza Uzun onayladı | Değişiklik yapılmadı; köşeleri opak ve siyahtır | **Bu görsel MIT Lisansı kapsamına girmez.** Dosyaya özel lisans belgesi yok; Doğrulanamadı | Kullanıcı beyanı |
| `icon.svg` | Aktif proje simgesi değildir (aktif simge: `assets/icons/yesil_dron_icon_256.png`); depoda korunuyor | Godot'un varsayılan proje simgesi (`editor/icons/DefaultProjectIcon.svg`) ile birebir aynı; Godot logosunu gösterir | Değiştirilmedi | Godot logosu CC BY 4.0 (eser sahibi Andrea Calabró); bu dosyanın aynı kapsamda olduğu doğrudan doğrulanamadı. MIT kapsamında değil | Godot deposuyla karşılaştırma; Godot deposundaki `misc/logo/LICENSE.txt`; https://godotengine.org/press/ |
| `docs/images/*.jpg` | README görselleri | Godot'ta çalışan oyundan alınan kareler; yukarıdaki varlıkları içerir | JPEG'e çevrildi | İçerdiği varlıklara bağlı | Oturum kaydı |
| Varsayılan yazı tipi | Arayüz | Godot ile gelir; depoda dosya yok | Yok | Adı ve lisansı Doğrulanamadı | Proje dosyaları |

**`icon.svg` atfı ve lisans durumu:** Dosya Godot logosunu gösterir. Logo atfı: Godot Engine Logo, Copyright (c) 2017 Andrea Calabró, [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) (kaynak: Godot deposundaki `misc/logo/LICENSE.txt`). Godot'un `COPYRIGHT.txt` dosyası bu lisansı `misc/logo/*` dosyaları için belirtir; `icon.svg` ile birebir aynı olan `editor/icons/DefaultProjectIcon.svg` orada ayrıca anılmaz. Bu nedenle `icon.svg` dosyasının kendisinin CC BY 4.0 kapsamında olduğu doğrudan doğrulanamadı. Dosya değiştirilmemiştir ve aktif proje simgesi değildir.

## Harita v2 görselinin kaynağı

Yeşil Dron'un harita v2 görseli, proje geliştirme sürecinde ChatGPT'nin görsel oluşturma aracıyla hazırlanmıştır. Bu bilgi proje sahibinin üretim sürecine ilişkin beyanına dayanmaktadır.

Orijinal üretim komutu ve teknik üretim kayıtları mevcut belgelerde bulunmadığından bağımsız olarak doğrulanamamıştır. Bu durum, haritanın ChatGPT ile üretildiği yönündeki kullanıcı beyanını geçersiz kılmaz.

`docs/modul10/` klasöründeki belgeler önceki inceleme tarihindeki durumu yansıtır. Güncel kaynak açıklaması `ASSETS.md` dosyasındadır.

## Gerçek üretim komutları

| Görsel | Durum |
|---|---|
| Harita v2 | Doğrulanamadı: özgün komut ve teknik üretim kayıtları mevcut belgelerde yok |
| Dron | Doğrulanamadı: elimizde yok |
| Su damlası | Doğrulanamadı: elimizde yok |

## Yapay zekâ çıktıları ve kullanım koşulları

- **OpenAI:** Kullanıcının bildirdiğine göre OpenAI kullanım koşulları, çıktının haklarının uygulanabilir hukuk sınırları içinde kullanıcıya ait olduğunu belirtir. Bu belgeyi hazırlarken koşullar sayfası doğrudan okunamadı. Bu bilgi, üçüncü taraf hakları için garanti değildir.
- **Claude Code ile üretilen HUD SVG görselleri (`assets/ui/*.svg`):** Hesaba uygulanan koşullar doğrulanamadı; bu görseller için lisans beyanı yoktur ve MIT kapsamında değildir. Kodların durumu için "Kod lisansı" bölümüne bakınız.
- Yapay zekâ çıktılarının korunabilirliği, benzerliği veya üçüncü taraf haklarıyla ilişkisi araştırılmamıştır. SVG ikonlarının başka ikonlara benzerliği de kontrol edilmemiştir.

## Kod lisansı

Oyun kodları, test kodları, sahneler ve açıkça belirtilen teknik yapılandırma dosyaları [MIT Lisansı](LICENSE) ile lisanslanmıştır. Lisans, yalnızca lisans verenin sahip olduğu hakları kapsar. Kodun büyük bölümü Claude Code ile üretilmiştir; bu üretimlerin hak durumu konusunda kesinlik iddia edilmez.

## Tarihli belgelerle ilişkisi

`docs/modul10/` altındaki belgeler değiştirilmemiştir. `varlik_lisans_kaydi.md` ve `yapay_zeka_katki_beyani.md`, harita v2'nin aracını "Doğrulanamadı" olarak yazar ve bu depoda bulunmayan kaynak görsellerden söz eder. Harita için ChatGPT bilgisi, o belgelerden sonra proje sahibi tarafından bildirilmiştir.

---

## English summary

This document is not legal advice and does not guarantee that the assets may be published.

| Asset | Source | License status |
|---|---|---|
| Map v2 | Prepared with ChatGPT's image generation tool, according to the project owner's statement. The original prompt and technical generation records are not in the available documents, so this could not be independently verified; this does not invalidate the statement. Documents in `docs/modul10/` reflect the earlier review; this file holds the current source description | Not verified |
| Drone sprite, water drop icon | ChatGPT (`gpt-image`), user statement and C2PA record (signature not verified); cleaned up with Claude Code | Not verified |
| Fill sound | "Bubble Short.wav" by murraysortz, [Freesound](https://freesound.org/people/murraysortz/sounds/192492/) | CC0, as declared by the uploader |
| SVG icons | Written by Claude Code (session record) | No license statement; not verified |
| Project icon (`yesil_dron_icon_256.png`) | Generated with ChatGPT (user statement); no generation record in the file, original prompt not verified; design approved by Beyza Uzun | Not verified; not covered by the MIT License |
| `icon.svg` (not the active project icon, which is `assets/icons/yesil_dron_icon_256.png`; kept in the repository) | From Godot; identical to Godot's default project icon and shows the Godot logo; not modified | The Godot logo is CC BY 4.0 (by Andrea Calabró); whether this file itself is under the same license could not be directly verified. Not covered by the MIT License |
| Default font | Not verified | Not verified |

**`icon.svg` attribution and license status:** The file shows the Godot logo. Logo attribution: Godot Engine Logo, Copyright (c) 2017 Andrea Calabró, [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) (source: `misc/logo/LICENSE.txt` in the Godot repository). Godot's `COPYRIGHT.txt` states this license for the `misc/logo/*` files; `editor/icons/DefaultProjectIcon.svg`, which is identical to `icon.svg`, is not listed there separately. Therefore it could not be directly verified that `icon.svg` itself is covered by CC BY 4.0. The file has not been modified and is not the active project icon.

According to the user, OpenAI's terms state that rights in output belong to the user to the extent permitted by applicable law. This is not a guarantee regarding third-party rights.

Claude Code-generated HUD SVG images (`assets/ui/*.svg`): the terms applying to the account could not be verified; these images have no license statement and are not covered by the MIT License. See the license paragraph below for the code.

Game code, test code, scenes and the listed technical configuration files are licensed under the [MIT License](LICENSE). The following are **not covered** by it: the ChatGPT images (map v2, drone, water drop), the custom project icon, the HUD SVG files, documents, test outputs and screenshots. `bubble_short.wav` is subject to its own CC0 record, as declared by the uploader. This document makes no definitive claim about ownership of these assets.
