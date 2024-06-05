Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86B2E3FE;
	Wed,  5 Jun 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610545; cv=none; b=nayqmzWzithe4rSuVLph3QKYfgzJQ/gQC4w7eGB1WuXDzb2H11AwobVrrbAQeCKCshDbTLv+Kcmbb1Hr/JOIzqkW5asstzgsaYwlTwUiMPxZGTn1eT9sBs7dc4xeTjc8wAZc85ufcknnsQFLLPB59wDbBYwVdisRVf3TEc9nmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610545; c=relaxed/simple;
	bh=Zk9QKYEwZkkHtEEFpKV+IP3hrfb4VZMRuIpGpAa5ek0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWkMtdaNG0sveQtlWPHllKeshcqOylteanTn0hsGQaIfwCDRqXTow05MWhJJ1gJFlSuu+Kl0ORFiBopEll7fG+loOt41E/bC+ZshKSqHP9Fi/objT2Ee+XgcF0S43DKQW5//nzAr5YokNyoXkPW8u3ejPMf4AmRG/6esDXZ6f5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2FCUM3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2FCUM3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F80C2BD11;
	Wed,  5 Jun 2024 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610544;
	bh=Zk9QKYEwZkkHtEEFpKV+IP3hrfb4VZMRuIpGpAa5ek0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=k2FCUM3jalLFrx4q1Dz4Y71KSsrp27/0f/AUvryeI7Y2fZ7VXpaxfprSz6/Nm1wzZ
	 Fgpg7W7DShjGOBtmuKFUWYE38fL218nUc9wmHx3JXIWLOBEjNRpOECz1LtJopr+vFp
	 3fN29SczD+nJ+ucuneXxYdQKJGRAy+h16Lf2Z2UdQz5riS3q3eooxlMSQ0f6/ySgUR
	 S/+vLkWftdUptaZWO2Mfy6K/1sMeLLSDJsV/jbX6EMJ1fg2rOtvcEiWZozDvgg57zu
	 YM7bvVsIzL0XcONWffVdY02teFfz78ZIO64fNY2sAyjSRwlQ3N6BKbm+qSdx/BH0q+
	 JJqA/DcPw4DBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56D38CE0A72; Wed,  5 Jun 2024 11:02:24 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:02:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH rcu 2/4] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
Message-ID: <35f27cc8-85b5-4b30-8f7e-cbd29d3adb48@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
 <20240604223633.2371664-2-paulmck@kernel.org>
 <CANpmjNOLuAZfjiNZqZ8zUrziOUiXw-7zOxRpOrwqYP_rgrEgJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOLuAZfjiNZqZ8zUrziOUiXw-7zOxRpOrwqYP_rgrEgJw@mail.gmail.com>

On Wed, Jun 05, 2024 at 09:56:41AM +0200, Marco Elver wrote:
> On Wed, 5 Jun 2024 at 00:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On powerpc systems, spinlock acquisition does not order prior stores
> > against later loads.  This means that this statement:
> >
> >         rfcp->rfc_next = NULL;
> >
> > Can be reordered to follow this statement:
> >
> >         WRITE_ONCE(*rfcpp, rfcp);
> >
> > Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
> > this statement:
> >
> >         rfcpn = READ_ONCE(rfcp->rfc_next)
> >
> > KCSAN located this data race, which represents a real failure on powerpc.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: <kasan-dev@googlegroups.com>
> 
> Nice find - was this found by KCSAN's weak memory modeling, i.e. the
> report showed you that a reordered access resulted in a data race?

If I remember correctly, yes.

Even on x86, the compiler is free to reorder that WRITE_ONCE() with
unmarked accesses, so one can argue that this bug is not specific
to powerpc.

> Acked-by: Marco Elver <elver@google.com>

I will apply on my next rebase, thank you!

							Thanx, Paul

> > ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 44cc455e1b615..cafe047d046e8 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2630,7 +2630,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
> >         spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
> >         rfcpp = rfp->rcu_fwd_cb_tail;
> >         rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
> > -       WRITE_ONCE(*rfcpp, rfcp);
> > +       smp_store_release(rfcpp, rfcp);
> >         WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
> >         i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
> >         if (i >= ARRAY_SIZE(rfp->n_launders_hist))
> > --
> > 2.40.1
> >
