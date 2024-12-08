Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150822C6C5;
	Sun,  8 Dec 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651005; cv=none; b=GXYue9UYSoM5umf2/UjRclzgFPBLxnpfH21a9zkbZyXyJUAJL5NHQz8TAiEtwBkrk2IpYJfBYCrKkc8lvC33zavT40W4rRcjzpAzl7OeAUkODx609cWDxlAiDLoQ3vuiqfxDvVVBlvEJiP5sJD6hvBFsOGtlM8o6eFlmKWZ164w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651005; c=relaxed/simple;
	bh=XtehevyRa+8ISr3glnLpD4rfKK/+tefuScf02PXADTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqolNjYDA8oEqCdZgtLkO9IQGmF7amN4fX5W16Wz2FdksF9I1NIqccgfCBdRtYQF2Rq1daW/EdMcXiZnK4ZTZt+fmjYP0GU3e0u+CQTAH5H8sJaWRDVP7tNTtWpnros8QHktbi2r27/rznFgeEQ6Q4xQBg0E6u4Nef/qRWNF4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETKsVyBm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETKsVyBm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so5361462a12.3;
        Sun, 08 Dec 2024 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733651001; x=1734255801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtehevyRa+8ISr3glnLpD4rfKK/+tefuScf02PXADTo=;
        b=ETKsVyBmYPMSIKXVoBUn2Cltbc3Hr9UFtIF1y8IYa3FSOxJjvyvU0XKbzx4Rvx7W3i
         LG9yL5ivjzzivtTTTOlnz8doQ05mqMMLFgRRiRYJuu/qkGQzD7bav+FX2tZQysjtQpJ5
         aydzV+JxGlAN2ttlmlyqXyj1DF807B9pEzuyQkkhB++FG3MYqsTW4+yT31+3tu4BgSNt
         f7JsG+O7FaQCShc0PnOsb6Mr4KgDtob9kh+ErYR1v+jeAdBoRX8vq0x2o27Mm29YB1d4
         nvZXUDuQOniMavBl2cPXjYDSfiJBlV5jmViwjyg+f8f/9nVfC62zTNNq3dA+ipTFRH3J
         pmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651001; x=1734255801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtehevyRa+8ISr3glnLpD4rfKK/+tefuScf02PXADTo=;
        b=UBXyVmskLE949MXIlhYW8nvvhjhRbWQzw6MSNtc5wCVC9wZb3T0rc1D9y6EfUazL3v
         IOaH4m9nv+tEsFK1Vwg/ge/YacwGfxEabUhy4m6uPiX02FqOxdHj+sx4uFwYPp3LXrvB
         ZSY/j+aUc8uuI0rJ9Py1iGggmUJoFBC9wzWJLoiEPtBue5w8wGh+3Yxhw/aZH4DvJvsH
         kli5dnsfrUPzYUO4EdG9hogfZmsdrDphmEbL8uXF8FY3b62BERY1RLd3LHsS9osMoJft
         oeMG8iFEjNReDojToDQML4v3VNdijAm8x8h5OfXrYkgf1UNvDY8EeaGkEs1mArFWpIzH
         ooHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jc/ZX5jVwLjR5TCM+qFRFC3PBTBlgV70ZaI1TMbEjpahZFfe3dyziAQZF8znusczM7Oi@vger.kernel.org, AJvYcCULGEOgBA9a7vkFCmx+W5YaW6PqWouwytBgLNQuxROHqfQmlziUlWmtTlO4+giMNv2jdv9hPyibeYCwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqxPbtQxTdy6oVygEbIeMoJ8wGZVI9iHiFqxdHTuBYIrUEaaL
	g78OEotFMi6yGrtAzLb6kExL3b6LXDQlhI5jiJonyPbywraYtHRfkAMB5W6bwVSpwHo8H3t+e0Q
	v6OUu4ZWk+uXrA+I3a0O/NrJegB0=
X-Gm-Gg: ASbGnct5QPwBSV0GJVyRMJSrNZ3f+9CTpHTPyxAVsr+tD/ZYll5zh4gMrA7bnp8XFBv
	NWkifNL835yggVLBh1/xUxQSoTPzOiCUt
X-Google-Smtp-Source: AGHT+IGJCdU0zlJsotg8ptV+ppMCFezUnN1nqU4HMEDp9V18y0xccgrBx6sPm5u7UmqGQ26AZ6TyTh+ttmOyEhaDWJs=
X-Received: by 2002:a05:6402:388f:b0:5d0:e50b:899e with SMTP id
 4fb4d7f45d1cf-5d3be6bd817mr9617526a12.4.1733651001312; Sun, 08 Dec 2024
 01:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop> <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com> <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
In-Reply-To: <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 8 Dec 2024 10:43:09 +0100
Message-ID: <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 7:38=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Magnus,
>
> On Sat, 2024-12-07 at 18:33 +0100, Magnus Lindholm wrote:
> > Just a short update:
> >
> > Regarding the SCSI module unload problem, building vanilla kernel-6.12.=
3:
> >
> > alpha-linux-gcc (Gentoo 14.2.1_p20241026 p3): does NOT work
> > alpha-linux-gcc (GCC) 8.5.0: Works!!
> > alpha-linux-gcc (GCC) 9.5.0: Works!!
>
> Interesting. Have you verified that this diagnosis is 100% reproducible?


I'm sticking to the cross-build compilers provided by kernel.org, this is
what I have so far:

14.2.0 does NOT work
10.5.0 does NOT work
10.1.0 does NOT work
9.5.0 works!
8.5.0 works!

I've run this in a couple of iterations, on my system, this appears to be
100% consistent. I'm using vanilla kernel source tree 6.12.3 for the
tests and the qla1280 scsi driver as an example for the module
unload test case.



> I'm asking since since I have now performed some compiler tests with olde=
r
> GCC versions and the SMP bug [1] is not always reproducible for me.
>
> Changing the GCC version does not make any difference.


> > Regarding the network interface rename/rcu_expedited() problem I've
> > tried gcc-8.5.0, gcc-9.5.0 and Gentoo 14.2.1_p20241026 p3 same
> > results for all three versions, even though the fix is similar, using
> > different compiler versions does not fix the issue.
>
> What about here? Is that 100% reproducible? And did you try bisecting thi=
s?

It seems consistent also here, but I haven't really tested it enough yet I'=
ll
get back to this one again, still working on the module unload case.

/Magnus
