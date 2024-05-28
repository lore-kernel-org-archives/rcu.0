Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AB446DB;
	Tue, 28 May 2024 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860231; cv=none; b=rz0T2bsZ+G4Xp9EmEzX9y+G7RuBLEFtSFydZSz7ATZL1iHE2ekrURnm9waVK4WzNYxXapkh1hx2n3tZwbelHtQQxjMil1JVht7eHwBhh/nOR0VeWrjD35bnLZBcit3NosYZnXL8+WkB4myCB3tn3vuYRnxcg+G+bzSL6IxzP+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860231; c=relaxed/simple;
	bh=gRy35OUeiPoftW5As7Ndowu/SYCpl1gyfvy0PbUawa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiIDWNRFppdpP9YsWKve2XxCM5Tg0lJxIG9ZlysuM5gZKHfo1Bj7/oSPd+dQmw8i1Vwu5ZACvbXzQIZr0hBUz0dYfVNSjIZM1cnwreLjonto/LkFoU9+7ezVI7VfrpA5YQycP+Ahas4cGX0CxL5jzt23G0O0PmVgnXNRLYqujqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOyAWkg1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOyAWkg1"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6818811ef2dso213134a12.0;
        Mon, 27 May 2024 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716860229; x=1717465029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zk9vV2YlMycmzWFDOTOhz2mFHoCHmz8RqkeX1scVZQ=;
        b=KOyAWkg1FSgLxEdmUFfxE8KFAGuoVd/umysLOIDDPeCzSZl1nzZ72c8RC78fNYlwg+
         x2XYPfiukf1v3UN5WkvEuP3QKDDGCledCZZA7KpOO1lD/ZTgBs7CZO5pO9seeuTtn/de
         OlnWk9WcTX8TyrWdzU9z7A6wiC1DZjZah+BDhF1yVPNN7Cg6LJdJMTFy/Q2Am3W5o+RV
         aDrpKyqZx3G0WIa0Iw4Ue1np6UT4RkRqulUGYahAAepSti2PNoFHNYSab+sBN9DiZRuF
         JRGqMmK8zTEg5Mw9hbhD6/FGkxLEPrCTwKTWBr9Xf32wm+br7nnnDYgaCewcUxUFntcG
         NHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716860229; x=1717465029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zk9vV2YlMycmzWFDOTOhz2mFHoCHmz8RqkeX1scVZQ=;
        b=Hopo+vw40qCTGvXVjp1dZ+XAK3qSpAqPLl3cFABmWAIz6PfEdujkNv49HTKBBCZ/hm
         UKy5JcsT10ZBtzTs1ZT++dG1F9xB4zq6Hgg5JHPO3hgI216eUVZAOZsowkA4t9ufW4lu
         sErOR9/Ar9jeYjfPs3pGxpzkNaxYYXGrQXeWijfIRRxoc/ZZRII7BJCnA0aFw1Uy8Twg
         EYyczJpqE3z1nE8PQ3KmIF2qY2i9eAnJq+XPVrAMDrzcmZmxE0tCzaOVDCJa5qai06sc
         VAREFRxlKtcqSlHwDsmj+Whda8U5a/VuCe/o5yh4+y4bQJO69ER9xY819OYElVoS5aQF
         6Amg==
X-Forwarded-Encrypted: i=1; AJvYcCVcL5RQ6At5ai3stHy1hi/hAQktI6wz1LJxsOej9P6w/GUe8PxPmy67XbCj9gYAkUSgOW6zVN8sc1eeNaqiCKPLOuy0fAer7UP3bBgYDQCMoGJBj46ppL/1wRrI/WDv315G
X-Gm-Message-State: AOJu0YxIX7dm3WQYggBycFEeQlL7eZy9WlTebXuUU1sioEf3hD9Thraw
	xc8j2V4IsCp4PjODScZo/hh6Fz74msIL0sZXgIc4RlZXSwflL0xxgrDftNJklg0OcU/aCur5vZA
	xlwG23itFrlU+kLc2iQQOrtC4uXu032/EltA+9Q==
