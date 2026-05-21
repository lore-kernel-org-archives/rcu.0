Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56265175A84
	for <rcu@vger.kernel.org>; Thu, 21 May 2026 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341043; cv=none; b=YS4S25Bh+BpZGreN1eKkTyb699QMP5waKHs+/Tk4pJKiXQpz+OjBB8iwu7/O4MUG1VRV7EG4irpKqH0Vm0dTRfCCdNQdmywGHYuAQ9KZDaxGjLK/ru5XseKu4E8TNCyQNJuu4aEkEkqKUSxQLkaUNO8L8Z2OSePvs5wFoU1cmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341043; c=relaxed/simple;
	bh=0AkV6Y6abfc3GxmYLLEzKbtsc9nr5OEHVvpYz0kBcBA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEZl9vzdpEsK8NoKFrF0c2LxWQZmz7tWSVi25at3DgRoZk3t6tYRJdu+YfrFZqvYAplYeA1YrgDzxLQKNPvUH33IIdrmORzot3+Y+btVCRYrKg+8aGNMpJrfncBkN+DFpqIK5eCtsa5wnYkgK2l7tjhEhvlyI9o2chdDLfjFBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7wc0tjP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7wc0tjP"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a87782588cso7259514e87.3
        for <rcu@vger.kernel.org>; Wed, 20 May 2026 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779341039; x=1779945839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XMkhoRXSSlnr5PN05I0uSHTY7DdiAQlMQwuf0EqQew=;
        b=F7wc0tjPjlF4wh+eiDDsbMQSJRsMhdQbn270dTQFgR9Gew3tQyDyo90KmfGFTSy+79
         COciSqOhKemFnoLs+TFKZ8PI3q9pRa8EpNBI9IrETZFRVEFAnk0xBlMWrIXIpqREG+9S
         LL9d8MfkyPOYkh81Qn+gVvAKtuxey20DZLl1YKq/98i7cLPle3hsxM9A18Q7v0aAzbBz
         769RIXcnx/odx9L/vZSUTOLvqC1tKAS4GcJw174FbNaieWnuWBplP3Lgfk3XjUOHCDnQ
         +kCU0PKlu9kD3OSGwkCrzJ5UsdWQTaqDD13S10zXXfDj/Oeh0zy0vi1j9YBtfm70kwgi
         1sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779341039; x=1779945839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XMkhoRXSSlnr5PN05I0uSHTY7DdiAQlMQwuf0EqQew=;
        b=pcfhwsA9aVuOMI/6591ZAgZCLrSkB8RJZwmZC4JMzHCb2uxKYXtkvXYvwICN98pHdo
         f62Ih4DJfErxtowbfdzSAqzKjfz5lb6F9+oV5ixdxThrnmXrY4grtevDW6Vgi4LNhOn2
         ok0ihW5cyhPOWxK+qdwA6wAVIRedUqoF/Ck6imY89MtR5YIOxBrOn4Q+4KN9NTDL1Hqt
         o+F27Dp6ezLR6TtYGVGmIz/sEciSwTk4t8qRgAt8OV36N0a1ES+L5kQznQJJOBZL+ECM
         +1NM98ZYvuPFrhKRhJp82ZEe9/XD7QjRZ1AxLyYrNhNrQUzzy1VDaMrMKfApF3Isg4tK
         7Ylw==
X-Forwarded-Encrypted: i=1; AFNElJ9QBzDL0KzUm5xzZMm9rBSSN679HcA41nFWcBvAbj6jmp59DR0dfDzYMi1+CJkt/4SUsCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6//H0v6Kruxdt8pz89yZ8uIscaqI0Tu1Kcg8c3nEJ3h1C+MPl
	UGWovsk+WaZeb6zYVtilpJl6eDd59FxCZd3ZoF3au3ya1wFGiVdCMRyo
X-Gm-Gg: Acq92OFSMCKItOWDKUEZFlzhhhUtqn+MHe0aWy6/slFHe6Y/oQM8GhBz+utD1lgfZL/
	Gin/0WML8/7irUp/XbPsUOVl/dXYqTDo3PFwNiaDBPCXoQ6KrsDdfhtCfiEIXOeihuidUQqOP5x
	DULpny9NjemQllS3ssyGe17cdOaE810vNWYLCQEu5QhBG1Tt+ig73dV9ZsDIQv3vdg0+2UfNZ+v
	AyITsuPQRsixKGEYTndmq6FKUhsGzKc+zYduOcN6LVZ4gd99jzMDDJcaGrxxNkV8ikiybyxy3c+
	lEA93jvJw/su1A7wnV4v5oCC5+UhdE7Oz+6mNpzhy49IA7mzhw3TyQba6ATcu9YOddCX5MmMwmV
	mn1eH1lgjHvmwctZ+WTCEsLTUYUTN3H5eY0zzZ/tldskWcxFvDHqONfpOySKPX0xAboWt7Gk9XJ
	2SjXVlGqVyBxOxCI9Z/jo=
X-Received: by 2002:a2e:bc83:0:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-395ca5ad8fbmr4560141fa.21.1779341039283;
        Wed, 20 May 2026 22:23:59 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500:de96:9acf:5dca:ede4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c3928sm35310351fa.11.2026.05.20.22.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:23:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 May 2026 07:23:57 +0200
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH -next v2 10/11] rcu: Latch normal synchronize_rcu() path
 on flood
