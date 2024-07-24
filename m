Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B91BF38;
	Wed, 24 Jul 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817018; cv=none; b=CacJAhh3P+AgA392XyBIqG/OVJepIyhEnXlxShIiwnaoOx+n31AWMudE1CcnLjTtwrjNKN0KjBGYHINd7t69Au69ld4dy+9qHQoBPb8pNXGct6z683ff5eCgI80+Jp8/fLcmim8VVS9cKsb0hCX8dgoG7qumIPyWyPRDR9dVbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817018; c=relaxed/simple;
	bh=taydrDayl7YHc0KDXIQF6dRJBLw2FPSiUK6agA/9N7U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGMyHjFePneSy1yWQ80+iHXXNGm0sKPxSIJNUtnzCPHIsXj70fAhMwEllRdmIuZ0xriT24bOtXWib10l4vEuxEMBVPk72CtQWMQvwJhTJwvWbZKfoQWGjPuen5dtuJ1TXVjg0zLYzkx0og78DuYas5UlSrNPyn11T8pv2rjGA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIKRPJEq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIKRPJEq"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so7724211fa.1;
        Wed, 24 Jul 2024 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721817015; x=1722421815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7wjB3vzUO80k45Zg+Rderw2hUnYXHkEAc45cO7N1O0=;
        b=aIKRPJEqqCXD0vgy+4yge0xD8N++iVSRWUASyvh0/cNdZLfVx0EkOoopSU0uHBlprG
         PUrGYp5Uwu3Bv7Q18JrtTFowMOcl9yiwVEoqdekKgbDWTuo0ak7zfvJT08iOE3sERPf4
         ySfhjYhKb/EozR3myPlqFwtiXvwduhOiV+dTysY/g7SoS237/Kgu31HXn94ann6+J8hv
         FVJhIQ0SAgWHExr/4QP3d+gkeHf9I1K7IZmUqQi524fXkjQPElZiZ6pK3GRb/19iPdTi
         j53ydDI1R7NPK7Tvx1A0Ym1JJnfNESesvVZNGox4W8GOx2wGmwvAqy3JK78nDGqZa4rO
         PNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817015; x=1722421815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7wjB3vzUO80k45Zg+Rderw2hUnYXHkEAc45cO7N1O0=;
        b=EPBnjHMhPJOmPN/w8SZDLfgEiESdAwZqSL4Ovbdsh/DHy8yy8aPzP+oU1Vm/CQmMcR
         eBOH4sg7s6kuTi3MezQEhb4cmhXQVX2gJV1G4U53+fLed4iOj/xt6I7Wa/od2z9CL4Im
         rzakzxiBS3gweBW8HHQgpNkZdcFZGgZ6qUI2Zsjul7p377fPkC/H8tWMlu7iz8yGxxov
         deu6/7JxOcXXy2Q74+AW2pMdZMQyV+7Esng+uop9pPi7j1Xg8i3rTNCB3Q9wmmbAkHAg
         kgrAPU9TR72CYWN1UMx+0KfuhBFt+NSUhZP1zgRTtSX90NkCehL/Dcw8Oj+ai6MQRCGX
         qyQg==
X-Forwarded-Encrypted: i=1; AJvYcCUjMMV4EM2hY5Fl//8TnDorBbJtKnbvOGsfx+LxCF//FRgaR/atUh/PY0QbQNhn9K04L4T4XJ6Wl3TKNvc79AMUGTr/exzm8C7fcp0nxb3tacpAi/OutTVjFXUkJYRBRkw5
X-Gm-Message-State: AOJu0YxVG98JG3NBrcgHWYeNWnvkYfOsKtYRaEI79Rr33U9Ff38o+HIu
	UYD6iAGBBIw2waOs2GUcSa9EgXuhJYjM+Bl3pezIC9FqQzJcU3ZR
X-Google-Smtp-Source: AGHT+IG5q1oR44yrZothEvstBAYXcvY/2KL9Ny1V7jKMWaZYDi2AomgPqVwVfIjEahYdPXguTJ01iA==
X-Received: by 2002:a2e:a284:0:b0:2f0:291e:d1dd with SMTP id 38308e7fff4ca-2f032cb1496mr4369691fa.11.1721817014985;
        Wed, 24 Jul 2024 03:30:14 -0700 (PDT)
Received: from pc636 (host-90-233-213-186.mobileonline.telia.com. [90.233.213.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef2dcf99b6sm11605591fa.96.2024.07.24.03.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 03:30:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 24 Jul 2024 12:30:11 +0200
To: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
Message-ID: <ZqDXsxAgH3ZLkAcW@pc636>
References: <20240723181025.187413-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723181025.187413-1-longman@redhat.com>

On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
> It was discovered that isolated CPUs could sometimes be disturbed by
> kworkers processing kfree_rcu() works causing higher than expected
> latency. It is because the RCU core uses "system_wq" which doesn't have
> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
> latency limits by using "system_unbound_wq" in the RCU core instead.
> This will ensure that those work items will not be run on CPUs marked
> as isolated.
> 
> Beside the WQ_UNBOUND flag, the other major difference between system_wq
> and system_unbound_wq is their max_active count. The system_unbound_wq
> has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
> is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.
> 
> Reported-by: Vratislav Bendel <vbendel@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-50220
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/rcu/tasks.h | 4 ++--
>  kernel/rcu/tree.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..494aa9513d0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3539,10 +3539,10 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
>  		if (delay < delay_left)
> -			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> +			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> -	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> +	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
>  }
>  
>  static void
> @@ -3634,7 +3634,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
>  		}
>  	}
>  
> @@ -3704,7 +3704,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
>  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_wq,
> +			queue_delayed_work(system_unbound_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> -- 
> 2.43.5
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Uladzislau Rezki
