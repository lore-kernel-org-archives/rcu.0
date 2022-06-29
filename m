Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB8C43334
	for <rcu@archiver.kernel.org>; Wed, 29 Jun 2022 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiF2U3v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiF2U3v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jun 2022 16:29:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BBF22506
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 13:29:50 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u14so23973292qvv.2
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6IGv+IKgPKHnzxqZVkEhxDyqtc80x0hxt+COdkVzvjY=;
        b=HEdHyB8UCGW/VSkGbhcXX/1am3z8nAEQ5HcLi+z5p093UvVc6kR8V1HaChPvjSYNtb
         oGLq9qKnfk/8RUnbOVbKFTUVXZh3xOYFeTq9JXjE0dyFyDgCI4NCHTXc68g/nLG3DJjh
         DuCAHcrNCmyhmJeJoJ61ZaXsG7OWksfKmvsS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6IGv+IKgPKHnzxqZVkEhxDyqtc80x0hxt+COdkVzvjY=;
        b=EGHhcViV/XxbrjCvmts/z6t7Yuwa55EWzXt63Bt/OcyQrYFwGzJRvVjz6aQFi/U8Na
         c+qgANR25glibMkoD8kr3auZR7oOrPj2JsTDMwfSWUc5v6rmVn0BKMrSrLsoBufBRRbl
         lGq/mka6zhQ71pthZgA8eIsYit4JOOXG6Wjg8oLCmSRSwbkKOY0XvM9JXrb04HLvG/4v
         dfkOugT8jfSvq9b8yZ/f79Tq0XwtTEZ6jBGp7kPEtlvanIiAt2xdZRecjOQPpK+v9F3v
         t2mVXSQpm+vRIeRrOrRwzMX2cSqfKDMiB3xvMu3ziEY2IwEwWEHVqj39u3t6MfmdoBsJ
         Mhfw==
X-Gm-Message-State: AJIora9OvgcygHr9vhj+cF7pzjjCs+82t6PdnBtdRY5WSmRtrh0xWqMc
        xD0E65gnrrxDiC8KN9Am9tElgw==
X-Google-Smtp-Source: AGRyM1sKaoVksRNhOJ6kwqWjLs6cABIFpgcgyZkPIXc/LHINSBcROYQqLKg28b35N8k81ZNERMNNMA==
X-Received: by 2002:a05:622a:1391:b0:304:eb9f:aee6 with SMTP id o17-20020a05622a139100b00304eb9faee6mr4322836qtk.365.1656534589375;
        Wed, 29 Jun 2022 13:29:49 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u3-20020a37ab03000000b006b1a343c2absm714861qke.131.2022.06.29.13.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:29:49 -0700 (PDT)
Date:   Wed, 29 Jun 2022 20:29:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <Yry2PAc0KtkYW24A@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220629115349.GA2119930@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629115349.GA2119930@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 29, 2022 at 01:53:49PM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	}
> >  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
> >  
> > -	// If there hasn't yet been all that many ->cblist enqueues
> > -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> > -	// ->nocb_bypass first.
> > -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> > +	// If caller passed a non-lazy CB and there hasn't yet been all that
> > +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> > +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> > +	// number of CBs (lazy + non-lazy) grows too much.
> > +	//
> > +	// Note that if the bypass list has lazy CBs, and the main list is
> > +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> > +	// the lazy CBs to the main list as well. That's the right thing to do,
> > +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> > +	// one, we can just reuse that GP for the already queued-up lazy ones.
> > +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> > +	    (lazy && n_lazy_cbs >= qhimark)) {
> >  		rcu_nocb_lock(rdp);
> >  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >  		if (*was_alldone)
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > -					    TPS("FirstQ"));
> > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> > +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> 
> That's outside the scope of this patchset but this makes me realize we
> unconditionally try to flush the bypass from call_rcu() fastpath, and
> therefore we unconditionally lock the bypass lock from call_rcu() fastpath.
> 
> It shouldn't be contended at this stage since we are holding the nocb_lock
> already, and only the local CPU can hold the nocb_bypass_lock without holding
> the nocb_lock. But still...
> 
> It looks safe to locklessly early check if (rcu_cblist_n_cbs(&rdp->nocb_bypass))
> before doing anything. Only the local CPU can enqueue to the bypass list.
> 
> Adding that to my TODO list...
> 

I am afraid I did not understand your comment. The bypass list lock is held
once we have decided to use the bypass list to queue something on to it.

The bypass flushing is also conditional on either the bypass cblist growing
too big or a jiffie elapsing since the first bypass queue.

So in both cases, acquiring the lock is conditional. What do you mean it is
unconditionally acquiring the bypass lock? Where?

Thanks!

 - Joel

