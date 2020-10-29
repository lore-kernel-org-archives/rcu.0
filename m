Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435CC4741F
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88CE20727
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kamngtTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJ2U5X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2U5X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 16:57:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B26C0613CF;
        Thu, 29 Oct 2020 13:57:22 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i6so5128240lfd.1;
        Thu, 29 Oct 2020 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tgYhSKMAAApq0oCw/G6+KM7ZmeNwhy01uUadN4Msmr8=;
        b=kamngtTUhEHe6EopfY7xDBXcaztAd12laOvNxT/Pfc5rHqUZsolkVu/ydHV+vBjRe6
         5LNoIdx2UDaj6TpXRuo6saeKCao+Bbs++hJfYzYUTshWOjTO0/Z7E7MqVgWlyyNjIG3u
         zNlzaFu5S3rEwZmukjVLxqZrKe85jp6yqJHbVIPIaMYp4Nef8IP7hNTGmos+prMP9YI5
         Gbaul1fEgVTdiqADoht6gzLJiukJBrE7fCY4opA/qw0TiGOMuPADmRt9+VLKgSkDC3Nu
         /5HXHli6Lk7KAPduNzxqjkP6apKtYAncHK4ggzD93AM3xjGo6a/pJ4riMfZTlE7JBOgm
         Jmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgYhSKMAAApq0oCw/G6+KM7ZmeNwhy01uUadN4Msmr8=;
        b=BaCfwF0zHygt6o9JEM5qMe1/3910YNIsefDZX+9zaRhb3/NIZQGkxkImO25RAAIhdz
         1tu/AVi24gvZE4H8qHnAevX/MMo4aWb0BLHTOur+25IqUcQxLtZ7Z8oGYRd8hnILXjBw
         YoXFdi6wCVqkxq8iCGWkVNvKWUZUxi6O9LIaw5kHQFHK0NHIV/wb6iD5hm5/+l6losf4
         jHWNdPxcFb2KoET/nvZJdNKNX8lFEbtt35CLJM3iy/6+AhFLz5K8EYzUWQjqZsu5QAph
         a5lH7XDDFIYSuEZU6yOOiqSJeIT7Zydr42Zam+aM5SjBYQsbFSEC2Xs/AditJ4qiIZhx
         G14Q==
X-Gm-Message-State: AOAM530q1EEfR/zgSH7blfVsretx+EWdGIyD0ISsqVnmPkpaTmR1Q/nm
        F7jpOnYgXsWsJnedg/gOdis=
X-Google-Smtp-Source: ABdhPJz1HePsbMnzrXaTW5LlatGbQe5A1udz2beATHkR5LAg7o9Xlqff/m0/1Fo4gornOtOrIIvPCQ==
X-Received: by 2002:ac2:4d96:: with SMTP id g22mr479731lfe.335.1604005041061;
        Thu, 29 Oct 2020 13:57:21 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j18sm392987lfh.283.2020.10.29.13.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:57:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 29 Oct 2020 21:57:17 +0100
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org, urezki@gmail.com
Subject: Re: [PATCH 06/16] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
Message-ID: <20201029205717.GA24578@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029165019.14218-6-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 05:50:09PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/pagemap.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c77b7c31b2e4..cbfbe2bcca75 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,9 +204,7 @@ void release_pages(struct page **pages, int nr);
>  static inline int __page_cache_add_speculative(struct page *page, int count)
>  {
>  #ifdef CONFIG_TINY_RCU
> -# ifdef CONFIG_PREEMPT_COUNT
> -	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> -# endif
> +	VM_BUG_ON(preemptible())
>  	/*
>  	 * Preempt must be disabled here - we rely on rcu_read_lock doing
>  	 * this for us.
> -- 
> 2.20.1
> 
Hello, Paul.

Sorry for a small mistake, it was fixed by you before, whereas i took an
old version of the patch that is question. Please use below one instead of
posted one:

Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Sep 14 19:25:00 2020 +0200

    mm/pagemap: Cleanup PREEMPT_COUNT leftovers
    
    CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
    removed. Cleanup the leftovers before doing so.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: linux-mm@kvack.org
    [ paulmck: Fix !SMP build error per kernel test robot feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d..b3d9d9217ea0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -168,9 +168,7 @@ void release_pages(struct page **pages, int nr);
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-       VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+       VM_BUG_ON(preemptible());
        /*
         * Preempt must be disabled here - we rely on rcu_read_lock doing
         * this for us.

--
Vlad Rezki
