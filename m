Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF495A10B
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323470; cv=none; b=ZvTALQ6ch2N8zWxxmchyuHTOx8zen4lW6ZrPBZ17MPYYD2qHVI3azqQS73GYd59+YhDDD0g9glVyJHuF6W1bRWFeEGeRGe65DvkRfBDRrADPmDgw8fSGCbNmiPpLPdV/ERyTZUi4QCbARH9i5yb0jDN3i6BDZjjXveaCnibtYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323470; c=relaxed/simple;
	bh=4Ow+hZEZVXZ1hL8+4TGPWGjfkGfocliWjZCVVMVaEMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojz6YrAh/QqZzhN1AqS4Ulsy+S6yRx3Onp7FBuRj37p20MKuVTPxEN+cYB/kbr+JNW7LZ2sh+87NyA8t2jwT7zNPM3IRYbGoV0iea9z+w7TGAzN7PNoiadshlxiuaEIOKvNso/N3gF8cCT+YBa0k0dotpWjj8nEQ6aXIKA8XVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sEPkYZdm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sEPkYZdm"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F6C040606
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707323465;
	bh=MZfq+RqPUpdCf28LWQdKtzFBG6Lk/NfNn4byOmQIDZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=sEPkYZdmtxad1lLv7mLrH1hg/t8nxsOJo28Ok9A8jKDvDNzdYWZFdFTn0aUtqfSek
	 QwA+ZVgnTd7ckq85nacwepn+71R0T5p0xSf+lPuJEFtpEZVRmXLaqxsivdSNjNj0W9
	 qB/+scvUanuaxdjboFgQlCCIGVzejmwlkcu211UxyklQIkoxKtOE8zYVVXShipkbIv
	 fsJTrumPIg21XNJlmlkRHWmeiB+LbqPqiYK5dKg0un+E6rLhPQfL0W7dN0Vq9im+B0
	 YIQu4FFm6Yx6pPkZDAOsK381JIQn/GzuubHCuGrRs+fum2bgK0KnXQ0L3n2K+MS9B1
	 VF9OxL/KRhzuA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3845827fdaso36371366b.1
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 08:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323465; x=1707928265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZfq+RqPUpdCf28LWQdKtzFBG6Lk/NfNn4byOmQIDZ0=;
        b=YSc7vxOuUi66r3NPCBTuSwSlu7lq4SHBu74DkCXeTfj41uc8W0GjmxUe53e4MWBCAW
         kvlFq16cK0Xp8hIWJUQKVDEy8ogOgBSJwu4ZMjvrpJwQ0oehWxzBBFPxWd8tZi1GGj9k
         SWGD0t97D2qXllLxTEhNxU3GxIKv1Qia8v13BIWFUZSJxzkKfDTPBMOtL8lMEMwob7CQ
         S+iB5DEkVvCCsUlZ/skA45qvn9E2C7pl0TtsvU4GTTk5As2OlLc8D7s1vGJphE6uoRW0
         0bW0tSOoECSA1mZbu4CItdtyc8oCE/NPu/AScki/MvX8FK0x2mVGpmQhstmcGByG66vn
         KQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWi+5w602iRVwAYSkMjVt6nmAQCRNhpgTHUBzPXKwMk7k+MY5jPiqDOCfB/OkoJzIozqNj9RXUaT2UJyTUdH4+Djl6g
X-Gm-Message-State: AOJu0YxAHmHRch4Olb5HLbn7ofGx19jU6KjLqDHVdgJ5BYN4Xkku7Q4O
	hZkWtG5vDhe8dBajY04R3QDpahtUcju+6+SAEh8GxbVwgQXIU7anVyrJqsvFK1Ee3vBxoW6372n
	PBTQr51pFsmRxfChoMTKdB/rMJoZTzX4z01oVgroLGZEpBotStbT6/tI2w8u40wNIEg==
X-Received: by 2002:a17:906:5297:b0:a38:a44f:d6df with SMTP id c23-20020a170906529700b00a38a44fd6dfmr298890ejm.0.1707323464705;
        Wed, 07 Feb 2024 08:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN3pwtePqW/o+feWySNjMEkRtWv2/jYaUxgoPaEOvz/ifOu488RTCgq8rR/bhlZM7+aIhIAQ==
X-Received: by 2002:a17:906:5297:b0:a38:a44f:d6df with SMTP id c23-20020a170906529700b00a38a44fd6dfmr298876ejm.0.1707323464342;
        Wed, 07 Feb 2024 08:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFADFk6bxsMytMu1B33RYQ70FfK3/yV8c4HpIDchyK83DycnKRI1WcuZ6DEuIurLZvJzKdKf3AhFBPnl7i1WsgBKnKNOMU0gCxLpNiQu7CdAWq5koCaJPbs57yYiqHCIv2CJROkEi/lK3todsH8QHwt+78PtE9dcRZwso+
