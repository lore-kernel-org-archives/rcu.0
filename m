Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7E405F7
	for <rcu@vger.kernel.org>; Thu, 23 Nov 2023 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBdkpKlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC9C433CA;
	Thu, 23 Nov 2023 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700761333;
	bh=wybC9NjaiAT+ygrEqCj1gw53nZJCWLLQbHdCCoiI/ig=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GBdkpKlpgH7AqaOJ59Z5kDNAyx7ZXldXmt4Bp5Candjvu78uXT43J9978CjQuoFhu
	 y5zGm3I6G+0ML0KaJSApyOKMZMP28QzA2SGy/Eu6ASH3htPcjxRkHZYXB54hza6rpF
	 bglT3uCnajq0KnPc/BRZ+8NXKmgMQLrJFoz5yIzdCfUFXX7QDEV3jW+oSEvJ+d6EEy
	 E37lvDGqFnLAXUXnlBJUfQ2pfj33+oAd+kNZ8wWG1JqKDo3bK+dvQfpi/syL+nppPq
	 rvwGzGYw9zlRHoCN9TSftKcjTHyJwChX6qHe9tD66kEjeqNnjsiCiMT1U+K9z5qlnB
	 1h6u9mWqppoiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EEF54CE0D0D; Thu, 23 Nov 2023 09:42:12 -0800 (PST)
Date: Thu, 23 Nov 2023 09:42:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <4ec83bf4-4c56-4f47-8473-151b57b80840@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
 <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
 <20231121221556.vtpmboamgszbt3jf@airbuntu>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121221556.vtpmboamgszbt3jf@airbuntu>

On Tue, Nov 21, 2023 at 10:15:56PM +0000, Qais Yousef wrote:
> On 11/22/23 15:26, Paul E. McKenney wrote:
> 
> > > Either way; I'll follow what the crowd wants too :-)
> > 
> > Usually a wise choice.  ;-)
> > 
> > But I must defer to the people using it.
> 
> >From Android PoV I'd like to be able to boot with default disabled and allow
> people to opt-in. At least for the time being until we have confidence no one
> is caught with surprise if this caused unexpected problems.
> 
> In the future it might default to on once it gets wider usage and testing.
> 
> So having a new Kconfig to DEFAULT_OFF sounds good to me to enable a compile
> time switch to pick the default with a boot time to further control.
> 
> Which would be my plan for v2 unless I hear another suggestion in the coming
> week (where I hope people would have had a chance to look and think about it).

Sounds good to me!  Silence will be interpreted as assent.  ;-)

							Thanx, Paul

> > > No need for the rcu_barrier() then? Only reason why we use the _cb flavour
> > 
> > The module_param() parameters are processed during early boot, before
> > the boot CPU has enabled interrupts.  In fact, before rcu_init()
> > is invoked, which is in turn long before the scheduler has started.
> > Calling rcu_barrier() that early is not so good for your kernel's
> > actuarial statistics.
> 
> Ah, I missed that it is done that early.
> 
> > 
> > I am guessing that the module_param_cb() processing happens somewhat
> > later in the kernel's lifetime.
> 
> 
> Thanks!
> 
> --
> Qais Yousef
