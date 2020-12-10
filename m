Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D145C4167B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601A823E21
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbgLJSTu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392941AbgLJSSF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 13:18:05 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1767C061794;
        Thu, 10 Dec 2020 10:17:23 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so9633057lfg.0;
        Thu, 10 Dec 2020 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eU3gAxbHfnuDe7fKcEuZgZLh+PC1w6WTIXE0r+35/k=;
        b=AFSFEY2QPDU6OkjO4H3NJtnS38VCLhNF4FP5bhhzJ91zxmxn/sUT0xktWvRZsVS+NY
         n+yzzVPz/Hz0beUTeC6H7kIWj3/yEF3Wzd9qUTyYVM8Npu7rd8aLv6EUKl77VgTHO4XW
         gO/qtn9UdbnuDGDbSKZ75LrNpHvvTHB+yXe+QmYOij2Rwd6C1y/strfZAh8Pi7gOag1e
         W2qWHOBPMG8frNF/j4HqOEqTJZ0s6oV3wWC0zA//jucC1X/jL9ILhDcm9xJr3e7Nn2/J
         6GGpRZcpuU5CUUc4um4x7UJC7ALWce5mhVpZ24Qqaodfr6Yg9mH8zOu3Dj33K1FbIaf2
         ViuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eU3gAxbHfnuDe7fKcEuZgZLh+PC1w6WTIXE0r+35/k=;
        b=pFJgUbImdhTESZEsGWiroP55jKbPQjuWBYBqfJ9PlSbXiLQKdOPKIzuXGFm+OMQRug
         D3js4SqhAf4aaDsh6oA7//eLTGdoxxXzmIo18pufyBgQRiOOz3Mu/HwocB6pDy8qIl+m
         ynIUkVkrTDXyX5yUWDq8T2oqRTPhKnAeH/2xv6Qrqc7G5bT0z0TEhTqpL2sgZDCsQbtB
         +uTlfhJkju2KuyQz2Wmf6m0IBUAdJvs0AxHxQIa1OjQRodhScuAYVWPreOJ0PxpNHvk0
         nqRdK0wMwPMPRYTe8/YGWUbfhBSXmFAn0EzBa0pc1zJk8LI7cPK2H3wVdc3Tw27Atm8l
         ow6Q==
X-Gm-Message-State: AOAM531L926vQ8esleETsiWAPoamMbd7qd0KoTzENdyLhmj4XZY94i5d
        FjmOLZdmYxxw9LVgPWKQeD0=
X-Google-Smtp-Source: ABdhPJzzS4xpRUhgeSNdf3lfAbc0iKSsSFDRBEqYnOduzCmt11voQLFYzrGoASRxDbie0iqoWmjoSA==
X-Received: by 2002:a19:2291:: with SMTP id i139mr3340562lfi.592.1607624242127;
        Thu, 10 Dec 2020 10:17:22 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c19sm603830lfr.182.2020.12.10.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:17:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 10 Dec 2020 19:17:19 +0100
To:     Daniel Axtens <dja@axtens.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of
 core_initcall()
Message-ID: <20201210181719.GA2014@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209203728.GA5972@pc638.lan>
 <875z59hjau.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z59hjau.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Daniel.

> Hi Vlad,
> 
> >> Initialize the RCU-tasks earlier, before *_initcall() callbacks are
> >> invoked. Do it after the workqueue subsytem is up and running. That
> >> gives us a possibility to make use of synchronize_rcu_tasks*() wait
> >> API in early_initcall() callbacks.
> >> 
> >> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Tested-by: Daniel Axtens <dja@axtens.net>
> 
Thank you for checking it!

> >> ---
> >>  include/linux/rcupdate.h |  6 ++++++
> >>  init/main.c              |  1 +
> >>  kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
> >>  3 files changed, 29 insertions(+), 4 deletions(-)
> >> 
> > I still don't have a powerPC hw so far, even though i have sent a request
> > to the osuosl.org. It would be appreciated if Michael or Daniel could run
> > and verify it.
> 
> Sorry it's taken me so long to get to this. Your patch fixes things for
> me. Thanks!
> 
No problem. I fully understand that sometimes we are limited in spare time.

>
> BTW, I'm happy to see you taking on the challenge of RCU after your good
> work on vmalloc - all the best with it!
> 
Yep, that work was quite interesting and probably not so easy, at least
in the beginning. Thanks for your supportive words and same to you
regarding your excellent KASAN work and future challenge :)

--
Vlad Rezki