Message-ID: <ag6W7RS3YyFClO3t@pc636>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-11-urezki@gmail.com>
 <ag3IhirNF-wlDE1W@localhost.localdomain>
 <ag3QQ7zWGMDx4MbV@milan>
 <ag41jLKrDsKGCS_H@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag41jLKrDsKGCS_H@localhost.localdomain>

On Thu, May 21, 2026 at 12:28:28AM +0200, Frederic Weisbecker wrote:
> Le Wed, May 20, 2026 at 05:16:19PM +0200, Uladzislau Rezki a écrit :
> > On Wed, May 20, 2026 at 04:43:18PM +0200, Frederic Weisbecker wrote:
> > > Le Tue, May 19, 2026 at 09:45:23PM +0200, Uladzislau Rezki (Sony) a écrit :
> > > > Currently, rcu_normal_wake_from_gp is only enabled by default
> > > > on small systems(<= 16 CPUs) or when a user explicitly set it
> > > > enabled.
> > > > 
> > > > Introduce an adaptive latching mechanism:
> > > >  * Track the number of in-flight synchronize_rcu() requests
> > > >    using a new rcu_sr_normal_count counter;
> > > > 
> > > >  * If the count reaches/exceeds RCU_SR_NORMAL_LATCH_THR(64),
> > > >    it sets the rcu_sr_normal_latched, reverting new requests
> > > >    onto the scaled wait_rcu_gp() path;
> > > > 
> > > >  * The latch is cleared only when the pending requests are fully
> > > >    drained(nr == 0);
> > > > 
> > > >  * Enables rcu_normal_wake_from_gp by default for all systems,
> > > >    relying on this dynamic throttling instead of static CPU
> > > >    limits.
> > > > 
> > > > Testing(synthetic flood workload):
> > > >   * Kernel version: 6.19.0-rc6
> > > >   * Number of CPUs: 1536
> > > >   * 60K concurrent synchronize_rcu() calls
> > > > 
> > > > Perf(cycles, system-wide):
> > > >   total cycles: 932020263832
> > > >   rcu_sr_normal_add_req(): 2650282811 cycles(~0.28%)
> > > > 
> > > > Perf report excerpt:
> > > >   0.01%  0.01%  sync_test/...  [k] rcu_sr_normal_add_req
> > > > 
> > > > Measured overhead of rcu_sr_normal_add_req() remained ~0.28%
> > > > of total CPU cycles in this synthetic stress test.
> > > > 
> > > > Tested-by: Samir M <samir@linux.ibm.com>
> > > > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         | 10 ++--
> > > >  kernel/rcu/tree.c                             | 52 ++++++++++++++-----
> > > >  2 files changed, 44 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index 4d0f545fb3ec..d5db2e85d551 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5862,13 +5862,13 @@ Kernel parameters
> > > >  			use a call_rcu[_hurry]() path. Please note, this is for a
> > > >  			normal grace period.
> > > >  
> > > > -			How to enable it:
> > > > +			How to disable it:
> > > >  
> > > > -			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > > > -			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> > > > +			echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > > > +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=0"
> > > >  
> > > > -			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> > > > -			disabled by the boot parameter passing 0.
> > > > +			Default is 1 if it is not explicitly disabled by the boot parameter
> > > > +			passing 0.
> > > >  
> > > >  	rcuscale.gp_async= [KNL]
> > > >  			Measure performance of asynchronous
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 09f0cef5014c..94274330d1db 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1632,17 +1632,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> > > >  	atomic_set_release(&sr_wn->inuse, 0);
> > > >  }
> > > >  
> > > > -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > > > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > > > -
> > > > -static int rcu_normal_wake_from_gp = -1;
> > > > +static int rcu_normal_wake_from_gp = 1;
> > > >  module_param(rcu_normal_wake_from_gp, int, 0644);
> > > >  static struct workqueue_struct *sync_wq;
> > > >  
> > > > +#define RCU_SR_NORMAL_LATCH_THR 64
> > > > +
> > > > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > > > +static atomic_long_t rcu_sr_normal_count;
> > > > +static int rcu_sr_normal_latched; /* 0/1 */
> > > > +
> > > >  static void rcu_sr_normal_complete(struct llist_node *node)
> > > >  {
> > > >  	struct rcu_synchronize *rs = container_of(
> > > >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > > > +	long nr;
> > > >  
> > > >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > > >  		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > > > @@ -1650,6 +1654,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > > >  
> > > >  	/* Finally. */
> > > >  	complete(&rs->completion);
> > > > +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > > > +	WARN_ON_ONCE(nr < 0);
> > > > +
> > > > +	/*
> > > > +	 * Unlatch: switch back to normal path when fully
> > > > +	 * drained and if it has been latched.
> > > > +	 */
> > > > +	if (nr == 0)
> > > > +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > 
> > > Given that it's already ordered by the llist add / del and the
> > > atomic_long_inc/dec_return, there should be no chance for bad
> > > things happening such as negative returned dec.
> > > 
> > > So it could be cmpxchg_relaxed(). But anyway, just an optimization.
> > > 
> > > In any case,
> > > 
> > > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > Hello, Frederic!
> > 
> > I change it accordingly, please check!
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 94274330d1db..2c76b59f75de 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1655,14 +1655,13 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >  	/* Finally. */
> >  	complete(&rs->completion);
> >  	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > -	WARN_ON_ONCE(nr < 0);
> 
> Why dropping this?
> 
OK, i misread your note about negative, "such as negative returned dec."

--
Uladzislau Rezki
