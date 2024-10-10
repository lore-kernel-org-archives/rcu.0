Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8A15E81
	for <rcu@vger.kernel.org>; Thu, 10 Oct 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520079; cv=none; b=G7Wi85us6zdZ6S49Q9YehYxOVf1x1t5jdvZ/x3rhG709tszhg8lIBnlG5FwedzvP+bFHVtaT1g1Re35uotuXLBDOr7WNYhv94nAiHNu9S1dk5iaLIcu77imc0NRpZXHOtatYCdcgaJRD8FT+/movEJip6PpohlALUvMWKVAP8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520079; c=relaxed/simple;
	bh=YDlMNjPq13XEcf5/f1zerRs3yGSjooeeUIzeM9qKR8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOHe3QGU2Vnx9j8egTHS0JK32pV3fqF93ZkxOe4xbivMP0QrslLCa5kE3Dk4nzeTMRcZYCF76DbKi8fwUJJw9tC4wcFGFHsF8lq0kMA10J68fVHyvGFjQUZITEv4BfBalEOxmlZwqXS82r0efNxrQVbKIeB5X6bx9DGzsjgkp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Rm26wj6y; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Rm26wj6y"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e290bf7adaaso342331276.1
        for <rcu@vger.kernel.org>; Wed, 09 Oct 2024 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728520076; x=1729124876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1+R02hpp8av9d1oke/1LYEST5x37dCj6t6Jn67ICpI=;
        b=Rm26wj6y69YdTqyPGcvFAzAZ69CPFadcI29Pu0cP+s3JzbfT0VMrKspEONYlqEv54w
         mZHdqH06D55pQGA5vfKi3N3kxOYLesZIiwmLpcuFX868x2Ar4hByM54ar1nsFIMllAbt
         zrYVrPoFAyQzR3rRB+ASv6kWuyB3OGXXy89zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728520076; x=1729124876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1+R02hpp8av9d1oke/1LYEST5x37dCj6t6Jn67ICpI=;
        b=VVW9kneNlMbga2PrpMZ9n2javf5wI8A0g1G0CBY5DrmMUNr41P+cxjFnpCi2rcA44U
         euLCOn+stZ3OOv7ycOAKZMwCPr0NQwVSnMVYOWtQhoxzRo21BqH9ZpKrjrTxvHMnrcEN
         Y5N/eMtAaz0TANg7gJfVnnHjwHCT2Tql6VazNwGsvnU9euzLtGekrGAzKnjh+DQz/Isx
         EMpuSUjbfUSgyRjoN005bp0d8k25E5F29D0TSQIY2B5uub42MrCXoyKe4COLCEUEChkJ
         7wiyD1/WQdiGFKwSreGu6SQEYMQWQuX8+rP9M/j7XpPE6RteM0CjhHx+YsfRznT1P8tk
         5OyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVl91Pa4KMV/55pBqedLw6KP/yyKW98weLbbthNCg4y0Dn5OQ/G1JPfyIgxHze6JGag0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKPpBQ1pXCfx4LolezhYvg51qoLRSq3dJ1uj/5zm5xTt4q+ZY
	di6VG1BufeHVUi3fy7/T5GlCCjlgre0dztawZbaYI5OKEuah22QNubWixOTU1URzQdQlHXt+t3M
	9W2Eve3KR/9XyTEB0w+g/00KQ0e4QIIxNczcFKQ==
X-Google-Smtp-Source: AGHT+IGSNIugRxV69BySb8PbtBCi38kFwqNESAtJ/YVFwaB3zOzNyFyMy0VDrtuxzYyQCslrOOZ5ho65fIQkyHk0TbY=
X-Received: by 2002:a05:6902:15c6:b0:e20:268b:8ad3 with SMTP id
 3f1490d57ef6-e28fe4e7431mr4112233276.38.1728520076560; Wed, 09 Oct 2024
 17:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002145738.38226-1-frederic@kernel.org> <20241002145738.38226-3-frederic@kernel.org>
 <CAEXW_YQSBwGME1+vKHSM8+svtosunk-QO2oMygFKgapPE3b45w@mail.gmail.com> <ZwbuDj_tjpWzQDhL@pavilion.home>
