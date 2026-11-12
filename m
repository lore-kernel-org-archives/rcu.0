Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444385;
	b=wKIjtdonP3VEuPvEYLVyKcfpKqO1SKF9PlTgVUd8WRLaRV1jDheoM3tmKGn0LMOQt4dG
	 Ka2bmxFrj5o/joH+rtB4A/Ka6BSrLwdEqxMXELWwJ84ewVduIag8c2Nco4sGLn+ESNDdC
	 A2OOuSZCiDNO5KYTur+slgm/Sp/FqZt0uuYtWxazq8YV9y7VOztfP9CgTDSbNgEt/cnYQ
	 FAsBqz0wPH2xgjW2BJk32M5N7w7HC0VkZB+SpatgsakdALP3VIP4AHYdpMo9NY+G7yV/w
	 1JccWLZ57qgoDRVHx2xi42DcrR2AFj5GWlQRTzsdL3Y/zFYE/7u3eaRKbe6TkyADaEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444385;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UylM3fCbOnl/hJqrcIoAx3XYJsPZLJxNhtnoVw+tiOw=;
	b=CUw/1CzYhjbQ95jUcj9ajX0L++WlWDHjLLUy1b/GbHTbpsLH/WE+r/5Iv9CvjXsNjuin
	 /RBAARAdKVSc2k3oE91tSKTp1/Am3RK6Qm8VhWLc7J3n5wDhYayGroDDdD5gtYPcxdDgl
	 3Zj3yvS8TUGpORENfhAfjurc5rDHvKecclBF+Bjk2h/3TJ1moDOpzC8R9uIzr4aE1vg0b
	 KYnoWJCUMPDD2KiCmg3D8MYdeAiz1yew9Zjj6FH/xhc0Ej8nOKAxJuFPFKxujCNhKAyqu
	 Mnc3c7SuaKa5pquw0rhBBzM9njvq71cCSTks/8cAU/8jKs5XOkUdArOjpu3slmx2Mpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCthSEC4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABD606A31C;
	Thu, 12 Nov 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCthSEC4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DF21F00A05;
	Thu, 12 Nov 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444384;
	bh=UylM3fCbOnl/hJqrcIoAx3XYJsPZLJxNhtnoVw+tiOw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=bCthSEC4X+MgN3If1ZvJelX8m88OPNi7BU9hbfw/mJR3D9YbeG8Zy3tLW7+3hRHnV
	 CGePV0WeP+JAIf8v7bMq5JJLPchTBbAzaqNXTPqbcWrjFhC3t+IRjQD3z4/yPyU1Ln
	 EYCamSOI3g7G3+00oJqx3lQrmXvFw6shMw6lCufGpku/Kt571izoZ69xzVYNAtN2Vh
	 oNJpDoevpaudIv5sf/mVJ0LmtqCWWf3XaVXeXPHwpDyPbU71IpQge3AwG0prAZYXzN
	 JW6h2TgOW2X9qd4fFT4G1i3hbx6xAgnvxXsnN+PrGP5rDUoeaGtHOHv4eJRUZkTrpD
	 TGVAdMyvS4ZNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 761F4CE08D0; Wed, 11 Nov 2026 16:46:24 -0800 (PST)
Date: Wed, 11 Nov 2026 16:46:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [PATCH v2 7/7] rcutorture: Check an atomic SRCU wait within an
 RCU reader
Message-ID: <71d0bf4b-d991-43ee-95c3-ca24c6717f4d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-8-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261111145949.70845-8-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:49AM -0500, Mathieu Desnoyers wrote:
> synchronize_srcu_atomic() may be called within rcu_read_lock().  It must
> then not end an RCU grace period, because its caller still holds it up.
> Tiny SRCU did end one, by calling synchronize_rcu().
> 
> Check this once, when a torture type starts with atomic SRCU readers.
> Take a cookie from get_state_synchronize_rcu() within rcu_read_lock(),
> call synchronize_srcu_atomic(), and warn if
> poll_state_synchronize_rcu() then reports the cookie as completed.  The
> cookie is taken within the reader, so no RCU grace period can complete
> it before rcu_read_unlock().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 2ec461414263..d9c9ff653cb6 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -799,6 +799,24 @@ static void srcu_torture_read_unlock_atomic(int idx)
>  	srcu_read_unlock_atomic_irqrestore(srcu_ctlp, idx, flags);
>  }
>  
> +/*
> + * Wait for an atomic SRCU grace period within an RCU reader.  The wait must
> + * not end an RCU grace period: this reader still holds it up.  The cookie is
> + * taken within the reader, so no RCU grace period can complete it there.
> + */
> +static void srcu_torture_check_atomic_in_rcu_reader(void)
> +{
> +	unsigned long cookie;
> +
> +	rcu_read_lock();
> +	cookie = get_state_synchronize_rcu();
> +	synchronize_srcu_atomic(srcu_ctlp);
> +	WARN_ONCE(poll_state_synchronize_rcu(cookie),
> +		  "%s: synchronize_srcu_atomic() ended an RCU grace period within an RCU reader\n",
> +		  __func__);
> +	rcu_read_unlock();
> +}
> +
>  static void srcu_torture_init(void)
>  {
>  	rcu_sync_torture_init();
> @@ -819,6 +837,7 @@ static void srcu_torture_init(void)
>  		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
>  		srcu_torture_init_forbidden_apis();
>  		srcu_torture_init_irqsave();
> +		srcu_torture_check_atomic_in_rcu_reader();
>  	}
>  }
>  
> @@ -1093,6 +1112,8 @@ static void srcud_torture_init(void)
>  		WARN_ON(init_srcu_struct(&srcu_ctld));
>  	}
>  	srcu_ctlp = &srcu_ctld;
> +	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
> +		srcu_torture_check_atomic_in_rcu_reader();
>  }
>  
>  static void srcu_torture_cleanup(void)
> -- 
> 2.47.3
> 
