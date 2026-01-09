Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A042309B2
	for <rcu@vger.kernel.org>; Fri,  9 Jan 2026 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930733; cv=none; b=ReOihkhKdnreVSLcsebnqJhaNX9La84uyMFzdLZTV3a2xpz/kYGK9jUjndDIJMkfwBuGn10aCneT2YHI/rivINv3rhYki/g0gj4A3aPgh9m8LzXDZybrl8DDjAzRf+bSZ+NkUwdo20xjfnQk8zBTl9sGLi7p+soL9nC3vs0SV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930733; c=relaxed/simple;
	bh=AVdEwSE8gOa5qwWATy7QUuW4oJvgE53RfI3DgwFz6E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyB6hGmeMPQjBhzVnkMzPwgCjKOxBbjZyq3lQvNrxYlwWHiRLO4rlvnMqEqnEnJN5ru77vlx1955cp+6UVZ20MDt9H1P+9Tu35VXlQmyyYA2yYbi3ls9rhZkKp3dLSWcPjVg5ToyEaviZfqxp9ZdcpecXerFQpqlOURcMbUh+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=x/C04q+/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x/C04q+/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso1968475eec.0
        for <rcu@vger.kernel.org>; Thu, 08 Jan 2026 19:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767930732; x=1768535532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+f1SsIZDMbxwTaTJ4GgOnkEVRMn7oML218Sxv/HWTw=;
        b=x/C04q+/PhoiZqgbtsFKQXvRKJRLAKNPsxjHMrgEJgGZUlm69NjXwUTkuE4vGPSKKa
         96iBdM+OIiN2L4wQKBiYdJgmaVGUZ+e7vctTQPJwORZHwWBKo+x2Mci3E2ML9JB3deg9
         4xJI+hhJleAKEXEvdkv+yvmooiOxeEo13ydZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930732; x=1768535532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+f1SsIZDMbxwTaTJ4GgOnkEVRMn7oML218Sxv/HWTw=;
        b=Zjau1aLr6lOFgvFEIW3MJI5nmD9xAF8+6DFeaZVaS9CzPf/w2ZFbISnQVkXpvXiBHw
         Mhl2CDj9qA+qfwiESURL77WpYIYyz/8TGcqyoVKLpJlAxWDfgAPUAJh2AJhxoQ9IAqBd
         KGx0foz5Iy02Ax060E8Ll6abGZRlJ51Z7AaRaDyelxGkRrDjgm4LT7Fy0eA88TzxdVFY
         h1WSy4AUCRV9rLBXMPObt3Gg3b+q4vpSis7xvRBPYHG7OoIrnBWPfqJA3dW0OMiaFCzx
         /Ylrj0xG2OihD/x3LKL+reJSbopJ7I1D2xoIYKcYnU4NttI4XFWREpQNvgI+wWH35aJx
         /78g==
X-Forwarded-Encrypted: i=1; AJvYcCWvKd56p9Pt8FEoth3NiRAc6USkDaHNp3IbhRk68Veexy0H7J+UHO7eDGfXKC2lewpLooQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGgfVMH8XGlt2x+yq6TyLRmzi0AOoSkIEcbTfHEJN7+qK2F3W
	ASsRqOk5VYWUDJkyX3xrkrEUHaE1A+daY6WOJxXxDfsLTVjAmycg4nG+jNHWo9naajE=
X-Gm-Gg: AY/fxX5r4X33uRDV9Xjy3R6XAQNnPneBNB0s9wzmanT/Tyu0Mab3aOua9DBcXQkENlt
	Or/a2JKBVHdopDO36Zmi1SYBrtev2HV7KlcjLn7t55eJr0NkkYgA0MOfTfYeYUF5MHE22N8u5BO
	gUexHHgDDLV5SbCMSU3HUJbKkRIlkR3aC0xdlrvZFQhw4gP0ohWQpqNg+jbyiH9ci7y8BJ6He58
	Qbe1qX+kyXll4cPqAw0s1t7Xn/dwvRO6CF8n2ZBNmJXiga791xltN6PD9dFdVcc0sydzaSIcUdM
	/IwXMCRlmOv75ge8afBmbvg8Ewkr8/QDhLDK8f+P0rgD3ZQTuvMKkvJDqh/GarMZDjUAVI4gcA5
	UaSMA15AvrCYdtHc8ks8/jGhPhPCqp52cJnBcX3GGC2wlnfMp+7LbRxndx8irI3Tkkeosd0aKZD
	wJKfneBBaD3WXmR/C1WS4=
X-Google-Smtp-Source: AGHT+IFUnmiXEo6GuJuz12uG0x/He17042vNl2YTT0DzjVTvwy+ECgj1J0TXa0FY4T5MjgHpppCmCw==
X-Received: by 2002:a05:7300:6ca7:b0:2ae:5d27:ff49 with SMTP id 5a478bee46e88-2b17d1e4b87mr8253247eec.7.1767930731537;
        Thu, 08 Jan 2026 19:52:11 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b175bee31dsm8426249eec.32.2026.01.08.19.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:52:10 -0800 (PST)
Date: Thu, 8 Jan 2026 22:52:09 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC 04/14] rcu: Promote blocked tasks from per-CPU to rnp
 lists
Message-ID: <20260109035209.GB1105379@joelbox2>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <20260103002343.6599-5-joelagnelf@nvidia.com>
 <20260105105931.141eb6f0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105105931.141eb6f0@gandalf.local.home>

On Mon, Jan 05, 2026 at 10:59:31AM -0500, Steven Rostedt wrote:
> On Fri,  2 Jan 2026 19:23:33 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
> > +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> > +/*
> > + * Promote blocked tasks from a single CPU's per-CPU list to the rnp list.
> > + *
> > + * If there are no tracked blockers (gp_tasks NULL) and this CPU
> > + * is still blocking the corresponding GP (bit set in qsmask), set
> > + * the pointer to ensure the GP machinery knows about the blocking task.
> > + * This handles late promotion during QS reporting, where tasks may have
> > + * blocked after rcu_gp_init() or sync_exp_reset_tree() ran their scans.
> > + */
> > +static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
> > +					  struct rcu_node *rnp)
> > +{
> > +	struct task_struct *t, *tmp;
> > +
> > +	raw_lockdep_assert_held_rcu_node(rnp);
> > +
> > +	raw_spin_lock(&rdp->blkd_lock);
> > +	list_for_each_entry_safe(t, tmp, &rdp->blkd_list, rcu_rdp_entry) {
> 
> How big can this list be? This would be considered an unbounded latency for
> PREEMPT_RT. If this is needed, then we need to disable this when PREEMPT_RT
> is enabled.

Steve, thanks. This is still quite a bit in the experimental/RFC phase, but
if we ever were to do this, we could splice the list of tasks into O(1)
instead of O(N) I am doing here. Great point.

Thanks for the suggestions about the guards as well on the other patch, I
shall use that where possible in any of my new code.

thanks,

 - Joel

