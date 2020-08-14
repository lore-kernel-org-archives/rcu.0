Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FC9C433E3
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928DB20716
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMcuY81H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHNLyM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLyJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 07:54:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E4C061384;
        Fri, 14 Aug 2020 04:54:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i80so4649453lfi.13;
        Fri, 14 Aug 2020 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJJl1olZSgHT/Jhiu6r/OOA+3riqNMH1SSNROcXwYmY=;
        b=CMcuY81HMluGkYb/1C+u09CWQgmE09tMSaY7GvDq/pR3QhI33pkKgujynl/hZ9jBgH
         /dvaWJleyujfPgspa9NoiYoflc4BN5vTUK4uUGk1Mue8ZYHH2oHtPRRM/43/l/D5CJoA
         +HchcxtK+gM7Xij45NiX7hKf0exAfIrcImhIIoyidWiD6nZWr+jhsq9QjyTbS15QbLZZ
         EmtTjQ1deErpdhPlafFvf0U9lc9kr8RZON5Yse9k6axM6HWEeYDl1Uv1+4EIR2bn2Us8
         EYK3a6tXOOK8MjYgWPycMtM8hiIOr6yR0x5ihFDeFSW6fApE7IP/b/oaF7tT9eaIu5Qm
         6TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJJl1olZSgHT/Jhiu6r/OOA+3riqNMH1SSNROcXwYmY=;
        b=YC0qD+u1Vh/47e5sCA68m5A55APDEggOW1B1A0FTuj+wMt3GJG9wswNQom2L590jRH
         JJeQY/9BwozjjkwQCHfhcKJ/07RU7psS3D+NqoX4qqmwnG3CAUTO/J3B+sVidpkwWj0k
         G7V8rzSl/IOFvrcVpy3pnX3bLhF/Y1OwJp6+A67MetoXw51CUMCmdboN52vNvAZGit0p
         3Vh6kUXnE5RAtPQLQjO+9ZXacbn3FaoD6lN5c14hPI5HAC93AdAr/BD0t7LF5JErQIpH
         KeBBKxJRiJmefzEg5MtB+EuCNqOsG9/cv/tIV1VkYIm3lVcEv7v3Wx/1e3Ih3CKQSXG/
         czbQ==
X-Gm-Message-State: AOAM532CciedioDWHc214T0g/Wn7n4hkwFSiS08X/2vJceg//tI3O0Lm
        bXuUoUe1IzahM8c3Fop/OB0=
X-Google-Smtp-Source: ABdhPJzFYPbeNuK90JNB8ioSCS9m02KhJ8SDU8+0y3pJ0/R7Ht2Usjmqvx4nizWqMB5TGAVcqH/4og==
X-Received: by 2002:a19:c894:: with SMTP id y142mr1002056lff.74.1597406047359;
        Fri, 14 Aug 2020 04:54:07 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p13sm1879876lfc.63.2020.08.14.04.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:54:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 14 Aug 2020 13:54:04 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814115404.GA28229@pc636>
References: <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813162047.GA27774@pc636>
 <20200813163617.GS9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813163617.GS9477@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 06:36:17PM +0200, Michal Hocko wrote:
