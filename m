Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270A27281E;
	Tue, 19 May 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227574; cv=none; b=mdcYCuMua5xNjpsmVtPVd3gckf77egEclSsot33oGr8PtsOzYKUWKUUim41YUL9mZfCw7203F/cV0DjFVV9XI/VS02N1E2013hs1JgALcaT9MQIwj8+O0iZ3J1Q2fI+GSOZHbE3V3VMw+bhlDYvVp4iIS1sWTBAIDqzKqgQl8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227574; c=relaxed/simple;
	bh=hxpkDkNyJWyVR4+J7MBuSEHvrKdrQ1KsasD1nDmBg0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRCErjALYaLKkeTSZG8P+7t58NZ7VN1sU6rNqwppE9yaqVzhd0HNsOm2dUxV0KEOx3OlbVTufegtPVRH3wi/6Ax4FGRKtqmNAIv52RHCXHhS4UJNT3HEkKB1PVD67/9MHKuhAFi1976mKqTbweYwfh2CwA1llXnGv0YmSxCOo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amm9Hf+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amm9Hf+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825101F000E9;
	Tue, 19 May 2026 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779227573;
	bh=9OMOZHKlKAuwAjDH0D5PZEfetycGSJp31qcVcS5JCoo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=amm9Hf+gvPMD1v14pXsGtmENODibdEEWT+8zL3lLd51O6aoSygEbV7A7hBZs9lS1o
	 FsQxpj8TW5q7dKiRal62Ffn4MKPgkivRxnoZlmYhgpCa+tVZYAB0/HWTlNfAqMY7rl
	 8BWNLzJak9hQyIibhgMXAooA5nqNPR5jzkdvxxMD5LbfyE0RQeE00HuYveRDjB4p6h
	 owVe+cmQdnHUWr/aokEE/c5DO63PklD4f7XhLv62m9DpY2R/PRROGTuk/2Sr6XfULq
	 CelDEoVOZYVaXNyBSDBzlAoPPiVa/Q1OdLQ8If2UKlWzC6I1Q1gqegyoc7GAdlQF2W
	 dAn+/3S/RIH8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3933CCE0890; Tue, 19 May 2026 14:52:53 -0700 (PDT)
Date: Tue, 19 May 2026 14:52:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Ingo Molnar <mingo@kernel.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: reduce stack usage in nocb_gp_wait()
Message-ID: <53d6cf5c-ba97-4341-9674-e9a5e60fb1d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260519190447.1716375-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519190447.1716375-1-arnd@kernel.org>

On Tue, May 19, 2026 at 09:01:28PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_UBSAN_ALIGNMENT is enabled, the stack usage of nocb_gp_wait()
> grows above typical warning limits:
> 
> In file included from kernel/rcu/tree.c:4930:
> kernel/rcu/tree_nocb.h: In function 'rcu_nocb_gp_kthread':
> kernel/rcu/tree_nocb.h:866:1: error: the frame size of 1968 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Apparently, the problem is passing rcu_data from a 'void *' pointer,
> which gcc assumes may be misaligned. When the function is not inlined
> into rcu_nocb_gp_kthread(), that is no longer visible to gcc.
> 
> Add a 'noinline_for_stack' annotation that leads to skipping a lot of
> the alignment sanitizer checks and keeps the stack usage 60% lower here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1047b30cd46b..373b877cf171 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -655,7 +655,7 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
>   */
> -static void nocb_gp_wait(struct rcu_data *my_rdp)
> +static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
>  	bool bypass = false;
>  	int __maybe_unused cpu = my_rdp->cpu;
> -- 
> 2.39.5
> 