In-Reply-To: <ZwbuDj_tjpWzQDhL@pavilion.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 9 Oct 2024 20:27:42 -0400
Message-ID: <CAEXW_YSK1ju5u7r1xwaGPivoPhcBJ7THaqGuurCzrLf7sDTWBw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rcu/nocb: Fix rcuog wake-up from offline softirq
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:56=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
[...]
> > >         ? tick_handle_periodic
> > >         sysvec_apic_timer_interrupt
> > >         </IRQ>
> > >
> > > The periodic tick must be shutdown when the CPU is offline, just like=
 is
> > > done for oneshot tick. This must be fixed but this is not enough:
> > > softirqs can happen on any hardirq tail and reproduce the above scena=
rio.
> > >
> > > Fix this with introducing a special deferred rcuog wake up mode when =
the
> > > CPU is offline. This deferred wake up doesn't arm any timer and simpl=
y
> > > wait for rcu_report_cpu_dead() to be called in order to flush any
> > > pending rcuog wake up.
> > [...]
> > > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > > index a9a811d9d7a3..7ed060edd12b 100644
> > > --- a/kernel/rcu/tree.h
> > > +++ b/kernel/rcu/tree.h
> > > @@ -290,6 +290,7 @@ struct rcu_data {
> > >  #define RCU_NOCB_WAKE_LAZY     2
> > >  #define RCU_NOCB_WAKE          3
> > >  #define RCU_NOCB_WAKE_FORCE    4
> > > +#define RCU_NOCB_WAKE_OFFLINE   5
> > >
> > >  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> > >                                         /* For jiffies_till_first_fqs=
 and */
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 2fb803f863da..8648233e1717 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -295,6 +295,8 @@ static void wake_nocb_gp_defer(struct rcu_data *r=
dp, int waketype,
> > >         case RCU_NOCB_WAKE_FORCE:
> > >                 if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
> > >                         mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
> > > +               fallthrough;
> > > +       case RCU_NOCB_WAKE_OFFLINE:
> > >                 if (rdp_gp->nocb_defer_wakeup < waketype)
> > >                         WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketyp=
e);
> > >                 break;
> > > @@ -562,8 +564,16 @@ static void __call_rcu_nocb_wake(struct rcu_data=
 *rdp, bool was_alldone,
> > >         lazy_len =3D READ_ONCE(rdp->lazy_len);
> > >         if (was_alldone) {
> > >                 rdp->qlen_last_fqs_check =3D len;
> > > -               // Only lazy CBs in bypass list
> > > -               if (lazy_len && bypass_len =3D=3D lazy_len) {
> > > +               if (cpu_is_offline(rdp->cpu)) {
> > > +                       /*
> > > +                        * Offline CPUs can't call swake_up_one_onlin=
e() from IRQs. Rely
> > > +                        * on the final deferred wake-up rcutree_repo=
rt_cpu_dead()
> > > +                        */
> > > +                       rcu_nocb_unlock(rdp);
> > > +                       wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_OFFLINE=
,
> > > +                                          TPS("WakeEmptyIsDeferredOf=
fline"));
> > > +               } else if (lazy_len && bypass_len =3D=3D lazy_len) {
> >
> > Since the call stack is when softirqs are disabled,  would an
> > alternative fix be (pseudocode):
> >
> > Change the following in the "if (was_alldone)" block:
> >
> >                if (!irqs_disabled_flags(flags)) {
> >
> > to:
> >                if (!irqs_disabled_flags(flags) && !in_softirq())
> >
> > ?
> >
> > That way perhaps an additional RCU_NOCB flag is not needed.
> >
> > Or does that not work for some reason?
>
> It works but this forces the wake-up through the timer when a callback is
> enqueued from softirqs. And waking up from the timer is a bit more overhe=
ad
> and also added GP delay. It could be this though:
>
>     if (!irqs_disabled_flags(flags) && cpu_online(smp_processor_id()))
>

This makes sense to me and also will future-proof this code path from
potential users who end up here. I think it will work.

Feel free to add to this and the next patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
