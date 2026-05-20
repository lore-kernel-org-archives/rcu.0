Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099843E6385
	for <rcu@vger.kernel.org>; Wed, 20 May 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290185; cv=none; b=Xn8sYlbvhh37ugolNQCVuXQqY3TW6Tw8IIaCAitUsQN4WAJb5AJ9xXMBouG2Es4tuPmvbzLA1nuNHuWKv3zPLf2ShgYZ1CXcvsAUHSBNoy6kIhq65O5zxXB3rlkBxvDyjz8fUrUI870qLJF4kgQZhWyGskoj2fC2BXPnPcMNzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290185; c=relaxed/simple;
	bh=6C3d9fF6ordTy1bLNo9WGKg1V2W1SV0rZt0P+L4+6OQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naFh6h2njqMfgUuXM1E1u48v2tGD7pzVWRnXO0B5v5ug0rCac3rrcqBxDiiBL4ESPzt4mTChfzFyQGhy0BVmJaXr0BMVXada6vaSrdV8BYkbnnHCIyoDxv4bAVT5MlaE8TVwGLVtAErcNZ4U1DdfSv/x8Zih1vH38xqniDd5nDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+gsTFrP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+gsTFrP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393d6025f99so56622901fa.0
        for <rcu@vger.kernel.org>; Wed, 20 May 2026 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290182; x=1779894982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7E0BkpX6m9EaJ1ukiylOpAvtj7VpIx/sv7T5fV1eufM=;
        b=J+gsTFrPMq8mrEh9WGKOBpdyF+pZDMgXyzzfjUq+UMIDZw5h3JaabYNUn9Ny6b6ccj
         dkrtXA6wPp/LTfpIowdn3FsojpGMoc3c3/zQP15aZ0Gch6JW0CeYIhHJJUAAoZcksWKG
         a1lDWJCbcqOXKsBX5FRgNY0mx7yreoUXn/HXK1TlebKukXhDsNT5lnep+wnIaNXZcKKW
         MQLEnxVYMUgX4Czo2VkBP5xUNH4HcUzVWvT3x+ZQSvtgQso0M1WMI4KxcvSwNzqOf+ev
         PtSBQ7qaBGXZh8DGmVXhAT/mgmR+3Pubt9qEShcZQMFbYAE57S37XrHfSj9yKiV6Feld
         MLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290182; x=1779894982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E0BkpX6m9EaJ1ukiylOpAvtj7VpIx/sv7T5fV1eufM=;
        b=FMth1ESNxbj8uhTm/TQm2iAGd7HZxX2hMXQ0xSiGY0g+awD1THxVPvtEhSL09JYzPV
         vPLobFP6giHpmo3HKcx8ywZgDmnuoojkg1Mu2KuGaY/RRNtoGxS9lpMxZJ03Nn120hcF
         +KXmQCzn6o6UHGCMWuJ+sBzRDCso9IRHXt5nHd2vuFfwu9f4MDA+CGHoejZjnMsTiMVH
         LSWh1EMVN8QnoYPuJW/6kZ3IObUhkn5RZCBzTVoEosIDdTqlNvFoMhDmcxAKJcDP3p8D
         TIhpTmblGpAFFBzlEQYvhNKJYk+7bBm6o/xpGJjJlwgppciW1EKTLkkKLyc2aSJuOtcN
         l4qg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZcPzvsIvJ2Dp4ibsIO5F4w5H1K2wRU54487N35Ri3us2SA0G4ZiivgtjoYO873LVQfnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mfbIW98gJeVyYEjFWb7I7dJBsTy18P9fXz2OTuUuLP5uB62J
	HiTTBUl7pbJGwBt6EnJC0nEMZJYQs0zh3pHF4LP5BK8eBdTQUjsIbO4sQGmbGiK2ebw=
X-Gm-Gg: Acq92OEpOKuEmqSXh1TFkHnUtuOu+YrW9aHdKJqh7TpiV8o3ojb7GIus9i5HYq2Kgdd
	CcLd2qCiI4/LxL4x2984zMUFgawZjW+OCKUb+zOgk/5jD0j9GuRHW4hvjSLfctxtk3qu4bvTvlc
	Zu4yeCQ7rodMsi8ugqOT4wdwS4xtkNQNttJ3o3VlZuetQshI2weBJg9pXbicFbUIuky0wdiqcjS
	w51r7uBobhuwcM91yG0xKTAVNgGQjiMIuhu1SysKYi368EWYbM4t5RHvF3EVNZaHqeT0moku/nL
	T+H6OiiFehzJiWPnl9LjxvujVJ8Y07E/3n2Y6GfsRdZZRwloFhzH+bhxyion3RH4Ym74O+oNjTH
	2C8tT0ns9fofBMLE5nN+KOmqxdenB8CIffhM1AM0DwNWaMe5f00OLbG2YhLvXRfaB
X-Received: by 2002:a05:651c:2111:b0:38e:35fe:b79 with SMTP id 38308e7fff4ca-3956089f942mr65620201fa.2.1779290181371;
        Wed, 20 May 2026 08:16:21 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882cf497sm31965011fa.16.2026.05.20.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:16:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 20 May 2026 17:16:19 +0200
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH -next v2 10/11] rcu: Latch normal synchronize_rcu() path
 on flood
