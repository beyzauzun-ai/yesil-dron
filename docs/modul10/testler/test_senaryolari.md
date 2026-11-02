# Yeşil Dron: 10. Modül Test Senaryoları

**Proje:** `yesil-dron` (2D). **Test betiği:** `modul10_testleri.gd`. **Ham çıktı:** `test_ciktisi_modul10.txt`.

Durumlar: **Başarılı**, **Hatalı**, **Denenmedi**. Gerçek gözlem sütunu, betiğin çalışma sırasında kaydettiği değerlerden üretilmiştir.

## Manuel test sonrası güncelleme

Bu belgedeki otomatik test kapsamı ve sonuçları değişmedi. Otomatik testlerin ardından Beyza Uzun Godot'ta 6 adımlık manuel test uyguladı. Manuel sonuçlar kullanıcının doğrudan beyanına dayanır, Claude Code tarafından gözlemlenmedi. Manuel test tarihi Doğrulanamadı. Ayrıntı: `../manuel_test_sonuclari.md`.

| Test türü | Sonuç |
|---|---|
| Otomatik kontroller (48 + 37 + 26) | 111/111 |
| Manuel testler (Beyza Uzun, kullanıcı beyanı) | 6/6 |

## Özet

| Test | Senaryo | Kontrol | Durum |
|---|---|---|---|
| T1 | Başlangıç ve HUD değerleri | 9/9 | Başarılı |
| T2 | Normal su toplama akışı | 11/11 | Başarılı |
| T3 | Boş depo ve su sınırları (kontrollü) | 6/6 | Başarılı |
| T4 | Dolu depoda dolum engeli | 5/5 | Başarılı |
| T5 | Tekrar edilen giriş-çıkış | 6/6 | Başarılı |
| T6 | Menüye dönme ve yeniden başlatma | 11/11 | Başarılı |
| **Toplam** | | **48/48** | |

| Önceki test | Sonuç | Çalıştırma |
|---|---|---|
| `dolum_testi.gd` | 37 başarılı, 0 hatalı | Kaynakla birebir aynı geçici kopya, `test_ciktisi_dolum_37.txt` |
| `ses_testi.gd` | 26 başarılı, 0 hatalı | Kaynakla birebir aynı geçici kopya, `test_ciktisi_ses_26.txt` |

## Kontrollü test değerleri

Aşağıdaki değerler test betiği tarafından `hud.su` üzerinden atanmıştır. Oyunda su harcama olmadığı için normal oynanışta oluşmazlar.

| Değer | Kullanıldığı test | Amaç |
|---|---|---|
| 0 | T3 | Boş depo |
| 73 | T2 | Dolumun miktar değil `su_max` ile sonuçlandığını görmek |
| 99 | T4 | Dolu olmayan depoda dolumun başladığını görmek |
| −5 | T3 | Alt sınır |
| 150 | T3 | Üst sınır |
| 30 | T3 | Bilinen sınırlama gözlemi |

## T1

**Durum:** Başarılı

**Başlangıç koşulu:** Ana menü açık; oyun henüz başlamamış. Su ve puan değerine müdahale yok.

**Kontrollü değer:** Yok

**Uygulama adımları:**

1. Projenin ana sahnesini yükle.
2. Odak Başla butonundayken `ui_accept` gönder.
3. HUD değerlerini ve dron konumunu oku.
4. 3 saniye dokunmadan bekle.

