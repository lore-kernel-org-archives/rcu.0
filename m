Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7D3358AF
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732010; cv=none; b=WExvV9n96xYoCfsrEF7W+BMIMpELjst2TpoqKUHO08HgwnBeCUPI93joa5/jYKHW2/QSUwDvFFomUj/RaqPuexTSyXx9eNaTBRmEEXZAGjC2Ky/k08n1xUiH7p/+B9dM/U0Ee2pBo+0pTc5xpWb6WaqdJUJtzSUFrlGd3F8CK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732010; c=relaxed/simple;
	bh=Fd9r5s3Uo7/NEFTM80WuDzG1z2OPJkYyVSmo6UzvLy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm/BCesbtx3fY+1q6FzYi804mBwjSNcKJHP5sjuR6fIWbM8QHocix3rzehLwmzJ4JuxOJfNw58tCtmHt/aKhNlh/Azkyt6bqNYoppeG2/G4x+GOjGqqdINJ6C11gwxCbOFavDgLnrQlRCG/MR81MEZbCS0p7o5dwRDN0ZlRrlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=qWxmCSCv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qWxmCSCv"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2148ca40eso185318285a.1
        for <rcu@vger.kernel.org>; Tue, 06 Jan 2026 12:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767732007; x=1768336807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeeQFWxcKymtkVYB5RA0pHHQMP4nx/JDC9n+qBdaSHg=;
        b=qWxmCSCv6fqPyDNcLmIjKOxx5WBWE9TZacqRiDgNW8kMbBfYf7ek2PKs7FHmG7l9CD
         MBRjC5S98w4ZTJ/mx02Ws30ynDavriqPSiz0hqxBE8gITm15bNB9XD43AbOqLdxjN8h3
         ZXJgbE1ZsvZusxlWI7HdIPMQeay29DW2Cvv9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767732007; x=1768336807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeeQFWxcKymtkVYB5RA0pHHQMP4nx/JDC9n+qBdaSHg=;
        b=dAd44M/egJ0QGlfQp4DrYI0GCOZZ0mimy2CVWqAqX3XLGsO/zAHgwhZ7M0eeMRXxSg
         LASes/GkO1dJXwKBYjLiBPRY/JHjpGG4j8Wug5mEE8Kngr0GadDvrhogyi9fcOniVfUQ
         0bl8uTlYGSozbd34xMLxoQflUlasB7o4TxScFmXTovlk+wP/2aSBYf5J7gIHpITPVeFU
         IduUhHiYb1/vu25/gN4wPe79RhugG3OxWbrjsAOocYT+GvspTYUuG7G5Xe4CdgZ0uEXy
         O3nfrdWUfIzkCpOKSCrAfgB4JYYDWIqaZNyC82aUEBhdQA7Jw5VX3yFi3VCwXPKoHCGH
         BFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZfjCin0QKtB9q7nRbzsseZD8958sQWkipvNf5xSvprgu6l3uwyC+dAS94LiQBq8AML4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WM37Q62lNnegiaY4JYQ1bDe140nvnhv7N57Zw3OC6gDRiXhv
	njSPlTF/NRkkeF3P7klS4bXEoDeskzh9lvBhy7Rl2U85z30L3jitk9j4W7WC4Mh2tgA=
X-Gm-Gg: AY/fxX6VF0dc0CGM+fQCY5jb2UzgH6CUz7ea48j/vsIzVp+UY6FfQ/Li5c7H8lngB3k
	gFolvpdW5CW+eK5TjZbgtR9LYGzeo65Pc96cTr7PRkutkr4+r5mqxQI833XCRsstn2SNSclkop+
	cQOymH212765BWjHmHnlsDMp7MHHaaxJA1LrBF0crLu0sb1Ewj/zfkEFrpg5jYl3Jmowylwu6vE
	ErzrH5TnPlOG895XXNjM2UvMlEccuiivEafuXVTDdFQuXa2ZoBv0yZboi9lf00OaD5+L1wPpdnb
	b07LYSWICxj4WHRmolm1pODOM0i/tAuDWA731vw+jfjJBYsXhWSrH8NSX2l0HmCPwq5HWhKYeV+
	lNIbDlcnTrtemDtwSO1HgCqCACBbBSSh9MgefjVLvRRvCjQ1VDjUZiYjYw96Do4EVPoxOQ7INqO
	cFx8zRO38H90ZrspR2vecY0nW/kqp4TNrBN+Pj
