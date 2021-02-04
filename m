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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD119C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC8464F3F
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 14:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhBDOPq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhBDOPB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Feb 2021 09:15:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761AC061573;
        Thu,  4 Feb 2021 06:14:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f1so4752769lfu.3;
        Thu, 04 Feb 2021 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wg+ElN1SsjQb5Njla5L8ZnJEjESAl6ih4UeEPF1Z9tU=;
        b=BdCTgD3C+0xb7yyEZCCjMucu0N4eRXHE+cuta0noSBf+R6i8hu+G3Kvbj3ighz9nkb
         PnoNNsKaMOns0JP13/giJuC7L8IiFNbhA0L50kdfF0zyXANd1Qb4seMmdpgh2zmUYai/
         /mYVNjae1wlZa69KXxwfrIeeSRuDZKMdtIXl3lSPg/pE/NF9/Tq7/9+Kvl0YHnlJvNTh
         iM+jdmDJnvtBpo5agYdbwpSPF+ItnvoPzOOuArdeL6H/xzYHpNpUzTAvGA0DjBXR65Mj
         ff+jc4IK3v3j+WQ93T7A1G1TfeBA99rLCnMdW2hbT2lWAq1g7pUB7c/MXAk1/32xqdS8
         NWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wg+ElN1SsjQb5Njla5L8ZnJEjESAl6ih4UeEPF1Z9tU=;
        b=GNfCYUMsfoSeGc4s1I+saWAIklTs+qWFQWrGKis+/abATCiGHSBhEbAMGgEzXNMPX9
         pSlQZieCuYQ910CJyPX3LiHyfarEGDcMbm9D+n+t5FPmHz21tG/4DYLXlIm3pWu+uZw0
         eLQiQ2vJ9rWV/lAvHe7FQ9Q64K3A2D0zPNgthUWm3wlBiOQ0mGciu3WFtfpBbT/k4Gtq
         cP8/mFRIX75y8I5j5O+MdDFwLfm/uKrOtsPO9Q9PNl6HmwtnLkWk9iw8CATYuJhCPJIn
         bSzyc3dbX5qipwDv6gvFwGkazQ5SoWptXrBCFQ6Yh3EQGfTaHtaZMPvN+crrHtr1y8IK
         rNHQ==
X-Gm-Message-State: AOAM530aE1W2PpqlY2P3XJUn86uvCQxudOS9Bn0UcOhTrOR7oaxyXqN0
        p0PIT4ctX4215n5499AoqPbeSXLHRc0VgV5E
X-Google-Smtp-Source: ABdhPJwvEk8HFascYHzViUNb2/VDydniueW+T3yvopQ+QmZDHX++QDZ1sV4CMyzO9uaQt+2ZYNsjEg==
X-Received: by 2002:ac2:4544:: with SMTP id j4mr4667597lfm.311.1612448055997;
        Thu, 04 Feb 2021 06:14:15 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id w23sm618986lfe.84.2021.02.04.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:14:15 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 4 Feb 2021 15:14:13 +0100
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Message-ID: <20210204141413.GB1904@pc638.lan>
References: <20210129200505.5273-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129200505.5273-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul.

> To stress and test a single argument of kfree_rcu() call, we
> should to have a special coverage for it. We used to have it
> in the test-suite related to vmalloc stressing. The reason is
> the rcuscale is a correct place for RCU related things.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/rcuscale.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 06491d5530db..e17745a155f9 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -94,6 +94,7 @@ torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
> +torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
>  torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *scale_type = "rcu";
> @@ -667,10 +668,14 @@ kfree_scale_thread(void *arg)
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
>  			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> +
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			if (kfree_rcu_test_single)
> +				kfree_rcu(alloc_ptr);
> +			else
> +				kfree_rcu(alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> -- 
> 2.20.1
>
What is about this change? Do you have any concern or comments?

--
Vlad Rezki