**Beklenen sonuç:** Oyun sahnesi açılır. Su 50/100, çubuk 50, puan 100, söndürülen 1/3, fidan 0/3, süre 95 sn, dron (576, 324). 3 saniye sonra aynı; sayaç, ses ve efekt kapalı.

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| Ana sahne menu | AnaMenu (res://scenes/ana_menu.tscn) | Başarılı |
| Odak Basla butonunda | true | Başarılı |
| ui_accept ile oyun sahnesi | Oyun | Başarılı |
| Su etiketi ve cubuk | Su: 50/100, cubuk 50.0 | Başarılı |
| Puan | Puan: 100 | Başarılı |
| Sondurulen, fidan, sure | Söndürülen: 1/3, Fidan: 0/3, Kalan süre: 95 sn | Başarılı |
| Dron baslangic konumu | (576.0, 324.0) | Başarılı |
| 3 sn sonra su ve sure ayni | su 50, Kalan süre: 95 sn | Başarılı |
| Sayac, ses ve efekt kapali | sayac durdu true, ses 0, efekt 0 | Başarılı |

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Bu otomatik test kapsamında denenmedi. Sonradan Beyza Uzun manuel test adımı 1–2'yi uyguladı: oyunu çalıştırma ve fareyle Başla, Başarılı (kullanıcı beyanı). Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## T2

**Durum:** Başarılı

**Başlangıç koşulu:** Yeni oyun; dron adada, su 50. İkinci bölümde su **kontrollü olarak 73** yapılır.

**Kontrollü değer:** Su 73

**Uygulama adımları:**

1. Ok tuşu eylemiyle (`ui_down`) dronu göle getir.
2. 1,5 saniye daha bekle, suyu oku.
3. Dolumu bekle, süreyi ölç.
4. Ses ve efekti say.
5. Su 73 ile tekrar et.

**Beklenen sonuç:** Kod suyu belirli bir miktar artırmaz, `su_max` değerine eşitler (`oyun.gd:41`). Yaklaşık 2 sn'de su 100, ses 1 kez tetiklenir, efekt 1 kez ve yaklaşık 0,8 sn görünür, puan değişmez.

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| Gole girince sayac basladi | kalan 1.57 sn | Başarılı |
| Yaklasik 1,5 sn'de su degismedi, ses yok | su 50, ses 0, giristen 1949 ms | Başarılı |
| Su su_max degerine cikti (su 50) | su 100, su_max 100, Su: 100/100 | Başarılı |
| Dolum suresi yaklasik 2 sn | 1998 ms | Başarılı |
| Ses 1 kez tetiklendi | tetiklenme 1 | Başarılı |
| Efekt 1 kez goruldu | efekt 1 | Başarılı |
| Efekt yaklasik 0,8 sn surdu ve kapandi | 781 ms | Başarılı |
| Ses bir kez bitti | bitis 1 | Başarılı |
| Puan degismedi | Puan: 100 | Başarılı |
| Kontrollu su 73: dolmadan once 73 | su 73 | Başarılı |
| Kontrollu su 73: su_max degerine cikti | su 100, 2014 ms | Başarılı |

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Bu otomatik test kapsamında denenmedi. Sonradan Beyza Uzun manuel test adımı 3–4'ü uyguladı: ok tuşlarıyla hareket, gölde dolum, duyulan ses ve damla efekti, Başarılı (kullanıcı beyanı). Kontrollü su 73 elle denenmedi. Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## T3

**Durum:** Başarılı

**Başlangıç koşulu:** Yeni oyun; **su kontrollü olarak 0** yapılır. Oyunda su harcama olmadığı için bu durum normal oynanışta oluşmaz.

**Kontrollü değer:** Su 0, −5, 150; ayrıca sınırlama gözlemi için su 30

**Uygulama adımları:**

1. `hud.su = 0` ata, HUD'ı oku.
2. Göl dışında 2,5 saniye bekle.
3. Göle gir, dolumu ölç.
4. Göl dışında `hud.su = -5`, sonra `hud.su = 150` ata.

**Beklenen sonuç:** HUD 0/100; göl dışında kendiliğinden dolmaz; gölde su 100 olur, ses 1 kez. −5 değeri 0'a, 150 değeri 100'e sıkışır (`hud.gd:8`).

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| Kontrollu su 0: HUD | su 0, Su: 0/100, cubuk 0.0 | Başarılı |
| Gol disinda su 0 kendiliginden dolmadi | su 0, ses 0 | Başarılı |
| Su 0'dan su_max degerine dolum | su 100, 2017 ms | Başarılı |
| Dolumda ses 1 kez | tetiklenme 1 | Başarılı |
| Kontrollu su -5: 0'a sikisti | su 0, Su: 0/100 | Başarılı |
| Kontrollu su 150: su_max degerine sikisti | su 100, Su: 100/100 | Başarılı |

**Bilinen sınırlama gözlemi (başarılı test sayılmaz):** Dron goldeyken su 30 yapildi, 3 sn beklendi: su 30, sayac durdu true, ses 1. Dolum yalnizca giriste basliyor.

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Bu senaryonun kontrollü değerleri (su 0, −5, 150, 30) manuel testte yer almadı: Denenmedi. Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## T4

**Durum:** Başarılı

**Başlangıç koşulu:** Yeni oyun; önce gerçek dolumla su 100 yapılır. İkinci bölümde **su kontrollü olarak 99** yapılır.

**Kontrollü değer:** Su 99

**Uygulama adımları:**

1. Gölde doldur, gölden çık.
2. Dolu depoyla yeniden gir, 3 saniye bekle.
3. Gölden çık, `hud.su = 99` ata, yeniden gir.

**Beklenen sonuç:** Dolu depoda sayaç başlamaz, ses ve efekt olmaz (`oyun.gd:30`). Su 99'da sayaç başlar, su 100 olur, 1 yeni ses ve efekt.

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| Gercek dolumla su 100 | su 100, 2014 ms | Başarılı |
| Dolu depoyla giriste sayac baslamadi | sayac durdu true | Başarılı |
| 3 sn'de yeni ses ve efekt yok, su 100 | ses 1, efekt 1, su 100 | Başarılı |
| Kontrollu su 99: sayac basladi | kalan 1.62 sn | Başarılı |
| Kontrollu su 99: su_max ve 1 yeni ses | su 100, 2016 ms, ses 2, efekt 2 | Başarılı |

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Dolu depoyla yeniden giriş ve kontrollü su 99 manuel testte yer almadı: Denenmedi. Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## T5

**Durum:** Başarılı

**Başlangıç koşulu:** Yeni oyun; dron gölün dışında, su 50.

**Kontrollü değer:** Yok

**Uygulama adımları:**

1. 5 kez göle gir, 0,8 saniye bekle, çık.
2. Bir kez daha gir, 2 saniyeye yakın çık.
3. Yeniden gir, suyu kontrol et.
4. Tam bekle, sonra 3 saniye daha bekle.

**Beklenen sonuç:** Süre birikmez; kısa girişlerde su, ses ve efekt değişmez. Tam beklemede 2 sn'de su 100, ses ve efekt 1 kez; sonrasında tekrar yok.

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| 5 kisa giris gercekten olustu | giris 5 | Başarılı |
| Toplam gol suresi 2 sn'yi asti, sure birikmedi | toplam 7749 ms, su 50, ses 0, efekt 0 | Başarılı |
| 2 sn'ye yakin cikista dolum olmadi | bu giriste 1849 ms, su 50, ses 0 | Başarılı |
| Yeniden giriste sayac sifirdan: 1,5 sn'de 50 | su 50 | Başarılı |
| Tam beklemede dolum | su 100, 2016 ms | Başarılı |
| Sonraki 3 sn'de tekrar yok: ses ve efekt 1 | ses 1, efekt 1, bitis 1 | Başarılı |

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Tekrar edilen giriş-çıkış manuel testte yer almadı: Denenmedi. Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## T6

**Durum:** Başarılı

**Başlangıç koşulu:** Yeni oyun. Puan test betiğiyle 50 artırılır, su gerçek dolumla 100 yapılır.

**Kontrollü değer:** Puan +50 (test betiğiyle)

**Uygulama adımları:**

1. Esc (`ui_cancel`) ile menüye dön, `ui_accept` ile yeniden başla; iki tur.
2. Dolum sırasında Esc.
3. Ses ve efekt çalarken Esc.

**Beklenen sonuç:** Menüye dönülür. Yeni oyunda su 50, puan 100, dron (576, 324); sayaç, ses ve efekt temiz. Ses oynatıcısı sahneyle kalkar; hata oluşmaz.

**Gerçek gözlem:**

| Kontrol | Ölçüm | Durum |
|---|---|---|
| Tur 1: degisen durum (puan 150, su 100) | Puan: 150, su 100, ses 1 | Başarılı |
| Tur 1: Esc ile menu | AnaMenu | Başarılı |
| Tur 1: yeni oyunda degerler sifirlandi | su 50, Puan: 100, konum (576.0, 324.0), ses 0, efekt 0 | Başarılı |
| Tur 2: degisen durum (puan 150, su 100) | Puan: 150, su 100, ses 1 | Başarılı |
| Tur 2: Esc ile menu | AnaMenu | Başarılı |
| Tur 2: yeni oyunda degerler sifirlandi | su 50, Puan: 100, konum (576.0, 324.0), ses 0, efekt 0 | Başarılı |
| Dolum sirasinda Esc: menu, ses yok | AnaMenu, ses 0 | Başarılı |
| Sonra Basla: su 50 | su 50 | Başarılı |
| Esc oncesi ses ve efekt calisiyor | ses true, efekt true | Başarılı |
| Ses calarken Esc: menu, oynatici sahneyle kalkti | AnaMenu, oynatici gecerli false | Başarılı |
| Sonra Basla: ses ve efekt yok, su 50 | ses 0, efekt 0, su 50 | Başarılı |

**Girdi türü:** Kodla simüle edildi. Gerçek klavye girişi: Denenmedi.

**Manuel test sonrası güncelleme:** Bu otomatik test kapsamında denenmedi. Sonradan Beyza Uzun manuel test adımı 5'i uyguladı: Esc ile menüye dönüş ve yeniden Başla, Başarılı (kullanıcı beyanı). Dolum sırasında ve efekt çalarken Esc manuel testte yer almadı: Denenmedi. Ayrıntı: `../manuel_test_sonuclari.md`.

**Test ortamı:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); Windows 10.0.26200; gl_compatibility; AMD Radeon(TM) Vega 8 Graphics; pencere 1152x648; ses sürücüsü WASAPI; 2026-11-02T14:20:20

