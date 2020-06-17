Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ADDC433DF
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 14:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E522088E
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rpdS1Hjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQOof (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQOof (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 10:44:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48EC06174E
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2020 07:44:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w3so2220391qkb.6
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2020 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7F7SNRxzCnfnBbLrOLTusmuJURjz4ocX1NNhWIlS4s=;
        b=rpdS1HjnJmhcoiSpvN7MKF/Uw51D4PiEMitZ1qPcs0lo5ugQIqOQC9mjJyp2YTiw9z
         o+F32/fVue7NTyQnd67w8wXUMWwvNAkaUpBVUTiZLidV+qX7zG/NpfT5jhjCHPPdRnZO
         z3+BjHhLC0TZAp/G1tesA8fKFPrmAp2CFw83Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7F7SNRxzCnfnBbLrOLTusmuJURjz4ocX1NNhWIlS4s=;
        b=Gwd+S2pUyWfSnxyY+D4EU1hz7VaUt62pqE3Sx41Ecp82AUuWE0Gqqubv/QKjIFON8I
         sFnaJwHmGZ6dyb9zAIoRdOhIy6E0iY6b7Bu6cLb7zjL9iMMAsTzTHdXQVCgzB/CChHCk
         F+sO+BwUuaYKM1KPrM4qgXW3iC2SE756KcwTPvYzywlSAtqxkZh+HoohPNeleCMAiKug
         O+9LSDGlpT46JAJmxqSgWo4p1rP7FqlxJ5gFEOhNDrJ3eskEHQk7HWjMycUA5TloceA7
         b8yWAktY8hDO4DiGiv7nK6u4RzKlZ8ASAVtAPoU3dckJk6Mvec8YRG5GNvHQw0nrFKXi
         PlPA==
X-Gm-Message-State: AOAM5320Bb46D4soURQxuPC3DoODlaozinFORRT3rpae6z5Y3tImG1Rw
        tH3pJ0S637Q8w1pQ5jVvVAIWnwCmwK4=
X-Google-Smtp-Source: ABdhPJx+aHlrhbPktpiP/TIb5dR3xVubbXtaTjC/j7ML27mIFlJAji8m58PXsVjaBYXDUuYGIvCOAw==
X-Received: by 2002:a05:620a:52a:: with SMTP id h10mr25605336qkh.185.1592405073784;
        Wed, 17 Jun 2020 07:44:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q124sm99819qke.51.2020.06.17.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:44:33 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:44:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: CPU trying to start a GP when no CBs were assigned new GP numbers
Message-ID: <20200617144432.GB73282@google.com>
References: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
 <20200617040614.GI2723@paulmck-ThinkPad-P72>
 <20200617063954.GA73282@google.com>
 <20200617140100.GJ2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617140100.GJ2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 17, 2020 at 07:01:00AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 17, 2020 at 02:39:54AM -0400, Joel Fernandes wrote:
> > On Tue, Jun 16, 2020 at 09:06:14PM -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 16, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> > > > Hi,
> > > > I am seeing something a bit strange with RCU where it is trying to
> > > > start a GP twice from a CPU even though no new CB was queued on that
> > > > CPU. It is quite possible that I'm missing something. Anyway, I wrote
> > > > a patch to add some tracing when CBs are queued into the segcb. I am
> > > > planning to post this trace patch later.
> > > > 
> > > > The trace in the link below shows CPU2 queuing around 5 CBs, which
> > > > then gets accelerated at 5.192123. The GP thread running on CPU3
> > > > starts a new GP. Now the CPU2 softirq runs again (roughly 1ms after
> > > > the previous acceleration). The softirq runs probably because the GP
> > > > thread is expecting a QS report from CPU 2.  When the CPU2's softirq
> > > > runs though, it does an acceleration again which triggers a second new
> > > > GP start. This seems a bit unnecessary AFAICS - because the need for
> > > > GP *832 was already recorded which is all CPU2 should really be caring
> > > > about right?
> > > > 
> > > > Here is the trace: https://pastebin.com/raw/AYGzu1g4
> > > 
> > > Assuming that the WAIT= and NEXT_READY= numbers are grace-period numbers,
> > 
> > In the trace there are 2 numbers for WAIT and NEXT_READY each, number of
> > callbacks and gp numbers. Sorry, should have clarified that.
> 
> Ah, I see.  What are you doing to compute the number of callbacks?

Here is my segcb trace patch, I added a rcu_segcblist_countseq() function:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?id=794cba82fe8b5c72df46d4f2548957db36317d39

> > > On the other hand, if CPU 2 is offloaded, what you might be seeing is
> > > the delayed drain of callbacks from the bypass.
> > 
> > Sorry should have clarified it was not offloaded.
> > 
> > I dug more deeper and noticed that during acceleration, it is possible that
> > the gp_seq numbers of empty segments are updated. In this case,
> > rcu_segcblist_accelerate() still returns true resulting in starting of a new
> > future GP. The below patch cures it, but I'm not sure if it introduces other
> > issues. In light testing, it appears working. WDYT?
> 
> You are quite correct that empty segments should not be assigned
> grace-period numbers.  Or at least that any such grace-period numbers
> should not be taken very seriously.

Thanks. This is what the test diff I shared below does, basically return
false from _accelerate() if all the segments assigned gp_seq(s) are empty.

> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 5f4fd3b8777ca..ebdba1d95f629 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -446,7 +478,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >   */
> >  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  {
> > -	int i;
> > +	int i, oldest_seg;
> >  
> >  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> >  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> > @@ -465,6 +497,9 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
> >  			break;
> >  
> > +	/* The oldest segment after which everything later is merged. */
> > +	oldest_seg = i;
> > +
> >  	/*
> >  	 * If all the segments contain callbacks that correspond to
> >  	 * earlier grace-period sequence numbers than "seq", leave.
> > @@ -488,10 +523,19 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
> >  	 * where there were no pending callbacks in the rcu_segcblist
> >  	 * structure other than in the RCU_NEXT_TAIL segment.
> >  	 */
> >  	for (; i < RCU_NEXT_TAIL; i++) {
> >  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
> >  		rsclp->gp_seq[i] = seq;
> >  	}
> > +
> > +	/*
> > +	 * If all segments after oldest_seg were empty, then new GP numbers
> > +	 * were assigned to empty segments. In this case, no need to start
> > +	 * those future GPs.
> > +	 */
> > +	if (rcu_segcblist_restempty(rsclp, oldest_seg))
> > +		return false;
> > +
> >  	return true;
> >  }
> 
> Looks like this needs a focused test program.  ;-)
> 
> Please see attached for an outdated test userspace program.  It probably
> needs help to check for this additional case.  And probably also other
> changes to account for three years of change.
> 
> This test program works by copying files from the designated Linux
> source tree, then building them into a userspace torture test.

Thanks, I will give it a try.

I also added a warning in the trace patch I linked above, at the end of
_accelerate() to make sure NEXT segment was always merged:

+	/*
+	 * Make sure the NEXT list is always empty after an acceleration.
+	 */
+	WARN_ON_ONCE(!rcu_segcblist_restempty(rsclp, RCU_NEXT_READY_TAIL));


thanks,

 - Joel

