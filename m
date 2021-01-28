Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB141C433E0
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE0764DD6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhA1SNx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhA1SH7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 13:07:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B336CC061786;
        Thu, 28 Jan 2021 10:07:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u25so8818381lfc.2;
        Thu, 28 Jan 2021 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HYqq0dEU1gtRG0YHpO7vLOo7MghFZ/pOcJQO5+wjdFA=;
        b=m2LxK9ZO1ECm0zggJ9dlCcwA7DlzTwsQDPHCkFP6RPRrVcgLdWSqo1VWIf3I+uzGFQ
         5jn9jdcuMmiR1sizs6hwVGEaspZ/C979xdTxt2CBXCrQ3cq8vrq6bl61LoESUX2fkwT4
         RyNqejdsfr7cpNGOmsa7oXpbDaa+tMLmzRcvGQIt5X47dsb7LTw/cFqnhacgo5mUtqzP
         9IJo8Lm33ymr11KVT7bLADiUFYK/6dHF6n5FFAoAO8fiFHehFVbToVJLH4712OCJjGpE
         8Q6GekdE5qMGAcgqtCC0jt5KocmpCOGg74TTgAmBp7Eq/OCu57Kajdp/kriexEpa7qkF
         +qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HYqq0dEU1gtRG0YHpO7vLOo7MghFZ/pOcJQO5+wjdFA=;
        b=QRkItdcejv6LgAgS453m8PqvE2XIWZ4SeVJYqmbJ618BAtJmg5yRY5WsfQAo1NN8k7
         8CluaFwetxw5AOx7rnvy7njahVcaMhFLrGKV+teNJtWLhMdcjrldJ0qcMvXTeSZnhxUj
         extw610tpQRbl0wKyFKFegTJrRoAuy47szftWCX5r/1bZefrNevv/h8YL339ZuOMQuSP
         9coSz7cutze04Nx1Jx3dT7xeWfYr4x8Zc54A7z8rdH4evvsh/XrlviEuuD+KrZ6re04g
         knZUomGX6SrI20miNSND4pNbWTqZH48RLJO07RUE8X8kHpksYmnBG6IFGPH1feViiAup
         qvJQ==
X-Gm-Message-State: AOAM530ZCo7JDO/tOalfiPhMRdjnUHy5iIHbDk2AbTWvLNLQZrHb6WoI
        XkXdfkSSSNiLRMGCaDko/dHsXRK7aLEQUg==
X-Google-Smtp-Source: ABdhPJyPb2gzXTkabvQU53TpHLVfZKqP+YokiLWcCr2zNJbC+3T57/fgXpla9W5YdAQhfqTToLL9lA==
X-Received: by 2002:a05:6512:1156:: with SMTP id m22mr118641lfg.637.1611857238234;
        Thu, 28 Jan 2021 10:07:18 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u17sm2215456ljj.2.2021.01.28.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:07:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Jan 2021 19:06:58 +0100
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/3] kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument
 kvfree_rcu()
Message-ID: <20210128180658.GB5144@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162148.1973-2-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 20, 2021 at 05:21:47PM +0100, Uladzislau Rezki (Sony) wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
> carried out by the single-argument variant of kvfree_rcu(), thus avoiding
> this can-sleep code path from dipping into the emergency reserves.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2014fb22644d..454809514c91 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3491,7 +3491,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  		if (!bnode && can_alloc) {
>  			krc_this_cpu_unlock(*krcp, *flags);
>  			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  			*krcp = krc_this_cpu_lock(flags);
>  		}
>  
> -- 
> 2.20.1
> 
Please see below a V2:

V1 -> V2:
    - rebase on [PATCH v2 1/1] kvfree_rcu: Directly allocate page for single-argument
    - add a comment about __GFP_NOMEMALLOC usage.

<snip>
From 1427698cdbdced53d9b5eee60aa5d22bc223056d Mon Sep 17 00:00:00 2001
From: "Paul E. McKenney" <paulmck@kernel.org>
Date: Wed, 20 Jan 2021 17:21:47 +0100
Subject: [PATCH v2 1/1] kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument
 kvfree_rcu()

This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
carried out by the single-argument variant of kvfree_rcu(), thus avoiding
this can-sleep code path from dipping into the emergency reserves.

Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e450c17a06b2..e7b705155c92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3496,11 +3496,14 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			// view. Apart of that it forbids any OOM invoking what is
 			// also beneficial since we are about to release memory soon.
 			//
+			// __GFP_NOMEMALLOC - prevents from consuming of all the
+			// memory reserves. Please note we have a fallback path.
+			//
 			// __GFP_NOWARN - it is supposed that an allocation can
 			// be failed under low memory or high memory pressure
 			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
-- 
2.20.1
<snip>

Thanks!

--
Vlad Rezki
