Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB639F17F
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951658; cv=none; b=sAMKinfEC11Y4y8pYpbluEn8zuTD2VyhzqpwNHd6o0OdP7KLPH5pPCOkvZ1eRaAXL906Zi3QwAhKzsu62ilFbqH+v5UaVQJm1Y9af3vqbTfCF3gtFzUpfMjllIGuu8O23JeRE+Q+9tprcPSVvFNka3ekuR/biAuE9NV6wNFAJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951658; c=relaxed/simple;
	bh=rWRwxJ0Lc6XFEsDidVrvYvVp8gYMBObbcxwPOdg4p5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiZ3ac7Iu435wZznBQthZsPNG6tpwk84hEPPhiOdRZSYZwjV3vPm1+UrFXMTChwdlDMiTOI7Dxd0rW/LsviuRHAbbNMVoCAkVzG0XXtygID3G1csV+ROSO6mmyBSVyM3W4epC4XFY0T98FhBGW8nUSx4L6TRKgDbmXDqBGA6SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOjJwFaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOjJwFaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F4BC4AF0C;
	Thu, 19 Mar 2026 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951658;
	bh=rWRwxJ0Lc6XFEsDidVrvYvVp8gYMBObbcxwPOdg4p5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOjJwFaNUJUskrfU9YcDRdTUa8EChLIuudemFiEUMYrRBwcYIVrSbkAeQLVYVzJPX
	 crkinUAlN096vERBk+to49rPG1uiwycByV2arMy2t25iGLQsFaG98DHNIwaNGYcjHW
	 MKfuybm7shQOjVOQpjWoYHwJ8ED/bA7sTGJVoaDSpxmNfQdk/i9Gc86t+7cxwu9dA8
	 Rruw+uY8KVwPcZzOJwbAQugMv28gcgkWkSwmnrqQ8JW990DDCKDhsjMl/uE0jVmATi
	 FFN8Lu1MwixTEiLQCR4Ll/c9Ihr3h/ydOr8PA4guc3V9oil/570Esya+/ztTs+Hd4k
	 Eq9aGug4xKnFw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 905E3F40071;
	Thu, 19 Mar 2026 16:20:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 16:20:56 -0400
X-ME-Sender: <xms:qFq8aXetvjToFKiJfqyG_BAKT4fRL3iuktIxZ5zzOBRfEBWSxIjDuQ>
    <xme:qFq8aWkRI7KnONlhEbi8n1S9eVJELUTUWaEWxSr8tpGkQM48l-PD_Na8hGDLQRq0l
    9hE-i8ZujsGnbEm5VwG6w1EEWi-SLAFh2RpfAhb0tLrh-b-FC2DK24>
X-ME-Received: <xmr:qFq8aZD9XUWApyDZOVkQv-nF6CGNmpM5jyOQVeM71f0-2UpO46uoBAqI_KKLLmn985tUxBL1rm4iyZtt850m23gAJIxNynqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvug
    gvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdu
    tdesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomh
    dprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvmhigohhrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qFq8aYfUzNcPIJFeEHZEhteFf6bybY7JZqUtXlBySVF1i0hRwGPQDQ>
    <xmx:qFq8aU7NSMZnMsX1ZZ5VkJGS5O47r0uDaqkVWn18vx0NbHlCa1ZpSA>
    <xmx:qFq8aSNI3Wp_1M9ehw4Bt26VTtEjQqQL-f-n0WP19chdqKLr3OCRgw>
    <xmx:qFq8aVHLQOM_aEZ2ZZDxzsPr-b0AyebHpE9g8vE3pPeBaYUtYa5Nqg>
    <xmx:qFq8aWQWMu96uDE-WyQo9rNcceFpIp-AZDPIwYYotkzIgM6vFQThS9bA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 16:20:56 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:20:55 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abxap0vo0SoP5Jh0@tardis.local>
