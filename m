Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4E34C9AD
	for <rcu@vger.kernel.org>; Thu,  5 Mar 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746147; cv=none; b=uRLpOeuBPf/k7uCFblKq+FxpcWUFmE4hI+JFUKIJMWzJ0SVliHnMCiD10sCvgNMZEoYf/lQuMrLESh23+k8D9SXZUVAed0gBV6uE1Rm7x8or0OkkgMpD3i6OkrnpM7BzOZjLjtRZ4IHYKgaDv/UI5ZZ/vOGCU5UWvLbPv0GWZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746147; c=relaxed/simple;
	bh=CgtChV6Hd8LP+fOJkZAugwAJXwDR8L9bIl2dVA8xn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9+MaGYhgtGfU2lrlFsjNBZbhVHpIoQnJpEQ7/arDYyQDAH2fMQnr/J+9MoQBfgoVRZRfR+H6/Y0QTZrrGTpqaKIrIXzHCa0jyOC2bXgovMcewXTz9tBSI6DBny1ry8RVH3/gCfqG1fa+C1qkMGLHPrw8ar5Fpk8PJ4X3h1laq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewiCsJ27; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewiCsJ27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17740C4AF0B
	for <rcu@vger.kernel.org>; Thu,  5 Mar 2026 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772746147;
	bh=CgtChV6Hd8LP+fOJkZAugwAJXwDR8L9bIl2dVA8xn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewiCsJ27TcHVyYQhBRLgnssRp9shG9MuvMrFIKIE6hiWWaMW6gdNV0EPkVGYRCxC1
	 MKqDA3C4y7xWDu58DYv8g8PTv5KL/WaQcUhMFD4gRwn0vUNDZlZfP5SuY9b85Luix1
	 mbXNxrI7F9DWuBBvm8f0UUFsEKwz1sTZ1ECgz2dThjmJfUZu8xrqvDwetzb+BqezkF
	 44btArYfaXiATAAkgKmaaf4ixLOFiwFUjCgRcI1Bu2kYX56zlr6+i83uVQJkmHvQoo
	 jjtd0FG/yD83m3gzBck+QRbfWA+2MWD7Vtb0C/L3Ts+/qK2OkVQSTRnmPNvkTriLlM
	 oAgHSol+Sbf/w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 38028F40069;
	Thu,  5 Mar 2026 16:29:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 16:29:06 -0500
X-ME-Sender: <xms:ovWpaeBFfo14ZQkyX_Fpi1i5kbkaUK2HaDf_zXq3lChKpyz0I3-jTA>
    <xme:ovWpaR1w-D-mGXlqp3gIghqZzhvUpf6kO1CsHkEjIOsFHcW4jFLXbbGZVBx1e6_6G
    _tsktfd_sqmdCc_jUt824peBTX6CU0tyPxGdhDj7rPg8rLIircT>
X-ME-Received: <xmr:ovWpaY2Zs1gzLpI1-FANLWKb_8iLLX3-nDT78hj-k5J2_BiRGH5UwrxMqQ8dzGBiQp-mB0LuEtHOfQQTn6RXuPDm6xcFK-Rh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopehrohhsthgvught
    sehgohhoughmihhsrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmh
    gv
X-ME-Proxy: <xmx:ovWpaeAtmYO5DLzmgO7GNatnPv5mjDXa6un1da3Pmd1_mD_lb3AhxA>
    <xmx:ovWpaf4--D9xJ29tmuE2ivu-u3ezBvh1eJ5IST1KgTKJqrvN6hGsVw>
    <xmx:ovWpaXIKQZq3dUKX7mG5VX6sacKLX_M7cz3Apew8ZZg4kBnHSAfS4A>
    <xmx:ovWpaYu6b4Ui9zjVxj6FDMs4Opk4Ivq9SUPiuqkzGgjvPl1UnNU3dg>
    <xmx:ovWpaWK9_kL6kUeDtsnDCxygAJ04Sr8Bzye4PNcz6Ni5WsP5oaGbCjnw>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 16:29:05 -0500 (EST)
Date: Thu, 5 Mar 2026 13:29:04 -0800
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] rcu: Fix lazy-preemption regression in torture-test
 suites
Message-ID: <aan1oNttjGU-uNu_@tardis.local>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>

On Tue, Mar 03, 2026 at 03:58:56PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> As of v7.0-rc1, architectures that support preemption, including x86 and
> arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
> Attempting to build kernels with these two Kconfig options results in
> .config errors, which causes torture-test programs such as rcutorture
> to throw false-positive errors.  This series fixes this v7.0-rc1
> regression by converting these scanarios from CONFIG_PREEMPT_NONE=y or
> CONFIG_PREEMPT_VOLUNTARY=y to CONFIG_PREEMPT_LAZY=y.
> 
> Those maintaining architectures not supporting preemption might wish to
> run rcutorture with CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y
> because I no longer have access to any systems supporting these Kconfig
> choices.
> 
> With all that said, the patches are as follows:
> 
> 1.	rcutorture: Update due to x86 not supporting none/voluntary
> 	preemption.
> 
> 2.	rcuscale: Update due to x86 not supporting none/voluntary
> 	preemption.
> 
> 3.	refscale: Update due to x86 not supporting none/voluntary
> 	preemption.
> 
> 4.	scftorture: Update due to x86 not supporting none/voluntary
> 	preemption.
> 

I queued this series at:

	https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/ fixes.v7.0

based on v7.0-rc2, and I'm running some test from my end. If everything
goes well, I will send a fix PR before -rc3. Thank you both!

Regards,
Boqun

> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  rcu/SRCU-N         |    3 ++-
>  rcu/SRCU-T         |    3 ++-
>  rcu/SRCU-U         |    3 ++-
>  rcu/TASKS02        |    3 ++-
>  rcu/TINY01         |    3 ++-
>  rcu/TINY02         |    3 ++-
>  rcu/TRACE01        |    3 ++-
>  rcu/TREE04         |    3 ++-
>  rcu/TREE05         |    3 ++-
>  rcu/TREE06         |    3 ++-
>  rcu/TRIVIAL        |    3 ++-
>  rcuscale/TINY      |    3 ++-
>  rcuscale/TRACE01   |    3 ++-
>  refscale/NOPREEMPT |    3 ++-
>  refscale/TINY      |    3 ++-
>  scf/NOPREEMPT      |    3 ++-
>  16 files changed, 32 insertions(+), 16 deletions(-)
> 
