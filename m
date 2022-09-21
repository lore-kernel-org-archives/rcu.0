Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B04ECAAD8
	for <rcu@archiver.kernel.org>; Wed, 21 Sep 2022 23:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIUXwt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIUXws (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Sep 2022 19:52:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65A9C2C6
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 16:52:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g23so5278597qtu.2
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FECpFjJKptYi5/betqKscw8Hm9Di8iX5KVsNY1fQlRU=;
        b=kFqIxb3c7aTOYtvRywPvr9C0DSxKXgUgqp0kyxd19QkCGttl5By0bLXCvIZgFE55pl
         3PvK57KsFb4puWctDuYXpLaBq0qYJjuftNOL7Nw5kb0U1/xv2ftOS+r9LToZNnfFR/SS
         BxWW7hkSw3f7hehfX+r7ESdZgWZw/L/b97cgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FECpFjJKptYi5/betqKscw8Hm9Di8iX5KVsNY1fQlRU=;
        b=lPqDC+8qN+atcubX9uEXYh5OlcuPiVvwmHlKrEk2V52UbcOh+TO0qaoW2Icgk9qL2D
         +0XYiAHIP6dLriMNV0YPiJrf9vYQlQgt5Pz9vAUGTx0dxu4agPnPUOHAt+sUkWf0W/wp
         CnxGaXTAh8+nqg9+uFp3Af9sfY10iNXovCGCe667pnm+4XCxYWcBNLToRNr5Ee108x+9
         iS/a/gb1jMnGMWS2LNlnlpLBxZrlC65WWBGPrWZ/LO+AngM1huDQhxFarxW0n8Kk+AGf
         cK+U1PgZ1vTaSDE3Iwmwiv90ldaC5SxcmTJzXON4C/WH4vPeYhvUfWwf44oViTOdOmVl
         c0nw==
X-Gm-Message-State: ACrzQf0+3+mGnc9IeyMtt2948wY9wAvxtZGeuoQb9wpcacl5CvlUjBtV
        e9ah4vGVAJ8jH6P1etsdaapyCA==
X-Google-Smtp-Source: AMsMyM7ptLfmiaAWJuvmyCcT2G+Lv43MG0ZAuZIBYJ10L0kPb08iAHb2HGZmAJkSzKA2lpAbe7GA+g==
X-Received: by 2002:a05:622a:241:b0:35d:75:88a0 with SMTP id c1-20020a05622a024100b0035d007588a0mr765726qtx.370.1663804366400;
        Wed, 21 Sep 2022 16:52:46 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006b872b606b1sm2930436qkp.128.2022.09.21.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:52:45 -0700 (PDT)
Date:   Wed, 21 Sep 2022 23:52:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <YyujzQ/sU/aAdx4r@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907094014.GA193994@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 07, 2022 at 11:40:14AM +0200, Frederic Weisbecker wrote:
> On Wed, Sep 07, 2022 at 12:06:26AM +0000, Joel Fernandes wrote:
> > > > @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > >   * Note that this function always returns true if rhp is NULL.
> > > >   */
> > > >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > > -				  unsigned long j)
> > > > +				  unsigned long j, unsigned long flush_flags)
> > > >  {
> > > > +	bool ret;
> > > > +
> > > >  	if (!rcu_rdp_is_offloaded(rdp))
> > > >  		return true;
> > > >  	rcu_lockdep_assert_cblist_protected(rdp);
> > > >  	rcu_nocb_bypass_lock(rdp);
> > > > -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> > > > +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > > > +
> > > > +	if (flush_flags & FLUSH_BP_WAKE)
> > > > +		wake_nocb_gp(rdp, true);
> > > 
> > > Why the true above?
> > > 
> > > Also should we check if the wake up is really necessary (otherwise it means we
> > > force a wake up for all rdp's from rcu_barrier())?
> > > 
> > >        was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
> > >        ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > >        if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
> > >        	  wake_nocb_gp(rdp, false);
> > 
> > You mean something like the following right? Though I'm thinking if its
> > better to call wake_nocb_gp() from tree.c in entrain() and let that handle
> > the wake. That way, we can get rid of the extra FLUSH_BP flags as well and
> > let the flush callers deal with the wakeups..
> 
> Ah yes that could make sense if only one caller cares.
> 
> > 
> > Anyway, for testing this should be good...
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index bd8f39ee2cd0..e3344c262672 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  				  unsigned long j, unsigned long flush_flags)
> >  {
> >  	bool ret;
> > +	bool was_alldone;
> >  
> >  	if (!rcu_rdp_is_offloaded(rdp))
> >  		return true;
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> >  	rcu_nocb_bypass_lock(rdp);
> > +	if (flush_flags & FLUSH_BP_WAKE)
> > +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > +
> 
> You can check that outside bypass lock (but you still need nocb_lock).
> 
> >  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> >  
> > -	if (flush_flags & FLUSH_BP_WAKE)
> > -		wake_nocb_gp(rdp, true);
> > +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
> > +		wake_nocb_gp(rdp, false);
> 
> That doesn't check if the bypass list was empty.

I am ending up with something like the below for v6, after discussing with
Paul on IRC he pointed out we only need to do the rcu_barrier() related
wakeup when all the CBs are lazy in the bypass list. Otherwise timer goes
off. I think Frederic mentioned something similar above in different words.

I prefer to keep this logic in tree_nocb.h since rcu_barrier_entrain()
shouldn't have to deal with nocb internals (in theory anyway).

Looks Ok?

thanks,

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH for v6] fixup! rcu: Introduce call_rcu_lazy() API implementation

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c197534d0c99..fd056358f041 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -375,18 +375,26 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, unsigned long flush_flags)
 {
 	bool ret;
-	bool was_alldone;
+	bool was_alldone = false;
+	bool bypass_all_lazy = false;
 
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	if (flush_flags & FLUSH_BP_WAKE)
+
+	if (flush_flags & FLUSH_BP_WAKE) {
 		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		bypass_all_lazy =
+		  (rcu_cblist_n_cbs(&rdp->nocb_bypass) == rdp->lazy_len);
+	}
 
 	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
 
-	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
+	// Wake up the nocb GP thread if needed. GP thread could be sleeping
+	// while waiting for lazy timer to expire (otherwise rcu_barrier may
+	// end up waiting for the duration of the lazy timer).
+	if (flush_flags & FLUSH_BP_WAKE && was_alldone && bypass_all_lazy)
 		wake_nocb_gp(rdp, false);
 
 	return ret;
-- 
2.37.3.998.g577e59143f-goog

