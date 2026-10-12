Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAB1F8691;
	Mon, 12 Oct 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837900; cv=none; b=mgpsRuivS7VRms4j3wIjFvRDtJFBifscOv8KlTJNJR3gqltoji18w6cBt3GrsetfPqg0TxcjoOQgxgkTJbn4z9HF6cnsNp97wF4xxvvGMrH/d0yViD3RHypqQp9awjC0Oidbt5H5iowDfTAtYJPzreKUt5uGpISmvAaxWMiTe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837900; c=relaxed/simple;
	bh=5WyS8VsuTcJFIQzu1exfYTiK0PGHYbFWmaG1Myti1FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3SWWUcF1kGflN7o1K9z4DqAeD8qDINdgq5P1SmhAbfDP/U1Qxo543JKKOV6hX8csiPJPMqqI3j+uX+p30LkE3LXwcUcyAX4/cswJOOU/7x5crrZSUdiupuf7Wxe+WE0JH/VJzPX3zbuLK9fkOfhHQHDnuNL8WISdb2jxXIKC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZZ8ZW7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZZ8ZW7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B119E1F0089B;
	Mon, 12 Oct 2026 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791837898;
	bh=1gRKTET9i7Xola75xFYMm1KXoj9OrdPlfT4u6/YGeco=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BZZ8ZW7X+mvuIKRkvCrLgmXTR78XKlwGR6mJmX7sw7egW4N0VvHqW9OrqNJwBQMza
	 NHQ6EQqjtC/yvi0PhIpvkVorUH6s/QXbkH4a6xsJEW9lT1UuTqZWYSreVCBY8PQgCG
	 o3YzFWxHdWVkUdHALvygBXQZgpk9ul1yKRFdxuJFrDqKZGtIwIdbfM7qqkv5ZiycH3
	 OF7Y+WGVI1xHihOWx2OuedDZXriVv41HmTFwn80PxJ9VZukac8qrfBhU1TFpTEuzx7
	 58bvYyOO5OMW3MceeiU/bNgDC7dXlXQKSPMLVAvFAs4v3bb2gVuh7exy+l/scFOXsL
	 FWl/FZAbdt/9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 64126CE04A0; Mon, 12 Oct 2026 13:44:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:44:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Document atomic SRCU in
 Design/Requirements/Requirements.rst
Message-ID: <0dd2509a-4ac2-4759-9017-ce32438b5afb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261011004553.2905142-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011004553.2905142-1-joelagnelf@nvidia.com>

On Sat, Oct 10, 2026 at 08:45:52PM -0400, Joel Fernandes wrote:
> Atomic SRCU (srcu_read_lock_atomic(), srcu_read_unlock_atomic(),
> synchronize_srcu_atomic(), init_srcu_struct_atomic(), and friends)
> added readers that do not sleep or block, plus an update side that spins
> rather than sleeping.
> 
> These are missing from Requirements.rst. Add them.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 8101fe6229d5..d43668595872 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2686,11 +2686,13 @@ The `SRCU API
>  <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
>  includes srcu_read_lock(), srcu_read_unlock(),
>  srcu_dereference(), srcu_dereference_check(), synchronize_srcu(),
> -synchronize_srcu_expedited(), call_srcu(), srcu_barrier(),
> -and srcu_read_lock_held(). It also includes DEFINE_SRCU(),
> -DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(), DEFINE_STATIC_SRCU_FAST(),
> -init_srcu_struct(), and init_srcu_struct_fast() APIs for defining and
> -initializing ``srcu_struct`` structures.
> +synchronize_srcu_expedited(), synchronize_srcu_atomic(), call_srcu(),
> +srcu_barrier(), and srcu_read_lock_held(). It also includes
> +DEFINE_SRCU(), DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(),
> +DEFINE_STATIC_SRCU_FAST(), DEFINE_SRCU_ATOMIC(),
> +DEFINE_STATIC_SRCU_ATOMIC(), init_srcu_struct(),
> +init_srcu_struct_fast(), and init_srcu_struct_atomic() APIs for
> +defining and initializing ``srcu_struct`` structures.
>  
>  More recently, the SRCU API has added polling interfaces:
>  
> @@ -2710,6 +2712,22 @@ certain types of buffer-cache algorithms having multi-stage age-out
>  mechanisms.  The idea is that by the time the block has aged completely
>  from the cache, an SRCU grace period will be very likely to have elapsed.
>  
> +A more recent addition to the SRCU API is the atomic flavor:
> +srcu_read_lock_atomic(), srcu_read_unlock_atomic(), and
> +synchronize_srcu_atomic(). An atomic-SRCU reader runs with preemption
> +disabled, must invoke srcu_read_lock_atomic() and
> +srcu_read_unlock_atomic() on the same CPU from the same context, and
> +must never sleep nor block on anything that might itself depend on
> +memory allocation, which allows synchronize_srcu_atomic() to spin
> +rather than sleep while waiting for pre-existing readers. This
> +requires that all other SRCU usage be excluded from a given atomic
> +``srcu_struct`` structure: every reader must use
> +srcu_read_lock_atomic() and srcu_read_unlock_atomic() rather than
> +srcu_read_lock() or any other SRCU reader flavor, and the structure
> +must not be passed to call_srcu(), synchronize_srcu(),
> +synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
> +srcu_barrier(), or srcu_expedite_current().
> +
>  Tasks RCU
>  ~~~~~~~~~
>  
> -- 
> 2.54.0
> 
