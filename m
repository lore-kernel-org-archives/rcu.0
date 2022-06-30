Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E5C433EF
	for <rcu@archiver.kernel.org>; Thu, 30 Jun 2022 14:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiF3OZV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiF3OZD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jun 2022 10:25:03 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605B2C66E
        for <rcu@vger.kernel.org>; Thu, 30 Jun 2022 07:08:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i17so29753577qvo.13
        for <rcu@vger.kernel.org>; Thu, 30 Jun 2022 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Z0pUtjQC8KE7tpDzNEFE6y+ZheqehZtaD3kD+I+qEk=;
        b=VBOggfUaOYccYerTO8qKWWDuYKlmCxY2qozdSGHq3aLRWttCAd/nM2JIkKCl1Bbga9
         H5XeHrkpxew8kxMPoH/hrQuCCBeAyJrUoIr1Uh1qRTJhPl4oH6gScxHjusLuX1dOORcC
         5+CgSFhNxiob7XU136a3nUFg4HQJ4jsFQ0Whc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Z0pUtjQC8KE7tpDzNEFE6y+ZheqehZtaD3kD+I+qEk=;
        b=nCydCwDrd/+H4HHeRHteFeKIFmUjuTNuNHWSC7kI7tpTEmibqVEYTlufiMI5JhXr5R
         x5ZaFuDIuc0rXOSrCVpczeZDiEFOFOb0wHvlMcvOL4fVylXqnyJNPzOiDFzB4K9d8kmj
         dvHhpnQxLgtsoCK7KLXlfYFs/yNbzRvZJdlG4jF+7boq13iRk6lbL1h+rVgd/MUZV8du
         yuIcHfQg6jjGnXKisNezUQO+MU9oNYGIqHhsN8doj6QMdhYBpEm18f0xqo1/g1IlbLUH
         onbakPq2jyCnzJV7eBG8Y7r/YQ7OADYQLCGlnCGNLt2GgPhmKBLpT21/3xluYjMeFAWl
         0iTg==
X-Gm-Message-State: AJIora+ll3XOeWF7PS9osOx5kEwdxxPcx9LcEhFa02EScHpX4RfesNwF
        utr669iellEsNpqv9Ls5PjNmGg==
X-Google-Smtp-Source: AGRyM1vDWJrx51Khe7LAj2MDb+5P1xJLQrjp6jmOv5yYq9zLDYFn1vbLY58SoNi8nkQKKwBznkqc6w==
X-Received: by 2002:a05:622a:1816:b0:31d:31de:db34 with SMTP id t22-20020a05622a181600b0031d31dedb34mr1892452qtc.588.1656598105714;
        Thu, 30 Jun 2022 07:08:25 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bs36-20020a05620a472400b006a6ab8f761csm16321399qkb.62.2022.06.30.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:08:25 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:08:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <Yr2uWCGQpYo6As9c@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220629115349.GA2119930@lothringen>
 <Yry2PAc0KtkYW24A@google.com>
 <20220629220114.GA2127569@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629220114.GA2127569@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 30, 2022 at 12:01:14AM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 29, 2022 at 08:29:48PM +0000, Joel Fernandes wrote:
> > On Wed, Jun 29, 2022 at 01:53:49PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > > > @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > >  	}
> > > >  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
> > > >  
> > > > -	// If there hasn't yet been all that many ->cblist enqueues
> > > > -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> > > > -	// ->nocb_bypass first.
> > > > -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> > > > +	// If caller passed a non-lazy CB and there hasn't yet been all that
> > > > +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> > > > +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> > > > +	// number of CBs (lazy + non-lazy) grows too much.
> > > > +	//
> > > > +	// Note that if the bypass list has lazy CBs, and the main list is
> > > > +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> > > > +	// the lazy CBs to the main list as well. That's the right thing to do,
> > > > +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> > > > +	// one, we can just reuse that GP for the already queued-up lazy ones.
> > > > +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> > > > +	    (lazy && n_lazy_cbs >= qhimark)) {
> > > >  		rcu_nocb_lock(rdp);
> > > >  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > > >  		if (*was_alldone)
> > > >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > > > -					    TPS("FirstQ"));
> > > > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > > +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> > > > +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> > > 
> > > That's outside the scope of this patchset but this makes me realize we
> > > unconditionally try to flush the bypass from call_rcu() fastpath, and
> > > therefore we unconditionally lock the bypass lock from call_rcu() fastpath.
> > > 
> > > It shouldn't be contended at this stage since we are holding the nocb_lock
> > > already, and only the local CPU can hold the nocb_bypass_lock without holding
> > > the nocb_lock. But still...
> > > 
> > > It looks safe to locklessly early check if (rcu_cblist_n_cbs(&rdp->nocb_bypass))
> > > before doing anything. Only the local CPU can enqueue to the bypass list.
> > > 
> > > Adding that to my TODO list...
> > > 
> > 
> > I am afraid I did not understand your comment. The bypass list lock is held
> > once we have decided to use the bypass list to queue something on to it.
> > 
> > The bypass flushing is also conditional on either the bypass cblist growing
> > too big or a jiffie elapsing since the first bypass queue.
> > 
> > So in both cases, acquiring the lock is conditional. What do you mean it is
> > unconditionally acquiring the bypass lock? Where?
> 
> Just to make sure we are talking about the same thing, I'm referring to this
> path:
> 
> 	// If there hasn't yet been all that many ->cblist enqueues
> 	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> 	// ->nocb_bypass first.
> 	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> 		rcu_nocb_lock(rdp);
> 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> 		if (*was_alldone)
> 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> 					    TPS("FirstQ"));
> 		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> 		return false; // Caller must enqueue the callback.
> 	}
> 
> This is called whenever we decide not to queue to the bypass list because
> there is no flooding detected (rdp->nocb_nobypass_count hasn't reached
> nocb_nobypass_lim_per_jiffy for the current jiffy). I call this the fast path
> because this is what I would except in a normal load, as opposed to callbacks
> flooding.
> 
> And in this fastpath, the above rcu_nocb_flush_bypass() is unconditional.

Sorry you are right, I see that now.

Another reason for why the contention is probably not a big deal (other than
the nocb lock being held), is that all other callers of the flush appear to
be in slow paths except for this one. Unless someone is offloading/deoffloading
rapidly or something :)

thanks,

 - Joel

