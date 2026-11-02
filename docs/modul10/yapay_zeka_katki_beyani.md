# Yeşil Dron: Yapay Zekâ Katkı Beyanı

**Modül:** GameUp Türkiye, Yapay Zekâyla Oyun Geliştirme, 10. Modül
**Öğrenci:** Beyza Uzun
**Proje:** `yesil-dron` (2D), Godot 4.7.2
**Hazırlanma tarihi:** 2 Kasım 2026

Bu belge taslak olarak Claude Code tarafından hazırlanmıştır. İçinde imza veya onay bulunmaz.

## 1. Kullanılan yapay zekâ araçları

| Araç | Rol | Dayanak |
|---|---|---|
| **Claude Code** | Projede dosya oluşturma ve düzenleme, Godot'ta test çalıştırma, teknik belgeleri hazırlama | Oturum kaydı, proje belgeleri |
| **ChatGPT** | Görsel üretimi ve eğitim sürecinde danışmanlık | Kullanıcı beyanı; görsellerde ayrıca C2PA kaydı |

C2PA kayıtları okunmuştur; dijital imzaları doğrulanmamıştır.

## 2. Claude Code'un katkıları

| Alan | Katkı | Dayanak |
|---|---|---|
| **Kod** | `dron.gd`, `oyun.gd`, `hud.gd`, `ana_menu.gd`: hareket, sınırlar, puan sinyali, su dolumu, damla efekti, ses bağlantısı, Esc | Oturum kaydı |
| **Sahneler** | `dron.tscn`, `oyun.tscn`, `hud.tscn`, `ana_menu.tscn`: düğümler, göl alanı, zamanlayıcı | Oturum kaydı |
| **HUD** | Gösterge düzeni, su değeri bağlantısı, ikon entegrasyonu | Oturum kaydı |
| **HUD SVG ikonları** | `yildiz`, `damla`, `ates`, `fidan`, `saat` SVG dosyalarını yazdı | Oturum kaydı |
| **Görsel temizliği** | `dron_modul8_temiz.png` ve `damla_modul8_temiz.png`: alfa temizliği, damlada kırpma ve 256×256 küçültme; Godot'ta mipmap ayarları | `docs/modul8/gorsel_uretim_kayitlari.md`, oturum kaydı |
| **Test betikleri** | 8. ve 10. modül betikleri (`docs/modul8/testler/`, `docs/modul10/testler/`); çalıştırma ve ölçüm | Betikler, test çıktıları, oturum kaydı |
| **Teknik belgeler** | Stil rehberi, üretim kayıtları, teknik uygulama belgesi, ses lisans kaydı, test senaryoları, bu belge ve varlık kaydı; önceki modül raporlarının hazırlanması | Proje belgeleri, oturum kaydı |
| **Araştırma** | Freesound'da ses adaylarının lisansını kaynak sayfalardan kontrol etme | `assets/audio/bubble_short_lisans.md`, oturum kaydı |

Claude Code'un yazdığı stil rehberindeki renkler ve kurallar Beyza Uzun'un verdiği stil yönergesine dayanır. Claude Code ayrıca örnek üretim istemleri önerdi; bunların görsel üretiminde kullanıldığına dair kayıt yoktur.

## 3. ChatGPT'nin katkıları

| Alan | Katkı | Dayanak |
|---|---|---|
| **Görsel üretimi** | `dron_modul8.png` ve `damla_modul8.png`. Eski `dron.png` ve haritanın ilk sürümü | Kullanıcı beyanı ve/veya C2PA kaydı |
| **Proje planlaması** | Eğitim sürecinde danışmanlık desteği | Kullanıcı beyanı |
| **Mekaniklerin değerlendirilmesi** | Danışmanlık desteği | Kullanıcı beyanı |
| **Test planları** | Hazırlanmasında danışmanlık desteği | Kullanıcı beyanı |
| **Rapor içerikleri** | Düzenlenmesinde danışmanlık desteği | Kullanıcı beyanı |
| **Ödevlerin değerlendirilmesi** | Danışmanlık desteği | Kullanıcı beyanı |

**Kapsam sınırı:** ChatGPT'nin proje kodlarını doğrudan yazdığına, Godot'ta test çalıştırdığına veya proje dosyalarını düzenlediğine dair kanıt yoktur; bu belge böyle bir iddiada bulunmaz. Danışmanlık içeriğinin ayrıntıları elimizde değildir.

## 4. Beyza Uzun'un rolü

### 4.1 Kararlar

