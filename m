Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0D279903;
	Fri, 11 Jul 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225682; cv=none; b=Je9H3l56SSjONxeT5NAPSpkBAhglo6IW8qe68LEvBbiTiciLHSE55YszrGF5QuV8ynTL0BEmfozZHlMWAFueNz65EivJuIdPw+PfJgIM2xv3VjIqJrjF1G21qJRexdDbSQnioCeWX5xEUu/lGc7w0SY5C7RX0mRVfWbOedMH1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225682; c=relaxed/simple;
	bh=v5skrjljMaiRznKR3++rcBMCio6TA4MIaU7O9AkkvO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHK/iHYxLKU3O3jLrK6omNHfF/LkSzskZq8H3dKA25OWGezQumCdCbk+3K/VMsR6oLnYBronlyUySv61BrqolRkcVDezqTv+vTnkiGBwA4Ovjb8LuEl6yPtcivW0mFGchQflOtWc+KimrrQly62kv1tCcdbjHWp1aijmur6uUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz9bZPMt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz9bZPMt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so4159116a12.2;
        Fri, 11 Jul 2025 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752225678; x=1752830478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5skrjljMaiRznKR3++rcBMCio6TA4MIaU7O9AkkvO4=;
        b=mz9bZPMtVFNiRRbp3sk4fXXaeBb3r6m2URxmHzI6NXPQcWxtvJO8cQbdUkh6wP8+/r
         B3DrwztzxEW42K3wXFsCONhJX0wque4/NLS2+MyhNKr8L2h3tM72BZ+CuJ1d+L5CpkcJ
         TpoI28IYkrCa3uRcR9QjdIY4H44+Ol3gkeNtzhIKEXcFdgMsZXLIq400H6lgYl6Uv2a7
         W6ROsProWa0RgjPj0pnbKSylf4QgYKTkpBRKMEf5/QcuYPKiDKLmYl3uUR+xHAp0R1OD
         LDlIkwaWFtmzcOSv8DQUkS4z6AJk1Z9qW97/3ixQy9SntNoLJB//85Jx+HoMQhuwCPcu
         tmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752225678; x=1752830478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5skrjljMaiRznKR3++rcBMCio6TA4MIaU7O9AkkvO4=;
        b=IxyBskojsWt94aWih4d1ffoNwf1CbA/199uIv/3TNROqctWYxjjaMwt3PoCaEuommV
         yW2/vJfygL/liHdqmE2fQwC3BCacV8nw980L6PieCZTHY//BitYUNgrpoVnUIZLs9g5h
         gXzThUJ/EQLYEIK9aARUzMIpI16pY2c/TOx3oFkojMBC4L9RBxJUT1BejEsu2EEhs2bY
         ZldbP8XPAPmzrKyGcFFuDhvnLNyWjIrCpMfrc5CDa6nFu26dHlv9s2egcoyFE4u2vRFK
         cb+2hvsCqaYvSfo2YN5SGL96VWbMDPlNT6L3OhwPvXA/UKzg83yYBNqc87fLVHOhgt2W
         PtOw==
X-Forwarded-Encrypted: i=1; AJvYcCXSJDqlMTjRUl6tq6XZvlIHlWAO0yHmzQEsLPhAWQaTiDARHfet546nB3gwzYoW9zifG1TXI3RgzNGwIpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoxpbm3JGaZY8bOMAzBX7KYB3awK28xkb6bhDMqACWG/UhFRkh
	U5mHnJjSd/q2F8jRmuCPDdLUNkSTerIjkB79Jt+5gvl7rVy9+spBQSeIbFpzc8BtegWvLNV9hvm
	QcdETOJ3PTuIqossm0zAFnBx2ZtNomYs=
X-Gm-Gg: ASbGnctPubDuFCTe4qMX0fnuqkCSWtf+RUzSapDbBuxz88QGbGRCVVCzyfY4PjJaLv8
	pvZzruS36r8ESBNTlBrZoqodOLB4dnc+qoXOtsw9nmuK8UjLRYBf6nsUMY+19lRhym7JLZd2Bzg
	Z72StKZKIvm/vwFX7D5BpVfHbdawPWiFCCDMn9GtbHiDyl0UXAvOs8PoKjKn2g/RGZ6HiuqQwrf
	m5j+3h4+dZ6pa+6cVnQFKdOJaZJnoFPd6cmjJZNhw==
X-Google-Smtp-Source: AGHT+IGaxamUHCv58lDZJx8LYdQFjQw/vvdayYy2xVYKdbyGDDDxQONMUPmrxQvmMYNkh8wFCp43zR+0OhbOW77dwW0=
X-Received: by 2002:a17:906:478a:b0:ae0:ad5c:4185 with SMTP id
 a640c23a62f3a-ae70131bae6mr153726366b.57.1752225677662; Fri, 11 Jul 2025
 02:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvcb-BAreFW=QS=DnWnXX1gK1EAX09tBQzopwH1Jd1d=w@mail.gmail.com>
In-Reply-To: <CA+G9fYvcb-BAreFW=QS=DnWnXX1gK1EAX09tBQzopwH1Jd1d=w@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Fri, 11 Jul 2025 14:51:02 +0530
X-Gm-Features: Ac12FXzUURrO7TVvQDfpHYXggr-im9yTZQ0aOXcB2YcIl5rlAM6oFaGWx2_l_Tc
Message-ID: <CAFwiDX8A=2N9iOOMRE_tzfPLDfsn70bhxDhiFMkyZ1pEMasXiA@mail.gmail.com>
Subject: Re: next-20250710: PREEMPT_RT: rcu_preempt self-detected stall on CPU rcu_preempt_deferred_qs_handler
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: rcu <rcu@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, neeraj.upadhyay@kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qi Xi <xiqi2@huawei.com>, 
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Fri, Jul 11, 2025 at 12:11=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Regressions on boot failure observed in builds with CONFIG_PREEMPT_RT=3Dy
> and CONFIG_LAZY_PREEMPT=3Dy enabled on multiple platforms running the
> Linux next-20250710.
>
> Kernel stalls and RCU preempt self-detected stalls reported.
> Boot log shows CPU stalls and failure as below.
>
> Test environments:
> - Ampere Altra
> - rk3399-rock-pi-4b
> - x86_64
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
>
> Boot regression: next-20250710 rcu_preempt self-detected stall on CPU
> rcu_preempt_deferred_qs_handler
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

Thanks for the report. We saw the same issue recently. Here is the fixed co=
mmit:

https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=3Dn=
ext&id=3D2e154d164418e1eaadbf5dc58cbf19e7be8fdc67

I have pushed it to rcu next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/log/?h=3Dnext



- Neeraj
