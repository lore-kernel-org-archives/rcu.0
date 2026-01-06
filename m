Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3C7260D
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660923; cv=none; b=ZRGbXrQCy9gCqAeDuZ5madyLElI1Xq1KswRIm0edH5EF40bKSs03LHPbOhrbHCc/OE5l0lnHHZgq4lZx9wovZeN3OeUfauUQHSZei1gwHPVzBC9xaku8Cl+EOMulW4XLjrhLJmMjR6rb9VaClhw5BbRFU8KnUdCLWqVp+OSSE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660923; c=relaxed/simple;
	bh=hqq2neX9aMXDFxbh6qJRKd6LDd3xk6djQn5SN7oUwDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLY6F38tanT6QYl5m5O0DYUlh/dEs6jgg2eubOg1THnoMnj/VJp6Mvpuq0NTWpH8+hl0QZ4JcV4wj3K08SWdOvTHmGxQB+AUDtd1hX5RheHWbJfFcEY8FocrNYXREskoxCLkY1MIZCufUVWxELHQKwOO/936bJlGZXX7+4oyWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=RKJ64fBp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RKJ64fBp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b23b6d9f11so49309885a.3
        for <rcu@vger.kernel.org>; Mon, 05 Jan 2026 16:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767660920; x=1768265720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nGgGrLrZDFvNWUqj/sFWkDKZxFMb4thuE7FwUyZntA=;
        b=RKJ64fBpNBeCHHyY4e0vPyZtJv+K2kTMLZpGlNJNIdmVWWruZJe3yXjzbhOVm2tOUk
         G+OCwbRf9BUdGQ6gWh6YLiHfR+wSssEg8xJ2x6bgvm4VMT/JIcfKMuAXjdW8wrHfQ+3P
         9f5J8itKrCWV6Pw2GP9oBXxkhfgRU8gNJuib0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660920; x=1768265720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nGgGrLrZDFvNWUqj/sFWkDKZxFMb4thuE7FwUyZntA=;
        b=iC9QheqoVO/HjUvfxYyc5fxd17jAdarkAGRIg6YXLu90HNMfSs1Lxhh0QH1R9nLSTC
         Xmvk+WyCPWeKFaKdmSHtfWv4Ovlzls7HnidTADvZ40pzsXXkmGa5CQ7/lB+lj2n2m6MY
         XxthyyL+HO51RAdXkkfEYHkWqfZlwYgjkQpeDkf9zQJtPjkGeXuV5xnMZ2tsneZH3bzV
         wR4XVWUAueXWXR+Y/2HbVuyzBRgh55tim0WhXlGKv14go6JsUa3DPVUGsqs6emKVWqeN
         gOPFWVU3t25lrMZ5mqi/NlUh2KZ31xIuURZTNl//bLBXrcylX8ql2uzKSXHSrOiMLVWS
         ZxPg==
X-Forwarded-Encrypted: i=1; AJvYcCUmWCupiXigbOqbBjm/fx5N46iDOPJIuIPTwGFmDeBchMO2POc25SrUFM7N0KaveMeZ1OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVT3CWE8FJQ929N8Gm2l0k8yxjJusFPaxUkeN6xRaAZvVlCG7
	Ms0LH27UpdCue3xM9Fr1KDjuQo4jDvncxJEukjwlX4lWYDFaFBIqw+euTGUYN13Qfno=
X-Gm-Gg: AY/fxX4pBi2ent19481/iHHWZJItBgDe227FS/KQKSfIvJx5p0ghSNilcitZ7JIUp/z
	R/1irE78TzXftsaEzo4UdbEEBXcgHUjhhxrJKs5tHvUNk3nLT1xp2dhcxEmfgRgvlEvUlG3FHaj
	rwmwg0WbbraSRkiTzckiDa30j8S4KVD6zN67yc60MskwDamZEf0KYIJrrfVp4trfmx4BXRUUgMx
	UtGDUGOkJtGL8LmQf8zFoZskQmW4zILBbvkGerEAsGe7+gxx0RpMI1S2Fo8qQXTyF81CSGUpdld
	o5sXkEeFsmHl3KFjKR0h3g63ImdMTO5mc3nDTYC8u0luIyCv0AtPVQFwVjTaV+0+aummwqUM58S
	FWJ9z2ILy2uj5/Ax49ZKPGrzbvpSTAf2qYT9OOetNXkGwSZGW37MB9J4BwhS4gdFKnypFTcPCYj
	pXGRyTCzFrTy0VcoaaStEWqmjgCQ==
