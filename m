Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8B36B;
	Sun,  9 Jun 2024 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717893131; cv=none; b=pZD/hOBTbLXmmSXKg3XjYQpb8EgthYkNCbFlRtMlyl/sV/qBUhfE9XL4XbaBdgkYgC3iXueDn6ChPBXeO814522stkd+vpqt5xkKPX5EWL+jY9i2kgNXOFswUvEWTLxEf865PJnWw9QcWLaRHuoWWzlGcCj2YdqsikVCE7pJxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717893131; c=relaxed/simple;
	bh=1dBgvwA68O2a7a6xUnCh4IVR05yvJKnzfljSAnRi0oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=A0N3P8H13aCqKqQaKywpIquCUrxpopNavXYEUSdKT4gnyOtbvTc8iMA9cKjrXYAiUTHFkYWqjzDhMA/P0qbje35vDdLslt2BnGMkMAB0dCiy0F9vvGj7tePwfQV/Oy36IdiEp3PlAiQWJdP7XfaLMmEULu7BNrKnxpYmVm2SfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkpHcd3H; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkpHcd3H"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2eb5b1917so406982a91.2;
        Sat, 08 Jun 2024 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717893129; x=1718497929; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnCHxXfWcDE9oW7NN5xGODtfi1ZsBpKLcmpR2EsiBZU=;
        b=IkpHcd3HCIz90WNgurqZf0GfhnaX/SuQGcu61dZZD3pROypFSQeSf0QV63IbFYDcEQ
         kajZY8nWEmGmx5QIBx7vnrGnu804X9cASbg9QbqAlXX7h78S9RC/0fRhLtNEZiASmbwQ
         WfC2ASO7sEW5unEIyngJiWUwY1F/xmo0JnpQdRyKF3EzHn5epxOhl0rT1kj/jJBhDNWB
         OKSOg5QZG/dS2cPQZ7pJ8Qn1/ynPlcAEVmUOqQibatz0nwcbyVcuBj1CEibs6rZWa/Fa
         Vf3n2Yrdct4bwGZtavu8KcBhtaSxYfq5QR/l0Y1o2TkrOEwW6j03BJlLjucLd2+L3XIw
         pDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717893129; x=1718497929;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnCHxXfWcDE9oW7NN5xGODtfi1ZsBpKLcmpR2EsiBZU=;
        b=uy3M4jfDHEJ6vLQex5ybCh9481FR2WwQpCw2TDSDw1yNDjHeN4Gv2NY/I05EIkoVvs
         HYAii6R+dv9oVzDFdCgWiKo+z/fEC7O3MnL5tHdb/2i7lwg3jp7ZnBUlcgjBnH5+xZbF
         up7bVj86p9F0hNz7lTuSdVztX+1cvmhgWs8JoSBZFV88YsljQaR9GWwqLdZeLhq6Sofh
         L45YbvzMmrmnItRReivgkBHj/ppMbaYORQOrFQmj/uL3MynThscb7ceMp31GWrly2RB0
         +kPVdqDj99D3UVxOkSmVGg030OycM56KRCpVEyYkbJlr32Q+2Xlgzwlx3+4C2WUggAWb
         BqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVnpfGm+x9lBTbTnup98Td9ui7qNBxJrrOGCoCPwKZsJtvS7sRhfMauCSMqWKcOZycXA7510ZQG19hRAJEfC6oidWePbz9YroXSq007WkukMCkdfpfEP1fyQWsyJ65bU327
X-Gm-Message-State: AOJu0Yzo/IOstoFtKOI+IT4Ews8OJ8slESUE6oNL+ueQ9skwyiNrjeBc
	n2S7q/vc4v7OFUrRjrZofWczFXgxLIpMpPtlGqAV5IcZoZrequqK3TRIrzOqzBD93R8JbWEVpbr
	0ydL5RKnjBABeGvAPX2VhW0B4fTg=
X-Google-Smtp-Source: AGHT+IECZKvgBg3lFZxwTgu/32De3poDCZTUfCYYjHO6ipviQTSuqFyflkaBKpE730DFvxTdyjfnwI/hYlit6H5JFz8=
X-Received: by 2002:a17:90a:990b:b0:2bf:8ce5:dc51 with SMTP id
 98e67ed59e1d1-2c2bcc6536dmr6182966a91.35.1717893129142; Sat, 08 Jun 2024
 17:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608014027.1118686-1-zhouzhouyi@gmail.com>
In-Reply-To: <20240608014027.1118686-1-zhouzhouyi@gmail.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Sun, 9 Jun 2024 08:31:58 +0800
Message-ID: <CAABZP2y+6C4vWQr7BP3Om3MTMd1oOqH4h8Lnm8tzyo3zrEJ_Ew@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: lower to GCC version 9 check for -Warray-bounds
To: akpm@linux-foundation.org, pmladek@suse.com, masahiroy@kernel.org, 
	yoann.congal@smile.fr, rdunlap@infradead.org, gustavoars@kernel.org, 
	nphamcs@gmail.com, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the patch is incorrect

