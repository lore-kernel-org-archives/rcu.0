Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0930594E;
	Wed, 25 Mar 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465761; cv=none; b=shTdqypWzXl4G0gR1ofZONLiMMAp/EOIfGJ+3/UKOKe3Iw0NEtGWmXXdtPKHSNj/VIYt+9MSxthsGU0wZfYf9rmiGzujGcBPXtwB9hIjLoJrGRjk9JxN+UBYPh+rY9UdJsS774Nm7fs9zvYk71Y1mpPBkb24MRdce26QophqyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465761; c=relaxed/simple;
	bh=fJeFP8G75M2CHp/7EG5mBsIdUvLdNEgoLcy0NuhsloE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OzXjm+4vQ3QV/jKMEmsxFeju3NPeuTmSJ2s5zcsphajc43OxD4oCJ1TTZibigzwm4OVbFYnzVrSzhznaK08uCImWXUQvL/YzRdKv5gf4UMGv7JcHpTe+vfjrUzgAel1Kf1PaGAbuVNmIiONkZNAvZv2ZpX8CLiIW0S5HifXEaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzFTHiK0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLDyj7A3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzFTHiK0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLDyj7A3"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774465757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iN4Rv3LXNy2hbzE+6U+o61C8MMSRdJ/QX+32T5wiLog=;
	b=FzFTHiK0s3hr5J9s6V+le3ElDm+hAdu1a83orYCvpc0hmT1EBG5R1LHcinMJ/FUkujoBsw
	59PJO077IYQic6mq9YGfmf4OhqsB3OUhlmTGocVkoQt6MMJtPMSOoe9m6TaS3QpjlHnLZd
	gXB34aGiGrMGgwIAYN76GUK55sybtaZNmhOiH1ZWLrRuSo3rCztThsEZnZCnXJDcREyrrz
	awsVBGY0q56zdP60CGZJdOotaSRAy6KkhIll1CzD0lCP3k3XzQQ8VSAJU9PY7wXLk6X/3J
	84LZRjm8f6wAMQvNZbOzSmWHc7UOtu3JvhrKuwKX+XgVgL4NwkNqn5vU9cTqvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774465757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iN4Rv3LXNy2hbzE+6U+o61C8MMSRdJ/QX+32T5wiLog=;
	b=mLDyj7A3QWY6w2hsm4tESbFho0kqINefEb2t1KKDPq1Yo7d/RSfUvqz2kTpRLNmpWRTMyK
	AtH56wJh4NxEpDDA==
To: Vishal Chourasia <vishalc@linux.ibm.com>, peterz@infradead.org,
 aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
 rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
 urezki@gmail.com, samir@linux.ibm.com, vishalc@linux.ibm.com
Subject: Re: [PATCH v3 1/2] cpuhp: Optimize SMT switch operation by batching
 lock acquisition
In-Reply-To: <20260218083915.660252-4-vishalc@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-4-vishalc@linux.ibm.com>
Date: Wed, 25 Mar 2026 20:09:17 +0100
Message-ID: <87ikajenfm.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 18 2026 at 14:09, Vishal Chourasia wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Bulk CPU hotplug operations, such as an SMT switch operation, requires
> hotplugging multiple CPUs. The current implementation takes
> cpus_write_lock() for each individual CPU, causing multiple slow grace
> period requests.
>
> Introduce cpu_up_locked() and cpu_down_locked() that assume the caller
> already holds cpus_write_lock(). The cpuhp_smt_enable() and
> cpuhp_smt_disable() functions are updated to hold the lock once around
> the entire loop, rather than for each individual CPU.
>
> Link: https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

You dropped Joel's Signed-off-by ....

> -/* Requires cpu_add_remove_lock to be held */
> -static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held */
> +static int __ref cpu_down_locked(unsigned int cpu, int tasks_frozen,
>  			   enum cpuhp_state target)

No line break required. You have 100 chars. If you still need one:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

>  	 */
>  	if (cpumask_any_and(cpu_online_mask,
>  			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
> -		ret = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}

Please remove the brackets. They are not longer required. All over the place.

> +static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +			   enum cpuhp_state target)
> +{
> +
> +	int ret;
> +	cpus_write_lock();

Coding style...

> +	ret = cpu_down_locked(cpu, tasks_frozen, target);
>  	cpus_write_unlock();
>  	arch_smt_update();
>  	return ret;
> @@ -2659,6 +2674,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	if (cpu_hotplug_offline_disabled) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +	if (cpu_hotplug_disabled) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	/* Hold cpus_write_lock() for entire batch operation. */
> +	cpus_write_lock();

 .... for the entire ...

And please visiually separate things. Newlines exist for a reason.

Thanks,

        tglx
