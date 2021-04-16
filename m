Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B5C433B4
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A1F61107
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhDPKOn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhDPKOm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Apr 2021 06:14:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F05C061756;
        Fri, 16 Apr 2021 03:14:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so4426848lfp.0;
        Fri, 16 Apr 2021 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eIvqPPBbAvNqFx12cHL1B4vffzpZCMAWEVEbWEu/lPo=;
        b=PLLod+j3TGvIeZ8l2Oja4vThf+Quu/N0GlL7m3yv2HJSbAMdBjXMjRxtplAvREq6Rc
         7oLFkSzOr0MpHyU1Vk3kH+VuBvtfhSWA6KpvOG72fHIRHccT0lkU0aOpyBLvU/7aXJKm
         tbxXpUDevLmmQ31DKMOJeKaFfrWEo/82sMge25xIF6b7N1kC8KpkZCH+99N8isQBzoxt
         MJ19CptHgUAfAbwyPDRSqLloNMpTrBhUAKCc68DLB8x+/geNn5Je02pcEbW3A34uyI7+
         8ePu9V04PcfKcZ1XCvSxFJ6/S55J53b8RdKj8GDiAhdZ3UtsqzvG6tkJ2dp8Nvg9rkzP
         zqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIvqPPBbAvNqFx12cHL1B4vffzpZCMAWEVEbWEu/lPo=;
        b=KI1JSMLABtLW6pnLRRqMR/GCc8k34DNbTmzqcZrDQsVfXM5qFyRjt3UljzmomLG35p
         erc+jxQaHIJ5AZzSvIydPsnDmgPcUCZGcG2/b77yjn91COBdG/4FNWrl16QcXR6cSNoB
         GPKrgtNUfJAa1lDe8TxVtawx8PRHawrJEuWCnh57mqGSdHSpo99lY9FalNJ6HctnbP17
         2SsGXjmIwGtnPGANNeMSSmz0y0Br89JZ4IGsi4mk2HXKPMqsYitPuSzH32PGm5tLY8B0
         nenJ4Usl/U2uKiGSAgfw6BErg62/aNBKGhX53XtZy2yAGOOruYfTzh2xh6Ip5HLy7Vwa
         /hyw==
X-Gm-Message-State: AOAM533GlC6WtNlt0DA74vlZM+vrb6m6UNjKqQZDbX+WwT8rN+Pj8U6o
        KQg9VaDY5dn319/6hRZERCk=
X-Google-Smtp-Source: ABdhPJz1BqIqw4B+wW1PzwZbDX3tu/8kF/ZmeHD7vy14wWmPIReixXyQfeqFKietpNVF3CusHKBR+w==
X-Received: by 2002:a19:911e:: with SMTP id t30mr2560275lfd.292.1618568056357;
        Fri, 16 Apr 2021 03:14:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id s13sm892724ljc.26.2021.04.16.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 03:14:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 16 Apr 2021 12:14:14 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 0/5] kvfree_rcu() miscellaneous fixes
Message-ID: <20210416101414.GA2711@pc638.lan>
References: <20210415172000.15086-1-urezki@gmail.com>
 <20210416011026.GD4212@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416011026.GD4212@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 15, 2021 at 06:10:26PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 15, 2021 at 07:19:55PM +0200, Uladzislau Rezki (Sony) wrote:
> > This is a v2 of a small series. See the changelog below:
> > 
> > V1 -> V2:
> > - document the rcu_delay_page_cache_fill_msec parameter;
> > - drop the "kvfree_rcu: introduce "flags" variable" patch;
> > - reword commit messages;
> > - in the patch [1], do not use READ_ONCE() instances in
> >   get_cached_bnode()/put_cached_bnode() it is protected
> >   by the lock.
> > - Capitalize the word following by ":" in commit messages.
> > 
> > Uladzislau Rezki (Sony) (4):
> > [1]  kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
> > [2]  kvfree_rcu: Add a bulk-list check when a scheduler is run
> > [3]  kvfree_rcu: Update "monitor_todo" once a batch is started
> > [4]  kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
> > 
> > Zhang Qiang (1):
> > [5]  kvfree_rcu: Release a page cache under memory pressure
> 
> I have queued these, thank you both!  And they pass touch tests, but
> could you please check that "git am -3" correctly resolved a couple of
> conflicts, one in Documentation/admin-guide/kernel-parameters.txt and
> the other in kernel/rcu/tree.c?
> 
Thanks!

I have double checked it. I see that everything is in place and
has been correctly applied on your latest "dev".

--
Vlad Rezki
