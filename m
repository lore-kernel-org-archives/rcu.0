Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B35390C99;
	Thu, 19 Mar 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942293; cv=none; b=OBI2WmQV1DPNlLqPFxnMMvU68FIXngkxmBJVyryoyYniKEtNs0vW/5GTp8BBw2m5yXX58M6O15b82myDWN57X8oHuEkVJDk2byyXnVW7o7S0Y+raZJIPzrNsfdgS5hXNZih1je8n4u2W4GDX6Y/OIpc6HyeVlqZ89wOWKcti2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942293; c=relaxed/simple;
	bh=onhOVTK80AMxZZ+yDhLTOQmbuzy0nPaHawf945+s19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQo5i+TkHhvGyuCAIkkAcYtQ5/u9eQyaQcejOc3sKYZjfYCtvyPTp4/Zq0V8uWo4YOp39fWMnP/wa/z9gTbfxDZQd6aoIm7F7B8Pwf0zwmHcQyGkIo0aK75d540yLXQJhX//CH6AVlYmePawQVFen6J3vdTgjVHjzdYfCI7dJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxz6m2FJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxz6m2FJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CABC2BCB0;
	Thu, 19 Mar 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942292;
	bh=onhOVTK80AMxZZ+yDhLTOQmbuzy0nPaHawf945+s19A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxz6m2FJYSvPHNYrkRkh/hCYxK/ULePCA3G+e62PbOrsvGPFWu6X8cdScDIUVCBxz
	 C/7u00vp+0lpML8PbX7dKUqAIuZH+70di4UG9Wkt1D3Yu8ln9fwnA66TbCHeRM67kK
	 elZWSfxpI6Ea/XpF8aYdL6+ttQF/ZnBpBWaq0zVWg4rQKq87itaENRapENQa4DCJZb
	 30SRMHHrFmYMuasev3qM+3MCI/Wk/2c/4KIHjCwlP/9nCTnDzSN+uEICq75F3/rtDz
	 TjHfXudOONTeOR2LxdF1+0OZRALqyq8wDh+L/sOFNh2hxoFkFstqacPK5gOHQ0OCyy
	 CkYs8NNn+1KzA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 75D34F40081;
	Thu, 19 Mar 2026 13:44:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 13:44:50 -0400
X-ME-Sender: <xms:Eja8aQ__TtKA8F8o-QSwD07MWbwpO3BjDRS6f650i2_3gwS6rdU5dA>
    <xme:Eja8aTEo0y9kTriL_DrarySYZ5jQ0jCls8-nK1wc2v6SW4eE_8rLIWy3VNNXwkyZW
    jvceQUtvEZOCTaB7d23wlC4YxjdlhFpTh_OxhKREB2HAzixpwN2tA>
X-ME-Received: <xmr:Eja8acLC9koI4Bo2MV3DujuxMwmDIEvOa3WCC5kX4o0A95tgW2mwHqjr109K5UVu9RE8lSjHhokbXzAla0ARib_EP3eZdLgO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghi
    ghgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehjohgvlhgrghhnvg
    hlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    uhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Eja8ablcSoBs1dJR13v6RKTDyTwpQWjhGhd-yCV2TaytMnZqMdxtBg>
    <xmx:Eja8ady1ruuu9JVdbUfJD1ZaawROIMPydANOGw0jqYynd8-ErYwtlA>
    <xmx:Eja8aduJQfOo_-on0RQU60e0__HKYLQDW6fcAaTJC25o31hGmv7TZQ>
    <xmx:Eja8aXHkidULyYImpBGCpkSFgHY3rRr6fZfkogeYmleqg_NzYEvL8Q>
    <xmx:Eja8ab6Zsbu1iC8YT14gUNxMBne_UEMYo75twZLISZEBSxk3m4GHn6Zn>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:44:49 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:44:48 -0700
From: Boqun Feng <boqun@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abw2ECYirX1tTwV9@tardis.local>
References: <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <20260319170244.jqndSwct@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319170244.jqndSwct@linutronix.de>

On Thu, Mar 19, 2026 at 06:02:44PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-19 09:48:16 [-0700], Boqun Feng wrote:
> > I agree it's not RCU's fault ;-)
> 
> I never claimed it is anyone's fault. I just see that BPF should be able
> to do things which kgdb would not be allowed to.
> 
> > I guess it'll be difficult to restrict BPF, however maybe BPF can call
> > call_srcu() in irq_work instead? Or a more systematic defer mechanism
> > that allows BPF to defer any lock holding functions to a different
> > context. (We have a similar issue that BPF cannot call kfree_rcu() in
> > some cases IIRC).
> > 
> > But we need to fix this in v7.0, so this short-term fix is still needed.
> 
> I would prefer something substantial before we rush to get a quick fix
> and move on.
> 

The quick fix here is really "restore the previous behavior of
call_rcu_tasks_trace() in call_srcu()", and the future work will
naturally happen: if the extra irq_work layer turns out calling issues
to other SRCU users, then we need to fix them as well. Otherwise, there
is no real need to avoid the extra irq_work hop. So I *think* it's OK
;-)

Cleaning up all the ad-hoc irq_work usages in BPF is another thing,
which can happen if we learn about all the cases and have a good design.

> If we could get that irq_work() part only for BPF where it is required
> then it would be already a step forward.
> 

I'm happy to include that (i.e. using Qiang's suggestion) if Joel also
agrees.

> Long term it would be nice if we could avoid calling this while locks
> are held. I think call_rcu() can't be used under rq/pi lock, but timers
> should be fine.
> 
> Is this rq/pi locking originating from "regular" BPF code or sched_ext?
> 

I think if you have any tracepoint (include traceable functions) under
rq/pi locking, then potentially BPF can call call_srcu() there.

The root cause of the issues is that BPF is actually like a NMI unless
the code is noinstr (There is a rabit hole about BPF calling
call_srcu() while it's instrumenting call_srcu() itself). And the right
way to solve all the issues is to have a general defer mechanism for
BPF.

Regards,
Boqun

> > Regars,
> > Boqun
> > 
> > > > Regards,
> > > > Boqun
> 
> Sebastian
