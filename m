Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB1C6FD1C
	for <rcu@archiver.kernel.org>; Fri, 24 Mar 2023 00:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCXAz1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Mar 2023 20:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCXAz0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Mar 2023 20:55:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602E1E2AF
        for <rcu@vger.kernel.org>; Thu, 23 Mar 2023 17:55:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id m16so626171qvi.12
        for <rcu@vger.kernel.org>; Thu, 23 Mar 2023 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679619325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDY+2CW4sBIspOPEpoK+fZpOPf1g82OxeCMdEPnBe+A=;
        b=a7J5KpS1MQOIUu4gejufifAwol+bk6nl+956Wt243cG4K6NwaxbbQL/8+vqN2wNsXP
         f989xOD1Xa9GRvnHuz28XmZIcJ7523nNpDSDQlGqA2c2oYn75Wk5CVmO1WWr6urFEM9S
         5iLvG+SItqTiH6ergP3fm8nm8ZlJG2nAONWZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679619325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDY+2CW4sBIspOPEpoK+fZpOPf1g82OxeCMdEPnBe+A=;
        b=roH1LJ0LfXP8AeEqbMXczN0iJsgSQgLWfAwYhvOmi26SsyIC5sBZnqg+lZigDz/Hwr
         mTNTnmem5ANGff3dL7uR4o4heAStu1zX8KkslSBJF5fVuBualsf8hR4y+6fm55XLkgon
         3bgn2QDRdlg5DL1RDeKbCOHMQNLe5N20D+OoyEnfloD7JNDjjFP6+7q9pLLqN7CRCfNr
         16IKZLo/UwlDGmMI+8qHcfXVvNpUq8QNVTSxD0gWWW5xiGaZYXNSnKmE/jiSKrTSBRmj
         i/MxYDWTATKT5aPSiNSArlF6qGt5j/J+sgw0fpwWL95RswhpGv/j8HdccW+vxSVACvLT
         6wjg==
X-Gm-Message-State: AAQBX9eAJWC3BAEM7nTqxyUduWbhRiuRKoKAyzE6W4pJLiNd++zbQit0
        z+Y9mgS1+ck69prZXd0ALKA0IA==
X-Google-Smtp-Source: AKy350boFSb8FiUVQAIlI5wFoPToHJakI2u/qXHDifYjzgY175DAwwQpSrZGqByUdZGjRg4yINHb+w==
X-Received: by 2002:a05:6214:2607:b0:56a:b623:9b09 with SMTP id gu7-20020a056214260700b0056ab6239b09mr1917518qvb.14.1679619324636;
        Thu, 23 Mar 2023 17:55:24 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b005dd8b9345f8sm280757qvx.144.2023.03.23.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 17:55:24 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:55:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <20230324005523.GB723582@google.com>
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 22, 2023 at 04:18:24PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 22, 2023 at 08:44:53PM +0100, Frederic Weisbecker wrote:
> > The shrinker may run concurrently with callbacks (de-)offloading. As
> > such, calling rcu_nocb_lock() is very dangerous because it does a
> > conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
> > lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
> > an imbalance.
> > 
> > Fix this with protecting against (de-)offloading using the barrier mutex.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Good catch!!!  A few questions, comments, and speculations below.

Added a few more. ;)

> > ---
> >  kernel/rcu/tree_nocb.h | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index f2280616f9d5..dd9b655ae533 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1336,13 +1336,25 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  	unsigned long flags;
> >  	unsigned long count = 0;
> >  
> > +	/*
> > +	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
> > +	 * may be ignored or imbalanced.
> > +	 */
> > +	mutex_lock(&rcu_state.barrier_mutex);
> 
> I was worried about this possibly leading to out-of-memory deadlock,
> but if I recall correctly, the (de-)offloading process never allocates
> memory, so this should be OK?

Maybe trylock is better then? If we can't make progress, may be better to let
kswapd free memory by other means than blocking on the mutex.

ISTR, from my Android days that there are weird lockdep issues that happen
when locking in a shrinker (due to the 'fake lock' dependency added during
reclaim).

> The other concern was that the (de-)offloading operation might take a
> long time, but the usual cause for that is huge numbers of callbacks,
> in which case letting them free their memory is not necessarily a bad
> strategy.
> 
> > +
> >  	/* Snapshot count of all CPUs */
> >  	for_each_possible_cpu(cpu) {
> >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > -		int _count = READ_ONCE(rdp->lazy_len);
> > +		int _count;
> > +
> > +		if (!rcu_rdp_is_offloaded(rdp))
> > +			continue;
> 
> If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?

Did you mean de-offloaded? If it is offloaded, that means nocb is active so
there could be lazy CBs queued. Or did I miss something?

thanks,

 - Joel


> Or can it contain garbage after a de-offloading operation?
> 
> > +		_count = READ_ONCE(rdp->lazy_len);
> >  
> >  		if (_count == 0)
> >  			continue;
> > +
> >  		rcu_nocb_lock_irqsave(rdp, flags);
> >  		WRITE_ONCE(rdp->lazy_len, 0);
> >  		rcu_nocb_unlock_irqrestore(rdp, flags);
> > @@ -1352,6 +1364,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  		if (sc->nr_to_scan <= 0)
> >  			break;
> >  	}
> > +
> > +	mutex_unlock(&rcu_state.barrier_mutex);
> > +
> >  	return count ? count : SHRINK_STOP;
> >  }
> >  
> > -- 
> > 2.34.1
> > 
