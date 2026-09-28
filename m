Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED14E77FE;
	Mon, 28 Sep 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609537; cv=none; b=nt9pnjxT7Vxedztdeq0e75ns8N9xrVCIV+1i6zuIiR/ntRr9CCCBEyKLeyFRrlOBnFQqgqpChPBGyxDQ37lYbYcounslSuG5DPEbc9jkPrVoCXdsJl6Z8/4xu5pI6s49uTuxSKHy4AepK5MUM+lvDMvMKv/y1iGBS/GO4pgTfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609537; c=relaxed/simple;
	bh=ntpxkvkUTTw0VO100ZA1zeUxr46OPt10yDVvtgdqXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhJSnQ1yJZapoHEUi6fiusaoEer1BGCcD5U4l4shFEh5kRZfs3LGOcPmqAhFYIR2dfY5rSE2hrkqhc01fCdlzKFqeDDoOjXB1nKGNd2c4+AtkJdso+Bdjbs6LhYDQKt5ykKG5hA5ucd+R+wf30hNC7ZBQL+evGUSLAJBQeEiZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZvBkIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZvBkIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F631F000FF;
	Mon, 28 Sep 2026 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790609535;
	bh=RZ9WA2ykHvGEyuJHbovdsGi/6qSj45jtXA79JrlEcCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XTZvBkISzr474Zrpuc1T2S4Ee8SyZkMMbisMtPO+BYsJSepLkD0Ws6J4iZ5rLcWum
	 J+yluaFVX3CFencgd9vUdPCfLHFODJKr7sPLW/0rgdpS/9tlquEGZoJPPGd96nn4qV
	 aswPRYVOdeBbsX1+AajnQKHaCkZL4ECuvjXMLoO7CBj3SV+LAf+9u/wqdF7hQ80/OU
	 w+roD5V7V7MJpI/IDfHufqIVDdByO/U0hFWn+SmODw/dzeU4/1KvZEoM9JyBXBxIWX
	 YvOmVvcBXVVUqKRIlaoXskpRULOQGU1hEzOTP4ZtOsIflzCUxfK3INliI1MYw2GHd7
	 Oy3028w/1pBKg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id A57C2F40068;
	Mon, 28 Sep 2026 11:32:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 11:32:13 -0400
X-ME-Sender: <xms:fYi6akmsatnwTTU1ehgcboBBVGYR8XCs09lRyFUB6fGnJPLB97C5AA>
    <xme:fYi6av3uOGsnwrwxy1whc8gqnqYE8ocjsXTOEvr-3TLpOsWOkLLDWQUl5b-yStJ8v
    rG73um7gCZqZoB9v6snNHVVL-vGBiqKsYhA_3KjESWUTurHpMfiWJM>
X-ME-Received: <xmr:fYi6ak1g9AdaPJ-xEtQhzi1sp_6Ft2i648EKOMPMFWpz-t1aaAWentqrDf18>
X-ME-Proxy-Cause: dmFkZTFv+luSSQR1rVkkY244nY3PGCdvQ4HGsOm4gQyyjHU6LnVfxNPuMl9U+fnlQzvYkD
    B4s2ZrJsH+VJ9jBortm/ytfrL66qBDzSes0sgLOcgPz7HzOUyergtAPYur0rNAIQb2wLxl
    LvayQYf/e+0Nxox3ythtkc2rSnpbzaqU8sIxJiU8IwGseoHHLPF2DaNSOrhqq0jkpcK/lT
    RbLxr6EpZHBnE+lUbUa0A7gkJEetinA5jcALDVCqd3uVesAXWhiBYs0N9enpRn89++r5Ug
    eofTicdHomr127teag8qiWQ/033tJnApSEOuMmouNkWYI2ZQ/uRKa59dwqsaWCOZ54qeKW
    neQ7Bjm0sbgDMdJNX3s4GcDkAsgQ7iTjbq7UDx7EKyxlZPC1vYO1QlgpLU4V3MOu9mwBiX
    oBQ4MHsXm6otMwLzVLrT3VSmrjthRPwQqHL4cIrvUNaSxY0EshF+Au2Kb8SC6cJIvvOF22
    9UZVy8Qf8yQf8dKdtTcYMA3fAiJQbR3z8byluocoGKQCxSYPFpXWOOnzcMLWV+NdF0YLUs
    4rhPDORQIPa0LT68ewGZYnem1QaObScGUNUj0n/dUjs5VwoqMqut12/rcycwMplBmsqnN0
    J02hu1L+nNaA7hs4c6E3iSzYfXbuIibhXYPr427T83jm4DzPbeJymStu17ng
