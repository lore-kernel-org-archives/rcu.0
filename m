Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC60C4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CB4206B7
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raxd4XYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgI3NkB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3NkB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 09:40:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B524C061755;
        Wed, 30 Sep 2020 06:39:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b12so2180804lfp.9;
        Wed, 30 Sep 2020 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Mv19Yx2WxdVyKnvOoeq4MvA7Ro0O7JtMWzZ1C2BvJM=;
        b=raxd4XYfV1muIM8s1gC3S4KP6FGX4R8WUQZ931rlO563LUJMZe0ngCrSQj8u+0ZADi
         xcySPT1dn0Kv7o5yhplz5jyVOmYihDRuYWtkIk15ar64efQV9oJs5qQDG4nF9hRmomsr
         iWADp/1No+P3ScB3qO2QO3pfdSsP3Psxr2/Ke6J7uDJRCW8r/N7WHb9KEu5RiSYc5MTg
         VaedPCasIVN4WBjc+oH89m15UtJwVbAZJb9YCNTc9Q1yueLUJ9+7E39t69GJZoa8izSL
         /HRUBA0dLo1qWMxyr0zPxHnn7NoLRxAwhsUJesKnOB5oqvIq+/PrUHZR2DjG4tv3egm/
         auIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Mv19Yx2WxdVyKnvOoeq4MvA7Ro0O7JtMWzZ1C2BvJM=;
        b=qp+lLFOUHy0juBwMSHo3w4fpYiwDSR/qJhnO74/UgaUCsFOB/lUn83bNzPFxhcoZgn
         VcqSD+QeKfsUpyyqbf4qvZbM+Otfcl1YZ6z1zCjfBysSpvsobqlIgTyjYPDuzQRvce5U
         qhc8D9yA2ult7h0acy2Y170JRfn2x1maYL8DmHT6MXk1Sr0rWFyKSSZbrwvgb1UjlJad
         K8yGrQRiu1gHMgBP8eTv/xD5dLnv4R/+3+5BHI5TlVC1UTd9ib0eXURPMl15AVfQ3LHp
         3m4ATmkxDrIdKdYWJCD4LUUZxTDhWtG4FT22NDgQJfAgugC8NSI11rTPGbGpLCUpwnZ9
         rJ1A==
X-Gm-Message-State: AOAM532XpWfcA2VDR2++go29uuq57OE0lkO1AgmhnalSvJ8dCRhHGgT3
        9fZIuoQz+lH3E7MswDgzqio=
X-Google-Smtp-Source: ABdhPJxpXr0wR69XUTokZpdN0EtefxY7Z63IScx35mYhulRHzMUV81dz8LoZI8BQHtdeOLiUtzgv4g==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr833353lfg.185.1601473197790;
        Wed, 30 Sep 2020 06:39:57 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a73sm196493lfd.245.2020.09.30.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 06:39:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Sep 2020 15:39:54 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930133954.GA19235@pc636>
References: <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200929162514.GA8768@pc636>
 <20200930092732.GP2277@dhcp22.suse.cz>
 <20200930123535.GB18005@pc636>
 <20200930124413.GU2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930124413.GU2277@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 02:44:13PM +0200, Michal Hocko wrote:
> On Wed 30-09-20 14:35:35, Uladzislau Rezki wrote:
> > On Wed, Sep 30, 2020 at 11:27:32AM +0200, Michal Hocko wrote:
> > > On Tue 29-09-20 18:25:14, Uladzislau Rezki wrote:
> > > > > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > > > > to provide a memory service for contexts which are not allowed to
> > > > > > sleep, RCU is part of them. Both flags used to provide such ability
> > > > > > before but not anymore.
> > > > > > 
> > > > > > Do you agree with it?
> > > > > 
> > > > > Yes this sucks. But this is something that we likely really want to live
> > > > > with. We have to explicitly _document_ that really atomic contexts in RT
> > > > > cannot use the allocator. From the past discussions we've had this is
> > > > > likely the most reasonable way forward because we do not really want to
> > > > > encourage anybody to do something like that and there should be ways
> > > > > around that. The same is btw. true also for !RT. The allocator is not
> > > > > NMI safe and while we should be able to make it compatible I am not
> > > > > convinced we really want to.
> > > > > 
> > > > > Would something like this be helpful wrt documentation?
> > > > > 
> > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > index 67a0774e080b..9fcd47606493 100644
> > > > > --- a/include/linux/gfp.h
> > > > > +++ b/include/linux/gfp.h
> > > > > @@ -238,7 +238,9 @@ struct vm_area_struct;
> > > > >   * %__GFP_FOO flags as necessary.
> > > > >   *
> > > > >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > > > > - * watermark is applied to allow access to "atomic reserves"
> > > > > + * watermark is applied to allow access to "atomic reserves".
> > > > > + * The current implementation doesn't support NMI and other non-preemptive context
> > > > > + * (e.g. raw_spin_lock).
> > > > >   *
> > > > >   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
> > > > >   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> > > > > 
> > > > To me it is clear. But also above conflicting statement:
> > > > 
> > > > <snip>
> > > > %GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
> > > > <snip>
> > > > 
> > > > should be rephrased, IMHO.
> > > 
> > > Any suggestions? Or more specifics about which part is conflicting? It
> > > tries to say that there is a higher demand to succeed even though the
> > > context cannot sleep to take active measures to achieve that. So the
> > > only way to achieve that is to break the watermakrs to a certain degree
> > > which is making them more "higher class" than other allocations.
> > > 
> > Michal, i had only one concern about it. It says that %GFP_ATOMIC users
> > can not sleep, i.e. callers know that they are in atomic, thus no any
> > sleeping, but the chose they make will force them to sleep.
> 
> I am not sure I follow you here. Do you mean they will be forced to
> sleep with PREEMPT_RT?
> 
Exactly :)

--
Vlad Rezki
