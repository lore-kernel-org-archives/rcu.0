Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C89409114;
	Fri, 11 Sep 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145241; cv=none; b=FzONl/UyRYaUV72MsH1qVnpd5enjHRSCJgDyzrB1AL9tvB292RSGnBPLoJ6fGKzeczWC08wMZNA3mKhZ5pUoVFpD2BpmxN9QyvJCLCgbnndFPNYtu9uqqSBcBda3RIt1i8rXj95iR2qbCDpBQHojydETySBRNCfUF7H++6Fbkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145241; c=relaxed/simple;
	bh=voWdrvM/LYp5hHaXOElkpjdoJ5lFxMk2nrH2By134rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK3tQOIPsvX/yMTLCGbNr4VeN9xFlPQbfhtxbGOcoMOwlgH9CoBrDsTRnvcmUKUMV0QBLkSM3eXIqruQS6F03JTqxYxpavZoSmUGLljH2NuXQHMXPlYPbSJpET8TOvFO8/m3ZS1YxwBAlRrorEEDB1xETPa+LPvIW6W6jRitqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKYEB+L6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKYEB+L6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91451F000FF;
	Fri, 11 Sep 2026 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145239;
	bh=av0409fTTGSs5Ag4uYjjV1dx8L7s5AjNobnmggEroqE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZKYEB+L6vK8prUY2zQoT8sqcvlfQWfROMhD9d3Ll7RwcFrrwUCwBiPaRBfiO/e3iL
	 eINLgiNA0kLNdarzZNe7NEgFJ7BwZMt5VWNimBkr7KdGI1Kd6Cf/fRD+EHJVHMb9p2
	 UQIKrfG9iu346jm1vJO59CvwEWeNiHkmOZ/TXgdw01211lzDSQQwl3S767sOpC2P53
	 MIiO7+HNLgJI9jYUGsPeQK6HBUJJwoLP4FATzq6tp1PhnN5Th8qUTyjXJGrIFfuqc5
	 hai2BIv8rjI5dz/jOQyvrzKcBvi9Ls727hc6VguuUIIb4QluMnMHh6y9rrWvhuHdTq
	 tyP0OO/jztQPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FD68CE1902; Fri, 11 Sep 2026 09:47:19 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:47:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
Message-ID: <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911093515.2802551-1-kunwu.chan@gmail.com>

On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> Add the lockdep annotation, same-type SRCU nesting warning, and
> early-boot check used by __synchronize_srcu().
> 
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Queued for review and testing, thank you both!

Interestingly enough, it is now the case that there is a grace-period
wait that can be placed in a normal RCU read-side critical section.
Does this mean that we should also adjust the --do-srcu-lockdep testing
in tools/testing/selftests/rcutorture/bin/torture.sh?

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6a9c432a3bd0..6c729e805fb3 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	unsigned long rdm0, rdm1;
>  	unsigned long unlocks0, unlocks1;
>  
> +	srcu_lock_sync(&ssp->dep_map);
> +
> +	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> +			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
> +
> +	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> +		return;
> +
>  	// Initialize.	Either init_srcu_struct() was invoked or
>  	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
>  	// will be done here.
> -- 
> 2.43.0
> 