> On Thu 13-08-20 18:20:47, Uladzislau Rezki wrote:
> > > On Thu 13-08-20 08:41:59, Paul E. McKenney wrote:
> > > > On Thu, Aug 13, 2020 at 04:53:35PM +0200, Michal Hocko wrote:
> > > > > On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
> > > > > > Michal Hocko <mhocko@suse.com> writes:
> > > > > > > On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> > > > > > >> It basically requires to convert the wait queue to something else. Is
> > > > > > >> the waitqueue strict single waiter?
> > > > > > >
> > > > > > > I would have to double check. From what I remember only kswapd should
> > > > > > > ever sleep on it.
> > > > > > 
> > > > > > That would make it trivial as we could simply switch it over to rcu_wait.
> > > > > > 
> > > > > > >> So that should be:
> > > > > > >> 
> > > > > > >> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> > > > > > >> 
> > > > > > >> which is limiting the damage to those callers which hand in
> > > > > > >> GFP_RT_NOWAIT.
> > > > > > >> 
> > > > > > >> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> > > > > > >> zone->lock in the wrong context. And we want to know about that so we
> > > > > > >> can look at the caller and figure out how to solve it.
> > > > > > >
> > > > > > > Yes, that would have to somehow need to annotate the zone_lock to be ok
> > > > > > > in those paths so that lockdep doesn't complain.
> > > > > > 
> > > > > > That opens the worst of all cans of worms. If we start this here then
> > > > > > Joe programmer and his dog will use these lockdep annotation to evade
> > > > > > warnings and when exposed to RT it will fall apart in pieces. Just that
> > > > > > at that point Joe programmer moved on to something else and the usual
> > > > > > suspects can mop up the pieces. We've seen that all over the place and
> > > > > > some people even disable lockdep temporarily because annotations don't
> > > > > > help.
> > > > > 
> > > > > Hmm. I am likely missing something really important here. We have two
> > > > > problems at hand:
> > > > > 1) RT will become broken as soon as this new RCU functionality which
> > > > > requires an allocation from inside of raw_spinlock hits the RT tree
> > > > > 2) lockdep splats which are telling us that early because of the
> > > > > raw_spinlock-> spin_lock dependency.
> > > > 
> > > > That is a reasonable high-level summary.
> > > > 
> > > > > 1) can be handled by handled by the bailing out whenever we have to use
> > > > > zone->lock inside the buddy allocator - essentially even more strict
> > > > > NOWAIT semantic than we have for RT tree - proposed (pseudo) patch is
> > > > > trying to describe that.
> > > > 
> > > > Unless I am missing something subtle, the problem with this approach
> > > > is that in production-environment CONFIG_PREEMPT_NONE=y kernels, there
> > > > is no way at runtime to distinguish between holding a spinlock on the
> > > > one hand and holding a raw spinlock on the other.  Therefore, without
> > > > some sort of indication from the caller, this approach will not make
> > > > CONFIG_PREEMPT_NONE=y users happy.
> > > 
> > > If the whole bailout is guarded by CONFIG_PREEMPT_RT specific atomicity
> > > check then there is no functional problem - GFP_RT_SAFE would still be
> > > GFP_NOWAIT so functional wise the allocator will still do the right
> > > thing.
> > > 
> > > [...]
> > > 
> > > > > That would require changing NOWAIT/ATOMIC allocations semantic quite
> > > > > drastically for !RT kernels as well. I am not sure this is something we
> > > > > can do. Or maybe I am just missing your point.
> > > > 
> > > > Exactly, and avoiding changing this semantic for current users is
> > > > precisely why we are proposing some sort of indication to be passed
> > > > into the allocation request.  In Uladzislau's patch, this was the
> > > > __GFP_NO_LOCKS flag, but whatever works.
> > > 
> > > As I've tried to explain already, I would really hope we can do without
> > > any new gfp flags. We are running out of them and they tend to generate
> > > a lot of maintenance burden. There is a lot of abuse etc. We should also
> > > not expose such an implementation detail of the allocator to callers
> > > because that would make future changes even harder. The alias, on the
> > > othere hand already builds on top of existing NOWAIT semantic and it
> > > just helps the allocator to complain about a wrong usage while it
> > > doesn't expose any internals.
> > > 
> > I know that Matthew and me raised it. We do can handle it without
> > introducing any flag. I mean just use 0 as argument to the page_alloc(gfp_flags = 0) 
> > 
> > i.e. #define __GFP_NO_LOCKS 0
> > 
> > so it will be handled same way how it is done in the "mm: Add __GFP_NO_LOCKS flag"
> > I can re-spin the RFC patch and send it out for better understanding.
> > 
> > Does it work for you, Michal? Or it is better just to drop the patch here?
> 
> That would change the semantic for GFP_NOWAIT users who decided to drop
> __GFP_KSWAPD_RECLAIM or even use 0 gfp mask right away, right? The point
>
I see your point. Doing GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM will do something
different what people expect. Right you are.

>
> I am trying to make is that an alias is good for RT because it doesn't
> have any users (because there is no RT atomic user of the allocator)
> currently.
>
Now I see your view. So we can handle RT case by using "RT && !preemptible()",
based on that we can bail out. GFP_ATOMIC and NOWAIT at least will keep same
semantic.

Second, if the CONFIG_PROVE_RAW_LOCK_NESTING is fixed for PREEMPT_COUNT=n,
then it would work. But i am lost here a bit if it is discussable or not.

Thanks!

--
Vlad Rezki
