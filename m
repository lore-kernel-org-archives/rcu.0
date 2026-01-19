Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CA3016E9
	for <rcu@vger.kernel.org>; Mon, 19 Jan 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821861; cv=none; b=SMlhIw2yGriU1YUeobPRz0huUwQURiyQcSR0aAKsQXPHkA+1K2L15WiMqRcvq+hkJ578UJTWeqvc6q9vRzq6Jq7R7nGRtEsXbOa/8yepCs3QawgRGXAWxjZ5Yc7F8PAdrN1P/dQlHpaEmSAVIljy6y4/dBINosBY0GQkiCgBCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821861; c=relaxed/simple;
	bh=uxcUk194uGzZeYHcTUlsFIXFeLcZtnzEBywgZVNlk78=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDsV1sw43cMUIEAK34PmBzGuGIdhj0MQMrm5d60o+L+7+3OZXgybbMML6eQ4xosp7cMu0Y0NqiYIJpp6uM5QJ+T36X9wMZI3VOPni+8Qm5Z9wPmOVD/Adm8vKENLtZOdz40kVlvl4CLlnxXs9obla2X2XLeERuShq8zy+cnt8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgn42JtF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgn42JtF"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so3798371e87.3
        for <rcu@vger.kernel.org>; Mon, 19 Jan 2026 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768821858; x=1769426658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7nhAQnYPCgKU9ad2+odoBV/ZH6TslLcu+uw0gi4j5jg=;
        b=Xgn42JtF41X5LvsIERf9nNbfgu7rmFWdYPUCpqJVvhNwDtvsvCPi5VMpR1CGWPkNts
         xC0Y+906ANgqE0EP3cYvWwkZbs0dO4WfWa0vCxVk8b36b01kSKVfx8DAtM8aT2KmQJWZ
         Z/XzA1Ytj/lHV11btD6ZDvZNPmh2Q+MCp+w3rQcyZDM5WEU6uK4NaHpnb2JlvS8oL0ad
         NSgEPP1t5EaES65NzRfqTgRRr0MVGtO/+5HeG0KtBtyjwnEPi4Q8fD1HqSf+8o/F2uFp
         29+ojKzSYiAyRhHKpmIk0GB5I9Crb0pPwWuS+0gP+cZSiZnEczV9M+0o/mhT5qAbo/JV
         swJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768821858; x=1769426658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhAQnYPCgKU9ad2+odoBV/ZH6TslLcu+uw0gi4j5jg=;
        b=OI5p8M7nAXDXKzPWxNPuSCRn1UZhiZ4nsiL6YUh8WcEwqgVZGmKMRSr4buh3IjKQ3E
         dvO9SaXnayK6a5DUJfc/B8gQ3kcNK16Q9l9r/0CcwABCo7ze0ofcxXjLBXaX4+S38KzI
         +IZkwwkRS0eFljkxeGdc2sX60SJB0CcqrZ0LGob3Opo3v5r1yhDXfHa7ksiHxmXfcW25
         Ht2QErdVdurmf3wiQQBTSkydP85LTjEOjYsJWoyvc3fIkoJoetd/1VpGB+X04c7YIhc7
         UDM9007TuPDa6TItKechE0fL37SPWh4CvSCbyLiZY9eO/qJx5WLgZWdtXkVIS2cyclg8
         CtSg==
X-Forwarded-Encrypted: i=1; AJvYcCUKC+Gfz9mPvjch+ODK8aZ2aWg5MXY9XtbFBN1qnJiV+O33EOsbvDV4CHUbdVCk5XYnBTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23zQIqBOUguMscoS2MZ4DcS7c6/4zxihmjx7TF+hRyEB45cue
	7WgwOAtKcZfJvNfrxZW+rPgTS8wSBd416i6j7izg+72GbYXy4pVkf/x5
X-Gm-Gg: AY/fxX4aVwuNRLDmFVC82oG0UmQbb08/y3d7ycl/xM1dyU/Ru0oA2VW+C5d2SYYpwrT
	ULFyi/s3IKVfqJm14zTqpKYV9wskLXUbEgfrj5uXnRaq79i1m6EQV5prlJDgSj6vXj2Z0XWXuXF
	u42rbcUwUYhYyGvvWlLXQw8Wxs2IGYL1droyFrStgzImM1tkQ3V4HAUlm1gbRL6JSKQFCkYI/+O
	tcn8xoXZLgFpLikojHYEB9lZu6c7C7nGSiYcDsVb2mLgo+JIZKXtSlhVMajJ4j22DzjmGfk8GGY
	eSBlpe3RgYot2ayD8ZaflgBvVy99y64A2JlaT/nAu/xh1PbzAG94XqnZInM9IXNuNZSAg0WzHOE
	8IeKvXPxvpBhuMK9FttDyCZr6nJxrHFPOrHcUxJlT5EuQ1TDdX44W
