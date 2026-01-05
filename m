Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1E2AE99
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767576698; cv=none; b=mpIkKO59c9Fq9d4DTKcRP6vVciOlFsh+Qsn/Q2UPhble18Hu+/SKA6rGSQmBTRhPSa6da9r8xyvE1pYwdXMREEjSWoOWqm/KQhBySuGFrzuPpBa129sHThqJVcoswLLo99PozlX9lscAPy34u2S6D6usZx/KkZbDq6Z6qdBedH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767576698; c=relaxed/simple;
	bh=dBgza8T+HXrVbo0psGQU3HbJdpnaF5Ddh2r1mkC/BvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuL6ywx79jLC8y9lM8MGSGFvY6M2uRsy5qgqpBvIyBDGlbhiw/V0FSKYNWmWfo4JD+uxQ1r2hgjLDMykOalKfIlfRRgu2yQIKZyreVi+HxgCpSaYHIs6/O5qTYVuHW1wzLyf5I6EP2YBGxEGsXMxgudZmrBmN1TN6JivsH9Osi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3whLhLI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3whLhLI"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b83122f9d78so1154307966b.0
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 17:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767576695; x=1768181495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6l4zXgOEcKxRD0+8QcvuGj5PVzJyWTzavzqrRU45JY=;
        b=M3whLhLI9SJc9jTfrfmLKvHhV0+5XQrzcc+qoMD5V1onnyXGCAU3DW178fV+jd+0QD
         A1rKBECM0mNwHHI07emApGbSpB6RHJCtwLX4nJSx9qzAGnOBbvELDPaYbi81em7IHYwg
         OCzEIQYkIDu7MqvEEpR3fcF7oXxmoaOcwPqiSWyCjCXSZGfAiEKZtVHlcCoP7qu7AqXO
         G/8l3ivAI/uwk37XnxczRC0nczhWwpCF7vxFcB7tXvsVJJDbEdsSM3bsNWlWphl6KF27
         gSLbdjgfuZ6SriKWdzXDaDQeGnzsX3QcKxsDhPELf42u2p26i1hkPUvfYjJ6oLZ6YfsS
         N8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767576695; x=1768181495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6l4zXgOEcKxRD0+8QcvuGj5PVzJyWTzavzqrRU45JY=;
        b=PAKqhea5IvWXPd7ZvA3bA42EDF8hCE0ej0QPLUEzW3Q30DpJVI0BbRT+spzKsEt7ij
         VDa/vQernDRfhzsu2RJTU//Q/typHR6t9UrgXPyshF5+0pLoWo7KOc64ZJqqCVFq7JAi
         lzQ6lV842YniMQo8fHoZUf8ldnxiEw0LbiZlhm9N1I1xAq4E9rXXhSQUFz15KU6QsKCh
         HdvO35/L/8NGmCq7yE8jo6uR3/3vA+9Z+EUbz/HZsU81JuMGG5Ar5y9O+njywe2+kITl
         S65NkbEG22XhnKGrqbmW08XKC+WsHQ6n4eRUE68PWoCjUIiwFJf+813km9jJz76MALDn
         Ef7w==
X-Forwarded-Encrypted: i=1; AJvYcCW/2IJGl7R+3RlTkYmaoySk/rwZocCsS/Hdg3MscYEeMGcIaN9Q0X25WC8JHXRFDwu0yG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPg/CuruV9kYjezr6BV4UqbDWOuSsEq/BNiiKi45+Ve1uMWs5
	OQEKwK9bXGJTVcKnCZkvOMwelKHWTrznzhSUIQipIbKoID3nVKkKeWOiZoJZ9M+od1MSgFBDAAa
	t3L8MYsOsXANe9hjp5+USLKkKIetiF7s=
