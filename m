Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884A15C128;
	Mon,  5 Aug 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875030; cv=none; b=HLKAeP9VAsAk/48cyhqp2y5xN9V+fVDpETW4RSRnh4r6OPZTpL1fAhv+RfApb/R1EJgbm2/TM1pbzso6IbBUyHKu+S6+ENl1yE1Q0n/yGcR2ikTmIJ74PL3JWaq8M1qBFBUp39xpZwBHq4y5C/g0zXoJc0QUd6kCKApTX410qvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875030; c=relaxed/simple;
	bh=vQwii10q1YmYVa9isa85ZRO5B5Git5ym+CsLyg9wPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6ENXg5lP/HJ1Sday+otJxdfWcF4XWE5Rvr5kV2i5T0eZiGANoXMMhaSUiBmfUvfohYWGNF1yb1pi6AXZm0oV2S7AcV+hGrY68iYsvTgIUMBLXabnZIPJQF7675jQ/wuwiWXlDbeUni+H+GH+spBEGiqXFgIZScozXXWejdG3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6cGXl8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6cGXl8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B73C32782;
	Mon,  5 Aug 2024 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722875029;
	bh=vQwii10q1YmYVa9isa85ZRO5B5Git5ym+CsLyg9wPCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6cGXl8qOQQhSq+jW2IBk/kplIW+fRTvFlWp6o+SBfIL2VJptogBiJ+XvRrpuKwT0
	 GlbCJ+orj+Vb5bEHt/SsqajQScJEvGKTXECUILf7Oxi5mMtAabmC7FGm5bvxszQaiL
	 HM7+xD7MYfMzTE+6/doHINDIXZ2pp+oPJPJVcdaT2enx5tyFnmCxfdQ9j7xtVqc4ko
	 7pEcN2ZSBt6RTQiu6RC0pC9Ar78AXW5SMHPimiLxi52mAK7PUXT0Vbdn2a0zyqI3MO
	 8nu1l7TyxVMpebsZvrg5+r59ITowKh5mEIo/Qk2ulq57sESO2iR3XWaVbrfCK8IucX
	 h9TUGXXeVoOlw==
Date: Mon, 5 Aug 2024 18:23:46 +0200
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
Message-ID: <ZrD8kmRw73bS3Lj6@localhost.localdomain>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-13-frederic@kernel.org>
 <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>
 <ZrDhp3TLz6Kp93BJ@localhost.localdomain>
 <00914d25-f0ae-4b00-9608-2457821c071c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00914d25-f0ae-4b00-9608-2457821c071c@suse.cz>

Le Mon, Aug 05, 2024 at 04:53:51PM +0200, Vlastimil Babka a écrit :
> If you mean the loop in kcompactd_init() then indeed, but we also have a
> hook in online_pages() to start new threads on newly onlined nodes, so
> that's not a problem.
> 
> The problem (I think) I see is cpumask_of_node(pgdat->node_id) is a snapshot
> of cpus running on the NUMA node the time, and is never updated later as new
> cpus might be brought up.

Oh I see now...

> 
> kcompactd_cpu_online() does try to update that when cpus are onlined (in a
> clumsy way), there was nothing like that for kswapd and after your series
> this update is also removed for kcompactd.

Ok...

> 
> > If all users of preferred affinity were to use NUMA nodes, it could be
> > a good idea to do a flavour of kernel/smpboot.c which would handle
> > per-node kthreads instead of per-cpu kthreads. I initially thought
> > about that. It would have handled all the lifecycle of those kthreads,
> > including creation, against hotplug. Unfortunately RCU doesn't rely on
> > per-NUMA nodes but rather use its own tree.
> > 
> > If there be more users of real per NUMA nodes kthreads than kswapd and
> > kcompactd, of course that would be much worth considering.
> 
> Yeah it's not that compelling, but a way to update the preferred affine mask
> in response to cpu hotplug events, that kswapd and kcompactd could use,
> would be sufficient. And maybe more widely useful.
> 
> I guess there could be a callback defined for kthread to provide a new
> preferred_affinity, that you'd call from kthreads_hotplug_update() ?
> And kcompactd and kswapd could both use the same callback that interprets
> kthread_data() as pgdat and fetches a new cpumask of it?

It's too bad we don't have a way to have a cpumask_possible_of_node(). I've
looked into the guts of numa but that doesn't look easy to do.

Or there could be kthread_set_preferred_node()... ?

Thanks.

> 
> > Thanks.
> 
