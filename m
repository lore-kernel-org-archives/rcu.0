Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428C2D1913
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870952; cv=none; b=EJZka3K7F3LB6PRbehAebv8UW9FPl8FBXiulOYen+nYhwcBDHK9TJXKRtX6dWgOtyl/oGpUfNKEsAf9+KHu47t43UUEiQVXTKMHSRZOZXb3jISYnBA60s4xKnAv2RcghiMT5RUK2D+RZN7Paiu6J2ZBE+dGdFwseZ+88DtuiDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870952; c=relaxed/simple;
	bh=qLp87+PS2VoqChkKXHptwT5mpcC0wE+8/ZBPtce/Mpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTWYj9BFeNYJOXCNFy8DqWGnfCOI+KhL2+N2uyrGJ3BECjQGWu1ODcrMXfzbwQWRjYTxnt1qtItTHitDzNQI2qw1kZSgoC8rCqkVQOD1/yLlq8zuh0n0BVFjDHZe5A2vgvwh/yNoC8YQkzeQmZFLyAu3w51PlUB0VzBYygUr4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpFMRFyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpFMRFyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8317CC4AF09;
	Wed, 18 Mar 2026 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773870952;
	bh=qLp87+PS2VoqChkKXHptwT5mpcC0wE+8/ZBPtce/Mpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpFMRFyr4t6kmD70Rd1FbmP6Spho394srNGKMD7jybr5nh0hR8s7vc3GcASj4Ba8G
	 aGuCACgq8MSplaYVXzYNz+Sw/+0Tnrl0cMBE2gHToh8f+zf16f+ivCbsZJ6gKym+XJ
	 ozk2A18KIQn0fqybJqRtRYI7rYqWOPHuOnLypF7xL7JjSu46c/k1KWTZaWREfdLuVS
	 pkgRG4V0UaWCePEjQJLeYLikyIMNRB9BjbzIETVg5yFI1ohxuHvpqgIX+0dnsC9VXa
	 7KQg/tapH37VapSt+PkY02syYm24qahZl24dEfhfaRJ/V4BbQzNvPzWWa+VlK36TSZ
	 PqrDosTON0jHg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45D41F4008E;
	Wed, 18 Mar 2026 17:55:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 17:55:50 -0400
X-ME-Sender: <xms:Zh-7aavjA5pLImuOS6IQkJMr7hr5YhMtW0n98RJRi0I8Ikn0_pmE5g>
    <xme:Zh-7acB4o7UquotZYZYwcE-PgOH8f_4ClVCiPPY4KfV_E9E9MYOH0dxeUgCrR4tra
    Hf0fAiigZ-Hus6WyiuLf_FRWepB7o20n3hg8hq_Bcsz8Q4ICR0fIw>
X-ME-Received: <xmr:Zh-7aaMivXm6WC0rKIB1b_rkUc2xNdMQ-eZnMw5VzH4O8G7CLnuvEkfHGcWevtbjGtFrleuKcwaz02PiZZFZAAEG5ae8CiPl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepkefghffhueehlefhkeetueffjeevteejfeffte
    ettdetgeefffdtudetuddugfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghl
    rdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhm
    pdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    highgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhi
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgt
    phhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtg
    husehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:Zh-7acAyXzvsAmStgRamjhljZj_DuEj7-3GsCju8tJRAXawBYnk7GQ>
    <xmx:Zh-7ab7zPnRre8j35w4Fjzr9GgSCQnRaGHGAemeW_WCZA6W30bM55w>
    <xmx:Zh-7aW7z9F0_q-RxUIwmkWFl1PIcVylwqiZTR0hYK016LdvimeFlig>
    <xmx:Zh-7adTiKHV-MQBbam10tWu6iWxCeEhRBptbzXGYv4UWQuJTvNNSZg>
    <xmx:Zh-7ae8cFVSynvYby7Z_uVNkygdB4A0DTItY8ZYfTKXEbWM3hYqR3bsI>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:55:49 -0400 (EDT)
Date: Wed, 18 Mar 2026 14:55:48 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <absfZGD3en9TUA1U@tardis.local>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <absesPf-10awctq9@tardis.local>

On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
[...]
> > Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> > different issue, from the NMI issue? It is more of an issue of calling
> > call_srcu  API with scheduler locks held.
> > 
> > Something like below I think:
> > 
> >   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
> >   ----------------------------         ------------------------------------
> >   [1] holds  &rq->__lock
> >                                         [2]
> >                                         -> call_srcu
> >                                         -> srcu_gp_start_if_needed
> >                                         -> srcu_funnel_gp_start
> >                                         -> spin_lock_irqsave_ssp_content...
> > 					  -> holds srcu locks
> > 
> >   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
> >                                                  -> queue_delayed_work
> >           -> call_srcu()                         -> __queue_work()
> >           -> srcu_gp_start_if_needed()           -> wake_up_worker()
> >           -> srcu_funnel_gp_start()              -> try_to_wake_up()
> >           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
> >           -> WANTS srcu locks
> 
> I see, we can also have a self deadlock even without CPU B, when CPU A
> is going to try_to_wake_up() the a worker on the same CPU.
> 
> An interesting observation is that the deadlock can be avoided in
> queue_delayed_work() uses a non-zero delay, that means a timer will be
> armed instead of acquiring the rq lock.
> 
> (But I guess BPF also wants to run with timer base lock held, right? ;-)
> ;-) ;-)).
> 
> /me going to check Paul's second fix at rcu/dev.
> 

Oh I mis-read, there is no second fix, just a rcutorture changes. Let me
see if I can find out a quick fix ;-)

Regards,
Boqun

> Regards,
> Boqun
> 
> > 
> > If I understand this, this looks like an issue that can happen independent
> > of the conversion of the spin locks.
> > 
> > thanks,
> > 
> > -- 
> > Joel Fernandes
