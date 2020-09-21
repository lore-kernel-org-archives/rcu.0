Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBC43463
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2DB218AC
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hua3oLTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgIUN1r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgIUN1q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 09:27:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B695C061755;
        Mon, 21 Sep 2020 06:27:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so11063512lja.7;
        Mon, 21 Sep 2020 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKT/JIsFFqmjDXSqQuaX6dHydVPeyJXqeiY+NwsV04s=;
        b=hua3oLTfb+FDOCXGstRREwb5tvEWujV3GiXymY13G0Ma8DKTv5RGen8s1EccyvEOET
         0pYRD+i6sFV/aT9nUqNYbngnKCICWdyUkt8c+Q+nYENC3IRedGlWMLW1fecPvkY2kO6k
         KmSKkv8VQQN+ZKFteYjY4oPBx/ryD/b9HsJ9fNVfPu1Um3jaEISegPqooC/zD6rxzsrb
         vBxMrua6j8P2ocU0vdOV4zsoYdHKOwk9JNDupDgcChaAndSAAMarw/SCL0RYlx33r0kl
         6wYB+eofJAgclHPs7GdT19/wE3pbbqE7MaQngLvYgVzBVeyOqyusfxnrRXoJfgjvyx+u
         om+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKT/JIsFFqmjDXSqQuaX6dHydVPeyJXqeiY+NwsV04s=;
        b=QKWt51cx0iakYJw1FLiJ2ZcDwyV4zShsC6fblAKYvTnR89CZZ4wA5BbOwcioyvjn0O
         kOmq1KARhrUb9c1DEyHbPz//3v2bxT0mNYYpN2gNWx1vNT2Uy1PvOKW17EGaGRSLNayb
         jOBL0aNgiC0pZIgOxLBb1pCkfVXXPjqv9pFw+hG5s6xQYjK+zPa11/A68gaQu6QpcdtY
         lnbFo0nXmSrWCOzSqkCEff90SMEgge+Jz1mI6S6AbXMwOkXTQAWuuec/KIh59TniXLnT
         cJC30xY9FXi7k1gIwIrAdMbsZXgXJ5HTZz9bg9nxpYFwaF1VyCF4DYuBTwkgdl9kJudn
         QyPQ==
X-Gm-Message-State: AOAM533jdkBSHakPJWy2A8FR6lgkG5p56cE99qNfuyVGqE+iPXy+N0hb
        vnFeILbPOygIS/El7z6jHxuqjAN31kV31Ds1
X-Google-Smtp-Source: ABdhPJwK3TpTKcyOBIx8i1nITc8f4VQf17bKp4sJxgihojiawbG9dlqpRfhK/WzMXUjliT83ioVFwQ==
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr16826448ljf.375.1600694864958;
        Mon, 21 Sep 2020 06:27:44 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r4sm2565026lfc.162.2020.09.21.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:27:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 21 Sep 2020 15:27:41 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 4/4] rcu/tree: Use schedule_delayed_work() instead of
 WQ_HIGHPRI queue
Message-ID: <20200921132741.GA20907@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-5-urezki@gmail.com>
 <20200920150638.GA5453@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920150638.GA5453@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 20, 2020 at 08:06:38AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 18, 2020 at 09:48:17PM +0200, Uladzislau Rezki (Sony) wrote:
> > Recently the separate worker thread has been introduced to
> > maintain the local page cache from the regular kernel context,
> > instead of kvfree_rcu() contexts. That was done because a caller
> > of the k[v]free_rcu() can be any context type what is a problem
> > from the allocation point of view.
> > 
> > >From the other hand, the lock-less way of obtaining a page has
> > been introduced and directly injected to the k[v]free_rcu() path.
> > 
> > Therefore it is not important anymore to use a high priority "wq"
> > for the external job that used to fill a page cache ASAP when it
> > was empty.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> And I needed to apply the patch below to make this one pass rcutorture
> scenarios SRCU-P and TREE05.  Repeat by:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "SRCU-P TREE05" --trust-make
> 
> Without the patch below, the system hangs very early in boot.
> 
> Please let me know if some other fix would be better.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce1ea4..2424e2a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3481,7 +3481,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
>  	if (!success) {
>  		// Use delayed work, so we do not deadlock with rq->lock.
> -		if (!atomic_xchg(&krcp->work_in_progress, 1))
> +		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> +		    !atomic_xchg(&krcp->work_in_progress, 1))
>  			schedule_delayed_work(&krcp->page_cache_work, 1);
>  
>  		if (head == NULL)
I will double check!

--
Vlad Rezki
