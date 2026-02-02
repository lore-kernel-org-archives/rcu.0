Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BF2472AA;
	Mon,  2 Feb 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047612; cv=none; b=fiCDVu14uK2RrgzuXTGcU0zfdtTbXTAzA/smxIGbC78SwxnuA95txXpWrUaPY9bQrxVHKyEuvC3e2/JYUnpl40K/2XOFqwOKBGOffu3mtFe6LuKgIH+eeY5kgq5XtOguiYrVfUyQTYsGTqgn2qSo80Sle1f1KN6CWNtsnJmSXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047612; c=relaxed/simple;
	bh=/3YSyhSQV7vNofFhW/+dqkXDH2hBI960cm0srCWasDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAYJxnR35W3eOU1RPqhTNesyXTG0KR5IR6Fg71+UIOIBQJR9JA0rc+VzuJ7aWGmqTqbu+vISMWjMqDqJ9p7MbEGVTKszxSrxEK5RVik/Un0kA5Y2oI9Z4rHuwE+ReVLHwezqGSbaRQUhfPne4GSaErJDk95Q1luo12Kt+FVN0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1t5xIrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1t5xIrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8515C116C6;
	Mon,  2 Feb 2026 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770047612;
	bh=/3YSyhSQV7vNofFhW/+dqkXDH2hBI960cm0srCWasDc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A1t5xIrwwLc5gwJK0quAzucqgunv30DWVwwiYK6tgW3KheKTM9b5fTmcW9ic4QVu5
	 TxP6UNYW00bMU+7le5Mg5UIkt3K8u9NxMl+YDspR/7CxFoNjb/kgBZhvESJNAd/FBv
	 ewrcVGzxtsTw4xt+ja5K+OKagF8wtwdkIjbLtYuUBewIJQ4HJ8HrbbKpjXps7btHZ2
	 4llTIwH8ptIfykHYJtKfBO+sXZ4h34W90IJE+2FCdb450EuK4HIQzGTmZdGLB+7+Q2
	 uC0DbA3tLLfhd52TRo8eRke3uw7FrVtCybQZgKsjwPnVNCoPdqOL2lS4voHNL2C0NF
	 d9cHIqvFLUtiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85447CE0B6E; Mon,  2 Feb 2026 07:53:31 -0800 (PST)
Date: Mon, 2 Feb 2026 07:53:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: mark lockdep_assert_rcu_helper() __always_inline
Message-ID: <d648f1cf-f894-4354-81ba-81cd3cf21270@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260202095507.1237440-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202095507.1237440-1-arnd@kernel.org>

On Mon, Feb 02, 2026 at 10:55:01AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are some configurations in which lockdep_assert_rcu_helper() ends up
> not being inlined, for some reason. This leads to a link failure because
> now the caller tries to pass a nonexistant __ctx_lock_RCU structure:
> 
> ld: lib/test_context-analysis.o: in function `test_rcu_assert_variants':
> test_context-analysis.c:(.text+0x275c): undefined reference to `RCU'
> ld: test_context-analysis.c:(.text+0x276c): undefined reference to `RCU_BH'
> ld: test_context-analysis.c:(.text+0x2774): undefined reference to `RCU_SCHED'
> 
> I saw this in one out of many 32-bit arm builds using gcc-15.2, but
> it probably happens in others as well.
> 
> Mark this function as __always_inline to fix the build.
> 
> Fixes: fe00f6e84621 ("rcu: Support Clang's context analysis")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index ea1e979b290e..7729fef249e1 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -406,7 +406,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>  
>  // See RCU_LOCKDEP_WARN() for an explanation of the double call to
>  // debug_lockdep_rcu_enabled().
> -static inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx_lock_RCU *ctx)
> +static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx_lock_RCU *ctx)
>  	__assumes_shared_ctx_lock(RCU) __assumes_shared_ctx_lock(ctx)
>  {
>  	return debug_lockdep_rcu_enabled() &&
> -- 
> 2.39.5
> 