X-Google-Smtp-Source: AGHT+IHNo0JD5HYAnIvsWqv6//ds5GCpX9miQ/PSD8IvV39sh/7bXFiVDS6KX+8DFMu7bg9EoCp8gdSH3bmQsucVq2g=
X-Received: by 2002:a17:90a:bb8c:b0:2bd:5deb:9d50 with SMTP id
 98e67ed59e1d1-2bf5f74e014mr9138711a91.39.1716860229503; Mon, 27 May 2024
 18:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527012018.351223-1-zhouzhouyi@gmail.com> <c60b572e-12a8-49b1-a75a-b8a7b7ed674b@amd.com>
In-Reply-To: <c60b572e-12a8-49b1-a75a-b8a7b7ed674b@amd.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Tue, 28 May 2024 09:36:58 +0800
Message-ID: <CAABZP2zGfhcYrn6UOhmkXEgtCAPLcN7bgCdbzAi1r+aNrToHKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r100: enhance error handling in r100_cp_init_microcode
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, chris@chrisdown.name, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing the patch

On Mon, May 27, 2024 at 3:58=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.05.24 um 03:20 schrieb Zhouyi Zhou:
> > In r100_cp_init_microcode, if rdev->family don't match any of
> > if statement,  fw_name will be NULL, which will cause
> > gcc (11.4.0 powerpc64le-linux-gnu) complain:
> >
> > In function =E2=80=98r100_cp_init_microcode=E2=80=99,
> >      inlined from =E2=80=98r100_cp_init=E2=80=99 at drivers/gpu/drm/rad=
eon/r100.c:1136:7:
> > ./include/linux/printk.h:457:44: warning: =E2=80=98%s=E2=80=99 directiv=
e argument is null [-Wformat-overflow=3D]
> >    457 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__V=
A_ARGS__)
> >
> > Above warning is emitted during the rcutorture test in
> > in PPC VM of Opensource Lab of Oregon State Univerisity.
> >
> > Enhance error handling in r100_cp_init_microcode, let r100_cp_init_micr=
ocode
> > return with -EINVAL when none of chip families is matched.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> > ---
> >   drivers/gpu/drm/radeon/r100.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r10=
0.c
> > index 0b1e19345f43..4f8a1bdd9365 100644
> > --- a/drivers/gpu/drm/radeon/r100.c
> > +++ b/drivers/gpu/drm/radeon/r100.c
> > @@ -1055,6 +1055,11 @@ static int r100_cp_init_microcode(struct radeon_=
device *rdev)
> >                  (rdev->family =3D=3D CHIP_RV570)) {
> >               DRM_INFO("Loading R500 Microcode\n");
> >               fw_name =3D FIRMWARE_R520;
> > +     } else {
> > +             pr_err("radeon_cp: Failed to load firmware \"%d\"\n",
> > +                     rdev->family);
> > +             err =3D -EINVAL;
> > +             goto out;
> >       }
> >
> >       err =3D request_firmware(&rdev->me_fw, fw_name, rdev->dev);
> > @@ -1067,6 +1072,8 @@ static int r100_cp_init_microcode(struct radeon_d=
evice *rdev)
> >               release_firmware(rdev->me_fw);
> >               rdev->me_fw =3D NULL;
> >       }
> > +
> > +out:
>
> That looks superfluous, just return -EINVAL directly in the else case abo=
ve.
>
> Apart from that this is for ~15year old hardware. I'm a bit reluctant
> adding code for something that old even when this change here looks
> harmless.
>
> Is there a plan to complain about that in an automated checker? If yes
> then the change is probably justified, if no then I would rather not do i=
t.
The warning is emitted when I invoke following commands in ubuntu
22.04 (ppc64le)
linux$make allmodconfig
linux$make drivers/gpu/drm/radeon/r100.o (a quick alternative to 'make -j$n=
proc)

But everything is OK when I invoke following commands in ubuntu 22.04 (ppc6=
4le)
linux$make allmodconfig LLVM=3D1
linux$make drivers/gpu/drm/radeon/r100.o LLVM=3D1

And I can't reproduce the warning in the x86 environment, so I guess
this phenomenon
is toolchain related ;-)

Thanks again
Regards,
Zhouyi
>
> Regards,
> Christian.
>
> >       return err;
> >   }
> >
>