X-Google-Smtp-Source: AGHT+IGPCzku8f59rMs2LGDA9VGzBc4eUYYIR4pc16ABPmhFZBvvSpu5dTBFZQ6jnweSq+6KkJgOPQ==
X-Received: by 2002:a05:620a:1a89:b0:8b2:7331:28e6 with SMTP id af79cd13be357-8c3894280ffmr16635185a.86.1767732007059;
        Tue, 06 Jan 2026 12:40:07 -0800 (PST)
Received: from [192.168.0.99] ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm240782285a.17.2026.01.06.12.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 12:40:06 -0800 (PST)
Message-ID: <9acfe215-5a14-428f-a398-e6a0b3dc18b4@joelfernandes.org>
Date: Tue, 6 Jan 2026 15:40:04 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
To: paulmck@kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/2026 2:17 PM, Paul E. McKenney wrote:
> On Mon, Jan 05, 2026 at 07:55:18PM -0500, Joel Fernandes wrote:
[..]
>>>> The optimized version maintains stable performance with essentially close to
>>>> zero rnp->lock overhead.
>>>>
>>>> rcutorture Testing
>>>> ------------------
>>>> TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
>>>> in progress.
>>>>
>>>> Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
>>>> the plan is to eventually turn this on all the time.
>>>
>>> Yes, Aravinda, Gopinath, and I did publish that paper back in the day
>>> (with Aravinda having done almost all the work), but it was an artificial
>>> workload.  Which is OK given that it was an academic effort.  It has also
>>> provided some entertainment, for example, an audience member asking me
>>> if I was aware of this work in a linguistic-kill-shot manner.  ;-)
>>>
>>> So are we finally seeing this effect in the wild?
>>
>> This patch set is also targeting a synthetic test I wrote to see if I could
>> reproduce a preemption problem. I know several instances over the years where my
>> teams (mainly at Google) were trying to resolve spin lock preemption inside
>> virtual machines by boosting vCPU threads. In the spirit of RCU performance and
>> VMs, we should probably optimize node locking IMO, but I do see your point of
>> view about optimizing real-world use cases as well.
> 
> Also taking care of all spinlocks instead of doing large numbers of
> per-spinlock workarounds would be good.  There are a *lot* of spinlocks
> in the Linux kernel!

I wouldn't call it a workaround yet. Avoiding lock contention by using per CPU
list is an optimization we have done before right? (Example the synthetic RCU
callback-flooding use case where we used a per-cpu list). We can call it
defensive programming, if you will. ;-) Especially in the scheduler hot path
where we are blocking/preempting. Again, I'm not saying we should do it for this
case since we are still studying the issue, but just on the fact that we are
optimizing a spin lock we acquire *a lot* shouldn't be categorized as a
workaround in my opinion.

This blocking is even more likely on preempt RT in read-side critical sections.
Again, I'm not saying that we should do this optimization, but I don't think we
can ignore it. At least not based on the data I have so far.
>> What bothers me about the current state of affairs is that even without any
>> grace period in progress, any task blocking in an RCU Read Side critical section
>> will take a (almost-)global lock that is shared by other CPUs who might also be
>> preempting/blocking RCU readers. Further, if this happens to be a vCPU that was
>> preempted while holding the node lock, then every other vCPU thread that blocks
>> in an RCU critical section will also block and end up slowing preemption down in
>> the vCPU. My preference would be to keep the readers fast while moving the
>> overhead to the slow path (the overhead being promoting tasks at the right time
>> that were blocked). In fact, in these patches, I'm directly going to the node
>> list if there is a grace period in progress.
> 
> Not "(almost-)global"!
> 
> That lock replicates itself automatically with increasing numbers of CPUs.
> That 16 used to be the full (at the time) 32-bit cpumask, but we decreased
> it to 16 based on performance feedback from Andi Kleen back in the day.
> If we are seeing real-world contention on that lock in real-world
> workloads on real-world systems, further adjustments could be made,
> either reducing CONFIG_RCU_FANOUT_LEAF further or offloading the lock,
> where your series is one example of the latter.