X-ME-Proxy: <xmx:fYi6ahoPQrGMju6JGw_sFvwM6DUUWL7jX5h9pXVSauwh1QjekWMl5A>
    <xmx:fYi6agifx9Fxz5rWnrbIu2EzuK0oCV28ZvpPNfvR3p5gPL_dtDZj-A>
    <xmx:fYi6at-bzEN1ZcxUM1_GBJyJzQwLoLmHDKUlN_5GsPOr1I-BSTtZTw>
    <xmx:fYi6asXnPEetGWabHVQ2r-qPtdev0tjNgpxX4VfZm7zIam7sDCBExg>
    <xmx:fYi6ahBjZ57kHnC3FbinkI440bPFxkJwazUnopH90j8myaUXYPIs0Q0o>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:32:12 -0400 (EDT)
Date: Mon, 28 Sep 2026 17:32:11 +0200
From: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arqIe2d8Koj857Kt@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net>
 <arovltfvFzv2FFjO@MacBook-0RXW5>
 <DLQX09XGAHDL.1LSFQH13SU7XR@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQX09XGAHDL.1LSFQH13SU7XR@garyguo.net>

On Mon, Sep 28, 2026 at 12:32:34PM +0100, Gary Guo wrote:
[...]
> >> For some context, the current Rust revocable implementation uses RCU, but this
> >> is limiting the case where it can be used. The current C revocable series in
> >> https://lore.kernel.org/all/20260912123529.7951-1-tzungbi@kernel.org/ uses SRCU.
> >> 
> >> I think this use case is a good one for hazptr, in fact, I have encouraged Alvin
> >> Sun to try it out and you can see an implementation (Rust) in here:
> >> https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-6-074badd18716@linux.dev/
> >> Although, over the course of the year, we have been reducing the amount of
> >> revocable usage and shifting to represent things with lifetime..
> >> 
> >
> > Paul asked me for the Rust usage a few days ago, and since we moved to
> > a lifetime based approach [1], which is better IMO, I don't think
> > switching to hazptr will should observable difference here, especially
> > for a real workload improvement. It's still worth trying to see how
> > hazptr in Rust would work for this, but it's less a sufficient condition
> > to merge hazptr from my understanding. Of course I could be wrong.
> >
> > [1]: https://lore.kernel.org/rust-for-linux/20260517000149.3226762-1-dakr@kernel.org/
> 
> What we get rid of is to use `Revocable` (or `DevRes`) to protect resources
> where we _know_ that the resource is alive (for example, in device private data,
> because it's teared down by driver-core on unbind).
> 
> However, there are cases where we can still have the `Revocable` pattern, for
> example when a class device is exposed to userspace and the bus device is
> unbinding. This is a pretty recurring pattern too, and cannot be handled via
> lifetime alone. This is what motivates the C revocable series.
> 

Not trying to discourage switching to hazptr in `Revocable`, but I think
the only shortcoming of RCU there is "unable to sleep while referencing
a `Revocable`", right? Certainly hazptr can help on that but so does
SRCU. I'm unsure hazptr can show observable advantages against SRCU
here. But I could be wrong.

Regards,
Boqun

> Best,
> Gary
