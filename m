Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783B27B4FD
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490165; cv=none; b=IinWLkOc9naKlU2J7NMr7Fa7bBEygcq5i+rAVECCsg+Dzy6R6k6KVWYp9p7wmeIJ70yIte8TmV4fYtFt8WgO59wRjHq1W7RZyUtbTs1b2jvJOQSzcgosWV3I5abmEhLqupybCZdbpejcn+dIETApvrmtwWY1WJLBlNsP9Lew3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490165; c=relaxed/simple;
	bh=mjjwqmLAva0+AAmgGltDXhwAsIA3qylltznpj7QTYrc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0/jjg4rglyvozLQz6WTv7PdH0uwSF6/100T/grATLHa65JtSfKVG9lFnjWrh41caCNefUVQ7blX5jPJ0oQ7FctV6lfeurKeiWmWuU7NjKNmopX6MfVJh/7utW9G0M3ciP1xaG3+a0gCJsU+Um95BLsRVDn4tRhi2OEZTzi5QFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDxxrF97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDxxrF97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED3AC4CEE4
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 00:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746490164;
	bh=mjjwqmLAva0+AAmgGltDXhwAsIA3qylltznpj7QTYrc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eDxxrF97gg2UIKN2pCZf6EyUmDk3L4sDIaQylZsL4GklRJUI5323K+5nwTU7KP6MQ
	 k96/rOjoph39gWcYa4Vcj0DhqFpcwr3TByC6w/5qKlPRq3UVUjzWr0O15ddZBBy1t1
	 rM0MSs9aXLBGbpF+1uUWvQ4ulNCJwTsa6zqX+9LIdUlQ/XU/CtPxQnOgwhFekODDWk
	 kIETZLs9vARSsWvpBHrViyvhxUIvo2hWO3jonKja9IkepsBCDmfa9GRo2wEbhVWaTo
	 Xkxc6g1KBKFa+C/Y5tZW+55xWVIIek3C14s25JsYLgy9mMEnk8XKxH/bkQHhoG8aXw
	 pP1kTyXMGIbNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FE75CE091E; Mon,  5 May 2025 17:09:24 -0700 (PDT)
Date: Mon, 5 May 2025 17:09:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Subject: Re: [BUG] RCU CPU stall warnings on TREE01 on arm64
Message-ID: <b9a1426e-1e23-41b0-a70c-60a0146e5195@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>
 <7e30f2f5-c2e4-4714-9a1c-879315f56865@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e30f2f5-c2e4-4714-9a1c-879315f56865@paulmck-laptop>

On Mon, May 05, 2025 at 03:44:43PM -0700, Paul E. McKenney wrote:
> On Mon, May 05, 2025 at 12:03:10PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Following up on off-list discussions and requests for more information.
> > 
> > These reproduce reasonably easily, and here is an example:
> > 
> > ------------------------------------------------------------------------
> > [  426.022056] rcu: NOCB: Cannot CB-offload online CPU 25
> > [  460.867350] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [  460.867980] rcu:     0-...!: (1 GPs behind) idle=8fe4/1/0x4000000000000000 softirq=2124/2125 fqs=0
> > [  460.868726] rcu:     1-...!: (1 GPs behind) idle=e0ac/1/0x4000000000000000 softirq=3547/3547 fqs=0
> 
> Early returns suggest that the following patch suppresses this issue.
> My guess is that the changes to TREE01 suffice, but I will try later
> excluding the TREE01.boot changes.  Architecture-dependent rcutorture
> scenario files, anyone?  :-/

Seven of nine runs failed without the patch below, and all of 63 passed
with the patch.  With only the Kconfig-option portion of the patch,
all of nine passed.

One option is the architecture-dependent rcutorture scenario files
mentioned above.  Another is to remove the CONFIG_MAXSMP=y and
CONFIG_CPUMASK_OFFSTACK=y from TREE01, but then add them to a new
architecture-dependent option in torture.sh.

Other options?

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
> index 8ae41d5f81a3..6281dbdc189f 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
> @@ -8,8 +8,9 @@ CONFIG_NO_HZ_IDLE=y
>  CONFIG_NO_HZ_FULL=n
>  CONFIG_RCU_TRACE=y
>  CONFIG_HOTPLUG_CPU=y
> -CONFIG_MAXSMP=y
> -CONFIG_CPUMASK_OFFSTACK=y
> +#CONFIG_MAXSMP=y
> +CONFIG_NR_CPUS=8
> +#CONFIG_CPUMASK_OFFSTACK=y
>  CONFIG_RCU_NOCB_CPU=y
>  CONFIG_DEBUG_LOCK_ALLOC=n
>  CONFIG_RCU_BOOST=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
> index 40af3df0f397..45e3b33f12a3 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
> @@ -1,4 +1,4 @@
> -maxcpus=8 nr_cpus=43
> +maxcpus=8 nr_cpus=8
>  rcutree.gp_preinit_delay=3
>  rcutree.gp_init_delay=3
>  rcutree.gp_cleanup_delay=3
