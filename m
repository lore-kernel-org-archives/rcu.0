Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5037C926;
	Sun, 27 Sep 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529855; cv=none; b=HIvBa2C//p69s6YmpjaPQ4mA44Dhz37aIYpC780pLs/WN3VX6J6WsG0NkMMVB28sDmKqyyDUp3Be3XMhbHxIHiqCSmMHnO6pH4UQAxK6P0AebccuhBx7OYirzg9fPFASYeL5GpWdk9vxiAfCzpRCjP5f+9AT5JRhw4jcM+6k1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529855; c=relaxed/simple;
	bh=MeGrK8YfWvafmUOL0X4RjmHpY1j4mqMYXco+hIrf4tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpWBiwCY/PMKZy4zlRtHiLCW+DckSm+biV7SqOAZ8ZNs7tVgBCX4d8TE6poPrUsy7SLkhfriohkGbknmVwV9ndyXlSUV3E7HUGGwuKgXBUwX1urxdkk9PVbHAcNO2k/WcMISSFyobLoSuHchIFKg2UZg5nBzwku1MTzIi5oDT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAdIBVmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAdIBVmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168681F00898;
	Sun, 27 Sep 2026 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529854;
	bh=XAG9Mub6do0/YvxTQaP+O+8WLPpaLUk8c/BmeAvudk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aAdIBVmZ6Q5iiC+LASB41gq5o2ChQlYoUSxgdtzle7GW4AgTp+1+FWXbJl5tGxfxo
	 +QHoIg/SpsYizAwExWvrLEZQ3xF7OWX6KtG8vVkCBqi58ng/lnLaFncx9BoM5Wn0Ns
	 CueU7ylwGzIu5bDwml5tCA3W2wtKdnPwGYfNEhQVS1Xvt4ahbXtzmj7+wtZfbqE0ms
	 0cVbrGdVlo7WXW8Rx3qH2Z1NmfVEfubiKWDv9b+axv1nLkWdSoErxDadmtYgwFq4K3
	 YyIctoYbNl4iAVIZLXBo42N09M4U7lM+MW2FtUxJLcNpNcGtaR9G/MCCSztwJ6bzWF
	 II0X/MI+4AeGw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1703EF40067;
	Sun, 27 Sep 2026 13:24:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 27 Sep 2026 13:24:13 -0400
X-ME-Sender: <xms:PVG5ao1rMqG5cpIXbYq2VVYDdx5If-MnjFtFDfHPI1PMiRoQ9n_h-g>
    <xme:PVG5avF2zDtkJiw8r4r69447DHRTLcWUOdBq0Xw-VJ8KCyjsVf5MxWv6W92u6luXC
    QFH91-6l-Ui0Bqx7b80cXm8JJpsIujPKshDczpcmcehSGU7kD7CH_A>
X-ME-Received: <xmr:PVG5ajF72k9PUjFaXEjCS5ZJXu1aJFo_qPIDSaljeI9lWdzp1csW-Qn1z0DL>
X-ME-Proxy-Cause: dmFkZTEz5mB8zCIAGCXrp7RUiQQUepCvMede+Cw3EQaTvRN4+kzAs2UKWiCyLj5YPSAzxV
    oorBmKvazoIR2yMYiy8gtEKa6np8jUnVSeTMen12syz7ijzssnssAU34xDELZK4+jRdQ9h
    tGYvlJ8bwxnjtSoSimkcdgpG3xWUzI7XIn8ssWVRAShtYonCwXbVZsDxyqXor4T5h0vcC8
    7/KmnXdf9LRpr9Kih1Np+izA8faBt8LrCARacC/2j0DyP4OwGmmZAhXfpAkFIM8Em6HKN/
    HMkc2OUGVQeOzVy+h+c2bxrL0rmDDhsONNT9/Kwomvp98q+8gg8U17SpzWeiSiiyyA49Ft
    g1/aCMUFn2pWQhdD2U7AeexX7LTOWBeGq5w3FRXFu5G69As45oZgzb25/4WSDwrx+4/jbj
    aQQXLsLFnXTv+cZ8EHqPCckIgqd9WV4wTX80EbA09Et/esqi6sdH/5HLEdWF8tLhRUPXKz
    DKgqsjfVzqmpj5FI0NiDfAMTgJTi441wmzi1wIfH4nSkrCXAtHAeWoKesL3J/6hoGehU+6
    Eit2dYPHWNaGBmN+lrhCIs5XvZbD0fBIVNL8bZ7K4x8g8YorYEfDzycWSpLaeFECh8pr9j
    7XoMhr0J/f+jFcrNrCPdjIZeC4hSNO6te3FocHNGshmF50k/tX/Qrwcd+t3w
