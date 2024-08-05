Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7613EA64;
	Mon,  5 Aug 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868139; cv=none; b=QtHhtrvz6+lGNb0vQ5AlavOv04/HbVSy7xnG00YH11lGnKO4o15fkerYPjHc178Ek4DWTAm3SKYMDUPRcKMFH74tHmELfNOw1x+IvQlUPwnXZP3vgQNsKR5vDCbZXiG8QZ6Xn1kChN9Jd1tbHEFVWZuOvGlqR0xZoSI27peCvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868139; c=relaxed/simple;
	bh=2MUO96snC0kehze5bCKp0JkvmV/H1MvGnp8mPHmGAiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbAUkg1v30SlNCxJFKPTcOaeRlbZF3SMfpzW96A/TqDrmLok0zIqtMJF1QBSxgqMhFGNrd6gdzg6FSuguSfBXTQKSeM6K1/IrV2zQfJp+7Y6UsiLkiBjxsW9vvsW21e29T87/aYvNCm+Comm5WWDxNexI0EWCxu7+bOZxqQkTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDFUOX5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDFUOX5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C29DC32782;
	Mon,  5 Aug 2024 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868138;
	bh=2MUO96snC0kehze5bCKp0JkvmV/H1MvGnp8mPHmGAiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDFUOX5ueN5MXxhCuXCSKKZN2EmVbjnuR4T/bPKzEDT8PuaM24GmAKtFyUAu1r7At
	 hB0zwQE05FfKARiaBNJNOOkoZ+gjR/WmyXaJQN9OqKOriCWmKElyz2PYCrofdUtZqp
	 ndK2lR1EefMAdGqAQKzqsxpaYh4tLG3pXqqUlhzzdA4OxD372mV+VWFIJvmukb+Fom
	 WkHEAOy0MmcmFv0yx3nNEcRycM4cs2iKbO7pMgGLVRGTebDArVSf0jxtzRfMJKA1Q8
	 ZPV23z8PYWXrDiHWyG4xD1vZx5R0Ig+6IVZE1vjQJprsM/EwTZlM0S4itG4RoSZ8dc
	 vkltUEmEoVGtg==
Date: Mon, 5 Aug 2024 16:28:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 12/20] kthread: Implement preferred affinity
Message-ID: <ZrDhp3TLz6Kp93BJ@localhost.localdomain>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-13-frederic@kernel.org>
 <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>

Le Tue, Jul 30, 2024 at 05:49:51PM +0200, Vlastimil Babka a écrit :
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit:
> 
> > +int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
> > +{
> > +	struct kthread *kthread = to_kthread(p);
> > +	cpumask_var_t affinity;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
> > +		WARN_ON(1);
> > +		return -EINVAL;
> > +	}
> > +
> 
> Should we also fail if kthread->preferred_affinity already exist? In
> case somebody calls this twice.

Good point!

> 
> Also for some of the use cases (kswapd, kcompactd) it would make sense
> to be able to add cpus of a node as they are onlined. Which seems we
> didn't do, except some corner case handling in kcompactd, but maybe we
> should? I wonder if the current implementation of onlining a completely
> new node with cpus does the right thing as a result of the individual
> onlining operations, or we end up with being affined to a single cpu (or
> none).
> 
> But that would need some kind of kthread_affine_preferred_update()
> implementation?

So you mean that the "for_each_node_state()" loop in kcompactd doesn't
handle all possible nodes but only those online when it's called? Or
am I confused?

If all users of preferred affinity were to use NUMA nodes, it could be
a good idea to do a flavour of kernel/smpboot.c which would handle
per-node kthreads instead of per-cpu kthreads. I initially thought
about that. It would have handled all the lifecycle of those kthreads,
including creation, against hotplug. Unfortunately RCU doesn't rely on
per-NUMA nodes but rather use its own tree.

If there be more users of real per NUMA nodes kthreads than kswapd and
kcompactd, of course that would be much worth considering.

Thanks.
