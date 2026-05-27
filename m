Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88138D688
	for <rcu@vger.kernel.org>; Wed, 27 May 2026 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910648; cv=none; b=kIkJkVMcWgsCHps90q8mupouN3o1p02yCSzgAxLoa9AL7W7P0vta+2xY4zL+rtr93m+VckobzuCbbbS+4QCho3gdaqFAF0G3vGMIW2rf5rOu7G2f3TD/xK6kHAkUHKe5C+4hbZpLtcZgnITCTqlG+fBQX0bHJHpJLfU1BStN8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910648; c=relaxed/simple;
	bh=x+vpFCv9t5i0eLtbepQ1BlkgQnMU1CTyc6ZrmXxQ3Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgySMseaeMf+50ng6Sr1fUdtEXSKBhtiNJTQaNSdk5O3345EFGxSuDEFAkGl4fg6D1MwidXsZAMlQiuI4KvqcVwK0cHrCV4/QoIRw4WHXqK61F/Pp3h7Fj2K2xLZdnAFo3nPgp8/zyEepdvi8zwm8zrlPFPAuMOnFIm70Ldcc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuyPiYIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuyPiYIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E5A1F00A3E;
	Wed, 27 May 2026 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910638;
	bh=FXecNFpbF9GdMUp7owwFqa+VD/uPa2ilh/nNP5piS9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EuyPiYIlwVaSDuzneH+p9kRWGchrwYMVtHZ0QgsNNr7aqsQbL8L9vWFEmSzawk9UU
	 17NitMf7r0WeFxBI6ZRzn+N1JF9u1BQpA9o6ZpW5lK1lluZ0kJFBMQqKfDbGjpumI1
	 uj48G6rFRIkz6f/HiAmjqG/KsxlN5Lm2CyZZWn8VL6Lz5Np5ypUCiw8vefcUKbv8NK
	 jMbYHdzYa0UFdrmnXrs8hyQjw7DJDuw4CktO+6hF1dU5AdVFqCaOR//asMTENQCFSq
	 kMFdRdsIb9JvjfTBvcDBZdbjk9dFjphbTVn3ctRq3m06VxPVLg8/EEau7bVWHTqCRz
	 f/+Px5g6UnHKQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97DB2F40070;
	Wed, 27 May 2026 15:37:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 15:37:16 -0400
X-ME-Sender: <xms:7EcXasMXidB6OfwP6TxyreBYecnlHlMdByePgEKPmiPunwrSbOd7nQ>
    <xme:7EcXaqDm17e7Td4uQydQzaNqyE_ec2X-Bpuip6sHDy667Dni7n1yLqe6Z29V7fE40
    OSLygGpJWyEIcJV024mRJ7DdYT33TfWUxUe2UlJJm3Vofafol3RXw>
X-ME-Received: <xmr:7EcXaq8Ta6XMMbnz6oAHH6jEzksBolQDLznUbxAE0v7CpTRIbtlE3Agha2wHweKx1Yr6yye2G0Bjg2UHkY5gVzVD63ILhzZc>
X-ME-Proxy-Cause: dmFkZTFDaPOFUTIrthp7MASqGDYyu33hhYiuJF+jfH0TbJsmPqMjc5Fbg/kqZe76GTdjZ+
    48A2PoaUy4MVeCrgTDTrWsa1ALBYCa5L08qLuLq2aB0CaasaErhs1ZMdrxnIK0XiauTDaW
    CEBBv8iQJpcyqu8G+x0bsEuJevxxsHKTWOPgHAWbOSgNGXSYO+YDPAlQL7VOHGaYwWjzJZ
    +1hNZsAlcq9o5JmqHk1i2SZ4CylGwDOOJGjawpbbnf5fJ0THYKXcY7KyiqT0T/idVA270p
    Z4TK4j74ak8N5a2vfD7uFFXhDeZgU1w4nFXlPbpeiVhCutzCqWztxnKNRHHl4cPp4pgzJ5
    oV1RGYmz2Bzm1pIDbYiDY1pOF8eLeWs0C57PNS/TYkzqPylszjcKD5Jd8m7CSvz53UCehV
    iFqzhr8IJQNRSkDbVWIbllj5xVwRi8Kz7aFPUn2WXdloW+5IE5axDkWaIebw7aPU29CDec
    BS6kima5QZbJ/9ugN1vEbinCpEQn0OswWhMoua9176KWHX7sR6jqojhIcGkmxMxaxinery
    prJzzH0G6mAwaLeigvG8gPht0wW4/mX2NbXScwKs/OSpNyZjh749DSoUEJJcBOH6YhreE8
    0Z/2SD4Qar0sWWNuIWyEiQQpvbHY+hHxXwoZES/b9JuRjj+IBWUODBCTPS3Q
