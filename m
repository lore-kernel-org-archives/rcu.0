Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D9C43334
	for <rcu@archiver.kernel.org>; Fri, 15 Jul 2022 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGOPkg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiGOPkf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jul 2022 11:40:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D351A2B
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:40:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m10so32521qvu.4
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YfP2csDQgeZJCL5kHpOFcCsfJF5frM/Tn8GRbCEcjuI=;
        b=t8hGHyy8bhKC8gfRnjmO/rRR0YzZ4UlbADz3f6W0HHkjX8XijzDD3sWIpOC40nMroG
         2A3qAbk1tFWJpcOwXwnQIAR5jgwp87hu1GdhMd1etbQJJV3rAZykpOS2fMDRsijXiske
         OMBWUlKtIN03KOj6bloQ+Il9mvfZZWIgPmyHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YfP2csDQgeZJCL5kHpOFcCsfJF5frM/Tn8GRbCEcjuI=;
        b=RPSugwfpl0VkfdYdCh/zOtkVQL2KYY+lOBAQ7kDVwhz1Jtk7tl81BWsXHuhibK51gC
         jMdc0fbyLSN7OVTr9UYcrCXtWeoesa+RhUlUE2Dff4mY3B+FwciMzjaXxov9c1OGTJeg
         JnSXhyyWpZhis2mt3ESVaYmrzWGk0DFyqMb6p/MS9poQ25Rm2OkLqdhC/2nbY1seLgBg
         KGn7TMwGbUlyXTBYnLKgn8Jfj6Yx2QJf8wgwk9WsRW6tO7gI2iT2QgakXriTLDYY1uvI
         d67HC8Im6mpjggkdfjCP4V1i/LqgtHHne2PCjGFbCOvGRs53UL3nCJzQ2qTs64q01eSu
         4Q7w==
X-Gm-Message-State: AJIora9ShA/rxozC+JBTDilkRKkjmaDipcSfRALV7z8EdXRKJBrWBird
        c+auvdQJkTggfgImcD4q5XTl+g==
X-Google-Smtp-Source: AGRyM1uCAeGo/cbi2tNetRyGhVT+MCbTJGHw2jlIstByss8EFRquzfqx+zPcBstg2RxRfc4cm122ZA==
X-Received: by 2002:a0c:b405:0:b0:473:8550:94a2 with SMTP id u5-20020a0cb405000000b00473855094a2mr11993792qve.116.1657899634083;
        Fri, 15 Jul 2022 08:40:34 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id t21-20020a05620a451500b006af37b005bdsm4215719qkp.128.2022.07.15.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:40:33 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:40:33 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <YtGKcScgTh3t4SYS@google.com>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
 <YtGFLFbzuZncfDeN@google.com>
 <20220715152937.GA1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715152937.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 15, 2022 at 08:29:37AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 15, 2022 at 03:18:04PM +0000, Joel Fernandes wrote:
> > On Thu, Jul 14, 2022 at 03:21:31PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 14, 2022 at 01:51:54PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> > > > > Hello!
> > > > > 
> > > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > > difference between the previous versions is that:
> > > > > - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
> > > > >   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
> > > > >   requested by Paul.
> > > > > - Fixed checkpatch and build robot issues.
> > > > > - Some more changes to 'lazy' parameter passing and consolidation of segcblist
> > > > >   functions.
> > > > > - more testing via rcutorture and rcuscale.
> > > > 
> > > > Thank you!  What I am going to do is to pull these into an experimental
> > > > not-for-mainline branch and run the usual set of rcutorture tests.
> > > > I will then take a look at the patches.
> > > 
> > > And there were a few conflicts with the nocb patch series in -rcu.
> > > The allegedly conflict-resolved series is here: joel.2022.07.14a
> > > Please let me know if I messed something up.
> > 
> > Thanks, it looks Ok. There is one robot fix for hexagon's arch where I think
> > TREE_RCU is disabled, could you apply the diff below to patch 1/5 ?
> > 
> > Or, I can also just keep it in my version of 1/5 to go out with the next rev.
> 
> Given that I am not testing on hexagon, I will let you fix this one on
> the next rev.  If someone out there is testing this branch on hexagon,
> they should feel free to apply your patch locally.  ;-)

I am pretty sure this is the feature that was going to make Hexagon widely
adopted, but your call ;-)

thanks,

 - Joel

