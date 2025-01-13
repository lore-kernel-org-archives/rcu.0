Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8A1C3306;
	Mon, 13 Jan 2025 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748000; cv=none; b=Vfz5hjIkmgjR4rVqqZQb+xyy+xmXVUBePeuYeBeFEHnW2AuUB2EDkW2gLrh98Z4orZpxPkazzB77S5rqkAVW/+oeSekqaOVHVUElnsyMXwQOTBAY3asz3nkx3ni/AiFk8VeVxGaYzOneB8YhkC/woHPZV+5l+Lpwn/1SUt8Zedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748000; c=relaxed/simple;
	bh=T0SFzWLHnj+Q4QvKspaAQeyurquuWReeOKvELWMKqn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVBQPWI5LWQuybhGIMZmPGwTZO45HWqlcURWWc4wocbxdyQmHUavOq3PPB4rIGjUaqMI2dM/oiANsQZRXVt7rbKy4+rIXyW0sMRzHgv5iVm+ipz2NPpGhs8MnkhGDqOdCFeZp6sdo/G/Bi0IvNR6NBtxnC8SGrCsfEaA19KvdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVsNEbp+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVsNEbp+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso701658066b.2;
        Sun, 12 Jan 2025 21:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736747997; x=1737352797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/G30vGUx/6t/QcniaQm9FHpMQLWUhu/pJjwyN8QZak=;
        b=kVsNEbp+I7qGdFbMCoR22+I3JZJkRiWmA0aDX/WFwxerw2ipMSVF7jGmAP0f8tgxYC
         RRj3+6eFN8iA80KMe+iaDt0C7z+IYXMQPi2xRsChqRlxkdGdQ8SokFzZnxwd/t1K6ssN
         qDXVxPaVKVFGtiaVWIQlx5g1DN4NGLwTGW8aRHVwJ8vWsPGp5PX6FWA/2Y1uASbnw+lh
         XUqDjHkpBMKuCUTzfPmFAba3nJ3ncjY4jWQRDURSVIYOrTw16JxqVD+/tYjecQngO8y+
         4SfKKSHvFSagBzODsbvruouQXQtBhL9knSb28t9FwLeK6FMgzLmUL5oiN+oPrMuAV7Fz
         zF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747997; x=1737352797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/G30vGUx/6t/QcniaQm9FHpMQLWUhu/pJjwyN8QZak=;
        b=db564kZsginILNIwPe8pBfJnxLqSTdsNPEntvP61BbvUxE+gFBljNLvb8sNYbzFaEm
         Ddsq7eEhBFyqJJEZZAPD/KzlafzIEQ9vGkcA302ulsnwzh1SUTM0QzLpcdd+PBFs8uMU
         e2K1i5NcjqFJ609ihS1ojWyQdrynx6IJ0mUyUdJ2oB96kdmtVjfbF7rvwHbM3odWnhkV
         gN9XNvYzHarf4712tJ1N0SnZ6eQ0mqtxDdRTjWcSpPZexJuwnc8eV7XlqQsOOe/8MMO8
         V8Is5dqhQ2qzlsA2FDZeNAy5r1zQUKKCdkYzN4DvKJhSK+pLEpH/ILvXrKlbDK5Utw1L
         nEYw==
X-Forwarded-Encrypted: i=1; AJvYcCUuf1avt+AOTOuqwEuwtVjxjhp5LPxxW28pMSHfl0PM9kJREW3jriSJB9v8Uws81f4F0q+5oJOIiFTmnA==@vger.kernel.org, AJvYcCXxJ5jSqHJAtX9SEvHb85tzvjUU8boleul00WEZfCrRX3LG8nQ5bxsfqdFV9Kbb5S63HrjH@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjZeNtYNA/gAcD94rrT/8OrGcHF0HA88hX0i79XV5i6ne1KWM
	F2HRuApHE+iTbnxjPO7m0Y1Mtc7wdYUM9HC0m6RPXpkap/w5lDcn+0t8cQRUvM4dCU/XYzQMGd+
	rXE/mHW/PcY9ajSla8hDC4zqTjhw=
X-Gm-Gg: ASbGncv6qzGVxHn2nPamfx9FJQH4Cnm1EEK4gSfSY2iGojNbyemzaVyAlcMC6u2EKXd
	a6ZFvUbFo8gqD0P4VXIaV2aIAJvPV4KNRmxKVJgE=
X-Google-Smtp-Source: AGHT+IE0oU2XF0Eu5iaqJexjJI8um9V3FOiLY3BumqufuaicveM49iDSGBZB3DJnn6eEk7NsXqw4UrlNCO/j7aVLQc8=
X-Received: by 2002:a17:907:9687:b0:aa6:912f:7ec1 with SMTP id
 a640c23a62f3a-ab2abc779dcmr1990231366b.39.1736747997240; Sun, 12 Jan 2025
 21:59:57 -0800 (PST)
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
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com> <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 13 Jan 2025 06:59:45 +0100
X-Gm-Features: AbW1kvYIvMGeKnEUIBgpK5UhGynimFWiiDZtRcCQPJr3yBdB0x8VWo2m1lxB5M4
Message-ID: <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  Can you please retrieve the value of SP in `smp_call_function_single'?
> Just something such as:
>
>         printk("SP: %016lx\n", __builtin_frame_address(0));
>


I will check!

Also wondering if this may be relevant?

 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=16660
