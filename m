Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341939A04D
	for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295832; cv=pass; b=PIwSyds4wSMnEMIUSGjFY2w8K9g1QCfSFYq5rrJ5VBOOnInbmKTk4RLIYnaWM4yvakpwqACMD1LPwMiqZZ9cRG5MzKVdDhcskO0FTKK58HIyoVdBnZOSA274ymetjtPmuSh7NnZGPnV9Wk/CUx9hDXo4VEl94sdY+/SK0Aut6Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295832; c=relaxed/simple;
	bh=Ux37VI2c1wSwiZ8dHTjel1794F0ZgvKwAVH9rjWnONc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFwnaExflpyD7vqRnGViSsL1rAGJpryoDEP9nmILtD7Gra+Oza++kuyyLqGPkDZkj77ppc0LbhITah8vkOKZ9dEhDICk6yd7fKwZXOcJxHoCkPEjGE1FLjqzo/BOqBJw75DIhdK3xKcwrCIUfXzO5P5BlJXDcA6ErZd3nKDO6Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewphxwql; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewphxwql"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so6275055e9.1
        for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 03:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789295829; cv=none;
        d=google.com; s=arc-20260327;
        b=WuvOvipIFRt5kpfFjyZ3m2LRk/cOM0mGKS+s84OAonbYy6jHl6ZfT67+aH0tQWock8
         n1MOzrbhIC+sdwpbFlmFRPORqYxbPUHUGDXGXV1IEpmeeoaX5mb/URgTwECkSumicaec
         DzfiWPqBcYpjuVuGsYfEz4JrDHR6zyQpthrT9fF69f4t0DYQbQLHfCIvECGL8SbcmTb/
         lJyWIXaQyg/6o9pC8ojhOyqg609iazoBJeKMQIPq3k34RZ72BQyvaHBYE19o0l9tb+Wh
         zT3RAZiztySsIVdg4jwlU5uVct/dvErx+shHKD+hC7p5ONHE8GgMEQbCWeGgNrZQOSH3
         GbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7ARN7xp6ZIy41Zr31Y3kGwxP50Dd95gKJiCWdq2eeg=;
        fh=/nJBNHBx/SmtzuKu3Hc3+I+H2SLmvhN7UvV0wxqiBrI=;
        b=I8aVuE/fN8otc28EuHfs54KMInQiyY5NYINUX/pE5kV8I0iKN6O83tiCWoWZCcuilq
         e2wG/obfSX+V4DHxOUh8bexBgxfmX6oHogUS+XWm90CbMGGegTLXU25FvVMNeyKvs6T/
         Bs4vR4xGNpHnpZlXL4MxEFGYM27KGYMjNZcqpkHaO9KMu1wqghUCc/FFQwsjqVofDBxU
         P15ty8nahKrqS5gSVcMu9molrXv8fM7zh2qR2K2Zn1Fc8tmkY4Y/1bT2L9+jv9hSxplB
         s5iCbYkv1LWQG/1Xj/ot02RiVSV/sLxD+Jzy3RNifbw8SpblVSbiMquXb7hnyUBeotat
         3/yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789295829; x=1789900629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7ARN7xp6ZIy41Zr31Y3kGwxP50Dd95gKJiCWdq2eeg=;
        b=ewphxwqlkp2UOWqCqWuhpy47SGXpSPYEUTta2w6P398+XOGV0Vu8os3BWPvrLuiC3U
         Rue2L7wMZoCI8iZM3b87yqYt4PxtXxAFElV57UZVFCrHwnwUmPYbNTuV4uLDtYGju5yo
         w5bYkDH+FQNs/96MWl2Cf3aMq/K1GUdPk8DgT6ivxzWBw72v7947nLisy9ZF9inrpkpE
         S+8y+vcEY3IQTFZsrsbipPg3M1Ry8EXxSuv0QVuHjAFDX7lEbipXfaesvreFqt5kN7+p
         bFnWFOIxFfsNmI/dqoBOM6pUurz/XQU+J9+VI45tuKxb+yk+XlnOvxGZw0Ft0acYwZ5Q
         tcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295829; x=1789900629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7ARN7xp6ZIy41Zr31Y3kGwxP50Dd95gKJiCWdq2eeg=;
        b=ky2Gg13geuKFt19Te862z47dRUdOCUQL+5Dr/6zRQYH8nt9E4hj3lwHsAm8dmxPlqg
         BonHUq52oSupRau+1+iGmKLXP8lrDsab8oXPZdAI4b2bNcVttkET4glw2tQ17bJe+HLn
         xkgsJEvwdSKylftTns5ciFtq9J9eaOSiWsVWG2LjE4dWKH3Z2lP+okLZhVFzJnipr+02
         SuCvBfSFNKbkegAyFb1yP0nTsU4Kv7AdzKctCMw2IxnwqPo4NbXAfGrYVPEP8ows71dy
         ZRiG4uNRCDRF6lvHGqD+GfaEOaMVGWml9k04iMV54/6h4PgYwzteFZR4+dCt7+pOBWao
         WvUw==