X-Google-Smtp-Source: AGHT+IGgKTlJnh+51ncHIs5CUj8xTEl3awH6nAA/bQHjr/MoLB2DSc+O5wU5QuHy+5EtksjShNdqXg==
X-Received: by 2002:a05:620a:25ce:b0:8bb:a675:b540 with SMTP id af79cd13be357-8c37ebca405mr189478585a.69.1767660920417;
        Mon, 05 Jan 2026 16:55:20 -0800 (PST)
Received: from [192.168.0.99] ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4bc1e7sm66614085a.21.2026.01.05.16.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 16:55:19 -0800 (PST)
Message-ID: <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
Date: Mon, 5 Jan 2026 19:55:18 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
To: paulmck@kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul,

On 1/5/2026 11:46 AM, Paul E. McKenney wrote:
> On Fri, Jan 02, 2026 at 07:23:29PM -0500, Joel Fernandes wrote:
>> When a task is preempted while holding an RCU read-side lock, the kernel
>> must track it on the rcu_node's blocked task list. This requires acquiring
>> rnp->lock shared by all CPUs in that node's subtree.
>>
>> Posting this as RFC for early feedback. There could be bugs lurking,
>> especially related to expedited GPs which I have not yet taken a close
>> look at. Several TODOs are added. It passed light TREE03 rcutorture
>> testing.
>>
>> On systems with 16 or fewer CPUs, the RCU hierarchy often has just a single
>> rcu_node, making rnp->lock effectively a global lock for all blocked task
>> operations. Every context switch where a task holds an RCU read-side lock
>> contends on this single lock.
>>
>> Enter Virtualization
>> --------------------
>> In virtualized environments, the problem becomes dramatically worse due to vCPU
>> preemption. Research from USENIX ATC'17 ("The RCU-Reader Preemption Problem in
>> VMs" by Gopinath and Paul McKenney) [1] explores the issue that RCU
>> reader preemption in VMs causes multi-second latency spikes and huge increases
>> in grace period duration.
>>
>> When a vCPU is preempted by the hypervisor while holding rnp->lock, other
>> vCPUs spin waiting for a lock holder that isn't even running. In testing
>> with host RT preemptors to inject vCPU preemption, lock hold times extended
>> from ~4us to over 4000us - a 1000x increase.
>>
>> The Solution
>> ------------
>> This series introduces per-CPU lists for tracking blocked RCU readers. The
>> key insight is that when no grace period is active, blocked tasks complete
>> their critical sections before really requiring any rnp locking.
>>
>> 1. Fast path: At context switch, Add the task only to the
>>    per-CPU list - no rnp->lock needed.
>>
>> 2. Promotion on demand: When a grace period starts, promote tasks from
>>    per-CPU lists to the rcu_node list.
>>
>> 3. Normal path: If a grace period is already waiting, tasks go directly
>>    to the rcu_node list as before.
>>
>> Results
>> -------
>> Testing with 64 reader threads under vCPU preemption from 32 host SCHED_FIFO
>> preemptors), 100 runs each. Throughput measured of read lock/unlock iterations
>> per second.
>>
>>                         Baseline        Optimized
>> Mean throughput         66,980 iter/s   97,719 iter/s   (+46%)
>> Lock hold time (mean)   1,069 us        ~0 us
> 
> Excellent performance improvement!

