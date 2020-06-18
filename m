Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70AC433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4605F20771
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HFQhLaYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgFRXyr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgFRXyq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 19:54:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50AC0613EE
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 16:54:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so7401919qka.4
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDvDd70QEgXgwyT4Q35elQVEcGFI1GdqJOBPMEPxGFs=;
        b=HFQhLaYwq0gsCyRls2cQYYsziEWpQgnhe980EFFGUMuG5cZBXEQAw5Gu1gYTrV+tkx
         xUjGCkGqKfPl3lJfzuv1qlcBUGpvCutbj2cwbpZ8Efay6x+3g6R7Ia8/8LVWw5+YZY4g
         /wbjMn6DXmjiefFJiO/zTQbOlLA0XZYuzsGu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDvDd70QEgXgwyT4Q35elQVEcGFI1GdqJOBPMEPxGFs=;
        b=YdZ1Aeih/TTzoMaFsKE3joTi48GUjm3P7WoyEuUY43W1/xjmu+m15/ethHPM6prVzo
         nqly8driyvse6pT96kAuZr9o10wY0svaTGajx1eCvoKbn72m5UzrieCCIuvjvc+Xlk6L
         rcKtFeLYZiMdf8BDBi4vKRaf6vU6sqg+MFO7R4mV6QlKCTHO67df61Ql5xkZ6ek+oq1u
         nUEUrn3zpD+t8v6aer8ieCgEJc41y5nbEUKpmlNqtTCxG7Z+nVl9DpGAF/ug0bnzXQnX
         1nWdtuIn9Mua+o+Lc14jwjGq4iA0xyGHbrQRxjNdSbMUD3CQT3MHEjCkiOvA5K1MiKix
         APng==
X-Gm-Message-State: AOAM5319IAiOR0WCWgOfOYXutiJ1iMwQX2pn7fxU7xHoqoij53LN84NU
        CKM+4f04ZCTDA2rGUG7xxAq9Ew==
X-Google-Smtp-Source: ABdhPJxnFkj3cOEHwReARlTrUr3tDwHBIA6+lZCUlWL5WSbOcXG8+YtXVwZCEG6S4uKVshNg/py84w==
X-Received: by 2002:a37:a985:: with SMTP id s127mr1032937qke.198.1592524485683;
        Thu, 18 Jun 2020 16:54:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n36sm828983qtc.35.2020.06.18.16.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:54:45 -0700 (PDT)
Date:   Thu, 18 Jun 2020 19:54:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 5/7] rcu/trace: Use rsp's gp_seq in acceleration's
 rcu_grace_period tracepoint
Message-ID: <20200618235444.GC40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-5-joel@joelfernandes.org>
 <20200618222721.GA2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618222721.GA2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 03:27:21PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 04:29:53PM -0400, Joel Fernandes (Google) wrote:
> > During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
> > the value used for acceleration - it is the value of gp_seq at which it
> > is safe the execute all callbacks in the callback list.
> > 
> > The rdp's gp_seq is not very useful for this scenario. Make
> > rcu_grace_period report the rsp's gp_seq instead as it allows one to
> > reason about how the acceleration works.
> 
> Good catch, but please instead trace the gp_seq_req local variable.

Oh sure, I will do that. Actually I was planning to, but was wondering if it
would be inconsistent with other trace_rcu_grace_period() invocations which
pass a real gp_seq (one that is as old as rcu_state.gp_seq). But agreed, this
is better since the acceleration uses it.

thanks,

 - Joel

> 							Thanx, Paul
> 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 81df1b837dd9d..c3bae7a83d792 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1437,9 +1437,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >  
> >  	/* Trace depending on how much we were able to accelerate. */
> >  	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
> > -		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccWaitCB"));
> > +		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccWaitCB"));
> >  	else
> > -		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccReadyCB"));
> > +		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccReadyCB"));
> >  
> >  	/* Count CBs for tracing. */
> >  	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > -- 
> > 2.27.0.111.gc72c7da667-goog
> > 
