Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389D1EA78
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571423; cv=none; b=G+G3Y6Xaok1aDDyoEz2blIDxcSXFSpeY6bRKb394v2p+2n/zD6ZEL5edgVSe2DknUGwb9YsLQ9Dzq/0wd5gYZmDXW22wGIUGVFHVsJc2ym+xZMZg0zit35GqWmKuvTCtxI2FUCAhdkw1JDb9p1KZzbv+s3dz299KEUVqr/6u8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571423; c=relaxed/simple;
	bh=iYDd2CCZaDTI0XXNpct8x2D9YVzhB8lenFO3FnIjIuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0fnr3CkSnviutwtnB1n6nHTWRUxFfMu4EMhSWMI4rWoEmT2+w3ujhpI1qttyMIUtMGq35uW9M1GA2Gej/heN+WRJHG8cQ/3CoCFYbfBOeLkJ9ey5nLrLNLY4jCdu5Cup5eNTDrPJ6aTQFlPMtjWoxXMmbUmBcQJp1c3RGH3DBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qerfqrgy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qerfqrgy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef6c471d5so12905165e9.0
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706571420; x=1707176220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMMfKQ6I26UF15nzzYdczMe2owzvmAj5Hyu6Sc/yk60=;
        b=qerfqrgy0U7c6y4k9AozkJ2OFrvf6icS9h1JvvlCo0G8KIsMWpzQwk9gn1Odqf8h0t
         nvTjMPyw5+Bb0P4zTFlCBmRCgCruklVXcNK5wvCMd0QCrzza1zo4pZwyUqD+/WgyguN1
         k/efaFNxezvtmOjVO2xmvlmszrSGvTvzs4DDw6sAcbX34Kouc13BbG/qV9d3RyfbUF+x
         nLJrisqW4pjapPr3NuxtBt8qlsLKm13+LxwxZFAmzoe+W2iiFhIvlcbuvL5IOjbSlg99
         hgY5zXsFoStp6epVevEVosh/VcNO4P7CqqDMoLyFMORjrUZrtVcGMH3lXxJka/AtfUp2
         1QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571420; x=1707176220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMMfKQ6I26UF15nzzYdczMe2owzvmAj5Hyu6Sc/yk60=;
        b=gmGr4av+9bGwekAvALa0fEc3zNjGVulQkl1mjYcVcmLo3SUmAp7J/KbGXEuZ38ZDuN
         t7L2Vm/0V/l5VAE1I58tYC9DvlUvXRg1negTn9G6WyyXuKPeF68giytMhldfD68G9PuB
         rvLOoJOlABTiCSauJczzWbixAruvyZhH0fQ/DmYfKMrzbSMQA+cleWoPHVFe3odgBuEf
         UGeU6mqGE/hZT8ZWgU+Q0hlKBYGHfd+IqZqSUYixw6rAu7588IvcCtbS8k3XYSnPFow2
         gCz7nS5fxC+jQtWVTfwEpPZEB0g64PSyzvDXL7BJYHmYIetx2zkZhOdp4HunP0usphMz
         MU9g==
X-Gm-Message-State: AOJu0Yze/cHDl/x86AU3kpvBcbFIbYa/cSZvILbW+XCLZuwHulS8OSJf
	tn7Q81+WKhry+aOnJ7d6oG1oJ41aP/LvXExesArxdTYOppui0MRraphh7MiEmLtdOAQaBX62EQQ
	ROAZKDWfpKNengytGi65dPE17jHWebgN38uOQ
X-Google-Smtp-Source: AGHT+IE34Livvi1kq++P3AVLyAv2GVTd+sHd41ine0uFqHQdaQtKBFL2POCkTjNUgdyDKQ1iCP2+Xbyj3ffpmuwJDlY=
X-Received: by 2002:a05:600c:1396:b0:40e:a569:3555 with SMTP id
 u22-20020a05600c139600b0040ea5693555mr6076286wmf.35.1706571419751; Mon, 29
 Jan 2024 15:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636> <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
 <Zbgp_JJvdczGccV3@pavilion.home> <3753c8ea-f408-4e52-bcb8-9586c483f699@joelfernandes.org>
 <Zbgwl9x3wZ3xqtcW@pavilion.home>
In-Reply-To: <Zbgwl9x3wZ3xqtcW@pavilion.home>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 29 Jan 2024 18:36:45 -0500
Message-ID: <CAJWu+opvDMw99oUzkiz8oKktT5pme2+FckA_96wgWoDRGkLb9Q@mail.gmail.com>
Subject: Re: Observation on NOHZ_FULL
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org, 
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:11=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Mon, Jan 29, 2024 at 05:53:50PM -0500, Joel Fernandes a =C3=A9crit :
> >
> >
> > On 1/29/2024 5:43 PM, Frederic Weisbecker wrote:
> > > Le Mon, Jan 29, 2024 at 05:20:23PM -0500, Joel Fernandes a =C3=A9crit=
 :
> > >>> If i do not miss something
> > >>> the NO_HZ_FULL will disable the timer if there is only one task on =
CPU
> > >>> so that running task benefits from not being interrupted thus gets =
more
> > >>> CPU time.
> > >>
> > >> Yes, that's right. I believe it is well known that HPC-type of workl=
oads benefit
> > >> from FULL, however it has led to want to try it out for constrained =
system as
> > >> well where CPU cycles are a premium, especially if the improvement i=
s like what
> > >> the report suggests (give or take the concerns/questions Paul raised=
).
> > >
> > > I'll be unable to suggest anything related to that Bogomips calculati=
on but
> > > I must add something about HPC.
> > >
> > > I have long believed that HPC would benefit from nohz_full but I actu=
ally never
> > > heard of any user of that. The current known users of nohz_full are w=
orkloads
> > > that don't use the kernel once the application is launched and do the=
ir own
> > > stack of, for example, networking, talking directly to the device fro=
m
> > > userspace. Using DPDK for example. These usecases are for extremely l=
ow latency
> > > expectations (a single interrupt can make you lose).
> > >
> > > HPC looks to me different, making use of syscalls and kernel for I/O.=
 Nohz_full
> > > may remove timer IRQs but it adds performance loss on kernel entry, m=
aking it
> > > probably unsuitable there. But I might be wrong.
> > >
> >
> > Thanks for the insights!
> >
> > The kernel entry/exit overhead bit is an interesting point and also tra=
cking
> > state for RCU observation purposes. I wonder how much is the overhead i=
n
> > practical cases and curious to measure (especially the tradeoffs betwee=
n that
> > and the tick). Added note to my list ;)
>
> And here is a summary of the added overhead with nohz_full:
>
> * Use of RCU_NOCB
> * Kernel entry/exit overhead (context_tracking/rcu/vtime)
> * Unbound work reaffine (less distributed across CPUs): workqueues, timer=
s, kthreads...
> * Remote tick every 1Hz on CPU 0 (one day I would love to remove that but=
 that
>   requires too much scheduler knowledge)
>
> The difference should be significantly measureable, even as compared to R=
CU_NOCB
> alone.

Noted, thank you Frederic!
 - Joel

>
> Thanks.
>
> >
> > thanks,
> >
> > - Joel
> >
> >
> >
> > >>
> > >> Thanks,
> > >>
> > >>  - Joel
> > >>