**Sürüm:** 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079); kaynak özeti `fe7d74988c674b5f` (ayrıntı aşağıda)

## Sesin değerlendirilmesi

| Konu | Durum | Dayanak |
|---|---|---|
| Sesin tetiklenmesi | Başarılı | `AudioStreamPlayer.playing` geçişleri sayıldı (T2–T6, `ses_testi.gd`) |
| Sesin bu çalıştırmada duyulması | Denenmedi | Otomatik test duyulan sesi ölçemez |
| Sesin manuel testte duyulması | Başarılı (kullanıcı beyanı) | Beyza Uzun, manuel test adımı 4; `../manuel_test_sonuclari.md` |

Kullanıcı sesi 8. modülde oyunda dinleyip onaylamıştı; bu, bu çalıştırmanın sonucu değildir.

## Girdi türleri

| Girdi | Durum |
|---|---|
| Kodla simüle edilmiş girdi (`Input.action_press`, `InputEventAction`) | T1–T6'da kullanıldı |
| Gerçek kullanıcı girişi (klavye) | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 3–5) |
| Fare ile Başla butonu | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 2 ve 5) |
| Çıkış butonu | Otomatik testlerde denenmedi; sonradan manuel testte Başarılı (Beyza Uzun, kullanıcı beyanı; adım 6) |

