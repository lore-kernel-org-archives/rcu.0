Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBB82C7E;
	Sat,  7 Dec 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733574841; cv=none; b=holyw4I2L+N+A9aa/C0ScyEiIXBTS3XtA37rCyVCYzvE+iSsvY/qOggh7OuuNQ/I2IJmiQYig9lZJkXYmVma9G2QQT5qI+JJmn7FygUXwe4c7+OGIgDl8xetRtWupYVKameaqXfAGUKLLDkhPWp+pWWO+NQ1O4Fjvjko/vDnvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733574841; c=relaxed/simple;
	bh=M6jXhS7eY9M9WTKyDzz1A83pH19yS9enT4xymk7WBdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbxi1PF8GojOi9SXQhLRwK6BEpQXM4LufK4by53F0WAuVnuRQESK9qHycrWcB67a2m7XY8BV7GYxj/aBauq07Kkz9LWNt5LuBHChzBkqcxagW8qW95BBKasgN9G/xApdH+UknqYRg7Rdn1BJfUPn9a8zRLblRhBZ8LxEiBVblUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0LnUJKF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0LnUJKF"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso4204558a12.0;
        Sat, 07 Dec 2024 04:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733574838; x=1734179638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6jXhS7eY9M9WTKyDzz1A83pH19yS9enT4xymk7WBdc=;
        b=K0LnUJKFWTJMH5IvDc724NzFboVkRM3OMU+34yJb31zi3jJBae3TJIur8+tMmWFhkM
         JBjTKYaPMyjC0H/gcPpnwvlS9CniF70fJE3fjgbiH/FQjxzwiO7A4I2qnpvdU+X5eglJ
         6TGLwTV3HeTa6FrteJL5fKVqYzjmsBuy8TyyheigljfUX/CXmrnnmOAcsPYQDhfG4i68
         /gewn0gvFH/BpH8Yuss0IdVvmwhQllpXChxRj02jUp3lnhzES+/NS8PasG7dnRwAA4KC
         QALaejXsCNwPYy9JhaBRFV+VVQQhxU2fgDcHxlgRJeSL4NbUhrDJ722jt3HIE+VvOqBN
         4eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733574838; x=1734179638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6jXhS7eY9M9WTKyDzz1A83pH19yS9enT4xymk7WBdc=;
        b=Mgo9aEXSwqQvQgF7pcLo4caMu8e614N2hf/lHwOiVY7n3vW3MpYZg+r+09qtUiLcfh
         RXjLAnGlwSrAMtL2CHyhX41TXQIRvaFpaSroLK7+mPOTcj/qvbW22CMuTI+dC8hhnBd1
         OaDmqqNtUHPT9uCAu4PmajPgdQabXoBAH1KUDue1GUBb0Y9PjVeG4axE4r/6tc0NhOIk
         S7czC5GSsfkdPBiw9BQrMb80YGyPUk7xa3MfnxJFwGK79tkc6PxMN2mcNV+OwWCMdVrx
         hZftLH53YYca2v9INWjBRYC74n/4veOjnudy4wBuBe79sgl8ZOI0fmDCEgdooaP4oOb/
         uZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq/1KFMszx8yecSRpYTK4VA1r5YFc2+iRkEOv6fFO95uRXPsvxL8A4V2MjdjwtxayKImKFq00AzmvMLA==@vger.kernel.org, AJvYcCXTun6Txgf5DDWqxFQzudBro3bbVshzoDob+5pST1O/yofgULo8RfSXOPqhYhHFAIhVgpMY@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+dmBtPwWYgVgcadUHUAkYrV6jgJeeyWGnNQ8RzWCJDHq4N/x
	citfrH5Min3v05KrAxL0umyWcmPzn61KwFoRdmshXqda4tMAEGwtGFLuy96QsfvT0ziSr7aGXiB
	6TTpy9OsMq5YeMESUoNcLRc8YlFMsFA==
X-Gm-Gg: ASbGncsMmJL/yHFJ2mOS3FG+xUIsOXbwhzXwMR66scFn6/eqZEySGlbdEswCWNpI4Fu
	5nX4cbzsB5S23U4Xw6NEt3395a3cOkLwV
X-Google-Smtp-Source: AGHT+IENTv54yP8do1jsdCr3AFKSB7J4q/3ZCNKBjtfK2wZ/oBQBm95rfZKzYvYL4dyKWnKSWQUkxjopCI1tw6Mer0M=
X-Received: by 2002:a17:906:1ba2:b0:aa6:28de:9d0e with SMTP id
 a640c23a62f3a-aa63a288717mr586192066b.58.1733574837853; Sat, 07 Dec 2024
 04:33:57 -0800 (PST)
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
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com> <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
In-Reply-To: <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 7 Dec 2024 13:33:46 +0100
Message-ID: <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Could this maybe a compiler bug? What about building the kernel with an older GCC version from [1]?
>
> Adrian
>
> > [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/


Hi,

I'll try to dig up an older build environment and see what happens.
Still if it is a compiler bug,
I wonder what makes RCU/kernel code trigger this and not other code?

I also notices that the interface-renaming rcu problem which occurs in
a different part of the
RCU code, when "fixing" according to the patch supplied previously in
this thread, the code
I hit the bug again if I revert from using CFLAGS=-02 to just using
CFLAGS=-0. So kernel
optimization flags can trigger this bug it seems.

/Magnus