- Proje fikri, modül hedefleri ve kabul koşulları
- Her aşamada uygulama planlarını onaylama veya değiştirme
- Görsellerin hazırlanması ve projede kullanılacak sürümlerin seçimi
- Haritanın v2 sürümünü hazırlayıp projeye ekleme
- Ses efekti olarak Bubble Short.wav'ı seçip projeye ekleme
- Dron ölçeği, mipmap gibi görünüm kararları, ses seviyesinin korunması
- 3D çalışmasının ayrı proje olması ve hareket sınırlarının onayı
- 10. modül kapsamı: yeni mekanik eklenmemesi, eski dosyalara dokunulmaması
- Doğrulanamayan bilgilerin tahmin edilmemesi kuralı

### 4.2 Kendi yaptığını bildirdiği kontroller

| Kontrol | Modül | Sonuç (kullanıcı beyanı) |
|---|---|---|
| Dolum sesini oyunda dinleme | 8 | Net ve uygun duyuluyor |
| Ödev videosunu izleme | 8 | Görüntü ve ses uygun |
| 3D projeyi Godot'ta elle deneme | 9 | Ok tuşları, `C` tuşu ve sahne çalışıyor |
| 2D oyunda 6 adımlık manuel test | 10 | 6/6 Başarılı; tarih Doğrulanamadı. Ayrıntı: `manuel_test_sonuclari.md` |

## 5. Yapay zekâ çıktılarının doğrulanması

### 5.1 Otomatik kontroller (10. modül)

Bu sonuçlar otomatik kontrollerdir. Girdiler kodla simüle edilmiştir.

| Test | Sonuç |
|---|---|
| Yeni T1–T6 (`modul10_testleri.gd`) | **48/48** başarılı |
| Önceki oyun kontrolleri (`dolum_testi.gd`) | **37/37** başarılı |
| Önceki ses kontrolleri (`ses_testi.gd`) | **26/26** başarılı |
| **Toplam otomatik kontrol** | **111/111** |

Ortam: Godot 4.7.2 stable, Windows, GL Compatibility, AMD Radeon Vega 8, 1152×648. Tarih: 2 Kasım 2026. Ayrıntı: `docs/modul10/testler/test_senaryolari.md`.

Manuel test sonuçları (6/6) bu toplama dahil değildir; bkz. bölüm 4.2 ve `manuel_test_sonuclari.md`.

### 5.2 Diğer doğrulamalar

- Kaynak dosyaların test öncesi ve sonrası SHA-256 karşılaştırması
- `yesil-dron_modul10_yedek` yedeğinin dosya sayısı, boyut ve SHA-256 doğrulaması
- Görsellerde alfa ve renk ölçümleri
- Ses lisansının Freesound kaynak sayfasından kontrolü

## 6. Yapılmayan kontroller

| Kontrol | Durum |
|---|---|
| 10. modül testleri için gerçek klavye girişi | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 3–5) |
| 10. modül testleri için fare ile kullanım | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 2 ve 5) |
| 10. modül çalıştırmasında sesin işitsel kontrolü | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 4) |
| Çıkış butonu | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 6) |
| C2PA dijital imza doğrulaması | Yapılmadı |

Otomatik testler sesin tetiklenme sayısını ölçer, duyulup duyulmadığını ölçmez.

**Manuel test sonrası güncelleme:** Manuel testleri Beyza Uzun uyguladı; sonuçlar kullanıcının doğrudan beyanına dayanır ve Claude Code tarafından gözlemlenmedi. Manuel test tarihi Doğrulanamadı. Manuel testte yer almayan durumlar (kontrollü su değerleri, dolu depoyla yeniden giriş, tekrar edilen giriş-çıkış, dolum veya efekt sırasında Esc) elle denenmedi. Ayrıntı: `manuel_test_sonuclari.md`.

## 7. Mevcut olmayan mekanikler

Oyun bitişi, yangın söndürme, fidan dikme, geri sayım ve su harcama projede yoktur. Bu nedenle test edilmemiş ve başarılı gösterilmemiştir.

## 8. Eksik bilgiler

1. Dron ve su damlasının ChatGPT'deki gerçek üretim komutları.
2. Harita v2'nin üretim aracı ve gerçek üretim komutu.
3. ChatGPT danışmanlığının içerik ayrıntıları ve kayıtları.
4. Dron için referans görselin `dron.png` olduğu; kullanıcı "önceki görsel" demiştir, dosya adı bu ifadeden çıkarılmıştır.
5. Yapay zekâ ile üretilen içeriklerin lisans durumu (bkz. `docs/modul10/varlik_lisans_kaydi.md`).

Bu belge hukuki görüş değildir. Yapay zekâ hizmetlerinin kullanım şartları konusunda kesinlik iddiasında bulunmaz.
