Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425675;
	b=LXRSjRKe92fOr2HMUz89+b0M2dn87tBZWnh3b76yBA3q0zc1CyS1bbnDKwBAx+up9rI7
	 ZPx+dqttevbD+7QEMV56Rjmn/MeqY5AVdbL9n4ICXu3CJXam9Vo3kykQk8oUOOZYB7R9m
	 /RZBx8/PYlz1H0f1glo0Jg6Yke8lUNKOewpPcr40gWCrzp9wjFgd6EXPYHeSmWnvszhb+
	 NFvo/feJ+scRDQoU+lOe6nuxUt/XMCCdpKGK4rPkB0QrTbyvCfiidZtf0oEnRs7qMnGq7
	 x3bic2ZDfQizHRgy2grsrszQpY401AgpJrdvg1lxc5wSNIWhthmZRkRX3iSI1Qdp9Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425675;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IWljEces0LlFXFiAokwrJ5cAXW+O2tCmvEjiKsX1oTU=;
	b=yGGg5O6gLQqTGsOhwnfIAA/UxCpAUyR17sWrXniMp1qusKzyr9QTvcy+PlPnk7j96zOb
	 +5Ko04MRH7notyNQKBX1tAi2Hxy4qJByCihGJ1kTxl7rZAyRjPijLfKcfSh7TDM3y6nIZ
	 BGPiQtN/P8tIsuwwjFyFqiuLyqeLycYI0uic0FiNHsEdBjwDR6idyAD4O/TWzXPSS6gTE
	 YwweR+rjcOcQpj9lEQaCPcTfK9RRLlqzd3X6e8QMyXnMoVruTe2kWSf7r7HQ/NJ1VTxY+
	 GlbmBShwmGq1FJpt/WUOU8pnF2PezqjXGjQLy6J81I67L9nHxgk9vKCq7V2wdcgCZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lo6InERq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFA606A32E;
	Wed, 11 Nov 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lo6InERq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526681F00A05;
	Wed, 11 Nov 2026 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425675;
	bh=IWljEces0LlFXFiAokwrJ5cAXW+O2tCmvEjiKsX1oTU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Lo6InERqX/AtoIxiuTqFh6Em4plItQQ/uuA4W5kCswnhwvkz1vwULJRhEPgSIcg+X
	 Vaf1yPN9QIXOL040NX3tFrQNUGDKBLShZ4na0efn3UwPX6AB0el3jTd25FV88FbZN9
	 WCHf4Q/A+fjPsLiwLoKhwf2nHC6A6grbx/uzuSG/34RZZOchbwC/Dr3tkhzCJG9muz
	 +cjLFqe8Cw/QaxzgX7ihOFwC1id4hFb9PHSq7ZGmpOPberkHx03QH0/qu4KU0/CmSa
	 Ka9QOMBR5VTp/lTxrhbhq3F2ENUkxWBmESdEEkJ1TQQruNHiqbUUdkCC+E4atW8+dU
	 W+jPoKXRbXkCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12CF9CE08D1; Wed, 11 Nov 2026 11:34:35 -0800 (PST)
Date: Wed, 11 Nov 2026 11:34:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their
 irqsave forms
Message-ID: <aca6b739-fd63-4f9e-8b40-237652a87c03@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>

On Wed, Nov 11, 2026 at 11:02:33AM -0800, David Woodhouse wrote:
> On Wed, 2026-11-11 at 09:59 -0500, Mathieu Desnoyers wrote:
> > 
> > On architectures without NMI-safe this_cpu_inc(), every atomic reader
> > now pays an atomic increment at lock and at unlock.  The update side is
> > unchanged.  On architectures with NMI-safe this_cpu_inc(), such as x86,
> > the readers use the same counter increments as before.  
> 
> The latter claim is only true in __srcu_read_lock_fast()/_fast_updown()
> isn't it? Not in the atomic-SRCU. Unless we do something like this on
> top?
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk> in case it actually
> makes sense and you use it as anything other than a hint.

Could we call __srcu_read_lock_fast() and __srcu_read_unlock_fast(),
respectively, instead of replicating their logic here?  (There might
well be a reason.  I am not immediately seeing one, but that would be
RCU for you!)

							Thanx, Paul

> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index b6e6171b4cd4..a6db7bf55cde 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -342,7 +342,18 @@ static inline int __srcu_read_lock_atomic(struct srcu_struct *ssp)
>  	if (in_task())
>  		non_block_start();
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
> -	retval = __srcu_read_lock_nmisafe(ssp);
> +	/*
> +	 * Where this_cpu_inc() is NMI-safe, the this_cpu_inc() + smp_mb()
> +	 * of __srcu_read_lock() is NMI-safe too, and is exactly what this
> +	 * flavor's readers always paid. Only the architectures which
> +	 * genuinely need the atomic increments take them; the pairing
> +	 * with synchronize_srcu_atomic()'s counter scan is unchanged
> +	 * either way (full barrier after the increment in both forms).
> +	 */
> +	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> +		retval = __srcu_read_lock(ssp);
> +	else
> +		retval = __srcu_read_lock_nmisafe(ssp);
>  	/*
>  	 * An NMI may interrupt lockdep itself.  Annotate it as a trylock
>  	 * there, as srcu_read_lock_nmisafe() does.
> @@ -600,7 +611,10 @@ static inline void __srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
>  	WARN_ON_ONCE(idx & ~0x1);
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
>  	srcu_lock_release(&ssp->dep_map);
> -	__srcu_read_unlock_nmisafe(ssp, idx);
> +	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> +		__srcu_read_unlock(ssp, idx);
> +	else
> +		__srcu_read_unlock_nmisafe(ssp, idx);
>  	if (in_task())
>  		non_block_end();
>  }
> 
> 
> 
> > David agreed to
> > the change, as long as synchronize_srcu_atomic() stays within the 4-16us
> > it was designed for [3].
> 
> I set a test running (*without* the above). 