References: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <20260319170244.jqndSwct@linutronix.de>
 <abw2ECYirX1tTwV9@tardis.local>
 <c520958e-78e1-41ce-b675-4a560305a206@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c520958e-78e1-41ce-b675-4a560305a206@nvidia.com>

On Thu, Mar 19, 2026 at 02:42:56PM -0400, Joel Fernandes wrote:
> On 3/19/2026 1:44 PM, Boqun Feng wrote:
> > On Thu, Mar 19, 2026 at 06:02:44PM +0100, Sebastian Andrzej Siewior wrote:
> >> On 2026-03-19 09:48:16 [-0700], Boqun Feng wrote:
> >>> I agree it's not RCU's fault ;-)
> >>
> >> I never claimed it is anyone's fault. I just see that BPF should be able
> >> to do things which kgdb would not be allowed to.
> >>
> >>> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> >>> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> >>> that allows BPF to defer any lock holding functions to a different
> >>> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> >>> some cases IIRC).
> >>>
> >>> But we need to fix this in v7.0, so this short-term fix is still needed.
> >>
> >> I would prefer something substantial before we rush to get a quick fix
> >> and move on.
> >>
> > 
> > The quick fix here is really "restore the previous behavior of
> > call_rcu_tasks_trace() in call_srcu()", and the future work will
> 
> Unfortunately reverting c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in
> terms of SRCU-fast") is tricky since the original body of RCU Tasks Trace code
> is deleted. Perhaps we should have added an easier escape-hatch, lesson learnt:)
> 
> > naturally happen: if the extra irq_work layer turns out calling issues
> > to other SRCU users, then we need to fix them as well. Otherwise, there
> > is no real need to avoid the extra irq_work hop. So I *think* it's OK
> > ;-)
> > 
> > Cleaning up all the ad-hoc irq_work usages in BPF is another thing,
> > which can happen if we learn about all the cases and have a good design.
> > 
> >> If we could get that irq_work() part only for BPF where it is required
> >> then it would be already a step forward.
> >>
> > 
> > I'm happy to include that (i.e. using Qiang's suggestion) if Joel also
> > agrees.
> 
> Sure, I am Ok with sort of short-term fix, but I worry that it still does not
> the issues due to the tasks-trace conversion. In particular, it doesn't fix the
> issue Andrea reported AFAICS, because there is a dependency on pool->lock? see:
> https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> 
> That happens precisely because of the queue_delayed_work() happening from the
> SRCU tasks-trace specific BPF right?
> 
> This looks something like this, due to combination of SRCU, scheduler and WQ:
> 
> srcu_usage.lock -> pool->lock -> pi_lock -> rq->__lock
>        ^                                       |
>        |                                       |
>        +----------- DEADLOCK CYCLE ------------+
> 
> >> Long term it would be nice if we could avoid calling this while locks
> >> are held. I think call_rcu() can't be used under rq/pi lock, but timers
> >> should be fine.
> >>
> >> Is this rq/pi locking originating from "regular" BPF code or sched_ext?
> >>
> > 
> > I think if you have any tracepoint (include traceable functions) under
> > rq/pi locking, then potentially BPF can call call_srcu() there.
> 
> > 
> > The root cause of the issues is that BPF is actually like a NMI unless
> > the code is noinstr (There is a rabit hole about BPF calling
> > call_srcu() while it's instrumenting call_srcu() itself). And the right
> > way to solve all the issues is to have a general defer mechanism for
> > BPF.
> Will that really solve the above mentioned issue though that Andrea reported?
> 

It should, since we call irq_work to queue_work instead queue_work
directly, so we break the srcu_usage.lock -> pool->lock dependency. But
yes, some tests would be good, the code is at:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ srcu-fix

related commits are:

78dcdc35d85f rcu: Use an intermediate irq_work to start process_srcu()
0490fe4b5c39 srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()

One fixes the raw spinlock vs spinlock issue, the other fixes the
deadlock.

Regards,
Boqun

> +Andrea, +Steve as well.
> 
> thanks,
> 
> --
> Joel Fernandes
> 
