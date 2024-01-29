Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10A524A2
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569882; cv=none; b=KFiNwyupcLSA78LgMFM+DT/e7C7tPjEhFOhQ7z/tNAwJQ24Bbe6RIYkzP3dZs+IHg0JIyjAI95/UqbXODlXpxZHpr5MXW1ByrXtCC4W9o+7pA/lVrAHMihVK2MbL6VzUk45GnjF/+tF2xULWNoR8IIB6NrMkMixVYBvLyBVwF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569882; c=relaxed/simple;
	bh=VyJjbcFldoUjg2lzu3QAIbuRl/pAo7pitpB9F6lgWZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW3oBov/k/DYfO6W6xALqUayMCkIiFYNmPYesSsWY8chAAt9CdaQBxBy5RXZYhBZAkvAbnDg2k7cLJa/jZXjFFB8lRx4RcQ+zAuMNM5/UrHy756lWpkz/lS5gGhgJ7daco9rOcrLp9qpifIQu/rRhV269sBd0fAz02iIJHw7CYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEZTPSvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEZTPSvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F8C433C7;
	Mon, 29 Jan 2024 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706569882;
	bh=VyJjbcFldoUjg2lzu3QAIbuRl/pAo7pitpB9F6lgWZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEZTPSvh5TLU1eC3AIjLtNi31PSDd4/2XW88XAsjRr8d6L1oZjOANNl9btZNhnBBF
	 DCRMgVZXp6ZTI0+GQyZOIRmXv4Jqgz5sgKDVymb185Y8Vgqh8el4ASH2PviBpCMKJT
	 DpHLzmQUxQPCjhrDxN1vY71nz2g9H3mFZq2l/jk1bETYOuiqFlH65VPx1PVk3k7gha
	 /1+jAtDKnhkUxPhFaO4ObymRWOoAlTiWZgpJCK6dr12QLVxustcaT3+2Y6c65Hle+U
	 j9FFT3LpEsmqxm3c2f40yTzktP+rY5XiIAJVUVstTRTJqgmHkCh3b9Z/A8zqZ0suzs
	 UA4Is2Ca2AymQ==
Date: Tue, 30 Jan 2024 00:11:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>,
	rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <Zbgwl9x3wZ3xqtcW@pavilion.home>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636>
 <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
 <Zbgp_JJvdczGccV3@pavilion.home>
 <3753c8ea-f408-4e52-bcb8-9586c483f699@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3753c8ea-f408-4e52-bcb8-9586c483f699@joelfernandes.org>

Le Mon, Jan 29, 2024 at 05:53:50PM -0500, Joel Fernandes a écrit :
> 
> 
> On 1/29/2024 5:43 PM, Frederic Weisbecker wrote:
> > Le Mon, Jan 29, 2024 at 05:20:23PM -0500, Joel Fernandes a écrit :
> >>> If i do not miss something
> >>> the NO_HZ_FULL will disable the timer if there is only one task on CPU
> >>> so that running task benefits from not being interrupted thus gets more
> >>> CPU time.
> >>
> >> Yes, that's right. I believe it is well known that HPC-type of workloads benefit
> >> from FULL, however it has led to want to try it out for constrained system as
> >> well where CPU cycles are a premium, especially if the improvement is like what
> >> the report suggests (give or take the concerns/questions Paul raised).
> > 
> > I'll be unable to suggest anything related to that Bogomips calculation but
> > I must add something about HPC.
> > 
> > I have long believed that HPC would benefit from nohz_full but I actually never
> > heard of any user of that. The current known users of nohz_full are workloads
> > that don't use the kernel once the application is launched and do their own
> > stack of, for example, networking, talking directly to the device from
> > userspace. Using DPDK for example. These usecases are for extremely low latency
> > expectations (a single interrupt can make you lose).
> > 
> > HPC looks to me different, making use of syscalls and kernel for I/O. Nohz_full
> > may remove timer IRQs but it adds performance loss on kernel entry, making it
> > probably unsuitable there. But I might be wrong.
> > 
> 
> Thanks for the insights!
> 
> The kernel entry/exit overhead bit is an interesting point and also tracking
> state for RCU observation purposes. I wonder how much is the overhead in
> practical cases and curious to measure (especially the tradeoffs between that
> and the tick). Added note to my list ;)

And here is a summary of the added overhead with nohz_full:

* Use of RCU_NOCB
* Kernel entry/exit overhead (context_tracking/rcu/vtime)
* Unbound work reaffine (less distributed across CPUs): workqueues, timers, kthreads...
* Remote tick every 1Hz on CPU 0 (one day I would love to remove that but that
  requires too much scheduler knowledge)

The difference should be significantly measureable, even as compared to RCU_NOCB
alone.

Thanks.

> 
> thanks,
> 
> - Joel
> 
> 
> 
> >>
> >> Thanks,
> >>
> >>  - Joel
> >>
