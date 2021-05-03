Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F680C433B4
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 19:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F6A6135F
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 19:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECTfP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 May 2021 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhECTfO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 May 2021 15:35:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B3C06174A;
        Mon,  3 May 2021 12:34:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t11so8252478lfl.11;
        Mon, 03 May 2021 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BSY9bKk9NolcYFOXi42/siSm3AMFD53uLmcVvnybB2M=;
        b=kt1YgzPGtGyBFfAgA4gqJS0lPcCmP+Q+6c7QNzQE9bCYamsEzjue4GsyVhif3OQD/p
         /rgYY11MNuk9355CAv1iSR6JxWcGJsOEtEnNkeUZ2vc+Ewy6SeNlpe7Ts3SavB5Jiz56
         nu74jsOiZLfiATCrNhWP7mWFUWFvmDyb/bA9vLzrCz6cy5qJkOvJLYE2SbfHin966MiE
         EVABlRLi32j4mrEI4PrzAwBj4lk3DeOAv0RtewQS0Rf8AMbVGL4nUWYM1yBAXTfDMCj0
         yJ9MikAziks3Wrdv/ofnYMY1gkKfdy7hVU9MWJ2OvGUmSgMPMdrQOICFH2SQHkeVvnSR
         +kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BSY9bKk9NolcYFOXi42/siSm3AMFD53uLmcVvnybB2M=;
        b=KW0hzodM96fwep5VivCLixR4PqfAk7zFJq0A1zH+QRvjNz9zEOrK35EKpR95Yiz612
         4kaVkv7ub1J7WA99Dy1NMMWMawdZ+GwF8NLHjhPzsYD0X6p5kbsuf2YUPjX8SM3etnxc
         TRdc5ybsL8ZRHtanL7jzIsBSJJTjJaUb+STyopp4Adk+HEIIiatBaHzhaL6GzdFICd41
         48LAu/ope5WFcgQeD33e+2r+EUt6APDHCb6vFsG8u9Nu2H9G2jYGD8EmVmi0pbf9kjgl
         pPlQXVGifJbFEivyx8BWjhkUFUcfhqX8gYRlzGg2D+X/iRJ2JP7Cp8kiq1lXXEZQAMh1
         LG5w==
X-Gm-Message-State: AOAM530hwTYC1dr4+UjBXY7ukNUsnDewJkHpn7EY4V0CbZ5mKUyTuWfg
        0ApAag1h54KgaL+MY5Y4/SA=
X-Google-Smtp-Source: ABdhPJz9aQZJTMeMgNQfz8NUOpL3hdRNfL7XtXE+z/f0C/ZaJe9J2C4/3KPOnrMMB1NlixBmIiOGJg==
X-Received: by 2002:a19:674d:: with SMTP id e13mr14834711lfj.652.1620070456304;
        Mon, 03 May 2021 12:34:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t21sm1402941ljh.84.2021.05.03.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:34:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 3 May 2021 21:34:13 +0200
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
Subject: Re: [PATCH v1 5/5] kvfree_rcu: Fix comments according to current code
Message-ID: <20210503193413.GA2421@pc638.lan>
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-5-urezki@gmail.com>
 <20210503164723.GX975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503164723.GX975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Wed, Apr 28, 2021 at 03:44:22PM +0200, Uladzislau Rezki (Sony) wrote:
> > We used to have an "emergency path" and comments related
> > to it. According to current kvfree_rcu() design that path
> > is not considered as emergency anymore.
> > 
> > This patch rephrases and updates comments regarding this.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Queued as follows, thank you!  Please check my usual wordsmithing to
> make sure that I did not mess anything up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 06c2113c4b1ce9ded69cd0ac4da9a00ed6be8834
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Apr 28 15:44:22 2021 +0200
> 
>     kvfree_rcu: Fix comments according to current code
>     
>     The kvfree_rcu() function now defers allocations in the common
>     case due to the fact that there is no lockless access to the
>     memory-allocator caches/pools.  In addition, in CONFIG_PREEMPT_NONE=y
>     and in CONFIG_PREEMPT_VOLUNTARY=y kernels, there is no reliable way to
>     determine if spinlocks are held.  As a result, allocation is deferred in
>     the common case, and the two-argument form of kvfree_rcu() thus uses the
>     "channel 3" queue through all the rcu_head structures.  This channel
>     is called referred to as the emergency case in comments, and these
>     comments are now obsolete.
>     
>     This commit therefore updates these comments to reflect the new
>     common-case nature of such emergencies.
>     
>     Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
Looks good to me.

--
Vlad Rezki