## Bilinen sınırlamalar

Bu mekanikler projede yoktur. Başarılı test olarak gösterilmemiştir.

| Mekanik | Durum |
|---|---|
| Oyun bitişi, kazanma, kaybetme | Denenmedi: mekanik yok |
| Yangın söndürme | Denenmedi: mekanik yok |
| Fidan dikme | Denenmedi: mekanik yok |
| Geri sayım (süre 95'te sabit) | Denenmedi: mekanik yok |
| Su harcama | Denenmedi: mekanik yok |
| Eyleme bağlı puan | Denenmedi: mekanik yok |
| Oyun içi Yeniden Başla seçeneği | Denenmedi: mekanik yok |

- **Gölün içindeyken su azalması:** Dolum yalnızca girişte başlar. Kontrollü gözlem T3'te yer alır. Mevcut oynanışta su azalmadığı için bu durum oluşmaz.

## Test düzeni notları

- **Bekleme süreleri:** "1,5 sn" adımı, dron hedef konuma vardıktan sonra başlar. Göle girişten sayıldığında ölçüm yaklaşık 1,9 saniyedir (T2'de 1949 ms). Bu yüzden 2 saniyelik sınırın yakınındadır; yavaş bir makinede zamanlama payı dar kalabilir.
- **Eski testler:** `dolum_testi.gd` ekran görüntülerini kendi klasörüne yazdığı için geçici kopyadan çalıştırıldı; önceki modül klasörüne dosya eklenmedi.
- **Çalıştırma:** Bu betik proje dosyalarına yazmaz; yalnızca `MODUL10_JSON` verilirse o yola JSON yazar. Godot editörü bu klasörde `.gd.uid` dosyaları oluşturabilir.

## Sürüm bilgisi

Projede Git yoktur. Sürüm, 4.7.2-stable (official) (ed1daf0bf001b61586d9930840f2f1394092c079) ve aşağıdaki SHA-256 özetleriyle tanımlanır.

| Dosya | SHA-256 |
|---|---|
| `res://project.godot` | `802022c52c48df11c66db08c39f9c21e4ed9ee34f21aa0630d25d52c02f53410` |
| `res://scenes/ana_menu.gd` | `b3a28ab969a8af971fd2a8566ae5927a60cc0305d76c0f0ba02a04726a41947a` |
| `res://scenes/ana_menu.tscn` | `ca01fee01ca1bf9bda14e6c8199f2cde4a73448971fed1ad19d7842d8a6dc908` |
| `res://scenes/dron.gd` | `38e4432a83ecdccc62e283f8ca59cac4d6b2bf8136122060f00d813a78bca8c3` |
| `res://scenes/dron.tscn` | `d816efc079e65db2b5bf3252a8ab301e8cfd9779151ab6b71b2fe8aed5a56971` |
| `res://scenes/hud.gd` | `3190b4d25cb17ce7aa17ee723808cbc1594f9f95ec3ccfe7940010652ded1fc4` |
| `res://scenes/hud.tscn` | `90ebbc8f15f5c07b7776df47808ed15726995c62a23d288c2f7da56715a4cb2b` |
| `res://scenes/oyun.gd` | `abce7eaa2568a5ede7931ef2e738a0816a6f18b6ae03ac76804e8f04d08513bb` |
| `res://scenes/oyun.tscn` | `29ac4f40b80afba29342b14aa3a9e03792bb86b36dd8503ee1e1e01e3e0d855f` |

## Çalıştırma

```bash
Godot --path <proje> -s res://docs/modul10/testler/modul10_testleri.gd
```
