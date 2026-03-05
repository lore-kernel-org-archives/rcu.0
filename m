Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370C3E0C48
	for <rcu@vger.kernel.org>; Thu,  5 Mar 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734959; cv=none; b=ouu6ZLrPmMLi/yzPEcNjp9y8erzSx1wPtStGo2Q+GxhZuib1nDxCnzZV+FkkFoGbXUXDjJg/StY/zOsNItiz+tuS0xMvnzaZwEXUIgVhxKFIuN5HnQAr1iHfEjpQUZtJaNYLnoU4OQTyH/dQSIynTxcUwSDwN5ZTJkhMf48OCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734959; c=relaxed/simple;
	bh=LwhLTl9qMzNJ+G4cveOgMcQtAegehHZ5c23NZuEqaB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OED61YYskfSMBnnPor0Tsv5G9piHrMmrwTR37xGTAVyux8U5h2hm49Lx2luuDP/Bn7VyAVVo4FRtj5b7flqjkgzU9dasP81wnktYRJOT2EthCmVj6nCSkEqlmuRaHvAk8AmPqMgqVId3pZN1Pl8azhpINKUkUIheSqziq9crRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnqPkO91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnqPkO91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C14C19422;
	Thu,  5 Mar 2026 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772734958;
	bh=LwhLTl9qMzNJ+G4cveOgMcQtAegehHZ5c23NZuEqaB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnqPkO91nOXyYM9ei74w+cbQ4Xa13SWOEtnOaJZTfzbVyn/osZpLrl6NH/1gi/olS
	 /Bi3UZbqVRW9LeKBu6XX5tAgBJ7+7eUG3FqHpULa3n4M6LRLNVfJj/gZdF88zSBqMl
	 sjeV3IcrKmZ94n7fkKQMF3JC3f492RZT+SLO5gge01Ea5eA8eMIaP0UgWcA8jrDR1/
	 V5bmbPm+yT2vHfVz6MdYuhyMeBpxSSVXKDhDdBfJq9CXJWesJQDjzLYm0aqzr8XjzG
	 9e4okQN9WHY3xXqbPVEieDgAemH/e+kYM9SPYX/0OkLdWj6gnCQZqeHhq37uOsy6ci
	 IvmTBxi4y1bew==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83951F40069;
	Thu,  5 Mar 2026 13:22:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 13:22:37 -0500
X-ME-Sender: <xms:7cmpaZEwIvseQpon-gtF6-O8BKbO1GzN4kZSwdi51l6kCrRhL26d6w>
    <xme:7cmpaXpjygx35VS2_yD1Tl1-dI5Wu-AkD4eF-93Ilz3n6rGCoaLEnvtFhX1u_Dma5
    KQzFKR-LD82vJ3fTZqbbP4IASbdWXTGIcjgBzE3ctgN1FI6tIqW>
X-ME-Received: <xmr:7cmpaSbGeS5SigDdn9LnLigiZrG1KwTfDhgIOvmy81gIxqF17IXcwuY9CAscrUkm7Y6Tt4f05Km40jn2SVi0Z9Wd_FoTODGP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtoh
    hmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthho
    pegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:7cmpaQWhF2BobmYtFwhVCwG1DahsiRyOMOcgZV9JYZ-Zc0RBgloylw>
    <xmx:7cmpab-DXvlOLIdEZfySp7Spvh9vZVOtWkHG5C3gMeItLyrTQdz7bQ>
    <xmx:7cmpaZ-2fSz12ZYZW4nvhZm0JmD82cpCrlA54zZvTjdxAB7VsvRiig>
    <xmx:7cmpabR3cQsN4-zECp886TNKpVk_oPwrU09FMvdvgsgaGPtOF7SDiQ>
    <xmx:7cmpadcde9EN4W2nmhj8-ziSldPyak5v5myafNmghLSBMkLd7kH-MtX3>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 13:22:37 -0500 (EST)
Date: Thu, 5 Mar 2026 10:22:35 -0800
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <aanJ65E2VSJd8ZAl@tardis.local>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
 <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>

Hi Paul,

