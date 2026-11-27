Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760080;
	b=JmIZHfmzWbQYbSnP/O56wZHh58u4U35UnsVy6fsUHmromcx+xjdOvB3DtImHUyU9fQcf
	 BtQrHsHr8Uvn7w7k8dY7vDn+vLBM0G6YwRjSuzHfaHzXaKwW294G88s0/bnyVj75zzbax
	 Uaci2368NzSbMN2OiM6ggz/KCyO12tHYzVTI0ULMM5yU6QWgSlkj5KjiFpAX0KJ2jkRhc
	 uDWMcndtRzoly1aVNpJgWDmDyHWEPWIPMaA1k0fR8g7uGHRd/uah8Fj9W/apZoj4AfydT
	 e+ayF84jJiGPg/ubsUcov0ftll9ErzemSFKHTlILdWbXkHjknk+sLPC5EJvx5feS6jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760080;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=D5JALuXk+z3NB80L41dOGExzEM0kYbAD7jHhu16MDp0=;
	b=aJ4R/wlphF8AUro2KPp+VYBK1cYfxGAmSUz/KoXTK+kA6wmNQ/7rslikV1ChNZOzuVlh
	 SQKUfYbjKLG9HzNaBEVEU/74LtGeaU+qGv0N4QQrJu3wClq7Xdd48k6R7NxZKMLgLFKhG
	 vKmNEsigyqiq1jiHH+5KixybjeRvWdHRCApTZ2ZmHLrWQ7V3s5t+X4gmQ5ECuBAVLzW2K
	 VVxcd1WB7c9w24DDi6itxmEfua3j020ic5b9ylnT+xhJMkCA3XdPRIdYinYDQmT216zZk
	 OrYpdeHi1jhUNwbY6TvettswfV1bt0JK+/lgBoyXhcsITlRkhP8iow76pNLf/j/4Dkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr1dmFCc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30550606A31E;
	Fri, 27 Nov 2026 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr1dmFCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C9E1F0089B;
	Fri, 27 Nov 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795760079;
	bh=D5JALuXk+z3NB80L41dOGExzEM0kYbAD7jHhu16MDp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Rr1dmFCcBDQ4mVlo/pUKE6pffpzb7p5k8cP9R70VQ8ILZ/izVTDRdHf7SHblFVIAu
	 8KGF2ziqf1i2qWMKlVepL0imJ3o39EyVs4IR81u2qMWfAiCcFoDnTVN0V+18dfA7Hr
	 0pehxZwLHRBxy95qIdYGwZk0bXaq39MdkJ0cSUbQFCzcI0m0iO83VWgOeq0Ehmm92R
	 mdD27qCY6p4/o8503bGODGTT4/JCmuhmIfHitvv+1syO6mzPIPt3Ij0NDclAhOy8RX
	 nw/Xp4ubITxlMy4gqHNUdECXsc/0Y6t3EJyGlVlIrOxXuMx19h3kDLHD12gPgbtNPa
	 SL9d3QkRVVxww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 58620CE0A35; Thu, 26 Nov 2026 22:14:39 -0800 (PST)
Date: Thu, 26 Nov 2026 22:14:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Fix comments for
 srcu_dereference_check()/srcu_dereference()
Message-ID: <e2e3ba2a-64e5-47fe-95a5-7028b6b52ce5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261126084241.17569-1-qiang.zhang@linux.dev>
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
In-Reply-To: <20261126084241.17569-1-qiang.zhang@linux.dev>

On Thu, Nov 26, 2026 at 04:42:41PM +0800, Zqiang wrote:
> These are SRCU-specific primitives and their checks are against
> SRCU read-side critical sections. this commit therefore fix comments
> "outside of an RCU read-side critical section" to "outside of an
> SRCU read-side critical section".
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good eyes!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/srcu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 380b5964fcb4..87e5535556c6 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -294,7 +294,7 @@ static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __m
>   *	really are in an SRCU read-side critical section.
>   * @c: condition to check for update-side use
>   *
> - * If PROVE_RCU is enabled, invoking this outside of an RCU read-side
> + * If PROVE_RCU is enabled, invoking this outside of an SRCU read-side
>   * critical section will result in an RCU-lockdep splat, unless @c evaluates
>   * to 1.  The @c argument will normally be a logical expression containing
>   * lockdep_is_held() calls.
> @@ -317,7 +317,7 @@ static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __m
>   *	really are in an SRCU read-side critical section.
>   *
>   * Makes rcu_dereference_check() do the dirty work.  If PROVE_RCU
> - * is enabled, invoking this outside of an RCU read-side critical
> + * is enabled, invoking this outside of an SRCU read-side critical
>   * section will result in an RCU-lockdep splat.
>   */
>  #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
> -- 
> 2.17.1
> 
