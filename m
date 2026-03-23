Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C18381B14;
	Mon, 23 Mar 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304343; cv=none; b=qfI7UMwUkG6v3MMm2QVubLrB4zKe6MYOgeHih1kXROa1Mpu7NpnLp68aXB2xRuG3yxQ0ySrR2VkgWixSQv6JUYP8cIPyqN0rcWZ3pTHlJP5xf+/zVi+pTslA9hvFD3nG2JERu0s2H6o0xTmzfRg9bPkuTXClE3kYjffOKdwfEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304343; c=relaxed/simple;
	bh=x0hI+jBcfbSimYeAjY+NYzvD0YkEAPCpfoo395I5Je0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sThfIx8BRtFMH6gc2DZq802asUrfgCOH+GflnZGGv0QCmqLYNgRCHeDJeunrH81twOokLF9uCqSEzea7mtd9/6VHFnULOos0zhCUWuBjd8H3hs5S7X7eaICaCfjYaN0yZHdd9MBzikv9iTsUYPHkLcNfz7ZwsOs8mWdL4Fj0cY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irlTCBe1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irlTCBe1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15643C2BC9E;
	Mon, 23 Mar 2026 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304342;
	bh=x0hI+jBcfbSimYeAjY+NYzvD0YkEAPCpfoo395I5Je0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irlTCBe1AMUicEJyhSmnpt1X59a332s1qwagVIOkB5iDT9CyZaVAQ1xhGa0MCnwHz
	 +yI+dT46/fQBPYXtd5WXXuxBFH0F5rNq/lD5+maEv57QSwS0ecRwXRYPm16pHygH6e
	 D55ZNd0OKTE4plIXvEHg05p95sxPWXPFuBJb9XvueDa74PdLCYYbE+Usf1X5sba6wn
	 qJiJjkcs3U5N0JaBgdi5frsFCIdzhpRGaL6OpaiNSLpSFjxzKXbS2eOcTmAhkI/Ygr
	 Btr5gm7Li5Vn0lDNvSfzFZ6nBVMY+ux98JiXTs82hvX3ihiLS3UicRQwWINLY1CsPD
	 Luj0oK4vTJWow==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33FA2F40078;
	Mon, 23 Mar 2026 18:19:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 18:19:01 -0400
X-ME-Sender: <xms:VbzBafBavgHC6mc1WA24a-ZI4nOU2ZV-4VJsftS4EVEckCk8jdmSGw>
    <xme:VbzBae6jZoo0O5n8O-dPiqF_0wI4bR-aD81TA7HuK64-u712KO0o0UHkso_sAKral
    hdUDNoR4Elgqry8bn6RXnfMAWHXmNIdSXNn76_dXf6hLgOumxH7dQ>
X-ME-Received: <xmr:VbzBaTHeYnizoq-T0b1wE-FUuH5iL3hGULCndLZB0SOsTa8fcFNi7NtMIRDIpzp9gPj_BJ92EpqLkslXx-cGl63cvLL89rVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelkeelucetufdoteggodetrf
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
    gtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VbzBaRQfHaUg6ChoAJ4MGBs59NTJn50m2l7e2zCQAKXVqZLtew5RCA>
    <xmx:VbzBaVc5b1ToY3LjhxIBwrL9ZF5SYfSPMv90wmu-MW-5ofybQ5LvcA>
    <xmx:VbzBafhdldySbm8u7Hhyq0Pqr3eoT2ImiAmQE_eDniXPAlLqzhNgrw>
    <xmx:VbzBaQJ1m4hV0Wpcbdls2MxtptxyGz4Zr7WzwfEaUm7Enwr7hkA9FQ>
    <xmx:VbzBacFcbbiElvvIVXuv7Yv5PnLsx_s_Q_BCo1n_Ioc_cR9hoHlXl3JD>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 18:19:00 -0400 (EDT)
Date: Mon, 23 Mar 2026 15:18:59 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
Message-ID: <acG8UyL4cFlXvs-B@tardis.local>
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
 <8fb6b64c-5c75-4b42-8abd-8e85173710a5@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb6b64c-5c75-4b42-8abd-8e85173710a5@nvidia.com>

On Mon, Mar 23, 2026 at 05:09:53PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/20/2026 6:29 PM, Boqun Feng wrote:
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> > 
> > [boqun: Apply Joel's feedback]
> > [boqun: Apply Andrea's test feedback]
> > 
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Tested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> 
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> I have the following in the shared rcu tree rcu/dev branch, but if you're
> sending it for 7.0 -rc cycle I will drop them:
> 
> 998608c o rcu: Use an intermediate irq_work to start process_srcu()
> 15d921a o rcutorture: Test call_srcu() with preemption disabled and not
> 

Thank you. I think Paul has another one we need for v7.0:

	https://lore.kernel.org/rcu/ad67e723-7f7d-4350-b886-c04e56c0b78d@paulmck-laptop/

I've made an fixes.v7.0-rc4 branch at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git fixes.v7.0-rc4

with these commits on top of -rc4:

d0f816d5e872 rcu: Use an intermediate irq_work to start process_srcu()
6b7fc20ab878 srcu: Push srcu_node allocation to GP when non-preemptible
f627bbab8fd0 srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()

I will send a PR at Wednesday if I don't hear any objection. Thanks!

Regards,
Boqun

> thanks,
> 
> -- 
> Joel Fernandes
> 
[..]
