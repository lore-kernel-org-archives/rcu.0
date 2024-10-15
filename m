Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F384203714
	for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018093; cv=none; b=U+4x/NjMBPESXoalvryrrmsjw3nOSIRxyi4ZR8l++FDK0Cpv4qPHwbCwcnSZ63LxHJ0ooSr9lkp9+stVzJvDaLn1hZXaYqlvND1YvHWuaalR4SgowLm3qwINUJKutTzpwNkspJob/rycuLcIxEnxwBgl8ZRqvHcYYNO9F3AuSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018093; c=relaxed/simple;
	bh=xclAp3358o1GSRDObWNEEYRwXA2GYIZQEWERQwBhl50=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpHal+8P9E588ToUSlthJh0lrYtA8x1iFiaJ5KCTTslUt+6GUxkhUiz/bcCdjAAcUh5W97+MK2OKBR8vtjvNKsm6pVVzQsRL7qRFG8Ucf68W3q3ovP5XM+zY9mpMfcYWWVycLDVw4rRQb620/RliuJDyPJcAsSNSS5Z3NEljmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=pIMBBLpH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pIMBBLpH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b10ed5e7cdso628598785a.3
        for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729018090; x=1729622890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3T1pHk6kVrDYaC9PJpwXDBTIgR4oYMz5uSi/GGf2dLg=;
        b=pIMBBLpHdDhvIOF8+PLFuwOMAWR441VoIMpD2xtwQ/WEXBTQiQ0s08386WHPYIrCxX
         HhbdGzPVzSj8zJdnJUK1/VopqKGTGwFcfpdZjw6IDdkS6hzaRghZj77esDRa/mLhfMyO
         RJUQGTFX8PtQm3IZJBAZeYv+dfnbbMkNVT3yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018090; x=1729622890;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T1pHk6kVrDYaC9PJpwXDBTIgR4oYMz5uSi/GGf2dLg=;
        b=dQYLgYY03MjSDil08MggVERWaHxeGn+Xcbg6s1wzkvn0vXdtKfXhKLRDewsetzKKz3
         s6V+6gsZthrDTUkCwNMgLV9CUxjim7JFaeXRixV//G9iwymhpScVzu7QTeeJxrkByPPu
         4hamccpcxh0jpcb/6ERXgzPdMrFyOIzjekrbhWos36QlsDRQ3SxIK+yU9BwvlQJxdVb6
         XmrJSzXifVJKo6Sfn2sD0dK0gHjd9b1LGb4DIjRVfictHrOkZzh8GTeuE8ITv8PBzeYt
         Km75qVOgmckhGI3h9whSo+Gu0InIJFckKgKP49trqC5BcyQ8AA3D8Zmr1gwSb+QYyQ4G
         qYQg==
X-Forwarded-Encrypted: i=1; AJvYcCXxgJulzN3urarsi8eWil5NMToWGbrms7JMAYJ4oo1r0CT9TS37XxLuzTux1ibsjri6vs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqlYTmjjy5aPqt7Vsir8oYFYjA1+gLl4lxYHA2bM4uZ9mPVr6
	Uw06OVwgLeS3kPcxuFVD9e4ZHYdumqWQPJWzFDWwjaJzHmsTYVDknKExQlL6gYU=
X-Google-Smtp-Source: AGHT+IGX+qjAK/CrOqvekczHdHEEe340jRXKcB/zLEOiPXMkbjeTCj4l6jHidKqL8ktZOU+ttRsz6g==
X-Received: by 2002:a05:620a:199a:b0:7a9:ac57:ff58 with SMTP id af79cd13be357-7b120fc4cf3mr1654070685a.37.1729018090221;
        Tue, 15 Oct 2024 11:48:10 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136179ec0sm100204585a.59.2024.10.15.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:48:09 -0700 (PDT)
Message-ID: <670eb8e9.050a0220.36d3ae.48f3@mx.google.com>
X-Google-Original-Message-ID: <20241015184807.GA973@JoelBox.>
Date: Tue, 15 Oct 2024 14:48:07 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 2/3] rcu: Stop stall warning from dumping stacks if
 grace period ends
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
 <20241009180509.778133-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180509.778133-2-paulmck@kernel.org>

On Wed, Oct 09, 2024 at 11:05:08AM -0700, Paul E. McKenney wrote:
> Currently, once an RCU CPU stall warning decides to dump the stalling
> CPUs' stacks, the rcu_dump_cpu_stacks() function persists until it
> has gone through the full list.  Unfortunately, if the stalled grace
> periods ends midway through, this function will be dumping stacks of
> innocent-bystander CPUs that happen to be blocking not the old grace
> period, but instead the new one.  This can cause serious confusion.
> 
> This commit therefore stops dumping stacks if and when the stalled grace
> period ends.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_stall.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d7cdd535e50b1..9d79133377ff6 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -335,13 +335,17 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>   * that don't support NMI-based stack dumps.  The NMI-triggered stack
>   * traces are more accurate because they are printed by the target CPU.
>   */
> -static void rcu_dump_cpu_stacks(void)
> +static void rcu_dump_cpu_stacks(unsigned long gp_seq)
>  {
>  	int cpu;
>  	unsigned long flags;
>  	struct rcu_node *rnp;
>  
>  	rcu_for_each_leaf_node(rnp) {
> +		if (gp_seq != rcu_state.gp_seq) {
> +			pr_err("INFO: Stall ended during stack backtracing.\n");
> +			return;
> +		}

small nit, this also needs data_race() like you did in next patch? Although
you did delete this code in the next patch.

thanks,

 - Joel


>  		printk_deferred_enter();
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		for_each_leaf_node_possible_cpu(rnp, cpu)
> @@ -608,7 +612,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
>  	       data_race(rcu_state.n_online_cpus)); // Diagnostic read
>  	if (ndetected) {
> -		rcu_dump_cpu_stacks();
> +		rcu_dump_cpu_stacks(gp_seq);
>  
>  		/* Complain about tasks blocking the grace period. */
>  		rcu_for_each_leaf_node(rnp)
> @@ -640,7 +644,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	rcu_force_quiescent_state();  /* Kick them all. */
>  }
>  
> -static void print_cpu_stall(unsigned long gps)
> +static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  {
>  	int cpu;
>  	unsigned long flags;
> @@ -677,7 +681,7 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> -	rcu_dump_cpu_stacks();
> +	rcu_dump_cpu_stacks(gp_seq);
>  
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	/* Rewrite if needed in case of slow consoles. */
> @@ -759,7 +763,8 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	gs2 = READ_ONCE(rcu_state.gp_seq);
>  	if (gs1 != gs2 ||
>  	    ULONG_CMP_LT(j, js) ||
> -	    ULONG_CMP_GE(gps, js))
> +	    ULONG_CMP_GE(gps, js) ||
> +	    !rcu_seq_state(gs2))
>  		return; /* No stall or GP completed since entering function. */
>  	rnp = rdp->mynode;
>  	jn = jiffies + ULONG_MAX / 2;
> @@ -780,7 +785,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  			pr_err("INFO: %s detected stall, but suppressed full report due to a stuck CSD-lock.\n", rcu_state.name);
>  		} else if (self_detected) {
>  			/* We haven't checked in, so go dump stack. */
> -			print_cpu_stall(gps);
> +			print_cpu_stall(gs2, gps);
>  		} else {
>  			/* They had a few time units to dump stack, so complain. */
>  			print_other_cpu_stall(gs2, gps);
> -- 
> 2.40.1
> 
> 
