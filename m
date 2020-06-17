Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453AC433DF
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 06:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C988208C3
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 06:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W80AIGvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQGj5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgFQGj4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 02:39:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B81C061573
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 23:39:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c12so1000269qkk.13
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRCJOr1skFnyM9iCZLxnxnicWQXrDbYWyABMrRwyPno=;
        b=W80AIGvLXmJtlUR0Jcd/qK77M8y5Ps2V0j8YNDkXgc0+hPm34Tjq+cPVFxM9GPJPxl
         aWd9PG48nQuSxHXLeQaA3k8YP0kMF1qV64sipWBiZiqmiaM1u83wM+k8dT6THU4t+ksF
         xVpepjgnTeNKDJNfvt6ucOoFk+MjXOLluNw7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRCJOr1skFnyM9iCZLxnxnicWQXrDbYWyABMrRwyPno=;
        b=cjziHf9qs1qRVU2h9YoMkKokw5Y6Ej3ZczmCPxmXVQU0jGTWQOQ6mcbbpkjBTr1CrL
         ublzqMoVkM1g9+l+G9UtPI+KaxQETQO3oEdZFkRLk0OjsNM+j79uZgLrGfDWKsEQFCaN
         2RAElAzlgK1oK9Kt6AB5g8vDIN4rjpwmMqEf75iyZtlqGetqVVLy8Jei52tLOKsiScgL
         vPGnNgaNU17fwef+qjnMkBGQb8bq1tK4PlTxpY2ar7SFw/S0MGX+bkpbTSZthll3jt6c
         Fi6ldTOEmVbU72NpQraQytzNf9Qx3H8e1AfeapRkPBHrb6U3PCgWs9AASGcbfdiLWWp4
         3shA==
X-Gm-Message-State: AOAM533R468XcnufV+0KVtmTLA5aEFNmIrebyWkahzoXiyt359qsdPgC
        mkHskHIPo/lAKGJsFLM0v/8JLA==
X-Google-Smtp-Source: ABdhPJyIemG/6HnkYt6+dokBCm5Xe4g7fVnVVAfhS6EkaHGkzyQOfQWHj5T2Jd9DCiYtnlmuth1kxg==
X-Received: by 2002:a05:620a:b84:: with SMTP id k4mr722597qkh.39.1592375995797;
        Tue, 16 Jun 2020 23:39:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v14sm18528500qtj.31.2020.06.16.23.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:39:54 -0700 (PDT)
Date:   Wed, 17 Jun 2020 02:39:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: CPU trying to start a GP when no CBs were assigned new GP numbers
Message-ID: <20200617063954.GA73282@google.com>
References: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
 <20200617040614.GI2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617040614.GI2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 16, 2020 at 09:06:14PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 16, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> > Hi,
> > I am seeing something a bit strange with RCU where it is trying to
> > start a GP twice from a CPU even though no new CB was queued on that
> > CPU. It is quite possible that I'm missing something. Anyway, I wrote
> > a patch to add some tracing when CBs are queued into the segcb. I am
> > planning to post this trace patch later.
> > 
> > The trace in the link below shows CPU2 queuing around 5 CBs, which
> > then gets accelerated at 5.192123. The GP thread running on CPU3
> > starts a new GP. Now the CPU2 softirq runs again (roughly 1ms after
> > the previous acceleration). The softirq runs probably because the GP
> > thread is expecting a QS report from CPU 2.  When the CPU2's softirq
> > runs though, it does an acceleration again which triggers a second new
> > GP start. This seems a bit unnecessary AFAICS - because the need for
> > GP *832 was already recorded which is all CPU2 should really be caring
> > about right?
> > 
> > Here is the trace: https://pastebin.com/raw/AYGzu1g4
> 
> Assuming that the WAIT= and NEXT_READY= numbers are grace-period numbers,

In the trace there are 2 numbers for WAIT and NEXT_READY each, number of
callbacks and gp numbers. Sorry, should have clarified that.

> this trace is expected behavior for two sets of callbacks, one that
> arrived at CPU 2 by time 5.192121 and another that arrived between then
> and time 5.193131.

There is just 1 set of callbacks.
> 
> So I have to ask...  What tells you that no callbacks arrived at CPU 2
> during this interval?

Because there is no rcu_callback tracepoint fired in the interim. The number
of callbacks that I'm tracing also confirm this.

> 
> On the other hand, if CPU 2 is offloaded, what you might be seeing is
> the delayed drain of callbacks from the bypass.

Sorry should have clarified it was not offloaded.

I dug more deeper and noticed that during acceleration, it is possible that
the gp_seq numbers of empty segments are updated. In this case,
rcu_segcblist_accelerate() still returns true resulting in starting of a new
future GP. The below patch cures it, but I'm not sure if it introduces other
issues. In light testing, it appears working. WDYT?

---8<-----------------------

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5f4fd3b8777ca..ebdba1d95f629 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -446,7 +478,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, oldest_seg;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -465,6 +497,9 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
 			break;
 
+	/* The oldest segment after which everything later is merged. */
+	oldest_seg = i;
+
 	/*
 	 * If all the segments contain callbacks that correspond to
 	 * earlier grace-period sequence numbers than "seq", leave.
@@ -488,10 +523,19 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * where there were no pending callbacks in the rcu_segcblist
 	 * structure other than in the RCU_NEXT_TAIL segment.
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
 		rsclp->gp_seq[i] = seq;
 	}
+
+	/*
+	 * If all segments after oldest_seg were empty, then new GP numbers
+	 * were assigned to empty segments. In this case, no need to start
+	 * those future GPs.
+	 */
+	if (rcu_segcblist_restempty(rsclp, oldest_seg))
+		return false;
+
 	return true;
 }
 

