Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D42FDC39;
	Wed, 12 Nov 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938897; cv=none; b=Alp9qk4OVDxoLuWi1hGMt8SjPcPdMvo3lBzKKrdYXL3Ase976lngL+bLfP9X9T8Upmr7ggRgbiGmq9W8D8ocehShJMbfIBw+t1Ik8ynYkLxGXxc7+F1ofEXu340oGOJ7XyK4zDVBI8eM/P7pdH50DE7lMJVJ0PqlZQvP1OzZAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938897; c=relaxed/simple;
	bh=QY+zoPIzfN+9Mk0hdDsedrt2YaoAkOT5enJe1rRyuqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgYdCd/0costkznweUPhm8Oxp+YlrQOOIwW1KbY/usHa7LrbjB4QIwxjTaWr9wtdFVYX+aXMeFyAePhKzltiNONw6j3YeYGsgrh/Ubgub3HW93PnFqvDBw8nZcP7R2ZHCOq8OYvWFUgfYQVyhMeNXxrt4EGod3peADHxrl9HW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9bOiefS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/O49MV5t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9bOiefS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/O49MV5t"
Date: Wed, 12 Nov 2025 10:14:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762938893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhZRAnq4lnNoniksK8u0xcraeNpF8Oa9Ou4T/tMR40Q=;
	b=Q9bOiefSwa6FUZBMUV+oVky89QENlG0JsFoowTdc/56OnjHALyreXUgPzahgl7f7SxYdbl
	6G0k0Lft8BZbwxr/alxiOMTgBm8q8s3My1b0Ir2rJj2DqHBxxGJSb7wQ1cTrjbUtxAU/oE
	5D/IACrWzEAec5Vud8fCgwKnHEw/mT/rVPvi3BazNZ7G2cJvHB+w6BMI7GTZq80eLL9pmH
	bBvi5fyZEExu1WF+8BV4J/F1ULIupZOawGZzRLWyUkIRichymmi0MYhCMu9xm0UcYWvoIH
	aRwfniqQ74VtSqJs3WHU23Ghe3lxw2+wwNhUScZ1ms3mRYKCRCo/f2uOxbsNfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762938893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhZRAnq4lnNoniksK8u0xcraeNpF8Oa9Ou4T/tMR40Q=;
	b=/O49MV5t/XuCqSI/SzJ8R/mLK5Ub0bCJ99Zk/AZtCN+DmFiIZE49SvJBCyfdlDWRqJBY57
	Iyg0DfrRb7clpkAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 3/8] refscale: Add local_bh_disable() readers
Message-ID: <20251112091452.AxsV206Y@linutronix.de>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <20251102224948.3906224-3-paulmck@kernel.org>
 <20251111153803.5_08_ro2@linutronix.de>
 <5b1fa8a6-0f47-4ab8-af7a-74916bc520e2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b1fa8a6-0f47-4ab8-af7a-74916bc520e2@paulmck-laptop>

On 2025-11-11 11:21:04 [-0800], Paul E. McKenney wrote:
> On Tue, Nov 11, 2025 at 04:38:03PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-02 14:49:43 [-0800], Paul E. McKenney wrote:
> > > --- a/kernel/rcu/refscale.c
> > > +++ b/kernel/rcu/refscale.c
> > > @@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
> > >  	.name		= "jiffies"
> > >  };
> > >  
> > > +static void ref_bh_section(const int nloops)
> > > +{
> > > +	int i;
> > > +
> > > +	preempt_disable();
> > > +	for (i = nloops; i >= 0; i--) {
> > > +		local_bh_disable();
> > 
> > This (preempt off followed by bh off) may cause warnings. That would be
> > bh is disabled on the CPU, it gets preempted by _this_ which disables
> > first preemption and then bh. 
> > I hid the code under CONFIG_PREEMPT_RT_NEEDS_BH_LOCK so it shouldn't be
> > a problem in the long term I think. So just if you see a warning here
> > under RT you know why :)
> 
> Huh.  Would migrate_disable() be appropriate?  Or I suppose I could just
> let it migrate on RT.  So how about the fix shown below?

Depends on what you want to achieve. Even with that bh-disable you can
be preempted but you can't migrate to another CPU.
That preempt-disable() will keep the RCU read section open during
bh-disable/ enable but migrate_disable() won't. But this not something I
need to explain to you ;) 
If that (to be within a RCU read section) is you intention you could
explicitly add a rcu_read_lock() there.
The change you suggested won't have the problem I mentioned.

> 							Thanx, Paul

Sebastian
