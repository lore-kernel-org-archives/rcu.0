Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0323817C;
	Tue, 15 Jul 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621841; cv=none; b=OHv9PaDa7Du85JQZ3xPsstsjOMu+Bo73iMMDY1Ska9VH4MPwbRfZhzYMK48aFrlXW8BIUAf7139qBS3xH2bn3mHfCK91vqukVTUDVHN22Dej7OLkTQ33/xCvkuScIonZc3OikAL+8JpyrIPpQpAkAkKqoGhAvmBMC/Es9kIYrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621841; c=relaxed/simple;
	bh=odpMVFl0WoNcLGsgPdLSgZTnXJhFCfIpt7Lp5tz5/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX+Ii2KYgyeTCD8cdIOcs/2J6kczM0uREiOGKf36ckcEH330AjSs7+hyZHKWP/IDKyTIklK9jUHt2scc8w5EJn56+pJyVQt8ipB40WZp67Q8qHNQl/VobkbYdm6MEKyFwhiVRI14VpcmOJw1DJ+H4SmKqPSLkGtkrBBKmyj50s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIw/JuA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIw/JuA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60808C4CEE3;
	Tue, 15 Jul 2025 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621840;
	bh=odpMVFl0WoNcLGsgPdLSgZTnXJhFCfIpt7Lp5tz5/Xk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eIw/JuA4yZJCZGdcxXTn6dtFaErGQgyu9KS3rKsItimt9Y+WcGmBitVC6VsuEOWnk
	 MjnN0OC1r9pRY0OQjERSsWRkn9nFdyEsFnKtp7pzrKP7qIPb76gEZTsOwJsIoNDzPl
	 c5BCmS1I/lzteABSIuEVG5+JO3AhIE4xBWlNKZGcJ7iy6vdp/KhZmDm6DprqqU4pVM
	 LUCUSFA8+CS6j3MOqXa5VjPqkqL9jlKeh5NF8OqSJJ78wub74K400p4ljeq39GbDoQ
	 hXnzw2oLAulu6i2GVhe03kK3lUIoJmY+GvliLTgZ1ZTGY85pvd0wq8zNSInHD14CZm
	 Fdj+UqVcj1LuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE7B7CE0811; Tue, 15 Jul 2025 16:23:59 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:23:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <1d52edcb-a0d4-4db3-9c78-fe4f1878d4da@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <ebad20d8-7b04-4c32-97a9-8ae058bdaedc@paulmck-laptop>
 <5b3558d9-9f4b-4fce-ae09-18310e1a4c22@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3558d9-9f4b-4fce-ae09-18310e1a4c22@efficios.com>

On Tue, Jul 15, 2025 at 03:56:06PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-14 12:34, Paul E. McKenney wrote:
> > On Fri, Jul 11, 2025 at 10:05:26AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:
> > 
> > [ . . . ]
> > 
> > > > AFAIU the goal here is to turn the guard(preempt_notrace)() into a
> > > > guard(rcu_notrace)() because the preempt-off critical sections don't
> > > > agree with BPF.
> > > 
> > > OK, got it, thank you!
> > > 
> > > The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
> > > least its share of entertainment, that is for sure.  ;-)
> > 
> > Is there a similar issue with CONFIG_PREEMPT_LAZY, given that in that
> > case rcu_read_unlock() maps to preempt_enable(), which also can invoke
> > the scheduler?
> 
> I'll have to defer that question to someone who is more familiar than me
> with the internals of CONFIG_PREEMPT_LAZY.
> 
> Thanks for your vote of confidence though! ;-)

Mathieu, we always have confidence in you!  ;-)

Building with CONFIG_PREEMPT_LAZY=y combines a quasi-preemptible kernel
with a non-preemptible RCU.  Which has rcu_read_unlock() defined as
preempt_disable().  There might need to be an rcu_read_unlock_notrace()
defined as preempt_disable_notrace(), given that __DECLARE_TRACE()
currently sees fit to use guard(preempt_notrace)().

Or am I overthinking this?

							Thanx, Paul