X-Forwarded-Encrypted: i=1; AKwUvBwk20Info6k81bEAReOl5BsAymU7ODlCYtHnPwtqtTt5el2LccRhz3xSo2UgSWtvdAL9NA=@vger.kernel.org
X-Gm-Message-State: AFuF++kGySlk/lb67QrGLs92458MgcCog7+iqM56665KfDakBm8D369p
	qCfjWLrtXaspt5hNGl1/LlmRTAIMeYwVmMhVz8Qep1YNN/SvjOc1DXTZDvgVMBayms15kTSxvg2
	pAV4qsJp7QIEd/u/A2CvqCZ8EAGEI+QE=
X-Gm-Gg: AYBFou1wM3GJ4RmpCAqU9WGtdlKuiBc/bLCzwEKhwAdSyXmqpcDnHUJnfx2guz6VjEG
	U0tr+gOW5wNEmupGlpaNcNPAB+faVML2jcDt3F/OIZopGfWIoITw9JYp9/4bB4TvXCzHX+WZtKL
	cf3rgDuM1ocJ2NX9eOMSlnfskMLFevGeOiq1yWOTrE7Y/tuX64F+LoHpc8VpeGqgkkqERixaJMA
	MJyjUj6FZzrvfmwEZBmFxW5B37IToP+Dsar3H1UE5SAWcVgxiDszU7syR7hFHx9orC53p5byADn
	hpXPB8qxiclb8VQJQtFUmC1Zfou21C5CaR4nXlC8uiSqtit54RoY0d+UGOKsCcZ5225Z8xbDubY
	WNBecK8KSW3HIkXUo9XvHATrO
X-Received: by 2002:a05:600c:630d:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49e75fbfce0mr19008255e9.0.1789295829093; Sun, 13 Sep 2026
 03:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop> <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop> <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
In-Reply-To: <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sun, 13 Sep 2026 18:36:56 +0800
X-Gm-Features: AcwNN1Xcymg8ur4V1pWxX4_V1hiMPq5gnVXccuzkPn0_fSw8O-LpBGdDkj6GCEI
Message-ID: <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 2:21=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> >
> > >
> > > On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> > >
> > >  On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > >  > Add the lockdep annotation, same-type SRCU nesting warning, and
> > >  > early-boot check used by __synchronize_srcu().
> > >  >
> > >  > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > >  > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > >  Queued for review and testing, thank you both!
> > >
> > >  Interestingly enough, it is now the case that there is a grace-perio=
d
> > >  wait that can be placed in a normal RCU read-side critical section.
> > >  Does this mean that we should also adjust the --do-srcu-lockdep test=
ing
> > >  in tools/testing/selftests/rcutorture/bin/torture.sh?
> > >
> > >  Thanks, Paul. Good point.
> > >
> > >  I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, includi=
ng the
> > >  case where `synchronize_srcu_atomic()` is called from a normal RCU
> > >  read-side critical section, and follow up with the necessary torture
> > >  testing changes.
> > >
> > Sounds good!
> >
> > Perhaps you and Zqiang can work together on this. Co-developed-by,
> > for example.
>
> Hi, Paul and KunWu

