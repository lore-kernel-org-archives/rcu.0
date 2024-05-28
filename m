Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E03D60;
	Tue, 28 May 2024 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860716; cv=none; b=in0CKILietXkGFHUUreG9rdd3B0S+hUrjnbGi83piV1BjcBoA1Oq036i6HCzYoQ+cebrW+l5BZJCZEfrk2XRWAVgBuxf3ZZN8VCUdb3vCkfkPm1IT3eeKY40ki6+U7W87ssrxYXTVf3LTMp/O0vDigfaVdWWAJOsgT//n7/bI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860716; c=relaxed/simple;
	bh=bCKDcQ86F3DZ6K1S7gKsoFLSTbjjXxjIz9TmVB+IQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdON4r1bH0uP6gkxUdPne/FVsnxjCMWIW1cBqsJxMhYLjfRrkO+0pebKJrrn/8RQgZ7ZVxqY9xThvTomd1q8uN7FzaDS+ZLNthyQh6tdQSbnMG0ruABvc8az/DBAJPeQiHKJqwhBsIXjgQGInT0104BLPin3McPIom0P7/xcfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1DKFIhj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1DKFIhj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bdf3f4d5ffso210917a91.3;
        Mon, 27 May 2024 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716860715; x=1717465515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZuzBn8quBWeOsvE1Lk2Z6AJ5TaLj0Zv5xeM9jkRkY=;
        b=g1DKFIhj5R2BmvlGneb7D5VUuNLPXXvXfZtwxIyiR+AKrlkfeK4eRjcjgxJF69YIAI
         +O+b5ApfRd2FCwr2zyHHtt5uPiquqF+XNRHHhdLKEaaF8GPDihyKwkm4/myD077/fpS3
         XgkFioeQVgrIK5lgdTzoGpq1gNmESQHCOVsEBjK2mNBM5CIaFiN6cbaDf2yy1Ik3j8Bo
         wtaBv8yHglkd/RrPfY33j+xneG8nz/NaVKo0D5D2lIQcVm7gsdm/iFLIuAJ06FuU9LIW
         DtBYIruU6hXxOYuGTz9ncgm26fgaGnOdlH/kjn4tEBAwoBaw1KwwnU9o7Uft7x2EBLVF
         RoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716860715; x=1717465515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WZuzBn8quBWeOsvE1Lk2Z6AJ5TaLj0Zv5xeM9jkRkY=;
        b=sOUvCodQ40TdhrbaIAp7d3fAw7XFGBptreV6Mi/Dt+KgXZo1wAEw9IHAMCbX4k4Ows
         YWPc8Le2CDrUx+QU8gv6uaHE24HcVxr1LVlvpVS2OBYPQZwQr2LV29SkLJFDkD3E73Ej
         /zju65MSiUXIvwMtX4eMcBq6rFLdPNlESU6Y4oJ8khmAuWdgRbnVBtiGBLExR6O37Ztb
         2GFOpfNt0MInk59jOxS0sz+4pd0b05j5RWILRBb3jvsd2w7v7xdjIP/Af8+dIoPvW5Kc
         A/h8MFqgkcxc8X9VIgfQQo2iFZhHtQvvunK62WRODFy/qms8GuhMudJV81KxiLn42tVI
         7BJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkQ8cq/G5nGBBduqRvHBi4XEV9Z7b5EVNWhoi5VkuJkA4sDX2+BXex4vrRRnV1LtISLAPzP1aRdV0YOGnCRwD91tnBOAySXSr8y+bMNjBSBC5RNDdumpjCYMsdYbThrl5E
X-Gm-Message-State: AOJu0Yz0F7fIUEQUBWNS4sMpIckc66Hgpp+sED5kA00qNp9SONjnTn13
	KdI/cs9c/CSjT9NiQn9AMM8S4fRULPHzUWpgDYrUU9c/HJdMG8vYHZvPvOV+pCol574yuHF/vyE
	jNUJ4id7VS7aqLvcji1/jW+w+e8rqqzmXmBufKQ99
X-Google-Smtp-Source: AGHT+IEoeAZtpR1+qNz/hWhSApB41CTHGMkY3r79faQLS6aa7Fl88PJ9rRkoYAH6sEGDE6IKTR44tV1Bv0/gNTmoUn0=
X-Received: by 2002:a17:90a:bc85:b0:2b2:6ede:5ce0 with SMTP id
 98e67ed59e1d1-2bf5f70f2d7mr9067767a91.39.1716860714620; Mon, 27 May 2024
 18:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527012018.351223-1-zhouzhouyi@gmail.com> <c60b572e-12a8-49b1-a75a-b8a7b7ed674b@amd.com>
 <CAABZP2zGfhcYrn6UOhmkXEgtCAPLcN7bgCdbzAi1r+aNrToHKQ@mail.gmail.com>
