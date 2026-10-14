Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CD47F76B;
	Wed, 14 Oct 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011988; cv=none; b=k9Wdr0v45JQrPA6Zxgx+9HPQCyVRgX1TvoGLjq75EG2N4lwJEP9RnD2Yn57aaG2pF3nO2Hjw2IpojbxCBOIP07DPinBTRefj9W3gS0aMjqlo2uaV1RYhWi4vmedIa5pYb6GHnysjvBPvMharLKEQ76ZJVgWsozZBrSiIxwM8tGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011988; c=relaxed/simple;
	bh=9YvjMi+IGukXYciHtarb7mrA0Mlg1FhHJ0GUS9WSqtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc8OcHmBXWHPCeHmjOnSfV+4vGkxj5ukjk6bPAm84e7D3Q5zifP3G+3OuQDfzCjHoiuxjzhJ7tl8tDAAAkWzV+oZ09jWecdrLOaPY8OD3tf6PPYaT4Kgv93/UoqTsky2MSYt+AEJBHxjtme9t9mGFzHGmMQDTvpigKmI0z9DQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry8b4mdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry8b4mdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3BF1F000C4;
	Wed, 14 Oct 2026 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011986;
	bh=9khNzu4tgqIL3/vt10n8GH15saWvLf36F2PkdZ1w4jM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ry8b4mdYuy6sLN+HSRlfSngSxuWsO6QcIPTGoObRzwUWYVrcn60OXeX5W61vreGZN
	 bQ/hbIXgDeoqhdm4Dx1KlwBwRDYCTKYiTBKfiTifXKHZT2i4fZzi/tRg7gIAdQRkpY
	 9muzABGW7aK37/sPx/XV8fyC09BuZ71pqYJg9K7rompgrWFlHBPpb6pZQ4tx6LUlj6
	 qIPomxMtjCx+tthoa4n5Y1XyYkY+aaG5hDJZfaMUoloX0Yfj9UjJgTfSSIGL108+g1
	 7tdofCH22BT1Q6Exj4cCALFIqgD8gyqvoZhvxG8QZ7uG3E8TKp6VeIrB5Qj8N609yz
	 AQTdjgjOOk+2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99529CE0C55; Wed, 14 Oct 2026 14:06:26 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:06:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v3 0/4] Hazard pointer updates
Message-ID: <2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>

On Sun, Oct 11, 2026 at 03:48:46PM -0400, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> This series applies on top of "hazptr: handle NULL address in
> hazptr_detach" you have in your rcu dev tree.
> 
> This first patch addresses a race identified by Boqun Feng in the
> two-phase wildcard scheme. (no change since the last series)
> 
> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
> Those were discussed at length in a prior version of hazard pointer
> patches.
> 
> Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
> the feedback received from Boqun and Gary.
> 
> Patch 4 introduces a "try acquire" helper to allow the fast path
> to not rely on wildcards, while keeping the wildcard forward
> progress guarantees in the acquire slow path, used on fast path
> failure.

I have pulled this in for additional review and testing, thank you!
(With Bradley's Reviewed-by on 4/4.)  Still subject to rebase, which means
that I can easily replace it with an updated series from you, if you wish.

But in the meantime, some additional testing.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (4):
>   hazptr: Fix two-phase hazptr_synchronize race with detach
>   ptr_eq.h: Introduce ptr_eq() to preserve address dependency
>   Documentation: RCU: Refer to ptr_eq()
>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> 
>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>  arch/x86/include/asm/ptr_eq.h         |  16 +++
>  include/asm-generic/Kbuild            |   1 +
>  include/asm-generic/ptr_eq.h          |  16 +++
>  include/linux/hazptr.h                |  48 +++++----
>  include/linux/ptr_eq.h                |  63 ++++++++++++
>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
>  7 files changed, 237 insertions(+), 80 deletions(-)
>  create mode 100644 arch/x86/include/asm/ptr_eq.h
>  create mode 100644 include/asm-generic/ptr_eq.h
>  create mode 100644 include/linux/ptr_eq.h
> 
> -- 
> 2.43.0
> 