Message-ID: <ag3QQ7zWGMDx4MbV@milan>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-11-urezki@gmail.com>
 <ag3IhirNF-wlDE1W@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3IhirNF-wlDE1W@localhost.localdomain>

On Wed, May 20, 2026 at 04:43:18PM +0200, Frederic Weisbecker wrote:
> Le Tue, May 19, 2026 at 09:45:23PM +0200, Uladzislau Rezki (Sony) a écrit :
> > Currently, rcu_normal_wake_from_gp is only enabled by default
> > on small systems(<= 16 CPUs) or when a user explicitly set it
> > enabled.
> > 
> > Introduce an adaptive latching mechanism:
> >  * Track the number of in-flight synchronize_rcu() requests
> >    using a new rcu_sr_normal_count counter;
> > 
> >  * If the count reaches/exceeds RCU_SR_NORMAL_LATCH_THR(64),
> >    it sets the rcu_sr_normal_latched, reverting new requests
> >    onto the scaled wait_rcu_gp() path;
> > 
> >  * The latch is cleared only when the pending requests are fully
> >    drained(nr == 0);
> > 
> >  * Enables rcu_normal_wake_from_gp by default for all systems,
> >    relying on this dynamic throttling instead of static CPU
> >    limits.
> > 
> > Testing(synthetic flood workload):
> >   * Kernel version: 6.19.0-rc6
> >   * Number of CPUs: 1536
> >   * 60K concurrent synchronize_rcu() calls
> > 
> > Perf(cycles, system-wide):
> >   total cycles: 932020263832
> >   rcu_sr_normal_add_req(): 2650282811 cycles(~0.28%)
> > 
> > Perf report excerpt:
> >   0.01%  0.01%  sync_test/...  [k] rcu_sr_normal_add_req
> > 
> > Measured overhead of rcu_sr_normal_add_req() remained ~0.28%
> > of total CPU cycles in this synthetic stress test.
> > 
> > Tested-by: Samir M <samir@linux.ibm.com>
> > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 ++--
> >  kernel/rcu/tree.c                             | 52 ++++++++++++++-----
> >  2 files changed, 44 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 4d0f545fb3ec..d5db2e85d551 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5862,13 +5862,13 @@ Kernel parameters
> >  			use a call_rcu[_hurry]() path. Please note, this is for a
> >  			normal grace period.
> >  
> > -			How to enable it:
> > +			How to disable it:
> >  
> > -			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > -			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> > +			echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=0"
> >  
> > -			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> > -			disabled by the boot parameter passing 0.
> > +			Default is 1 if it is not explicitly disabled by the boot parameter
> > +			passing 0.
> >  
> >  	rcuscale.gp_async= [KNL]
> >  			Measure performance of asynchronous
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 09f0cef5014c..94274330d1db 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1632,17 +1632,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >  	atomic_set_release(&sr_wn->inuse, 0);
> >  }
> >  
> > -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > -
> > -static int rcu_normal_wake_from_gp = -1;
> > +static int rcu_normal_wake_from_gp = 1;
> >  module_param(rcu_normal_wake_from_gp, int, 0644);
> >  static struct workqueue_struct *sync_wq;
> >  
> > +#define RCU_SR_NORMAL_LATCH_THR 64
> > +
> > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > +static atomic_long_t rcu_sr_normal_count;
> > +static int rcu_sr_normal_latched; /* 0/1 */
> > +
> >  static void rcu_sr_normal_complete(struct llist_node *node)
> >  {
> >  	struct rcu_synchronize *rs = container_of(
> >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > +	long nr;
> >  
> >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> >  		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > @@ -1650,6 +1654,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >  
> >  	/* Finally. */
> >  	complete(&rs->completion);
> > +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > +	WARN_ON_ONCE(nr < 0);
> > +
> > +	/*
> > +	 * Unlatch: switch back to normal path when fully
> > +	 * drained and if it has been latched.
> > +	 */
> > +	if (nr == 0)
> > +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> 
> Given that it's already ordered by the llist add / del and the
> atomic_long_inc/dec_return, there should be no chance for bad
> things happening such as negative returned dec.
> 
> So it could be cmpxchg_relaxed(). But anyway, just an optimization.
> 
> In any case,
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
Hello, Frederic!

I change it accordingly, please check!

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 94274330d1db..2c76b59f75de 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1655,14 +1655,13 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 	/* Finally. */
 	complete(&rs->completion);
 	nr = atomic_long_dec_return(&rcu_sr_normal_count);
-	WARN_ON_ONCE(nr < 0);
 
 	/*
 	 * Unlatch: switch back to normal path when fully
 	 * drained and if it has been latched.
 	 */
 	if (nr == 0)
-		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
+		(void)cmpxchg_relaxed(&rcu_sr_normal_latched, 1, 0);
 }
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
@@ -1823,7 +1822,7 @@ static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 	 * because it only selects between the fast and fallback paths.
 	 */
 	if (nr == RCU_SR_NORMAL_LATCH_THR)
-		(void)cmpxchg(&rcu_sr_normal_latched, 0, 1);
+		(void)cmpxchg_relaxed(&rcu_sr_normal_latched, 0, 1);
 
 	/* Publish for the GP kthread/worker. */
 	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);

Sounds good?

--
Uladzislau Rezki
