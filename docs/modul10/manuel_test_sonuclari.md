# Yeşil Dron: 10. Modül Manuel Test Sonuçları

| Alan | Bilgi |
|---|---|
| **Test eden** | Beyza Uzun |
| **Test yöntemi** | Godot üzerinden gerçek kullanıcı testi |
| **Ortam** | Windows, Godot 4.7.2, 2D Yeşil Dron |
| **Sonuç kaynağı** | Kullanıcının doğrudan beyanı |
| **Manuel test tarihi** | Doğrulanamadı |
| **Sonuç** | 6/6 başarılı |

**Bu testler Claude Code tarafından otomatik çalıştırılmadı.** Testleri Beyza Uzun elle uyguladı. Claude Code yalnızca bildirilen sonuçları bu belgeye kaydetti; sonuçları kendisi gözlemlemedi.

## Manuel testler

| # | Test | Durum |
|---|---|---|
| 1 | Godot'ta 2D projeyi açıp F5 ile oyunu çalıştırma | Başarılı |
| 2 | Fareyle Başla düğmesine tıklayarak oyuna girme | Başarılı |
| 3 | Ok tuşlarıyla dronu dört yönde hareket ettirme | Başarılı |
| 4 | Gölde yaklaşık 2 saniye bekleyerek su dolumunu, dolum sesinin duyulmasını ve damla efektini kontrol etme | Başarılı |
| 5 | Esc ile menüye dönüp yeniden Başla düğmesine basarak başlangıç durumuna dönme | Başarılı |
| 6 | Çıkış düğmesine basarak oyunu kapatma | Başarılı |

## Otomatik test sonuçları

Bu sonuçlar manuel testlerden ayrıdır. Claude Code tarafından çalıştırıldı; girdiler kodla simüle edildi. Ayrıntılar: `testler/test_senaryolari.md`.

| Test | Sonuç |
|---|---|
| Yeni testler (T1–T6) | 48/48 |
| Önceki dolum testleri | 37/37 |
| Önceki ses testleri | 26/26 |
| **Toplam otomatik kontrol** | **111/111** |

## Önceki belgelerle ilişkisi

`testler/test_senaryolari.md` ve `yapay_zeka_katki_beyani.md` belgelerindeki gerçek klavye, fare, işitsel ve Çıkış düğmesi için yazılan "Denenmedi" kayıtları, bu manuel testlerden önceki durumu gösterir. Bu belge o dosyaları değiştirmez; manuel test sonuçları için bu belge esas alınır.
