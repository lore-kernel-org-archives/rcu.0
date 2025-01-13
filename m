Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D81190692;
	Mon, 13 Jan 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787152; cv=none; b=eERLZOl54lSs42iWJasu0RDzWEZIv7e4PHSQPGTTdEDecZy9NFsIQy0tXFQl9XbGenz+5ZAMBO1lSWgDEG2VRRQFBCIKJlxwMUXfj5iin0cpYeyswXakDhFNBk71tvJ9R67XIOBpxBJrFLgkGpKwd+V7MuPBnIxVCdFynV51vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787152; c=relaxed/simple;
	bh=DMoxqLiFfhY7CL47LQcap+sW3j0RiI3MKZajpknZvTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJKCT2rfpio0GPbJ3DFhYNI4VFN3J/AzL2sQU1vtX0BxGdZrHDBlYcGQzdUnh08P5wL9bHWee8LQAkr1Buq4I1Bzxb//lLEvEfDCsWeyXXoopNJMaf5JuL+dGZQQHm/euTctZ3qXQBCkZp2grlX8S/KfISh0YJbzc7z5ny2pUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na7GKajg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na7GKajg"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso8793802a12.3;
        Mon, 13 Jan 2025 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736787149; x=1737391949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfN5f0SNNeovJ6u2fLvDjtdxvC4rmZaKjrkepOGojiw=;
        b=na7GKajgK0ElHFuvf+lgGABdj/JoT/LCzLtzyhC3oTdUpRWnTOn4NBJSTdm9PCGu26
         83JFosLV+aaJYeDYCNBXn5yJhDVoJ17XZTxhcdIWZWZ/mA+MShOO7mtOzcJlcxx5wz76
         6uKSmdrEjvVl6OqTw2PKyz95GFjBRuRKIF7Cwf3yncw8QqgYZI4IhOuBbF07lmfyl2Lt
         /rLCgE3fK9qnNTiLgY7OxYuqt2WOv4r2WWEi6nn1wO5TvXlBgiR7uNaWHji6iDZaZS7U
         HNLTz0/DJj+e4EIUaszYAmcC4mgQrZW/Lw9ObNiDUSm3sZ1a8GTa8JczJJrkjkiqDfWZ
         kDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736787149; x=1737391949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfN5f0SNNeovJ6u2fLvDjtdxvC4rmZaKjrkepOGojiw=;
        b=i1hcpHZ3hwc2Cr+p6pm/aw2gJ92r+UWBHyBUyBLJLE7XDvojW1kUaL+pqzNvcU+YHj
         j8N23ND5OsNLnrBTV3hP5WVjIBgAiYSMOdVbu75UJldd/At/6wZCOM4vduMgYR4aEEzi
         D0HwLAILCkChF5eiEZBT409sZ7Sc9vT78AWdSyOiaSlOmxN/97EGWEVoIEnohnMgPq9J
         XH9XAX5msjQzDll+OpSE4jYFWbZt5AUq3t8IQUCSRGn6ZHY46JB2Zqf1hVhQNSpNr5ph
         o99EMlQS9j252Kd/uBJ81NJUUN2wLZNCQWMelefVGwQ7glen4/DNmDK+HdjAfQ9f4i5R
         nNig==
X-Forwarded-Encrypted: i=1; AJvYcCWahRne2aNpwHdS/ZGr95HRh/s0ctUGYPjU8vaotrLcnua7hiQy9yftu4WHZ0B+BklL285W@vger.kernel.org, AJvYcCWgFOBaR7c/pNmXhwb/PIVvwb2x8fFj0KlAaxdQHg0g/dKfSfUjFmfEk2AWJMR5JcXQnwVFw1nYKQ3COg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nAfUQHy9BqtLjlpfyTNlqXpYz93B9QpmgGd73UekTRl3aue2
	3QHYqm0suXtM7vgMqvmbaqMgnvQyvhLzU9x+phSo7YlEX6i3O4vJ+MIiAio0eFi4D23GqRGv010
	R+eaYXbaZ45ox1VXkQRChqDSr9xbX4eqjp1E=
X-Gm-Gg: ASbGncvzDcGyp2aWMOIP1GO4rHQJa5XuQ2fwCeLcK19MuzSPwDD+rYRPfNHWi2Xocfz
	RbnH+nyvfyQYo2V5tMwAs3Z2eFlpEco9eikUu8Ao=
X-Google-Smtp-Source: AGHT+IHaPJsi8VD+62eBbqkZD4L9x4tHOjuiovoyWhFt2/mNjjcQs0jUFwHLZsk07LmFykx9Br9tY8xC5y5fX1Mcc+E=
X-Received: by 2002:a17:906:478d:b0:aa6:841a:dff0 with SMTP id
 a640c23a62f3a-ab2ab73e6e9mr1905039166b.32.1736787148943; Mon, 13 Jan 2025
 08:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
 <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop> <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>
 <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop> <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
 <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
In-Reply-To: <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 13 Jan 2025 17:52:17 +0100
X-Gm-Features: AbW1kva6O8CuLelkV9iY03YjoeTnQqzvdfQGSQd4PFU_H1b6Cpy8pzAHcM62Yl0
Message-ID: <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I've sprinkled some stack pointer printouts and its seems like (as
suspected) the kernel stack pointer is not 16-byte aligned, at least
not in kernel-mode.

Example printouts:
SP: fffffc00059dfc08
SP: fffffc00059dfe48
SP: fffffc00059dfc08

I found some ML threads that seemed relevant one on stack alignment in
NetBSD-alpha after changes in GCC and one on x86_64 with linux/gcc

https://mail-index.netbsd.org/port-alpha/2021/07/05/msg001145.html

https://patchwork.kernel.org/project/linux-crypto/patch/20170110143340.GA37=
87@gondor.apana.org.au/



/Magnus

On Mon, Jan 13, 2025 at 6:59=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> >  Can you please retrieve the value of SP in `smp_call_function_single'?
> > Just something such as:
> >
> >         printk("SP: %016lx\n", __builtin_frame_address(0));
> >
>
>
> I will check!
>
> Also wondering if this may be relevant?
>
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D16660
