Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E703EE1F7
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938901; cv=none; b=mkT3Z93GAhqxxQBZZg+TEt4l+zhRBbCUSqz3d7co+fLrJ3kribTaMsVDYQUQDXAKKv2xl1EeaIBECRJTBmsiDPeUsvC61JHuKBS9T93a6bfdJ5SigsafXg74vY+xnrc8FZHT6/zXHr2ingvcsakyHewPaP/MaBiMT84LVJhBrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938901; c=relaxed/simple;
	bh=BW+s1tfvjSzvorY/ZLwBEykUFgF+GdVyXuLp1ysnz7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih2ibI61/NTg8AcfZOicuPh3WtjAO9YaYU2cmIpcaymoxzeW7wk10pSoW1a5lSbHOuSMHMjunVykROtnwgT//0Y0IbZLj6Ap+aqB+f7yxl+aJlijTkvIi5zFT+7nlRVHzK5GlKe3iQmj5qZIkhzSeheZ13dGre+wtusCfwAAHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU4z0T0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU4z0T0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6468BC4AF0B;
	Thu, 19 Mar 2026 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938900;
	bh=BW+s1tfvjSzvorY/ZLwBEykUFgF+GdVyXuLp1ysnz7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU4z0T0ly3DCHb/hQwHCEWHIPXFk7kOJvVELPtGaFh+sliuK9/Rv2s80VtauVUTfg
	 1IDkgg26BBUwNnxsPRJWl3YZGD50OMKxvoIX83bP5lk9CVenO5jeAGcUrTwxR3oV8D
	 8OBgwJqWH4Fo5rCZJbGeH1LeYMdQ8O8ZfN2/9GLfTIAKHLbenKZQ+DqwrUWayCsj9p
	 bbXNYZTr9KTJ46kv4dGTqAFaAQDp1G7bLYpaO/SnRZojWcr3oIJuFpf2zm+cl0XLh6
	 yxy286MPKQ7cy5JMOHGI7SKO/MNa4Tv1wJdaiiK7WnPhGjOsU8LCpCNi0Wbjad1yjN
	 5i2cidYoSEpzA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C889F40073;
	Thu, 19 Mar 2026 12:48:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 19 Mar 2026 12:48:18 -0400
X-ME-Sender: <xms:0ii8af4qtLUBqFla_35wBurD4IJfxeJLdEnxHmQPU_dpDPX_TSkevA>
    <xme:0ii8afSWs6mqniQlsBm5HnZ3jNvm_ZVcw7AROlCi2wUz5HXT_k1OFmOxRrS_dqfOQ
    KHXHAsQ5XCiCFXUtOpelULc-FJoT6nLPfjDg7if5jGhLPpt2p7POg>
X-ME-Received: <xmr:0ii8ackdzQgcCTJ0x-9qv3RNylAK8KEX_WixbmFxbg5P3tHPZf9-GnLag6sGD1EzglK8gq4GNQ0_HfPxawf1vYnR0je17772>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejheefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0ii8abRoy-YiMLexhYV2s85vPWkTVAHTaOL7X7cP2T6tWFrNrs2wdA>
    <xmx:0ii8abtRyDYGxbz1Dpq3ztAnS9clEQjW0UWTMA43Gxm_TLcoT4hcEA>
    <xmx:0ii8ac5BxwK5TvAMQqgKpVdXfSWokgDqWahCAJNEAzIuxEjP0LnLKQ>
    <xmx:0ii8aeiIweIOTObvuQ08d4gaHh5IeCiMUYy1CUMa30acBRWQGQsM3A>
    <xmx:0ii8aWmK2SmcGziRtlzedc1f4FJ5UhkBqaw2O-QHowHNxr_YEfLVSA6z>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 12:48:17 -0400 (EDT)
Date: Thu, 19 Mar 2026 09:48:16 -0700
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
Message-ID: <abwo0I_mu94t5Ews@tardis.local>
References: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319163350.c7WuYOM9@linutronix.de>

On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > Please just use the queue_delayed_work() with a delay >0.
> > > 
> > 
> > That doesn't work since queue_delayed_work() with a positive delay will
> > still acquire timer base lock, and we can have BPF instrument with timer
> > base lock held i.e. calling call_srcu() with timer base lock.
> > 
> > irq_work on the other hand doesn't use any locking.
> 
> Could we please restrict BPF somehow so it does roam free? It is
> absolutely awful to have irq_work() in call_srcu() just because it
> might acquire locks.
> 

I agree it's not RCU's fault ;-)

I guess it'll be difficult to restrict BPF, however maybe BPF can call
call_srcu() in irq_work instead? Or a more systematic defer mechanism
that allows BPF to defer any lock holding functions to a different
context. (We have a similar issue that BPF cannot call kfree_rcu() in
some cases IIRC).

But we need to fix this in v7.0, so this short-term fix is still needed.

Regars,
Boqun

> > Regards,
> > Boqun
> > 
> Sebastian
