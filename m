Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1ACC4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A720791
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K+46e+Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgI3Rsz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3Rsz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 13:48:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192AC061755
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 10:48:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g128so2799119iof.11
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QPmNeUX1bWiynEkFpQ8LFbxgXrdGF1ePUmA+g1hmvc=;
        b=K+46e+Uog+2T1I+TOuHcyrukfXR8Dcsi2XAT/Jv3NckuYxiup+3IpVVhjucX0+FBu1
         xJ/juyanFTPgTdLxYe1kUJZoRIqmoDVkhGbjtk4zYqN44Ktbab3olfVq/M/9fxiOZLUN
         e1x/bw+NZ6QvGb3sNnwb0entFB/LOCfhKhK2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QPmNeUX1bWiynEkFpQ8LFbxgXrdGF1ePUmA+g1hmvc=;
        b=f0m2ZhtYAyPJrGfKbh1cMCAF2NEDp0LQmdhCkbyzTP9aH5Y96NThAy94N3vDqNIdtT
         NlW6dCIo3Obwnuxo9IRIXxD42b5DFypQ2c3YuS2dQJx84BBckFlnfuL1ZYqnGyMB31XK
         plZ5eefY6h2QIY1po+fLHnVnefwUkwclZ3aDqkyzb2ooM5OSvrI8kJxLE3xb7zLe/DFN
         Hia0xLuer/9c1/5oETvrf2wb+10e3QL5EwH1y4znG05NeX09z8zR+8Dl08rXT06Qb/8D
         0fbmMiw3ejM6dEp6Vo7+IynKRaaJtzXwOQqOHSqXdRnR//jZ7FksIqt5wMU+w3pKEg7D
         RH5w==
X-Gm-Message-State: AOAM531oSzWvQgoI7oJuOtv2RZq0idITgOHljvR9HwrWSVuWAIsdq1tT
        PN/ER1FpDzK3/QuWBE+rAEV+eVX6GoeG96+Gy2pTsQ==
X-Google-Smtp-Source: ABdhPJyH2qooLdafccnV5z+ZBU82is4eon7Xxy75LgeCjygNOkk23NrnAjI6C0Bhrv7s9SoJD2KS3uAUeLcKSBakYnc=
X-Received: by 2002:a05:6602:2a4b:: with SMTP id k11mr2470720iov.85.1601488132303;
 Wed, 30 Sep 2020 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200923103706.GJ3179@techsingularity.net> <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net> <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz> <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz> <20200930152517.GA1470428@google.com>
 <20200930164822.GX2277@dhcp22.suse.cz> <CAEXW_YSLhXR=7Asa19v7z2Aj=AqDiehHQLych3B7S+qxgPEWzQ@mail.gmail.com>
 <20200930172205.GY2277@dhcp22.suse.cz>
In-Reply-To: <20200930172205.GY2277@dhcp22.suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Sep 2020 13:48:40 -0400
Message-ID: <CAEXW_YSvnC+hv2Y47Nrg5TS1gZ8UPnSBooqMv7krcrxe94EWSQ@mail.gmail.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 1:22 PM Michal Hocko <mhocko@suse.com> wrote:

> > > > I think documenting is useful.
> > > >
> > > > Could it be more explicit in what the issue is? Something like:
> > > >
> > > > * Even with GFP_ATOMIC, calls to the allocator can sleep on PREEMPT_RT
> > > > systems. Therefore, the current low-level allocator implementation does not
> > > > support being called from special contexts that are atomic on RT - such as
> > > > NMI and raw_spin_lock. Due to these constraints and considering calling code
> > > > usually has no control over the PREEMPT_RT configuration, callers of the
> > > > allocator should avoid calling the allocator from these cotnexts even in
> > > > non-RT systems.
> > >
> > > I do not mind documenting RT specific behavior but as mentioned in other
> > > reply, this should likely go via RT tree for now. There is likely more
> > > to clarify about atomicity for PREEMPT_RT.
> >
> > I am sorry, I did not understand what you meant by something missing
> > in Linus Tree. CONFIG_PREEMPT_RT is there.
>
> OK, I was not aware we already CONFIG_PREEMPT_RT in the three. There is
> still a lot from the RT patchset including sleeping spin locks that make
> a real difference. Or maybe I haven't checked properly.
>
> > Could you clarify? Also the CONFIG_PREEMPT_RT is the only thing
> > driving this requirement for GFP_ATOMIC right? Or are there non-RT
> > reasons why GFP_ATOMIC allocation cannot be done from
> > NMI/raw_spin_lock ?
>
> I have already sent a clarification patch [1]. NMI is not supported
> regardless of the preemption mode. Hope this clarifies it a bit.
>
> [1] http://lkml.kernel.org/r/20200929123010.5137-1-mhocko@kernel.org

That works for me. Thanks,

  - Joel