Thanks. :)
> It would be good to simplify the management of the blocked-tasks lists,
> and to make it more exact, as in never unnecessarily priority-boost
> a task.  But it is not like people have been complaining, at least not
> to me.  And earlier attempts in that direction added more mess than
> simplification.  :-(

Interesting. I might look into the boosting logic to see whether we can avoid
boosting certain tasks depending on whether they help the grace period complete
or not. Thank you for the suggestion.

>> The optimized version maintains stable performance with essentially close to
>> zero rnp->lock overhead.
>>
>> rcutorture Testing
>> ------------------
>> TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
>> in progress.
>>
>> Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
>> the plan is to eventually turn this on all the time.
> 
> Yes, Aravinda, Gopinath, and I did publish that paper back in the day
> (with Aravinda having done almost all the work), but it was an artificial
> workload.  Which is OK given that it was an academic effort.  It has also
> provided some entertainment, for example, an audience member asking me
> if I was aware of this work in a linguistic-kill-shot manner.  ;-)
> 
> So are we finally seeing this effect in the wild?

This patch set is also targeting a synthetic test I wrote to see if I could
reproduce a preemption problem. I know several instances over the years where my
teams (mainly at Google) were trying to resolve spin lock preemption inside
virtual machines by boosting vCPU threads. In the spirit of RCU performance and
VMs, we should probably optimize node locking IMO, but I do see your point of
view about optimizing real-world use cases as well.

What bothers me about the current state of affairs is that even without any
grace period in progress, any task blocking in an RCU Read Side critical section
will take a (almost-)global lock that is shared by other CPUs who might also be
preempting/blocking RCU readers. Further, if this happens to be a vCPU that was
preempted while holding the node lock, then every other vCPU thread that blocks
in an RCU critical section will also block and end up slowing preemption down in
the vCPU. My preference would be to keep the readers fast while moving the
overhead to the slow path (the overhead being promoting tasks at the right time
that were blocked). In fact, in these patches, I'm directly going to the node
list if there is a grace period in progress.

> The main point of this patch series is to avoid lock contention due to
> vCPU preemption, correct?  If so, will we need similar work on the other
> locks in the Linux kernel, both within RCU and elsewhere?  I vaguely
> recall your doing some work along those lines a few years back, and
> maybe Thomas Gleixner's deferred-preemption work could help with this.
> Or not, who knows?  Keeping the hypervisor informed of lock state is
> not necessarily free.

Yes, I did some work on this at Google, but it turned out to be a very
fragmented effort in terms of where (which subsystem - KVM, scheduler etc)
should we do the priority boosting of vCPU threads. In the end, we just ended up
with an internal prototype that was not upstreamable but worked pretty well and
only had time for production (a lesson I learned there is we should probably
work on upstream solutions first, but life is not that easy sometimes).

About the deferred-preemption, I believe Steven Rostedt at one point was looking
at that for VMs, but that effort stalled as Peter is concerned about doing that
would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
communicate locking information between vCPU threads and the host and then let
the host avoid vCPU preemption - but the scheduler needs to do something with
that information. Otherwise, it's no use.

> Also if so, would the following rather simpler patch do the same trick,
> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 6a319e2926589..04dbee983b37d 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -198,9 +198,9 @@ config RCU_FANOUT
>  
>  config RCU_FANOUT_LEAF
>  	int "Tree-based hierarchical RCU leaf-level fanout value"
> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
>  	default 2 if RCU_STRICT_GRACE_PERIOD
> 
> ------------------------------------------------------------------------
> 
> This passes a quick 20-minute rcutorture smoke test.  Does it provide
> similar performance benefits?

I tried this out, and it also brings down the contention and solves the problem
I saw (in testing so far).

Would this work also if the test had grace periods init/cleanup racing with
preempted RCU read-side critical sections? I'm doing longer tests now to see how
this performs under GP-stress, versus my solution. I am also seeing that with
just the node lists, not per-cpu list, I see a dramatic throughput drop after
some amount of time, but I can't explain it. And I do not see this with the
per-cpu list solution (I'm currently testing if I see the same throughput drop
with the fan-out solution you proposed).

I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
reasonable, considering this is not a default. Are you suggesting defaulting to
this for small systems? If not, then I guess the optimization will not be
enabled by default. Eventually, with this patch set, if we are moving forward
with this approach, I will remove the config option for per-CPU block list
altogether so that it is enabled by default. That's kind of my plan if we agreed
on this, but it is just an RFC stage :).

thanks,

 - Joel


