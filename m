Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EF3C585C
	for <rcu@vger.kernel.org>; Fri, 21 Aug 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306680; cv=none; b=CfoMJu2+lKQKypyJjalGURUOCgj4m4C9JfVHx4bVCeKGVLwJnfrUa+ByTDUzRx6yP3Q/iMRSJ+xq8zxwp73oX+XDy5iCYNA4rodTNLEEPNeIpI3P1z93pm5CZ/IPdmdbtX2sW3/vM1i1XpmiV8N9AloBtr8KwBo1bL6wZE2Uxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306680; c=relaxed/simple;
	bh=kkxhoeuSQrdocKzl93FFa+ugRDGQ/EaEtjBmFRHdW5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnaE0TM2PdHbwzMwqeu9+IQXu0MJhkv3DVffe7zuLHOkzrWaqcOmClxKRquetpkOc0M5cVKaoLdDED7xfLIStyXlAyl/F2jt043AktclV/PkZHtJc+ecS1UBfYGKeU/+22o4p7M8gs/QK73rGoM6wgp7aak6evL4bQZeXpkZBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oruSBcaB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7RWUWhpr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oruSBcaB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7RWUWhpr"
Date: Fri, 21 Aug 2026 12:04:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787306673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQVdqZ9m+PnZbKagL7wDDN6cHVS1zQhiwYWgwMp93TA=;
	b=oruSBcaB44QORb+ri7cBoSFPzY5TrZgKEFbpbawIQxZotMrsQnG0p4gNo2OjsR+exXzBLu
	2GINKWRSPgjuOsbdXBNCzeaN8kYaneL0XDVZXPhgNCjeYVu1fNmv6yeDTq0QKkehVKodRx
	6fSpODW53yyWTc6emQUnQmZec4NM32ggcFNDbFj099bSklhIXI8RqQKogZfOa/sChE/drf
	rfKVnYyRLDjiUCaW+DnA75iInNYf4bioj41YG4RX8BkngHS//fseHK1u9OUBQt+qRf8ruD
	Gx+hFlfZLEu5tgeTaHp7PAu4rCHOep5AvcraqVdLws9I5a0K3MWzDn9nEcx1yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787306673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQVdqZ9m+PnZbKagL7wDDN6cHVS1zQhiwYWgwMp93TA=;
	b=7RWUWhprTyJgCYqcTeUppziT0RnJjVdXf7t/Ks+lD4OIHbBPh7KMBcDJIZY8ZDIouSOhWv
	C4z2yyTsJY0jCmAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260821100431.jvWas8Wc@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
 <aob12RahomSmpUQY@localhost.localdomain>
 <20260820135500.hXUAsbHR@linutronix.de>
 <20260820130028.2243d53c@fedora>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820130028.2243d53c@fedora>

On 2026-08-20 13:00:28 [-0400], Steven Rostedt wrote:
> On Thu, 20 Aug 2026 15:55:00 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 7c2f7cc131f7a..b703233d4a63f 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > > >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> > > >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > > >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > > -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > > > +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);  
> > > 
> > > It may need a comment to not lose that.  
> 
> I agree a comment would be useful here.
Urgh.

> > We could also make irq_work.o earlier in the Makefile, right at the top
> > so it comes before tracing. This was one of the first ideas and makes
> > the issue also go away. But given that it is just a wake we avoid waking
> > the irq_work/ thread just to schedule a timer/ wake workqueue.
> 
> That doesn't sound as robust as this solution. Updating Makefile order
> is a fragile solution.

This is the way how ordering in initcall works. Both are early_initcall
so if you don't tweak the makefile for ordering you would have to
introduce a level before early.

> Anyway for this patch,
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org.
> 
> -- Steve

Sebastian
