Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997011FC8;
	Mon, 20 Jan 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378108; cv=none; b=i+8w+rG117E1xuSfbMPFPiBuN8/BwOUpqjkgjZfWhfpHvFu1DyV21RpHaV3UKbE8IBieQz23BC00ab18uZSShoD8IZHieKWs7d7GS08xYfKOtmhxl2WU1Q/k9CpYfbCUeaw6WgiQc/4/HNMffQOeJ5q1LU2YTJ+CP3tZLWvTBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378108; c=relaxed/simple;
	bh=K9iRMUDhv0rs7d0AKQiPe0lt8dvk6O8u7LQKbnOUEl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1YqvEwNAMInrk11LapiidZr5JfS/U/jVHD5GppmPZbCf6FmZefwErayV7IYJ4HoEGFSUQkSuBHrTcKo36iRZnd/hHFi7/MH7UHVln1zGQi+HaBUOfPumP+DEe5PgXp78xK2xq90gF0gLxgy03Wc59iS1FKgHrUN/xdwV4lur3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEtxili5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEtxili5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11086103a12.1;
        Mon, 20 Jan 2025 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737378105; x=1737982905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzbBSvQ2fJboSP9XzDbnbob6fwTWVoHDrWCjAFghTh0=;
        b=kEtxili5sIh/s4RkSy0yEU4e1bSyACNM1RccRXSmD+gUdnelfMPcE9QYCr4yU2z4/M
         M6edCKcK6T0IQZChrIrdkgd1/KC8ceHylTfqwY8fGxiJ+yN8ULzqCuRK0UQB9o5X9yhj
         ktW1Cs4WYINu4KjVhFy9bYNbA9aFVW5HAxftkf5aFE4Y1cEZrgbKOCS9OlpWX3DqnZGD
         7SN0etvzrTI3Jw7KW5pn3P2VKmQsjwCYPHi7ZaJanGJPE3TwLVnKT+BQBm1uv5etswFC
         C5FlTt02GqEN6u0pu+slu6yiGCoA/XHdRng50F5km8GAE0dQfZYk1GNgx9Jm0D1dWzpK
         xBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378105; x=1737982905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzbBSvQ2fJboSP9XzDbnbob6fwTWVoHDrWCjAFghTh0=;
        b=paBgiOTcz+rMpNn2TIyczpB5rQ39fI5I6QVZxI6gxvxXGeSkWQCpnT8Vta7zFbcQig
         zGtb7gGtBxFAQ4EUuPTeTIWtVOQ9iNIt2d4iZTKD6/qwroas6xSCH9nn1msSMlfFg3Dj
         UsRqk1RVvyUomgYUX+6sow/nOd9UUNqBPa78r35v7HSQduHIiWQxRL//ho5iyh45UpSf
         ZUXBVKXla97jthQlU/WuPfh5x3/PGtCEubJYovOK4j7hIybdhfscjiKtAAI3Z6T6WgRh
         11Foy4ldebsPYZnRYTw6djb2jvKRGFQcbqR6AZlGBQtWb+WoWcZCB+rcnik2dkJkOMuD
         WujA==
X-Forwarded-Encrypted: i=1; AJvYcCW3oohLjKak1Jx+2NuAKY9YLplXw1lwDg58WZJbaOfIX+rGLiHtb51zVr7BJ0QBFE8N14BjcbANxq80OA==@vger.kernel.org, AJvYcCWuJq1C2XFM/Hp3qzn2isuD9refasjfALExSt0MbhFERU0DuJi1fV1vXwlQ9BnZwtP+BBpt@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdRxcw5HSinshxG5oA8b6afRHxtB3MW1Nk5/CQpYK4s5iCcTB
	sKhMro03CQMMI1cinWLLvQIfbA0OgAVY7aWKTcgqAKALUr46AvW/aj/1PqRIsg06s/8+d+NooCK
	Moiyc1iU7IDP8iC67gbsOasO+foQ=
X-Gm-Gg: ASbGncvKeKH5KddK/amesKWXcYZicIgkCE7U+WYbgxcm/tzEMcZ91YUuFn0BmzQjFFJ
	eRU1Fe7C+NBRMaTn9XgoreWpspXiykrFP+X6cAMWm9oW3GgZm7n+t
X-Google-Smtp-Source: AGHT+IGs4lyXV9f4kP8/HQcftAAjfVo0Lhua/zM/u2ToVU/hR0jR3rADkEEw2ec6M/BMJEb3bwS749JaJfr2ZBiswjs=
X-Received: by 2002:a05:6402:51d3:b0:5d4:c0c:70f9 with SMTP id
 4fb4d7f45d1cf-5da0c27e591mr18638532a12.6.1737378104463; Mon, 20 Jan 2025
 05:01:44 -0800 (PST)
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
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
In-Reply-To: <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 20 Jan 2025 14:01:32 +0100
X-Gm-Features: AbW1kvbY_2TBUNeXR1ZOUrMLsSjN72qRl_8ezN1aoEB9yy_6_41YOTVf40D3hQM
Message-ID: <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Attempting to summarize the findings relating to this bug as well as
the comments in the mail thread, my understanding is this: In order to
conform to the psABI, gcc was changed (back in 2004?) to assume
16-byte stack alignment on Linux/alpha. This seems to be the case for
user-mode processes stacks, however not for the stack in kernel-mode.
Some simple printouts of stack pointers in kernel mode suggest that
the kernel stack is in fact only 8-byte aligned on Linux/alpha. In
comparison, I've made similar checks on hppa, sparc and x86_64 and on
these platforms the kernel stack seems to be 16-byte aligned (at
least). If gcc assumes 16-byte alignment, and the code uses
__attribute__((__aligned__(x))) gcc will generate assembly code that
may cause stack corruption, if the stack at run-time is in fact only
8-byte aligned. A quick-fix/workaround for this might be to avoid
using the __attribute__((__aligned__(x))) directive on
variables/structs declared on the stack in the kernel code (at least
for alpha), but to really get to the bottom of this, the kernel needs
to be fixed so that the kernel stack is in fact always 16-byte aligned
on alpha. This means that this bug is not really related to rcu or smp
but rather a mismatch between gcc and linux-alpha regarding psABI
compliance.

/Magnus

On Mon, Jan 13, 2025 at 5:52=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> Hi, I've sprinkled some stack pointer printouts and its seems like (as
> suspected) the kernel stack pointer is not 16-byte aligned, at least
> not in kernel-mode.
>
> Example printouts:
> SP: fffffc00059dfc08
> SP: fffffc00059dfe48
> SP: fffffc00059dfc08
>
> I found some ML threads that seemed relevant one on stack alignment in
> NetBSD-alpha after changes in GCC and one on x86_64 with linux/gcc
>
> https://mail-index.netbsd.org/port-alpha/2021/07/05/msg001145.html
>
> https://patchwork.kernel.org/project/linux-crypto/patch/20170110143340.GA=
3787@gondor.apana.org.au/
>
>
>
> /Magnus
>
> On Mon, Jan 13, 2025 at 6:59=E2=80=AFAM Magnus Lindholm <linmag7@gmail.co=
m> wrote:
> >
> > >  Can you please retrieve the value of SP in `smp_call_function_single=
'?
> > > Just something such as:
> > >
> > >         printk("SP: %016lx\n", __builtin_frame_address(0));
> > >
> >
> >
> > I will check!
> >
> > Also wondering if this may be relevant?
> >
> >  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D16660
