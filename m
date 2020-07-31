Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98239C433DF
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739442076B
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 01:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qLa9jk/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgGaBVz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaBVy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 21:21:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0CC061574
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 18:21:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so27521796qkk.0
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/j2YojXjp6X9HLdlD/RvksyoFdPKZnneEIBr33XwXdQ=;
        b=qLa9jk/LSBAvtEZZ5ZFL3KjRk4IqwMmj8j5WFyD9NQvzOVnN80qOAqYJrwRSGdXYGJ
         iD9OvBJPDPm/N9jCEBA5TISOSVkyaq0uuAmbv+sCkyz3RqTcCPDaBKcv3CbB7+TfHLEx
         eksCtwPX2Z/g48Mkun69SquxbyaQ1dRyLIBFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/j2YojXjp6X9HLdlD/RvksyoFdPKZnneEIBr33XwXdQ=;
        b=hWkTMuLCMgMuiTEk8BCjpVs6IrDhAyg2Rz7UmuHCJjcUKWsZG3cwXSPR2J6VmUFcRu
         4UbXb7xyh12xRswNWx++8dNhrjWCik13K68M1vmgFDhLB34Gs3JXB3afb1z0+AgZa3yP
         ZX1AkK9kWBQI9vnvECtJJDwvCKOL84tNHI2jYrcEAWcf7wTnoq+1hknWiXegb0pwkeIh
         ndpeu5+vhNHeBwVMO83uIQKFcHj9nGAGWbu5FE8jRRDpWCjVEmuHQyVkk5HQ2ZlypfbR
         XQdTaDEe6W85qIZ1PyMLX355cNGky+F4lsA6jOTOcLpSRHZE/narlUEpITEcgqJ8jXKv
         w32A==
X-Gm-Message-State: AOAM532Y7A/s5DF7R7msGHKlj/y3cHc9F6WOhmmmEyHcIem+KcZNadE7
        OGoqZJs9Umoe88PFMA7LI6EsoA==
X-Google-Smtp-Source: ABdhPJzXAOl5o5JKy9CXp5X9KRwQBuWNKdlmJVlK56I52I4hu9SLT/emhyFHw3enEGMNBnCOj5xA7A==
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr1813493qki.158.1596158513533;
        Thu, 30 Jul 2020 18:21:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x29sm6277053qtv.80.2020.07.30.18.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:21:52 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:21:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting
 quiescent states
Message-ID: <20200731012152.GC2336096@google.com>
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730030221.705255-2-joel@joelfernandes.org>
 <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
 <20200730163520.GA9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730163520.GA9247@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:20AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 29, 2020 at 11:25:19PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 29, 2020 at 11:02 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > At least since v4.19, the FQS loop no longer reports quiescent states
> > 
> > I meant here, "FQS loop no longer reports quiescent states for offline CPUs."
> > 
> > Sorry,
> 
> You did have me going there for a bit.  ;-)
> 
> No period (".") at the end though, unless you fix up the following
> to start a new sentence.

Ok.

> > > unless it is a dire situation where an offlined CPU failed to report
> > > a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
> > > to keep the comment current.
> 
> How about the following for this last sentence?
> 
> "This commit therefore fixes the comment in rcu_gp_init() to match
> the current code."

As per:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

It says:
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.

May be I should make it "Fix the comment in rcu_gp_init() to match the
current code"?

> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 1e51962b565b..929568ff5989 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
> > >
> > >         /*
> > >          * Apply per-leaf buffered online and offline operations to the
> > > -        * rcu_node tree.  Note that this new grace period need not wait
> > > -        * for subsequent online CPUs, and that quiescent-state forcing
> > > +        * rcu_node tree.  Note that this new grace period need not wait for
> > > +        * subsequent online CPUs, and that RCU hooks in CPU offlining path
> > >          * will handle subsequent offline CPUs.
> 
> How about something like this?
> 
> 	...  Note that this new grace period ned not wait for subsequent
> 	online CPUs, and that RCU hooks in the CPU offlining path, when
> 	combined with checks in this function, will handle CPUs that
> 	are currently going offline and that go offline later.

Sounds good to me. I think s/and that go/or that go/ though.

I will make these changes and send v3, let me know though if you object.

thanks,

 - Joel


> 						Thanx, Paul
> 
> > >          */
> > >         rcu_state.gp_state = RCU_GP_ONOFF;
> > > --
> > > 2.28.0.rc0.142.g3c755180ce-goog
> > >
