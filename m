Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64956C433EF
	for <rcu@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiF3OgB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiF3Ofq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F61FDD
        for <rcu@vger.kernel.org>; Thu, 30 Jun 2022 07:25:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cu16so29940932qvb.7
        for <rcu@vger.kernel.org>; Thu, 30 Jun 2022 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cP6nxi4Od/FipmKssZv/t/7VDNGeJsL7rLZQtr/bnfg=;
        b=e2thX87Xi6JBWAdzrOzzt2b49dJhtcdhmvYlkWLFmPiYBpA7hUb536FwSeJzvbCQZA
         Y9ym8sbl0y1mMP6HXvf8EbtMeDkrGCXkX6ruuTS4KPD7kMRsJKhZEX7kO4cvNh7/Qw1m
         8QC32c7ZrpE9AnoSnetTNNX4hdFDFoJLZA+Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cP6nxi4Od/FipmKssZv/t/7VDNGeJsL7rLZQtr/bnfg=;
        b=KwyBh8dWcCPlKhHO5ZgUKW1AOu7A9CV0T/f8Gr+wGYfo4Yncc5aoG1LT8i3PU28nha
         /+HpaBqqfEEWnzSuHVFJburoIWs22cc6v5cA2LFCrRk/DDSszenbOKbwCBoTuJKDKn/K
         GhCfOxa75cTp/Xec1IUCQt0m0NrGWOrzv8tF9LpW6dSZyYu2vx9U2S601l0pzzXu5B4y
         PwZqKUqHLrzgS/T5fCzYFHa2sHNSA6RXOex3Ofu6LMEDSitUaihXmeG45RvCefd/ZGIp
         VBmbnOZPnPBJdMKzn5+sxEB2UpgZa1SJDIzenH0K8Cye52lP5qbo+sFYlVLjSCvHRoCt
         on2g==
X-Gm-Message-State: AJIora/hSxpjuh3TrXHaYthaEnJNhhxhqnrhstwecfxE3UISroQ2Co63
        pSuckvb4NkL1sLcG5CkVyCVHCoKkxLFcfg==
X-Google-Smtp-Source: AGRyM1tnh5nMQ/K4LPr1B4lD+/f7XrZ/UcsUbnVKa82BaswzWbBpuvXX7qazXG2HSxlGK7MaocB4wA==
X-Received: by 2002:a05:6214:260b:b0:470:52b2:2521 with SMTP id gu11-20020a056214260b00b0047052b22521mr11508499qvb.31.1656599117176;
        Thu, 30 Jun 2022 07:25:17 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q8-20020a37f708000000b006b1fe4a103dsm1702333qkj.51.2022.06.30.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:25:16 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:25:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <Yr2yTKZe7JmNrimV@google.com>
References: <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrsyrmDbfnkpfDEP@google.com>
 <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
 <20220629165627.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrysWAx/rMbBF5iY@google.com>
 <20220629210720.GO1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629210720.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 29, 2022 at 02:07:20PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 29, 2022 at 07:47:36PM +0000, Joel Fernandes wrote:
> > On Wed, Jun 29, 2022 at 09:56:27AM -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 28, 2022 at 05:13:21PM -0400, Joel Fernandes wrote:
> > > > On Tue, Jun 28, 2022 at 12:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > > > > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > > > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > > > > > should return the number of freeable items, but if there are no objects
> > > > > > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > > > > > cache should be skipped for another reason.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > > > ---
> > > > > > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > > > > >               atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > -     return count;
> > > > > > > > > > +     return count == 0 ? SHRINK_EMPTY : count;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static unsigned long
> > > > > > > > > > --
> > > > > > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > > > > > >
> > > > > > > > > Looks good to me!
> > > > > > > > >
> > > > > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > >
> > > > > > > > Now that you mention it, this does look independent of the rest of
> > > > > > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > > > > > >
> > > > > > > Thanks Paul and Vlad!
> > > > > > >
> > > > > > > Paul, apologies for being quiet. I have been working on the series and the
> > > > > > > review comments carefully. I appreciate your help with this work.
> > > > > >
> > > > > > Not a problem.  After all, this stuff is changing some of the trickier
> > > > > > parts of RCU.  We must therefore assume that some significant time and
> > > > > > effort will be required to get it right.
> > > > >
> > > > > To your point about trickier parts of RCU, the v2 series though I tested it
> > > > > before submitting is now giving me strange results with rcuscale. Sometimes
> > > > > laziness does not seem to be in effect (as pointed out by rcuscale), other
> > > > > times I am seeing stalls.
> > > > >
> > > > > So I have to carefully look through all of this again. I am not sure why I
> > > > > was not seeing these issues with the exact same code before (frustrated).
> > > > 
> > > > Looks like I found at least 3 bugs in my v2 series which testing
> > > > picked up now. RCU-lazy was being too lazy or not too lazy. Now tests
> > > > pass, so its progress but does beg for more testing:
> > > 
> > > It is entirely possible that call_rcu_lazy() needs its own special
> > > purpose tests.  This might be a separate test parallel to the test for
> > > kfree_rcu() in kernel/rcu/rcuscale.c, for example.
> > 
> > I see, perhaps I can add a 'lazy' flag to rcutorture as well, so it uses
> > call_rcu_lazy() for its async RCU invocations?
> 
> That will be tricky because of rcutorture's timeliness expectations.

I have facility now to set the lazy timeout from test kernel modules. I was
thinking I could set the same from rcu torture. Maybe something like a 100
jiffies? Then it can run through all the regular rcutorture tests and
still exercise the new code paths.

> Maybe a self-invoking lazy callback initiated by rcu_torture_fakewriter()
> that prints a line about its statistics at shutdown time?  At a minimum,
> the number of times that it was invoked.  Better would be to print one
> line summarizing stats for all of them.
> 
> The main thing that could be detected from this is a callback being
> stranded.  Given that rcutorture enqueues non-lazy callbacks like a
> drunken sailor, they won't end up being all that lazy.

Thanks for this idea as well. I'll think more about it. thanks,

 - Joel