X-ME-Proxy: <xmx:7EcXarFPqVMuH-L8DuvupI_bO8xb8Nc9emWYmXzREAI4m_Yuo5y75w>
    <xmx:7EcXahICljBcdWsFAtnEaMzWaMpURlX5NELFGs4Q7Ja76ha8q9xdIQ>
    <xmx:7EcXaue-JJicZt8zoFDLyabQyE8s0Z4PeyjoVt7OjIZCsaiKCTuMPA>
    <xmx:7EcXauXWS7VZjozL6XUrVnT4Lp2p86rhl7G4ZUc72twTYQ7CyuJGnw>
    <xmx:7EcXalHlM7CBATwR3SSE_PYuYUPF_GyuGAjNKHa1moIcLAzR589YviRm>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 15:37:15 -0400 (EDT)
Date: Wed, 27 May 2026 12:37:14 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 2/4] srcu: expose srcu_readers_active()
Message-ID: <ahdH6uMgAwd9KTAU@tardis.local>
References: <20260527174120.510447-1-work@onurozkan.dev>
 <20260527174120.510447-3-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527174120.510447-3-work@onurozkan.dev>

On Wed, May 27, 2026 at 08:40:43PM +0300, Onur Özkan wrote:
> Move srcu_readers_active() from kernel/rcu/srcutree.c into
> include/linux/srcu.h so it can be reused by Rust SRCU helpers.
> 
> Provide a CONFIG_TINY_SRCU implementation in the header as well
> so the helper is available regardless of the selected SRCU backend.
> 
> This is needed by rust/helpers/srcu.c which now adds
> rust_helper_srcu_readers_active() as a wrapper around the SRCU helper
> for Rust callers.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  include/linux/srcu.h  | 29 +++++++++++++++++++++++++++++
>  kernel/rcu/srcutiny.c |  2 +-
>  kernel/rcu/srcutree.c | 25 -------------------------
>  rust/helpers/srcu.c   |  5 +++++
>  4 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 81b1938512d5..5ca35efb4536 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -92,6 +92,35 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
>  void cleanup_srcu_struct(struct srcu_struct *ssp);
>  void synchronize_srcu(struct srcu_struct *ssp);
>  
> +/**
> + * srcu_readers_active - returns true if there are readers, and false otherwise
> + * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> + *
> + * Note that this is not an atomic primitive, and can therefore suffer
> + * severe errors when invoked on an active srcu_struct. That said, it can be
> + * useful as an error check at cleanup time.
> + */
> +static inline bool srcu_readers_active(struct srcu_struct *ssp)
> +{
> +#ifdef CONFIG_TINY_SRCU

Having a "#ifdef" in a function body is generally considered as bad code
(I know we have some of these in rust helpers, but helpers are a bit
special and maybe we should clean them up). So could you move this
function into include/linux/srcutiny.h and include/linux/srcutree.h?

Thanks!

Regards,
Boqun

> +	return READ_ONCE(ssp->srcu_lock_nesting[0]) || READ_ONCE(ssp->srcu_lock_nesting[1]);
> +#else
> +	int cpu;
> +	unsigned long sum = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> +
> +		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> +		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> +		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> +		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> +	}
> +
> +	return sum;
> +#endif
> +}
> +
>  #define SRCU_GET_STATE_COMPLETED 0x1
>  
>  /**
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index a2e2d516e51b..5dc26af604bf 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
>   */
>  void cleanup_srcu_struct(struct srcu_struct *ssp)
>  {
> -	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
> +	WARN_ON(srcu_readers_active(ssp));
>  	irq_work_sync(&ssp->srcu_irq_work);
>  	flush_work(&ssp->srcu_work);
>  	WARN_ON(ssp->srcu_gp_running);
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a..b1e97ba2e53f 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -598,31 +598,6 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
>  }
>  
> -/**
> - * srcu_readers_active - returns true if there are readers. and false
> - *                       otherwise
> - * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> - *
> - * Note that this is not an atomic primitive, and can therefore suffer
> - * severe errors when invoked on an active srcu_struct.  That said, it
> - * can be useful as an error check at cleanup time.
> - */
> -static bool srcu_readers_active(struct srcu_struct *ssp)
> -{
> -	int cpu;
> -	unsigned long sum = 0;
> -
> -	for_each_possible_cpu(cpu) {
> -		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> -
> -		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> -		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> -		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> -		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> -	}
> -	return sum;
> -}
> -
>  /*
>   * We use an adaptive strategy for synchronize_srcu() and especially for
>   * synchronize_srcu_expedited().  We spin for a fixed time period
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> index 79dd24a104ef..fa4b5879dda5 100644
> --- a/rust/helpers/srcu.c
> +++ b/rust/helpers/srcu.c
> @@ -13,6 +13,11 @@ __rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
>  #endif /* CONFIG_DEBUG_LOCK_ALLOC */
>  }
>  
> +__rust_helper bool rust_helper_srcu_readers_active(struct srcu_struct *ssp)
> +{
> +	return srcu_readers_active(ssp);
> +}
> +
>  __rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
>  {
>  	return srcu_read_lock(ssp);
> -- 
> 2.51.2
> 
