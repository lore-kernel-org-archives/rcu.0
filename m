Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8942E42A
	for <rcu@vger.kernel.org>; Fri, 21 Aug 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330663; cv=none; b=huYi3Sm9Sxs+m+YYoXXGIxGXbmueHlTcmKrnmiatQ/BBCvOfa76z61bLtu8jb1VbwBRr4xIKjq1Lz4KTxKfZGvLqS/gREb8e6b3osclcTblvnbwawuAvBQQseIYiqZM0A/mYOd8qmcT3EepcWx/fmQOVnuw1jjfUbFNuvCJf5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330663; c=relaxed/simple;
	bh=0xtK+TmNvOaIdV6jXOPZYGP1+lklmjT6F6aInixrRbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8MPbJOcsm6puYxd2acKiSbsFT1TpSGqk5ZnPE93nU3NVBhuz0H1SsZQ6aLa2BeaaVV0JekEhwqvfS5jGpzxO98o7lEGjjDFWfIldvOPne/zdIb5duDvflY87fz12suEh2gaGga73qaaTqawcNG3O80wzmt1kbkaJ/QOydPa3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=rPNa3BUf; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="rPNa3BUf"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A5FED1C09CE;
	Fri, 21 Aug 2026 16:44:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 80FB817;
	Fri, 21 Aug 2026 16:44:14 +0000 (UTC)
Date: Fri, 21 Aug 2026 12:44:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Lai Jiangshan <jiangshanlai@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
 <josh@joshtriplett.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260821124412.3b2e49c2@fedora>
In-Reply-To: <20260821110108.kAu0wszk@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
	<aob12RahomSmpUQY@localhost.localdomain>
	<20260820135500.hXUAsbHR@linutronix.de>
	<20260820130028.2243d53c@fedora>
	<20260821100431.jvWas8Wc@linutronix.de>
	<20260821110108.kAu0wszk@linutronix.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 80FB817
X-Stat-Signature: cyeseiai6qhd4krpiy14rgirx5r18dsf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+1M+7kY4OcA2vrIMtjtrx7OoE5i36rK6c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kn93FLurHttlnRRgXzhSJoMOWAdNKw1l72AUTr8Rcxo=; b=rPNa3BUfrxuZ4LH3MO0mO8fxUudvQljEt1Va6/3Y+otbFuH+zV4c3fYDh115Zy3OmbEkhw2VqRvJM97Y5jcp08Q3RlmgHa8BSJ1RoVxbeQoIRgkl8AXONojqSaoiPXBXgA3XHU9WuWcPq0U4e7tZlLWvdzesHvMTbf92oxBavcI=
X-HE-Tag: 1787330654-772401
X-HE-Meta: U2FsdGVkX19zixgdhpWOKqoWC/hebcTrSbreZBKSS6jFFsz5chRt0qnTglnfj+0Gabik0sf2yzxQTCRka8dTHH2gxkyopGbkovtbBsE2C/OY8n4c+fNPq0KzDOHe80AxRt7/IpHoKKhcG6kZtDPDC37TXBNNHuFjgYd0DIM/x3IWrANkIY9b8RlyhH1RUeQoxQIq/22rqAMJ/WShSHFdXNNDcOZAQa8RiqyFP4eVHPrTiB7tV82tFJgMJEvgwK9XNav6C8q9iPasAre9zSpzD+dOclSurOSOnkgSV5bSijWF2UCl7jTzc1XPCifGRO3m

On Fri, 21 Aug 2026 13:01:08 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > > > > > +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);    
> > > > > 
> > > > > It may need a comment to not lose that.    
> > > 
> > > I agree a comment would be useful here.  
> > Urgh.  
> 
> What do you want me to cover in the comment? The arguing pro
> IRQ_WORK_INIT_HARD is because it is "just" a workqueue schedule and it
> avoids the jump over irq_work/ thread. This makes sense regardless of
> the tracing issue.
> If it would be not compatible with hard-irq context I would argue for
> the makefile change which is still sane since there is no other way to
> express dependencies (which we clearly have here).

Basically just a word to why it is HARD.

 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
-	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
+	/*
+	 * trace events started on the command line require SRCU before
+	 * the irq_work kthread starts. Since all it does is a simple
+	 * wakeup, having it as a hard irq, even on PREEMPT_RT is fine.
+	 */
+	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);
 	ssp->srcu_sup->sda_is_static = is_static;

-- Steve
