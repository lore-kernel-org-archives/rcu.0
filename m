Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3487214A64;
	Tue, 23 Dec 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452339; cv=none; b=NhrP0qxEYUgs9NhEu5RC5837JXcOe3LfqxhEGN96+CMbarPEoy3yMkWhoGAwXC9WJ/CYguGUJwJEaZKxQ0W1mfXC7gI8XlY8e78NwxlWscLOzRarITJOV+qGG1FTth50bINpop4OgnvwXED1FAeHVIEDyfCine47UTrEt3gWzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452339; c=relaxed/simple;
	bh=18V59Ds61liPoDtI/YsGKLrF5SOHUeBLw1WL4mj/O08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS0sHYIKyJigzbhihTFFy/BatfBM/3H4ecwHH/0TUz0fFX02BmezkDucKsis+QwerC4jNeKmuPUNRRRR8K4ZxobcWy+nkTbzw+k+EPNOEHpoLwleXK5Te7XO4jpsdvHkg3IvDXdHj/coML41DIr4p1OsAg++fd1PNySpt7/6gJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4sLCIB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4sLCIB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44594C4CEF1;
	Tue, 23 Dec 2025 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452339;
	bh=18V59Ds61liPoDtI/YsGKLrF5SOHUeBLw1WL4mj/O08=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B4sLCIB7lV4enxJOXFbNYEr3kP3hEyzHHSAu5rRqjydu0GAjlV4UEyGqdOw3naeIu
	 HAD0f7slHKHWJyp/hLWN3IXIV+t24lKnn78tSwljKK9IJRHP+iBKAi+xXtbm2DZDy5
	 KYGEQCn3jLBHYo112zrGqjscwwsw5JCvUgR+uukDiADPGiki5qZM4AQSQz3luvufZy
	 yRKfWtNchUOOA3TVOppeyuZH0c8fOF41+SVd1MQjmwisvL4tt5Ea0qt8mEsIfFkcex
	 yAU8CsJqwNIywl72Obv63nBh06ITTDz1/hkF8/HGtXld5Jx0jATDsAWim6qdN3si/Z
	 jsZ0YmtrssEFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A3C3FCE0B06; Mon, 22 Dec 2025 17:12:18 -0800 (PST)
Date: Mon, 22 Dec 2025 17:12:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Message-ID: <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223004407.61147-1-joelagnelf@nvidia.com>

On Mon, Dec 22, 2025 at 07:44:07PM -0500, Joel Fernandes wrote:
> Fix incorrect operator precedence in the conditional that determines
> when to call exp_current() during torture testing. The modulo
> by 0xff appears to do nothing.
> 
> Fix by adding parentheses:
> 
>     !(torture_random(&rand) % 0xff)
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Good eyes, thank you!

Unfortunately, Chris Mason beat you to it:

50d8a5d2a94c ("rcutorture: Correctly compute probability to invoke ->exp_current()")

I will add your Reported-by to that commit on my next rebase.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 82588ceed9da..9873a1d54c46 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1749,7 +1749,7 @@ rcu_torture_writer(void *arg)
>  					ulo[i] = cur_ops->get_comp_state();
>  				gp_snap = cur_ops->start_gp_poll();
>  				rcu_torture_writer_state = RTWS_POLL_WAIT;
> -				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
> +				if (cur_ops->exp_current && !(torture_random(&rand) % 0xff))
>  					cur_ops->exp_current();
>  				while (!cur_ops->poll_gp_state(gp_snap)) {
>  					gp_snap1 = cur_ops->get_gp_state();
> @@ -1771,7 +1771,7 @@ rcu_torture_writer(void *arg)
>  					cur_ops->get_comp_state_full(&rgo[i]);
>  				cur_ops->start_gp_poll_full(&gp_snap_full);
>  				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
> -				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
> +				if (cur_ops->exp_current && !(torture_random(&rand) % 0xff))
>  					cur_ops->exp_current();
>  				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
>  					cur_ops->get_gp_state_full(&gp_snap1_full);
> -- 
> 2.34.1
> 