X-Received: by 2002:a05:6512:3a8b:b0:59b:7c3e:21bc with SMTP id 2adb3069b0e04-59baeefdb8fmr4165456e87.46.1768821857737;
        Mon, 19 Jan 2026 03:24:17 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33f01asm3291575e87.13.2026.01.19.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:24:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 19 Jan 2026 12:24:15 +0100
To: Samir M <samir@linux.ibm.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <aW4UX3_-LzeSB4Wk@milan>
References: <20260114183415.286489-1-urezki@gmail.com>
 <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>

On Sat, Jan 17, 2026 at 11:47:08AM +0530, Samir M wrote:
> 
> On 15/01/26 12:04 am, Uladzislau Rezki (Sony) wrote:
> > Currently, rcu_normal_wake_from_gp is only enabled by default
> > on small systems(<= 16 CPUs) or when a user explicitly set it
> > enabled.
> > 
> > This patch introduces an adaptive latching mechanism:
> >   * Tracks the number of in-flight synchronize_rcu() requests
> >     using a new atomic_t counter(rcu_sr_normal_count);
> > 
> >   * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
> >     the rcu_sr_normal_latched, reverting new requests onto the
> >     scaled wait_rcu_gp() path;
> > 
> >   * The latch is cleared only when the pending requests are fully
> >     drained(nr == 0);
> > 
> >   * Enables rcu_normal_wake_from_gp by default for all systems,
> >     relying on this dynamic throttling instead of static CPU
> >     limits.
> > 
> > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >   kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
> >   1 file changed, 26 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 293bbd9ac3f4..c42d480d6e0b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >   	atomic_set_release(&sr_wn->inuse, 0);
> >   }
> > -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > -
> > -static int rcu_normal_wake_from_gp = -1;
> > +static int rcu_normal_wake_from_gp = 1;
> >   module_param(rcu_normal_wake_from_gp, int, 0644);
> >   static struct workqueue_struct *sync_wq;
> > +#define RCU_SR_NORMAL_LATCH_THR 64
> > +
> > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > +static atomic_long_t rcu_sr_normal_count;
> > +static atomic_t rcu_sr_normal_latched;
> > +
> >   static void rcu_sr_normal_complete(struct llist_node *node)
> >   {
> >   	struct rcu_synchronize *rs = container_of(
> >   		(struct rcu_head *) node, struct rcu_synchronize, head);
> > +	long nr;
> >   	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> >   		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >   	/* Finally. */
> >   	complete(&rs->completion);
> > +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > +	WARN_ON_ONCE(nr < 0);
> > +
> > +	/*
> > +	 * Unlatch: switch back to normal path when fully
> > +	 * drained and if it has been latched.
> > +	 */
> > +	if (nr == 0)
> > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> >   }
> >   static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
> >   static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> >   {
> > +	long nr;
> > +
> >   	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > +
> > +	/* Latch: only when flooded and if unlatched. */
> > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> >   }
> >   /*
> > @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
> >   	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> > -	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> > +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> > +			atomic_read(&rcu_sr_normal_latched)) {
> >   		wait_rcu_gp(call_rcu_hurry);
> >   		goto trace_complete_out;
> >   	}
> > @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
> >   	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> >   	WARN_ON(!sync_wq);
> > -	/* Respect if explicitly disabled via a boot parameter. */
> > -	if (rcu_normal_wake_from_gp < 0) {
> > -		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > -			rcu_normal_wake_from_gp = 1;
> > -	}
> > -
> >   	/* Fill in default value for rcutree.qovld boot parameter. */
> >   	/* -After- the rcu_node ->lock fields are initialized! */
> >   	if (qovld < 0)
> 
> 
> Hi Uladzislau,
> 
> I verified this patch using the configuration described below.
> Configuration:
>     •    Kernel version: 6.19.0-rc5
>     •    Number of CPUs: 2048
> 
> Using this setup, I evaluated the patch with both SMT enabled and SMT
> disabled. The results indicate that when SMT is enabled, the system time is
> noticeably higher. In contrast, with SMT disabled, no significant increase
> in system time is observed.
> 
> SMT=ON  -> sys 31m22.922s
> SMT=OFF -> sys 0m0.046s
> 
> 
> SMT Mode    | Without Patch    | With Patch   | % Improvement    |
> ------------------------------------------------------------------
> SMT=off     | 30m 53.194s      | 26m 24.009s  | +14.53%          |
> SMT=on      | 49m 5.920s       | 47m 5.513s   | +4.09%           |
> 
> 
> Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>
> 
Thank you!

If we decide to go with it i will add Tested-by.

--
Uladzislau Rezki
