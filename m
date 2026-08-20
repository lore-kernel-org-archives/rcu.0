Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7237C90E
	for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245245; cv=none; b=lJrvFqwG88YdPKHnv0miMmz36G+/OVIYQ/akqa83n1FvMEhNGkNo4PUIcqVezp6hI8qQ6Vun0+8pLeFWMWJthyRE0+8XHwYDZKJloRmckQ5EtL+ggnAK7vsJOCl4JQDoaUTTTtssgM2JYzJxCDnRaIUBtMO4G2IxoTl68MDfxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245245; c=relaxed/simple;
	bh=d73/65O3EJddd94Ftz8cuWaU8eHaHvSROcHFwtE9Hgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGUwYAVNIxInjfQyKc4dy7Ox/TCD/arN2WBXUIn4XBeQTku+iZVDPS390wm8l5DBvm/53qqBpAUPkXIA0f87294NnLcZkC9HsUeoqIM/qfG5zB8m4hRzNC9PzLwNwDMPzHS0UOz/UBgvRceM0x6erfxUArmNj3m5caUlvWJCDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jj2oXFg+; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jj2oXFg+"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EB18180205;
	Thu, 20 Aug 2026 17:00:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 6426620025;
	Thu, 20 Aug 2026 17:00:31 +0000 (UTC)
Date: Thu, 20 Aug 2026 13:00:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Lai Jiangshan <jiangshanlai@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
 <josh@joshtriplett.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260820130028.2243d53c@fedora>
In-Reply-To: <20260820135500.hXUAsbHR@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
	<aob12RahomSmpUQY@localhost.localdomain>
	<20260820135500.hXUAsbHR@linutronix.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x3tiiugppggnx6wiqjuqr5h8oao16osf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6426620025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cYqxSlDBmypQWZzLVcosmGzgtLlKeV9Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FbDr8IlhceKKRQEH2RbCZ5jCU04Uji7h/bs380CjYLg=; b=jj2oXFg+NBbbqf4HDPMcFit4Knn+DRcam6pz3XuZzzshOQwItmRRGhvuzWZKn/axgE92elBEhf+OSzQdjnTT07PZSM2KpZYXySbIdULocWru5MRkobtj05sMIxlYFur3G+6m8dHE6UxdNDXzepmjehxsClMVv1us6um/5nutvcA=
X-HE-Tag: 1787245231-857373
X-HE-Meta: U2FsdGVkX19DDQutVmD+VA+U3XpEOOiyVS/hUGjYTgfoSQIG7LOvSq86GPbOq9YlI3qOfyUXKamsIaCj3TMEgBKW8QU2gjh6L+6BYbRWI2x99eUtR1wtJAa2C9e3VaugFz3KmiqiiUk3jQwcS0GF6xxpJ+OWe4jCeuCluXSB85Iqoe+4/+twiqOBjCNpHEyLwk4pyWOoicp8NoxtFEccsa6aa5pR47BDuK4OZwhCWP/yMIMVvjeLeB+eu4m6Rhupn1T1zLK5jyXCa4UwlhSvVnwJyEnba901zOsg3eku+bxW3X/T6tFFoDvSi1J2lMJ9U/GYWGh2tvh14FzAgRHguRQQ2tVo8A968J3J2fLmRoGINmK11V3OCshNpgHeS7Rc

On Thu, 20 Aug 2026 15:55:00 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 7c2f7cc131f7a..b703233d4a63f 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> > >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > > +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);  
> > 
> > It may need a comment to not lose that.  

I agree a comment would be useful here.

> 
> We could also make irq_work.o earlier in the Makefile, right at the top
> so it comes before tracing. This was one of the first ideas and makes
> the issue also go away. But given that it is just a wake we avoid waking
> the irq_work/ thread just to schedule a timer/ wake workqueue.

That doesn't sound as robust as this solution. Updating Makefile order
is a fragile solution.

Anyway for this patch,

Reviewed-by: Steven Rostedt <rostedt@goodmis.org.

-- Steve

