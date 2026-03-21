Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BB303A0A
	for <rcu@vger.kernel.org>; Sat, 21 Mar 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116423; cv=none; b=Fc1DCc5Qolb7wnohAkCJcdo6vuqgJMUHXaY+kotGhcto9dTvVNG+fmGLp8aEDgcDsJOaH04/xJJmdELpfqq3yjxUX7FCu0PJK6CvP/LwTRw9Pj0UcjRm6OTlteOI6ZIevQfUl8MF58l6cu+jvROMyUQNdXAP7xBkIUxd6/y2syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116423; c=relaxed/simple;
	bh=9SI804+dfgP3coyKqaFN4HwiKt+xbISR1utGkPjaJeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVjxUuTNhrHWKQP7rKeWA5qCFFrlqYwD0yg5qC3WsMJ4+LZHAe+fS1nKLGlpWSIgR8Apa30mGDDTMTepBCK4iDqw3Te6vSTnZP9Bt04yN5FIuHIdQiKVkCp1XaBuYdZR6hAKrapg0iJzI0ZsS3q8ccwkeiWtt3FXGwwFdtgdxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf4iZygR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf4iZygR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B7BC4AF0B;
	Sat, 21 Mar 2026 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116423;
	bh=9SI804+dfgP3coyKqaFN4HwiKt+xbISR1utGkPjaJeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kf4iZygRTpyRdjGidcumAFJng9m7wAu6oeBZXGs8BIQWJXQK7M0uBhvJQaq4GmHXn
	 DLbsR+Jn8ERLJ57OwtIrlso/4/h1XZm2m7oiE+DIDDAQiAVlEhZy+VFX2FT6qfFA8n
	 KiakcVMhoCfF+07p92h0yswrVFl/BWgVk1pt4Xm1gfIfGdmPjDG8uyFNDZY+2GEDgx
	 mSUb1/Qpd2Xun0c1z0x9FVcYSX2VZ19qcIpvZaFWvpHEN2rQkEkCWQdeuZWRZL6f80
	 cZJGc81rl36ufqw1Qz6wlHspFBdkeJXzCv1HlS8eVptHPtYuWpmzEZ6HfFRLZ5O+/U
	 zaQx9Om/k57Ww==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 53683F4006B;
	Sat, 21 Mar 2026 14:07:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 21 Mar 2026 14:07:01 -0400
X-ME-Sender: <xms:Rd6-aXWUpJFVVNnuB-V61RctUwmrOiozEyoraGLm5eLo5kTVUZvZMQ>
    <xme:Rd6-aY-ftgPT4Fc0fdAPU8_HGDghgj2WtRUwI04prYvkw3BTaQMqO_5H7HNEsSTTS
    DQH-XcFVenRxxrztCcsNg8yKYt-4y3KKwW-xkPedSKoagGxyg5tbw>
X-ME-Received: <xmr:Rd6-ab6n75HiH8_ILfoHHPCH3X-dL7rtZE5FAVsiDDteTrdANoBAbmpPcuxWN_aCYvNxHLv-HTt5wVnpbuSQGE9OdZ1IW4L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Rd6-aR2eHxdt2k9RTHyq5j6tv_RfJQ71UBh87yuoTdtg05SkEv4LWQ>
    <xmx:Rd6-aSxm7Qdm5ZWaxEliby2P7rJv4By7e7A9huA5JavidCSXrngf-g>
    <xmx:Rd6-aanS8a-6-u0lvEe9ol9-KnSuHUF_441iv0rELexzPXJl4WNcYA>
    <xmx:Rd6-aV8q_KjkaqWxBbnxiO5ZXNq9yANuk1wNyhfww4m3Cvfvhskutg>
    <xmx:Rd6-aVojSDzpS66_ps_Xt3nIBqNDnqa_IibVQ0le_O-V8BO9pvYqz1zn>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 14:07:00 -0400 (EDT)
Date: Sat, 21 Mar 2026 11:06:59 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <ab7eQ0QDNV9ZjQMN@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>

On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
[...]
> > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > +	delay = srcu_get_delay(ssp);
> > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > 
> > 
> > It was fixed differently in v2:
> > 
> > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > 
> > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > overly careful code is probably fine ;-)
> > 
> > Thanks for the testing and feedback.
> 
> OK, I will try that one, thank you!
> 
> FYI, with my change on your earlier version, SRCU-T got deadlocks between
> the pi-lock and the workqueue pool lock.  Which might or might not be
> particularly urgent.
> 

I just checked my run yesterday, I also hit it. It's probably what
Zqiang has found:

	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/

We have a queue_work_on() in srcu_schedule_cbs_sdp(), so

    srcu_torture_deferred_free():
      raw_spin_lock_irqsave(->pi_lock,...);
      call_srcu():
        if (snp == snp_leaf && snp_seq != s) {
           srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
	     if (!delay)
               queue_work_on(...)

I was about to reply to Zqiang, fixing that could be a touch design
decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
incoming.

Regards,
Boqun

> 							Thanx, Paul
> 