On Wed, Mar 04, 2026 at 04:01:19PM -0800, Paul E. McKenney wrote:
> As of v7.0-rc1, architectures that support preemption, including x86 and
> arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
> Attempting to build kernels with these two Kconfig options results in
> .config errors.  This commit therefore switches such rcutorture scenarios
> to CONFIG_PREEMPT_LAZY.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 
> Changes since v2:
> 
> o	Fold in c69ac5693540 ("rcutorture: Adjust scenarios for default
> 	lazy preemption")
> 

I'm not sure I got what the "Fold" here means? I think you didn't do the
fold? Because..

> Changes since v1:
> 
> o	Add CONFIG_PREEMPT_DYNAMIC=n in order to test non-preemptible RCU.
> 
> o	Remove CONFIG_PREEMPT_COUNT=n because it conflicts with
> 	CONFIG_PREEMPT_LAZY=y.
> 
> o	Remove some stray conflicting CONFIG_PREEMPT_LAZY=n instances.
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> index 07f5e0a70ae70..f943cdfb0a741 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> @@ -2,7 +2,9 @@ CONFIG_RCU_TRACE=n
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=4
>  CONFIG_HOTPLUG_CPU=y
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_DYNAMIC=n
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  #CHECK#CONFIG_RCU_EXPERT=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
> index c70cf0405f248..06e4d1030279c 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
> @@ -1,5 +1,6 @@
>  CONFIG_SMP=n
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
> index bc9eeabaa1b18..71da6e3e94886 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
> @@ -1,5 +1,6 @@
>  CONFIG_SMP=n
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> @@ -7,4 +8,3 @@ CONFIG_PREEMPT_DYNAMIC=n
>  CONFIG_RCU_TRACE=n
>  CONFIG_DEBUG_LOCK_ALLOC=n
>  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> -CONFIG_PREEMPT_COUNT=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
> index 2f9fcffff5ae3..dd2bd4e08da4e 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
> @@ -1,5 +1,6 @@
>  CONFIG_SMP=n
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> index bd5ed7b0da5f0..2be53bf60d65b 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> @@ -1,9 +1,9 @@
>  CONFIG_SMP=n
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> -CONFIG_PREEMPT_LAZY=n

This is the line that was introduced by the said commit, hence this
patch is still separate from that commit I think?

Regards,
Boqun

>  #CHECK#CONFIG_TINY_RCU=y
>  CONFIG_HZ_PERIODIC=n
>  CONFIG_NO_HZ_IDLE=y
> @@ -12,4 +12,3 @@ CONFIG_RCU_TRACE=n
>  #CHECK#CONFIG_RCU_STALL_COMMON=n
>  CONFIG_DEBUG_LOCK_ALLOC=n
>  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> -CONFIG_PREEMPT_COUNT=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> index 30439f6fc20e6..be8860342ef71 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> @@ -1,5 +1,6 @@
>  CONFIG_SMP=n
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> index 18efab346381a..8fb124c28f283 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> @@ -1,7 +1,8 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=5
>  CONFIG_HOTPLUG_CPU=y
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> index 34aee1acb8662..ac857d5bcb222 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> @@ -1,11 +1,12 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> +CONFIG_PREEMPT_LAZY=y
>  CONFIG_PREEMPT_NONE=n
> -CONFIG_PREEMPT_VOLUNTARY=y
> +CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> -CONFIG_PREEMPT_LAZY=n
>  #CHECK#CONFIG_TREE_RCU=y
> +#CHECK#CONFIG_PREEMPT_RCU=n
>  CONFIG_HZ_PERIODIC=n
>  CONFIG_NO_HZ_IDLE=n
>  CONFIG_NO_HZ_FULL=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> index 0513aa33c32c4..61d15b1b54d16 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> @@ -1,9 +1,10 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_DYNAMIC=n
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
> -CONFIG_PREEMPT_LAZY=n
>  #CHECK#CONFIG_TREE_RCU=y
>  CONFIG_HZ_PERIODIC=n
>  CONFIG_NO_HZ_IDLE=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> index cc3ea23c76557..0e090bb68a0f6 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> @@ -1,10 +1,12 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_DYNAMIC=n
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
> -CONFIG_PREEMPT_LAZY=n
>  #CHECK#CONFIG_TREE_RCU=y
> +#CHECK#CONFIG_PREEMPT_RCU=n
>  CONFIG_HZ_PERIODIC=n
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_NO_HZ_FULL=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> index 420632b030dc4..b2ce37861e71a 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> @@ -6,6 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
>  #CHECK#CONFIG_TREE_RCU=y
> +CONFIG_PREEMPT_RCU=n
>  CONFIG_HZ_PERIODIC=n
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_NO_HZ_FULL=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> index 5d546efa68e83..696fba9968c60 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> @@ -1,6 +1,8 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> -CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_DYNAMIC=n
> +CONFIG_PREEMPT_LAZY=y
> +CONFIG_PREEMPT_NONE=n
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_HZ_PERIODIC=n
> 