Received: from localhost (host-79-53-78-93.retail.telecomitalia.it. [79.53.78.93])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a38620c3b3dsm913512ejb.198.2024.02.07.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:31:03 -0800 (PST)
Date: Wed, 7 Feb 2024 17:31:02 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcOwRsEhbQhGv9X2@gpd>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>

On Wed, Feb 07, 2024 at 10:48:10AM -0500, Joel Fernandes wrote:
> 
> 
> On 2/6/2024 12:51 PM, Andrea Righi wrote:
> >  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
> >    in this scenario (the bogo-ops/s are very susceptible to any kind of
> >    interference, so even if in the long runs NO_HZ_FULL still seems to
> >    provide some benefits looking at the average, we also need to
> >    consider that there might be a significant error in the measurements,
> >    standard deviation was pretty high)
> > 
> 
> Ack on the bogo-ops disclaimers as also mentioned in the stress-ng docs. Agreed
> a better metric for perf is helpful.
> 
> I am assuming you also have RCU_NOCB enabled for this test?

yep, booting with rcu_nocb=all.

> 
> >  - fio doing short writes (in page cache) seems to perform like 2x
> >    better in terms of iops with nohz_full, respect to the other cases
> >    and it performs 2x slower with large IO writes (not sure why... need
> >    to investigate more)
> 
> This is interesting, it could be worth counting how many kernel entries/exits
> occur for large IO vs small IO. I'd imagine for large IO we have fewer syscalls
> and hence lower entry/exit overhead. But if there more interrupts for whatever
> reason with large IO, then that also implies more kernel entries/exits. As
> Frederic was saying, NOHZ_FULL has higher overhead on kernel entry/exit.

Good point. I was expecting to see a reduced performance due to the
kernel entry/exit overhead, assuming we had more syscalls in the short
writes case, that's why I was confused. But, as you correctly pointed
out, we may actually have more entry/exit events due to interrupts.

I'll repeat the test counting the kernel entries/exits to figure out
what's happening exactly, thanks for the hint!

> 
> > 
> >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> >    return, respect to the other cases (is this expected?)
> 
> It depends on which hrtimer_interrupt() instance? There must be several in the
> trace due to unrelated timers. Are you saying the worst case or it is always 2x
> more? We do queue a timer for Lazy RCU to flush the RCU work but it is set to 10
> seconds and should be canceled most of the time (Its just a guard rail). It is
> possible there is lock contention on ->nocb_gp_lock whizxzch is causing the timer
> handler execution to be slow. We have several trace_rcu_nocb* trace points,
> including for the timer. Perhaps you could enable those and we dig deeper?

So, my plan was to (try to) measure the potential overhead that we may
introduce by enabling the new config options in the tick handler,
therefore I tried to tace the time distribution of the different
hrtimer_interrupt() invocations, using this:

---
#!/usr/bin/bpftrace

kprobe:hrtimer_interrupt {
    @start[tid] = nsecs;
}

kretprobe:hrtimer_interrupt /@start[tid]/ {
    @elapsed = hist(nsecs - @start[tid]);
    delete(@start[tid]);
}
---

The time distribution is always ~2x with lazy RCU enabled, but honestly
I don't know if this metric is really relevant.

In terms of performance it is probably more relevant the fact that we
move the RCU callbacks from softirq to kthread context and process them
in batch. This for sure has a bigger impact respect to the overhead that
we may add to the tick handler.

But I'll try to enable the trace_rcu_nocb* tracepoints and see if we can
get some interesting details of what is happening.

> 
> Further, it is interesting to see if it is only the hrtimer_interrupt() instance
> that also results in a call to do_nocb_deferred_wakeup_timer() via say function
> tracing. That will confirm that it is the lazy timer that is slow for you.

ok

> 
> The actual number of callbacks should not be causing specifically the
> hrtimer_interrupt() to take too long to run, AFAICS. But RCU's lazy feature does
> increase the number of timer interrupts.
> 
> Further still, it depends on how much hrtimer_interrupt() takes with lazy RCU to
> call it a problem IMO. Some numbers with units will be nice.

This is what I see (this is a single run, but the other runs are
similar), unit is nanosec, with lazy RCU enabled hrtimer_interrupt()
takes around 4K-16K ns, with lazy RCU off most of the times it takes
2K-4K ns:

 - lazy rcu off:

[1K, 2K)       	 88307 |@@@@@@@@@@@@                                    	|
[2K, 4K)      	380695 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
[4K, 8K)           194 |                                                	|

 - lazy rcu on:

[2K, 4K)          3094 |                                                	  |
[4K, 8K)        265763 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8K, 16K)       182341 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             	  |
[16K, 32K)        3422 |                                                	  |

Again, I'm not sure if this is really a problem or not, or if it is even
a relevant metric for the overall performance, I was just curious to
understand why it is different.

Thanks,
-Andrea
