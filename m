Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C876331A5F;
	Fri, 30 Jan 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740751; cv=none; b=pxJnrgcIwnIQnK/lBg8TGEBqhaDb73U8/oF2kei65WPjk4J+KyhPHZZvxgt2uLWup/g2BN32AZW9j5/lT+so5jGcmPMEZIdhRbfD25n2/uOfz3bPDYuXsq/ZwKrOZJE//dJ7UYKOb//b0BHYuO94rePk+3gesGvnzkS4Lf8o+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740751; c=relaxed/simple;
	bh=b2fjr9SlIFfRfwHooV4/Sk/Eoh98yVotcbswH2ce68A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okT0BjWRoTs3EzHvWYnqAYrqyf2Q/GGqQjB/re6ojLwbmN49zq3r8GMjXurofKGjNthRM5aMtGAVHynj3X3iKzLifR5vEa6D6GV8zsAC9wK9kNLcCeHY2mCbz97pE9kg+WovWa4WIComG0GILST6czWBS/d/mFx1nhtZpTKrIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDKQe0jN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDKQe0jN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B5CC4AF09;
	Fri, 30 Jan 2026 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769740750;
	bh=b2fjr9SlIFfRfwHooV4/Sk/Eoh98yVotcbswH2ce68A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDKQe0jNRYFB4dguu4QyCfHdfHcX5nc3f2rEYONXV+Sg7MA2xYw5Ia37WiiBK/4Yo
	 3d60aR/3wdFHIKtB3zn7kZLLv64bmujm4nqx3tvUgmn0/m7OLs0K0qfZIbOo+5Rmak
	 pJEOftN9h/0ETfNosGxk04XouJaI1WM2fvec3b9Dc4OiaNTV07c8LUwozXznud3jpB
	 GK2Hi6pVF2N5KCXsWQgzJM2lu3g7fwHoZw6fMvBQ+WX4PX6HyAP75T77wR8Jj/Ib1K
	 l//YcO7vJDWIdXcDcMuIABzMwXpQE8lHY6f0Au1ZPNXivGDP/pn8E6KGpHaS4WvDqL
	 CpoqtSMROiIUg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 808A8F40072;
	Thu, 29 Jan 2026 21:39:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Jan 2026 21:39:09 -0500
X-ME-Sender: <xms:zRl8aSlWwAGD7ogVG6-L7PwDh7Qf_sufHPBoIdCnEynPmS0ro6JQkg>
    <xme:zRl8aaQ7u5kd3kuRQzQKaeKZvAhKxS1Dzet9OIokLCtWjVgPCXes9iES7Sh7anqYC
    BARqREkODEkY6YB9huRVphn-dxtZBgQc18OdV4yHD5FPWcZIhl98g>
X-ME-Received: <xmr:zRl8aRW5hKjG4OcOJE9XobqwxITxW1-1Qgp-8sQ08mllcT8OZM1PtfPb1PBCg_ToCxr17rNI7P_vcUgvrgDHdV33yx8VDS2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    efhefgffelkefhheeifeeggefhgeeuieevueegfeeugfeuffeludeuhefhleeggeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoug
    hmihhsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zRl8aeKS80s1IPVKL4K_Ng1NVJlxaNl1znmZHzNliz9bGhoSB45wow>
    <xmx:zRl8aR3PqgTs8dQS9nVUphBERNOa7ZmaHmfSDErwaAaL4XzfMrkoMw>
    <xmx:zRl8abI-_7fcOfFUBOI1qKgp_6ABf6X0zYtKP5w0zr9piygan05HhQ>
    <xmx:zRl8ach1Ny47APoCYwlke9QewqdCKDh_73Kpaj1wve19i_UpctI9Jg>
    <xmx:zRl8abBN0V7_4PUgdlzaOuD_YZVeL14p5MOubOdKPGbTwy1FUfIXly7s>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 21:39:08 -0500 (EST)
Date: Thu, 29 Jan 2026 18:39:07 -0800
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] srcu: Fix warning to permit SRCU-fast readers in NMI
 handlers
Message-ID: <aXwZyxqsxgOyZHTU@tardis.local>
References: <8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop>

On Thu, Jan 29, 2026 at 05:30:44PM -0800, Paul E. McKenney wrote:
> srcu: Fix warning to permit SRCU-fast readers in NMI handlers
> 

This line seems to be duplicated ;)

> SRCU-fast is designed to be used in NMI handlers, even going so far
> as to use atomic operations for architectures supporting NMIs but not
> providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
> in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
> handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
> such complaints.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: bpf@vger.kernel.org
> 

I queued it with the duplicate line removed, please see below.

Regards,
Boqun

---------------------->8
Subject: [PATCH] srcu: Fix warning to permit SRCU-fast readers in NMI handlers

SRCU-fast is designed to be used in NMI handlers, even going so far
as to use atomic operations for architectures supporting NMIs but not
providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
such complaints.

[boqun: Remove the duplicate title line]

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 kernel/rcu/srcutree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c469c708fdd6..66ba6a2f83d3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
-	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
+		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
-- 