I meant it is global or almost global depending on the number of CPUs. So for
example on an 8 CPU system with the default fanout, it is a global lock, correct?

> I could easily believe that the vCPU preemption problem needs to be
> addressed, but doing so on a per-spinlock basis would lead to greatly
> increased complexity throughout the kernel, not just RCU.

I agree with this. I was not intending to solve this for the entire kernel, at
first at least.

>> About the deferred-preemption, I believe Steven Rostedt at one point was looking
>> at that for VMs, but that effort stalled as Peter is concerned about doing that
>> would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
>> communicate locking information between vCPU threads and the host and then let
>> the host avoid vCPU preemption - but the scheduler needs to do something with
>> that information. Otherwise, it's no use.
> 
> Has deferred preemption for userspace locking also stalled?  If not,
> then the scheduler's support for userspace should apply directly to
> guest OSes, right?

I don't think there have been any user space locking optimizations for
preemption that has made it upstream (AFAIK). I know there were efforts, but I
could be out of date there. I think the devil is in the details as well because
user space optimizations cannot always be applied to guests in my experience.
The VM exit path and the syscall entry/exit paths are quite different, including
the API boundary.

>>> Also if so, would the following rather simpler patch do the same trick,
>>> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
>>>
>>> ------------------------------------------------------------------------
>>>
>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>> index 6a319e2926589..04dbee983b37d 100644
>>> --- a/kernel/rcu/Kconfig
>>> +++ b/kernel/rcu/Kconfig
>>> @@ -198,9 +198,9 @@ config RCU_FANOUT
>>>  
>>>  config RCU_FANOUT_LEAF
>>>  	int "Tree-based hierarchical RCU leaf-level fanout value"
>>> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>>> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>>> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
>>> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>>> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>>> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
>>>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
>>>  	default 2 if RCU_STRICT_GRACE_PERIOD
>>>
>>> ------------------------------------------------------------------------
>>>
>>> This passes a quick 20-minute rcutorture smoke test.  Does it provide
>>> similar performance benefits?
>>
>> I tried this out, and it also brings down the contention and solves the problem
>> I saw (in testing so far).
>>
>> Would this work also if the test had grace periods init/cleanup racing with
>> preempted RCU read-side critical sections? I'm doing longer tests now to see how
>> this performs under GP-stress, versus my solution. I am also seeing that with
>> just the node lists, not per-cpu list, I see a dramatic throughput drop after
>> some amount of time, but I can't explain it. And I do not see this with the
>> per-cpu list solution (I'm currently testing if I see the same throughput drop
>> with the fan-out solution you proposed).
> 
> Might the throughput drop be due to increased load on the host?

The load is constant with the benchmark, and the data is repeatable and
consistent. So random load on the host is unlikely.

> Another possibility is that tasks/vCPUs got shuffled so as to increase
> the probability of preemption.
> 
> Also, doesn't your patch also cause the grace-period kthread to acquire
> that per-CPU lock, thus also possibly resulting in contention, vCPU
> preemption, and so on?

Yes, I'm tracing it more. Even with baseline (without these patches), I see this
throughput drop so it is worth investigating. I think it's something possibly
like a lock convoy forming, but the fact that if I don't use RNP locking, the
lock convoy disappears, and the throughput is completely stable. That tells me
that that has something to do with that or something related. I also measured
the exact RNP lock time and counted the number of contentions, so I am not
really guessing here. The RNP lock is contended consistently. I think it's a
great idea for me to extend this lock contention measurement to the run queue
locks as well, for me to measure how they are doing (or even extending it to all
locks, as you mentioned) - at least for me to confirm the theory that the same
test severely contends other locks as well.

>> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
>> reasonable, considering this is not a default. Are you suggesting defaulting to
>> this for small systems? If not, then I guess the optimization will not be
>> enabled by default. Eventually, with this patch set, if we are moving forward
>> with this approach, I will remove the config option for per-CPU block list
>> altogether so that it is enabled by default. That's kind of my plan if we agreed
>> on this, but it is just an RFC stage :).
> 
> Right now, we are experimenting, so the usability issue is less pressing.
> Once we find out what is really going on for real-world systems, we
> can make adjustments if and as appropriate, said adjustments including
> usability.

Sure, thanks.

 - Joel

