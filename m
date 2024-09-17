Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EB433B3
	for <rcu@vger.kernel.org>; Tue, 17 Sep 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556727; cv=none; b=dInfaDGEzHUV3y/MhyU5llh/fYo9MSWSd6U3rt603uJx5Lfo47+EhwZDR/ERWlD15MkPzeTsQX0zjx22keubexARZa423pO3CdmgzOUY9YDtd87FseCARmM+8gZX6F04FG5HgZXqvn32ch3DLqn/x2Fd2Ptp+Yw5PzLFrZCTytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556727; c=relaxed/simple;
	bh=pPCDGkmjaJFiaG0NM6Gk+8jx2l1609rB2A5MJWi94cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFWKNNRUf6p0znLPFBR/tc9XHhC3cjd09cvWczWmrD8/RWF74CeB/yotSdF6imc8Ek2L5KAb73L7q5rIH5h1bs4bsuvP2Iim72YLZ5nJYBi8yKrnQxpAOfLWzjGl1R1/bjuAcXuvXwTDgLIRxBeNWAI8Sdq7Cu1s46dY8SIGDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PsEHh3h8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PsEHh3h8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so53501735e9.3
        for <rcu@vger.kernel.org>; Tue, 17 Sep 2024 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726556724; x=1727161524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ILf67Y81lASSuXGrTQfS2z5An5s8u2dCx//Qru/Z7g=;
        b=PsEHh3h8rw3rS0dUK8fB62LBW9ItWC6Umdtle2/nBYdTeCEp8VG5ZE4mX8thDhRGo+
         dVT6G0j4V7fd3ScdKFxrmO6KVFMH+WwtRxcPIRFYqTnhUieJsS4Zt8BzzInDG0GqP56A
         hncoWZ7vf5ng6SpEslj2flVhnjPXtLzv96y1ZA1kDNe18rQz+HgOdkxpQ7scQykNmW2e
         MIYzlqT3lDL86PrGAH+fwbVnnxOgl/HIVl4GNaP36meYbQVxGxaofT2cAYJIiHoT5dfp
         g321ZGmqKnOVnl++E6iwRqzE8Mv9/kJTpt2ImkspCXghg61lv/j3IJZaObIAZ0e3kMuO
         PaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556724; x=1727161524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ILf67Y81lASSuXGrTQfS2z5An5s8u2dCx//Qru/Z7g=;
        b=DUnr+mOSX2ddGBdKFX2lj5JLxpeBU86bgIr+VfjdeU/0aIsaE+ppb503jprYH4FDIn
         wBhtBNsNAfp7VcjgR5tY+5HT6vz6JXOp6lxeAx4SR7nDQHb993VdcRQr0r8TzojbpN/e
         vy/uS/Dnf3maqz56Z/p4Vxy9b95/7rEbbB/MqvesQoad0BtwB58yHO9OybAzwCg4vua9
         hSIF/l1uSWB6sjOh7LarfdW7xPrBi6AkzPISiVrxCW/Mu1qPzB0sC56MQn1oEmtY+Ms0
         dfm6fvdJpL+Do6iZNJG93scO+76NR8hH95dwFg6J3fMlc0lIiOyhyaEBG+zbz29sg9ok
         rccw==
X-Forwarded-Encrypted: i=1; AJvYcCVNL4kTFGVfQGXtzeNOarLDRkHTEoLGLREdtfiCO1aCHTIBd/Qs+BxjrSelZx8kI+wzZmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVcRR3LJvqpNmbCUyIz4lwwCdz33/hmHdxaqnjJrZpT6wOXGz
	USdM1fJtRKcPezxlnes9ghhx4h4c/DW65fz8IWTTdwqve9dgY7OgSRaQ3n001OM=
X-Google-Smtp-Source: AGHT+IH3o/npKUx4YaHbMCjDDrmqsFqTss9Txf7nthZNJj9hxmPQ6MElpiejAbOBFTxY5d2alc+OAw==
X-Received: by 2002:a05:600c:3588:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42d9070a259mr154521055e9.7.1726556723600;
        Tue, 17 Sep 2024 00:05:23 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055052sm129132255e9.9.2024.09.17.00.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:05:23 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:05:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <ZukqMvPU03hgCLHu@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
 <4b107fec-e391-4680-9457-b282310b4454@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b107fec-e391-4680-9457-b282310b4454@suse.cz>

On Tue 17-09-24 09:01:08, Vlastimil Babka wrote:
> On 9/17/24 8:26 AM, Michal Hocko wrote:
> > On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> >> Kthreads attached to a preferred NUMA node for their task structure
> >> allocation can also be assumed to run preferrably within that same node.
> >>
> >> A more precise affinity is usually notified by calling
> >> kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> >>
> >> For the others, a default affinity to the node is desired and sometimes
> >> implemented with more or less success when it comes to deal with hotplug
> >> events and nohz_full / CPU Isolation interactions:
> >>
> >> - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> >> - kswapd is affine to its node and ignores hotplug and CPU Isolation
> >> - A bunch of drivers create their kthreads on a specific node and
> >>   don't take care about affining further.
> >>
> >> Handle that default node affinity preference at the generic level
> >> instead, provided a kthread is created on an actual node and doesn't
> >> apply any specific affinity such as a given CPU or a custom cpumask to
> >> bind to before its first wake-up.
> > 
> > Makes sense.
> > 
> >> This generic handling is aware of CPU hotplug events and CPU isolation
> >> such that:
> >>
> >> * When a housekeeping CPU goes up and is part of the node of a given
> >>   kthread, it is added to its applied affinity set (and
> >>   possibly the default last resort online housekeeping set is removed
> >>   from the set).
> >>
> >> * When a housekeeping CPU goes down while it was part of the node of a
> >>   kthread, it is removed from the kthread's applied
> >>   affinity. The last resort is to affine the kthread to all online
> >>   housekeeping CPUs.
> > 
> > But I am not really sure about this part. Sure it makes sense to set the
> > affinity to exclude isolated CPUs but why do we care about hotplug
> > events at all. Let's say we offline all cpus from a given node (or
> > that all but isolated cpus are offline - is this even
> > realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> > affinity in such a case? In other words how is that different from
> > tasksetting an userspace task to a cpu that goes offline? We still do
> > allow such a task to run, right? We just do not care about affinity
> > anymore.
> 
> AFAIU it handles better the situation where all houskeeping cpus from
> the preferred node go down, then it affines to houskeeping cpus from any
> node vs any cpu including isolated ones.

Doesn't that happen automagically? Or can it end up on a random
isolated cpu?

-- 
Michal Hocko
SUSE Labs
