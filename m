Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428281;
	b=iWLmcz5ornypCRTLuzORfNg1Q0/+HKTA9iMdOc8xKWUVKSIjHxWdgPCNd4fSrc0qLPIC
	 3+YMBEANougTMJvAMqOoSQTZZTBrH0pe7oHx1nm22BZ+/R0fi2Z2+H1PvmTwYxZBQAfbv
	 7LnC/uPXbDPWadfM0Pjw99nu44KARH19IvSS89ImtRMaQxQYJjzGZb++5iJ8FC8ihukzK
	 GaYVP5Gslz0k6mPm33ml4xFOtUT7pvCj7RUTL+8xTC/wTlpdID7htA2IsAeeytwtLxPOr
	 9av6IAKaJl69rIZ+Afz1Y/Lx9gxOpZadNzV0N1W8G+vZH7Xod9vBqh7UjbN3AtDB/Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428281;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KAotcb89D4hecifdLk1/qMYE4+oOkQbgn1TxucAlack=;
	b=ylVmHiVjUv5PkQUrtUKgoL/wPDVRPxirOB3aromupajv/7V2Dq0lD0PxMtVJKoQzpT50
	 KQTl4q2ASjMAXNVYMODsAIuCGW/ORwpM+baXELToqgw0qJ+SgYamwc3GdvLUOS2FEtqw3
	 CzWIYGftZ2zXN/48fH0UNQqZqUR5cxFWyCT+hJ1HKlS0GXnZLW1YpuLMdYbukRKcagOLz
	 UW9hJ7psFKK6zqINJqqAEVYgzlVNfwevMjPM3mmcZbahe0A4zuBECz2hTOSZxjy+b+WO5
	 gGa9rYRvN0vuz4pHcf+7z79H1eTbxEZ4c4JWKJoeaILG+/W/ktmHNd7rSDTST6Tmgog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TyZTK/Nj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F2606A320;
	Mon, 19 Oct 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyZTK/Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDB61F000C4;
	Mon, 19 Oct 2026 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428280;
	bh=KAotcb89D4hecifdLk1/qMYE4+oOkQbgn1TxucAlack=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TyZTK/Nj7KAGHnYmed9f1KZ9jupGg8uUu/Gpaem5iBmpngGRyl9E8i6WsX3dRN4EP
	 az2321s1aEjcmdiDunDjk6AIXq4PWvzVlNOCol5pg/kyP+LjUmcmqyElv6WW+zGIyq
	 Od4ZjhdPu3GjMdcIxcY92CAG+oGTAIN1nt1NEQNYX6dupFv9t368CCOq/6LqI5iqB2
	 E6lRa2SSfTzssQsS6apsAXAWGl+5GCtjvedUM/2eDN0CocQtk+8Siq1ZDxwmnGyePh
	 u24TRF6Ahy0SYfxxBXs0p8VVV1JfTriBoDuw8mrBqgoEtE7Ttlqr8Tbx7H9xOfQDm4
	 WDrIhXQoWB6WA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4222FCE09FC; Mon, 19 Oct 2026 09:44:40 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:44:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Update recent RCU/SRCU API additions to
 whatisRCU.rst
Message-ID: <25bb1aa8-7563-4fca-a17b-5a7d168b5c23@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019122209.15604-1-qiang.zhang@linux.dev>
 <20261019122209.15604-2-qiang.zhang@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019122209.15604-2-qiang.zhang@linux.dev>

On Mon, Oct 19, 2026 at 08:22:09PM +0800, Zqiang wrote:
> The following commit introduces some new RCU/SRCU APIs:
> 
> Commit 'd3f52f53a562 ("srcu: Create an SRCU-fast-updown API")'
> Commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> Commit 'cacadb630375 ("srcu: Add guards for notrace variants of SRCU-fast readers")'
> Commit 'fa8a2d55139f ("srcu: Add lock guard for srcu_fast_updown flavor")'
> Commit '954c0d741299 ("srcu: Add guards for SRCU-fast readers")'
> 
> This commit therefore update thems and some missing RCU related APIs
> to whatisRCU.rst.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Thank you, for both patches:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/RCU/whatisRCU.rst | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index e6767baff2d3..fe9dc3948690 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1084,8 +1084,9 @@ RCU::
>  	rcu_dereference			call_rcu
>  	rcu_dereference_check		call_rcu_hurry
>  	rcu_dereference_protected	kfree_rcu
> -	rcu_read_lock_held		kvfree_rcu
> -	rcu_read_lock_any_held		kfree_rcu_mightsleep
> +	rcu_dereference_all		kvfree_rcu
> +	rcu_read_lock_held		kfree_rcu_mightsleep
> +	rcu_read_lock_any_held		kvfree_rcu_mightsleep
>  	rcu_pointer_handoff		cond_synchronize_rcu
>  	unrcu_pointer			cond_synchronize_rcu_full
>  					cond_synchronize_rcu_expedited
> @@ -1209,13 +1210,23 @@ SRCU::
>  	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
>  	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
>  	srcu_read_lock_notrace		poll_state_synchronize_srcu
> -	srcu_read_unlock_notrace
> +	srcu_read_unlock_notrace	synchronize_srcu_atomic
>  	srcu_down_read
>  	srcu_up_read
>  	srcu_down_read_fast
>  	srcu_up_read_fast
> +	srcu_read_lock_fast_updown
> +	srcu_read_unlock_fast_updown
> +	srcu_read_lock_atomic
> +	srcu_read_unlock_atomic
>  	guard(srcu)()
> +	guard(srcu_fast)()
> +	guard(srcu_fast_notrace)()
> +	guard(srcu_fast_updown)()
>  	scoped_guard(srcu)
> +	scoped_guard(srcu_fast)
> +	scoped_guard(srcu_fast_notrace)
> +	scoped_guard(srcu_fast_updown)
>  	srcu_read_lock_held
>  	srcu_dereference
>  	srcu_dereference_check
> @@ -1229,9 +1240,16 @@ SRCU: Initialization/cleanup/ordering::
>  	DEFINE_STATIC_SRCU
>  	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
>  	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
> +	DEFINE_SRCU_FAST_UPDOWN		// for srcu_read_lock_fast_updown() and friends
> +	DEFINE_STATIC_SRCU_FAST_UPDOWN	// for srcu_read_lock_fast_updown() and friends
> +	DEFINE_SRCU_ATOMIC		// for srcu_read_lock_atomic() and friends
> +	DEFINE_STATIC_SRCU_ATOMIC	// for srcu_read_lock_atomic() and friends
>  	init_srcu_struct
>  	init_srcu_struct_fast
> +	init_srcu_struct_fast_updown
> +	init_srcu_struct_atomic
>  	cleanup_srcu_struct
> +	smp_mb__after_srcu_read_lock
>  	smp_mb__after_srcu_read_unlock
>  
>  All: lockdep-checked RCU utility APIs::
> -- 
> 2.17.1
> 