X-ME-Proxy: <xmx:PVG5ai5alIyW7n8bNCwLXIBe3sh2HmXYbbH4JIQOy1sdDV6OZvWozQ>
    <xmx:PVG5aoyOtbH5xpF3Y6yXsf0aQl8kTzd9bLy8Uv_w8EWDszh1IleF5Q>
    <xmx:PVG5ahMv_KapEYxYcqB7w_es9ekOSv-gV_UnZtOYT3LlcF13hfQJLw>
    <xmx:PVG5aulMrwwPGoj4riIakcS_n__r7Yc0KCz-DozL6WZfjZtM65ZVQw>
    <xmx:PVG5amTLKuwCpC_N_PYSeFGk-K68XmK2ezysm2ZY2v5k5nYOpMKfol4M>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 13:24:12 -0400 (EDT)
Date: Sun, 27 Sep 2026 19:24:11 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arlROwtdFs3YyUt_@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>

On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
[...]
> > > @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> > >   	for_each_possible_cpu(cpu) {
> > >   		/*
> > >   		 * Scan CPU slots.
> > > -		 * Forward progress against recurring wildcards is guaranteed
> > > -		 * by scanning for one wildcard while new elements use the
> > > -		 * other wildcard value (1UL vs 2UL).
> > >   		 * Forward progress against recurring single hazard pointer
> > >   		 * values is guaranteed by the fact that a hazard pointer
> > >   		 * is not reclaimed nor reused until the scan for that hazard
> > >   		 * pointer completes, which prevents a steady flow of readers
> > >   		 * to acquire that same hazard pointer value.
> > 
> > (Not a comment to this patch, but I think it's worth bringing up)
> > 
> > I want to point out this is not true for the lockdep use case, because
> > the we need to protect a hash list deletion there, and we use the
> > address of the hash bucket there. It's proven fine in practice because
> > the readers are rare (we only call the reader is_dynamic_key() in
> > register_lock_class(), that is every time you have a new lock class to
> > register).
> > 
> > Maybe what we want to say here is that "if the users guarantee no steady
> > flow of the same hazard pointer value, we guarantee forward progress".
> > Thoughts?
> 
> AFAIU, your approach to protect lockdep linked lists is to use the
> address of the hash bucket to protect the traversal. As this address is
> invariant (global array item address), that address should be fine
> to fulfill hazptr requirements, but it has downsides: rather than
> protecting the specific nodes being retired, the whole hash chain is
> protected. This means that, as you point out, many readers retiring
> nodes from a given bucket (except the first node) could end up holding a
> continuous stream of hazptr for a given hazptr value, preventing
> progress of hazptr synchronize.
> 
> It's also coarser: per-bucket rather than per-node.
> 
> Am I missing something here ?
> 

No, you got it right, but as I said, we can use it in lockdep since the
readers are relatively rare, so not an issue here.

> One honest question: is this pattern something we expect to
> see often ? If so, then we may want to introduce a notion of

I honestly don't know. But in my opinion, we'd better focus on finding
more typical usage of hazptr (i.e. protecting actual object). So ...

> hazptr protection "period" flip (similar to some RCU implementations),
> where we tag the low bit of the slot pointer (0 vs 1), and alternate
> between the two periods in synchronize. This would prevent a steady-flow
> of same-value readers from preventing synchronize forward progress.
> 
> Thoughts ?
> 

... I will say let's add it only if we have more users of this pattern.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> > 
> > The rest looks good to me.
> > 
> > Regards,
> > Boqun
> > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