Hi Zqiang,

Thanks for pointing out these cases.

>
> Should we also consider the following situations ?
>
>
> idx =3D srcu_read_lock_atomic(srcu)
>
> by interrupt run hardirq context:
>    synchronize_rcu_atomic(srcu)
>
> srcu_read_unlock_atomic(srcu, idx)

For the same-CPU interrupt case, the existing check in
synchronize_srcu_atomic() already catches it:

    synchronize_srcu_atomic(ssp)
      RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
        "Illegal synchronize_srcu_atomic() in same-type SRCU ...");

lockdep_is_held() resolves to __lock_is_held() (lockdep.c:5612),
which checks current->held_locks[]. The interrupt handler runs with
the same current, so it sees the SRCU dep_map acquired by
srcu_read_lock_atomic().

>
>
> or:
>
>
>
>            CPU0:                                                         =
         CPU1:
>
> idx =3D srcu_read_lock_atomic(srcu)
>
> smp_call_function_single(CPU1, som_func, NULL, 1)
> to send IPI to CPU1, and sync wait complete.
>                                                                    hardir=
q context or ide task context:
>
>                                                                          =
 some_func()
>                                                                          =
 ->synchronize_rcu_atomic(srcu)
>
> srcu_read_unlock_atomic(srcu, idx)

The cross-CPU case is different. current->held_locks[] is part of
struct task_struct (sched.h:1302), so the existing
__lock_is_held() check can only see the current task's held locks.
It cannot see the SRCU read-side lock held by the task running on
another CPU. The same limitation applies to the
lock_is_held(&rcu_lock_map) check in synchronize_srcu() at
srcutree.c:1665.

>
>
> Add WARN_ON(irqs_disabled()) to synchronize_rcu_atomic() ?
>
> Any thoughts?

WARN_ON(irqs_disabled()) wouldn't help with the cross-CPU case:
CPU1 could be running in process context with interrupts enabled, so
the WARN would not trigger. It would also add a false positive for
legitimate hardirq calls. synchronize_srcu_atomic() omits
might_sleep() (compare __synchronize_srcu() at srcutree.c:1676)
because it is designed to work in contexts where sleeping is not
allowed, including hardirq context.

Whether a general cross-CPU read-side-hold check is feasible is an
open question. It would need to account for the read-side state across
CPUs without adding too much overhead to the SRCU read-side fast path.

I'm happy to discuss and explore whether there is a reasonable way to
handle this cross-CPU case.

Thanks,
Kunwu

>
> Thanks
> Zqiang
>
>
> >
> >  Thanx, Paul
> >
> > >
> > > Thanks,
> > >  Kunwu
> > >
> > >
> > >  Thanx, Paul
> > >
> > >  > ---
> > >  > kernel/rcu/srcutree.c | 8 ++++++++
> > >  > 1 file changed, 8 insertions(+)
> > >  >
> > >  > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >  > index 6a9c432a3bd0..6c729e805fb3 100644
> > >  > --- a/kernel/rcu/srcutree.c
> > >  > +++ b/kernel/rcu/srcutree.c
> > >  > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_st=
ruct *ssp)
> > >  > unsigned long rdm0, rdm1;
> > >  > unsigned long unlocks0, unlocks1;
> > >  >
> > >  > + srcu_lock_sync(&ssp->dep_map);
> > >  > +
> > >  > + RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > >  > + "Illegal synchronize_srcu_atomic() in same-type SRCU read-side c=
ritical section");
> > >  > +
> > >  > + if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> > >  > + return;
> > >  > +
> > >  > // Initialize. Either init_srcu_struct() was invoked or
> > >  > // DEFINE_SRCU() or similar was used. Therefore, no allocation
> > >  > // will be done here.
> > >  > --
> > >  > 2.43.0
> > >  >
> > >
> >