On Sat, Jun 8, 2024 at 9:40=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> w=
rote:
>
> commit 3e00f5802fab ("init/Kconfig: lower GCC version check for -Warray-b=
ounds")
> lowers GCC version check for -Warray-bounds, but I continue to see false =
positives
> from -Warray-bounds in GCC 9.4.
They are not false positives, GCC 9.4.0 did report the out of bound
array access!
>
> This happens after
> commit b44759705f7d ("bitmap: make bitmap_{get,set}_value8() use bitmap_{=
read,write}()")
>
> During the rcuturture test in Ubuntu 20.04 GCC 9.4.0 x86_64, the compilin=
g of
rcutorture test
> drivers/gpio/gpio-pca953x.c issues following warning:
>
> ```
>   CC      drivers/gpio/gpio-pca953x.o
> In file included from drivers/gpio/gpio-pca953x.c:12:
> drivers/gpio/gpio-pca953x.c: In function =E2=80=98pca953x_probe=E2=80=99:
> ./include/linux/bitmap.h:799:17: error: array subscript [1, 1024] is outs=
ide array bounds of =E2=80=98long unsigned int[1]=E2=80=99 [-Werror=3Darray=
-bounds]
>   799 |  map[index + 1] &=3D BITMAP_FIRST_WORD_MASK(start + nbits);
>       |                 ^~
> In file included from ./include/linux/atomic.h:5,
>                  from drivers/gpio/gpio-pca953x.c:11:
> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing =E2=80=98val=
=E2=80=99
>  1015 |  DECLARE_BITMAP(val, MAX_LINE);
>       |                 ^~~
> ./include/linux/types.h:11:16: note: in definition of macro =E2=80=98DECL=
ARE_BITMAP=E2=80=99
>    11 |  unsigned long name[BITS_TO_LONGS(bits)]
>       |                ^~~~
> In file included from drivers/gpio/gpio-pca953x.c:12:
> ./include/linux/bitmap.h:800:17: error: array subscript [1, 1024] is outs=
ide array bounds of =E2=80=98long unsigned int[1]=E2=80=99 [-Werror=3Darray=
-bounds]
>   800 |  map[index + 1] |=3D (value >> space);
>       |  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:5,
>                  from drivers/gpio/gpio-pca953x.c:11:
> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing =E2=80=98val=
=E2=80=99
>  1015 |  DECLARE_BITMAP(val, MAX_LINE);
>       |                 ^~~
> ./include/linux/types.h:11:16: note: in definition of macro =E2=80=98DECL=
ARE_BITMAP=E2=80=99
>    11 |  unsigned long name[BITS_TO_LONGS(bits)]
> ```
>
In device_pca957x_init:
```
DECLARE_BITMAP(val, MAX_LINE);
for (i =3D 0; i < NBANK(chip); i++)
         bitmap_set_value8(val, 0x02, i * BANK_SZ);
```
We can't ensure "i*BANK_SZ" is within "MAX_LINE".
After setting the boundary, GCC no longer emits warnings:
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 77a2812f2974..e40bbd7c83ec 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1021,7 +1021,7 @@ static int device_pca957x_init(struct pca953x_chip *c=
hip)
                return ret;

        /* To enable register 6, 7 to control pull up and pull down */
-       for (i =3D 0; i < NBANK(chip); i++)
+       for (i =3D 0; i < NBANK(chip) && i < MAX_BANK; i++)
                bitmap_set_value8(val, 0x02, i * BANK_SZ);

The case is similar in drivers/pinctrl/pinctrl-cy8c95x0.c.

I will send another patch to set array access boundaries in the above
two source files.

Sorry for the inconvenience that I brought,
Sorry for the trouble.

Regards
Zhouyi

> Disable gcc-9+ array-bounds avoid above warning.
>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  init/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 72404c1f2157..27ce2ded95b6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -876,14 +876,14 @@ config CC_IMPLICIT_FALLTHROUGH
>         default "-Wimplicit-fallthrough=3D5" if CC_IS_GCC && $(cc-option,=
-Wimplicit-fallthrough=3D5)
>         default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-W=
unreachable-code-fallthrough)
>
> -# Currently, disable gcc-10+ array-bounds globally.
> +# Currently, disable gcc-9+ array-bounds globally.
>  # It's still broken in gcc-13, so no upper bound yet.
> -config GCC10_NO_ARRAY_BOUNDS
> +config GCC9_NO_ARRAY_BOUNDS
>         def_bool y
>
>  config CC_NO_ARRAY_BOUNDS
>         bool
> -       default y if CC_IS_GCC && GCC_VERSION >=3D 100000 && GCC10_NO_ARR=
AY_BOUNDS
> +       default y if CC_IS_GCC && GCC_VERSION >=3D 90000 && GCC9_NO_ARRAY=
_BOUNDS
>
>  # Currently, disable -Wstringop-overflow for GCC globally.
>  config GCC_NO_STRINGOP_OVERFLOW
> --
> 2.25.1
>