In-Reply-To: <CAABZP2zGfhcYrn6UOhmkXEgtCAPLcN7bgCdbzAi1r+aNrToHKQ@mail.gmail.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Tue, 28 May 2024 09:45:03 +0800
Message-ID: <CAABZP2ximP0kiSSXSw51fhrt0EuZMLUHeonzS2VGSUwm-QEF3w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r100: enhance error handling in r100_cp_init_microcode
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, chris@chrisdown.name, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix some error in my previous email

On Tue, May 28, 2024 at 9:36=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Thanks for reviewing the patch
>
> On Mon, May 27, 2024 at 3:58=E2=80=AFPM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 27.05.24 um 03:20 schrieb Zhouyi Zhou:
> > > In r100_cp_init_microcode, if rdev->family don't match any of
> > > if statement,  fw_name will be NULL, which will cause
> > > gcc (11.4.0 powerpc64le-linux-gnu) complain:
> > >
> > > In function =E2=80=98r100_cp_init_microcode=E2=80=99,
> > >      inlined from =E2=80=98r100_cp_init=E2=80=99 at drivers/gpu/drm/r=
adeon/r100.c:1136:7:
> > > ./include/linux/printk.h:457:44: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> > >    457 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##_=
_VA_ARGS__)
> > >
> > > Above warning is emitted during the rcutorture test in
> > > in PPC VM of Opensource Lab of Oregon State Univerisity.
> > >
> > > Enhance error handling in r100_cp_init_microcode, let r100_cp_init_mi=
crocode
> > > return with -EINVAL when none of chip families is matched.
> > >
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > > ---
> > >   drivers/gpu/drm/radeon/r100.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r=
100.c
> > > index 0b1e19345f43..4f8a1bdd9365 100644
> > > --- a/drivers/gpu/drm/radeon/r100.c
> > > +++ b/drivers/gpu/drm/radeon/r100.c
> > > @@ -1055,6 +1055,11 @@ static int r100_cp_init_microcode(struct radeo=
n_device *rdev)
> > >                  (rdev->family =3D=3D CHIP_RV570)) {
> > >               DRM_INFO("Loading R500 Microcode\n");
> > >               fw_name =3D FIRMWARE_R520;
> > > +     } else {
> > > +             pr_err("radeon_cp: Failed to load firmware \"%d\"\n",
> > > +                     rdev->family);
> > > +             err =3D -EINVAL;
> > > +             goto out;
> > >       }
> > >
> > >       err =3D request_firmware(&rdev->me_fw, fw_name, rdev->dev);
> > > @@ -1067,6 +1072,8 @@ static int r100_cp_init_microcode(struct radeon=
_device *rdev)
> > >               release_firmware(rdev->me_fw);
> > >               rdev->me_fw =3D NULL;
> > >       }
> > > +
> > > +out:
> >
> > That looks superfluous, just return -EINVAL directly in the else case a=
bove.
> >
> > Apart from that this is for ~15year old hardware. I'm a bit reluctant
> > adding code for something that old even when this change here looks
> > harmless.
> >
> > Is there a plan to complain about that in an automated checker? If yes
> > then the change is probably justified, if no then I would rather not do=
 it.
> The warning is emitted when I invoke following commands in ubuntu
> 22.04 (ppc64le)
> linux$make allmodconfig
> linux$make drivers/gpu/drm/radeon/r100.o (a quick alternative to 'make -j=
$nproc)
the command should be make -j(number of CPUs in my machine), please don't i=
nvoke
'make -j$nproc' which is my mistake, this command is very dangerous,
and make my machine hung ;-(

Sorry for the trouble
Thanks again
Zhouyi
> But everything is OK when I invoke following commands in ubuntu 22.04 (pp=
c64le)
> linux$make allmodconfig LLVM=3D1
> linux$make drivers/gpu/drm/radeon/r100.o LLVM=3D1
>
> And I can't reproduce the warning in the x86 environment, so I guess
> this phenomenon
> is toolchain related ;-)
>
> Thanks again
> Regards,
> Zhouyi
> >
> > Regards,
> > Christian.
> >
> > >       return err;
> > >   }
> > >
> >