X-Gm-Gg: AY/fxX6Ir6HK/+boRtJC1xMT7FYtiCG1xHDqBnmIVTpGTtOOZWdaL6nhbwnJmwW3+Ie
	V9opDBKJqxM5F8Aau26UUHHYiQspBKvPmhaeKNPE9PK6OnDg1kmxVbWLKOttQUCi0JChZZ+5w0m
	x4cCFJ0fp2OHvsWkJMf12uVRnWkHSBOV70Z03VOUzhFvBmnsTwzmvGGoYqExQmdyTsiXlUrAu7B
	J+knvBteODOESZ9w0BFkyRO4uvhDtuqux0oYEr0cLy0Q3JS9vBB74fK2mUHG3duDz7+lGU4
X-Google-Smtp-Source: AGHT+IED+3iO0pFnU2HMNvJiyI1riJrzxfuOIsHO1+ROH+7jgrOeOZu1/yyDCYNo0EFMbM9O5Ao0gPGFFbNl2h6fnys=
X-Received: by 2002:a17:906:2082:b0:b80:3fb3:bdf6 with SMTP id
 a640c23a62f3a-b803fb3bf41mr3207739766b.40.1767576695000; Sun, 04 Jan 2026
 17:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104081027.189234-1-dolinux.peng@gmail.com>
 <20260104194534.GA2247470@joelbox2> <3188cbf5bcbe5799c77a6cc870ad0ee85b58d255@linux.dev>
 <CAEXW_YSxHnUxNXNiwBZRiVF9i5OBv7bV73e_k_RFJ3Osnrr18Q@mail.gmail.com>
In-Reply-To: <CAEXW_YSxHnUxNXNiwBZRiVF9i5OBv7bV73e_k_RFJ3Osnrr18Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 5 Jan 2026 09:31:24 +0800
X-Gm-Features: AQt7F2qa-nj9VinLRV1Q8Jh8v1qFFMB7s4fiHYuULJkv3dsPkik_gOYQ-13gD8A
Message-ID: <CAErzpmsNu8NQ73ovB41Cam1_tc4doH52mwnt-Vw01=2K5xjiMw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Align stall warning 'idle=' output with documentation
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Zqiang <qiang.zhang@linux.dev>, Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, rostedt@goodmis.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 8:34=E2=80=AFAM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Sun, Jan 4, 2026 at 7:32=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wro=
te:
> >
> > >
> > > On Sun, Jan 04, 2026 at 04:10:27PM +0800, Donglin Peng wrote:
> > >
> > > >
> > > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > > >
> > > >  The RCU stall warning message includes an "idle=3D" field to indic=
ate
> > > >  the dyntick-idle state of a CPU. According to Documentation/RCU/st=
allwarn.rst,
> > > >  the hexadecimal number before the first '/' represents the low-ord=
er 16
> > > >  bits of the dynticks counter. An even value denotes that the CPU i=
s in
> > > >  dyntick-idle mode, while an odd value indicates otherwise.
> [...]
> > > >  kernel/rcu/tree_stall.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > >  diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > >  index b67532cb8770..d25cc826d77a 100644
> > > >  --- a/kernel/rcu/tree_stall.h
> > > >  +++ b/kernel/rcu/tree_stall.h
> > > >  @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> > > >  rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> > > >  "!."[!delta],
> > > >  ticks_value, ticks_title,
> > > >  - ct_rcu_watching_cpu(cpu) & 0xffff,
> > > >  + (ct_rcu_watching_cpu(cpu) >> ilog2(CT_RCU_WATCHING)) & 0xffff,
> >
> >
> >
> > May be also use CT_RCU_WATCHING_START to
> > replace ilog2(CT_RCU_WATCHING) operations? (I didn't actually test it)

Thank you for the suggestion. I agree that using the CT_RCU_WATCHING_START
macro is cleaner. I will fix it in the next version.

I noted that the CT_RCU_WATCHING_START macro was introduced in
kernel version 6.19-rc1 by commit d1e6d2773898 ("rcu: Add a
small-width RCU watching counter debug option").
Therefore, if this patch needs to be backported to older kernel versions
that lack this macro, using ilog2(CT_RCU_WATCHING) would be the
simpler, more compatible approach.

>
> It should compile down to the same thing, but either is fine with me.
>
> thanks,
>
>  - Joel
