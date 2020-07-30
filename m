Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D12C433DF
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0002082E
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 12:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qKj3QG0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgG3Mxv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgG3Mxu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 08:53:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337CCC061794
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 05:53:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so17064393qto.3
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Axn2UqhWLSVFHKSnfRxdouhha5NVgiK5lnLse6I8u/A=;
        b=qKj3QG0jwvFT0NZqDejQIs9lBvfAq1rwCAK66yjilxPi02Gftmljq9/TtWuJSUrTdf
         0A5FsV1qzVsnazzVipjEF8aL3obfFIwsE6upFp4Gpec60UDOSzb1IsgyZZ46ujTxIn9o
         jDVf3LcgHaggfl5lPv0biDPFrN9viSMQtusPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Axn2UqhWLSVFHKSnfRxdouhha5NVgiK5lnLse6I8u/A=;
        b=jeWwO10E7Qkrh3/CQ+0f6WcApk5akrwbMqSRP5lJ+rf6wE9JlEHSBn1nxRV4lV259p
         3BnoXy+2+50/3CrctB6LDzmNh+pfRnKNCojNOKFij4Txs7OhpZhQo09OKmYD4oTkLPeW
         KpqmbKiSWhztQhfG2fa5IRwxX9WqRzyirvLi7hb/kTsDXIljA8cyJxF8i1I63aCBBkzH
         iQctBzXui2QC9eYtHMXz/4v0v8FXfpAwacUWi7RdG4TPknLIuzdeqXaHU5+HScbiuyEW
         Sx4XlGXf24ueHFzRirsfXd/wLskRmzALQmUJgHwnqJoXbV50sIX6X/u0jDQlMCsMjDba
         w6qQ==
X-Gm-Message-State: AOAM532eZhXwpZaYmaf4qNYdVOK50AJCHDnnLzhRH4NJ4Sdh+NbZhJbK
        U1eAuSIkLccQxUxZZeEATQW5NA==
X-Google-Smtp-Source: ABdhPJwbJddY2ae4n72jMCi/8IovQDNd2woE1dqvSEGMExUQGBjQpyx1XNeAtFII7RIAYjVw1ykbwQ==
X-Received: by 2002:ac8:7741:: with SMTP id g1mr2701917qtu.28.1596113629333;
        Thu, 30 Jul 2020 05:53:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 205sm4166584qkn.104.2020.07.30.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 05:53:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 08:53:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200730125348.GA2074029@google.com>
References: <20200727211012.30948-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727211012.30948-1-urezki@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 27, 2020 at 11:10:12PM +0200, Uladzislau Rezki (Sony) wrote:
> If the kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING
> option, the lockedp will complain about violation of the
> nesting rules:
> 
> <snip>
> [   28.060389] =============================
> [   28.060389] [ BUG: Invalid wait context ]
> [   28.060389] 5.8.0-rc3-rcu #211 Tainted: G            E
> [   28.060389] -----------------------------
> [   28.060390] vmalloc_test/0/523 is trying to lock:
> [   28.060390] ffff96df7ffe0228 (&zone->lock){-.-.}-{3:3}, at: get_page_from_freelist+0xcf0/0x16d0
> [   28.060391] other info that might help us debug this:
> [   28.060391] context-{5:5}
> [   28.060392] 2 locks held by vmalloc_test/0/523:
> [   28.060392]  #0: ffffffffc06750d0 (prepare_for_test_rwsem){++++}-{4:4}, at: test_func+0x76/0x240 [test_vmalloc]
> [   28.060393]  #1: ffff96df5fa1d390 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x5c/0x230
> [   28.060395] stack backtrace:
> [   28.060395] CPU: 0 PID: 523 Comm: vmalloc_test/0 Tainted: G            E     5.8.0-rc3-rcu #211
> [   28.060395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   28.060396] Call Trace:
> [   28.060397]  dump_stack+0x96/0xd0
> [   28.060397]  __lock_acquire.cold.65+0x166/0x2d7
> [   28.060398]  ? find_held_lock+0x2d/0x90
> [   28.060399]  lock_acquire+0xad/0x370
> [   28.060400]  ? get_page_from_freelist+0xcf0/0x16d0
> [   28.060401]  ? mark_held_locks+0x48/0x70
> [   28.060402]  _raw_spin_lock+0x25/0x30
> [   28.060403]  ? get_page_from_freelist+0xcf0/0x16d0
> [   28.060404]  get_page_from_freelist+0xcf0/0x16d0
> [   28.060405]  ? __lock_acquire+0x3ee/0x1b90
> [   28.060407]  __alloc_pages_nodemask+0x16a/0x3a0
> [   28.060408]  __get_free_pages+0xd/0x30
> [   28.060409]  kvfree_call_rcu+0x18a/0x230
> <snip>
> 
> Internally the kfree_rcu() uses raw_spinlock_t whereas the
> page allocator internally deals with spinlock_t to access
> to its zones.
> 
> In order to prevent such vialation that is in question we
> can drop the internal raw_spinlock_t before entering to
> the page allocaor.
> 
> Short changelog (v1 -> v2):
>     - rework the commit message;
>     - rework the patch making it smaller;
>     - add more comments.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21c2fa5bd8c3..2de112404121 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3287,6 +3287,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  		return false;
>  
>  	lockdep_assert_held(&krcp->lock);
> +	lockdep_assert_irqs_disabled();
> +
>  	idx = !!is_vmalloc_addr(ptr);
>  
>  	/* Check if a new block is required. */
> @@ -3306,6 +3308,29 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  				return false;
>  
> +			/*
> +			 * If built with CONFIG_PROVE_RAW_LOCK_NESTING option,
> +			 * the lockedp will complain about violation of the
> +			 * nesting rules. It does the raw_spinlock vs. spinlock
> +			 * nesting checks.
> +			 *
> +			 * That is why we drop the raw lock. Please note IRQs are
> +			 * still disabled it guarantees that the "current" stays
> +			 * on the same CPU later on when the raw lock is taken
> +			 * back.
> +			 *
> +			 * It is important because if the page allocator is invoked
> +			 * in fully preemptible context, it can be that we get a page
> +			 * but end up on another CPU. That another CPU might not need
> +			 * a page because of having some extra spots in its internal
> +			 * array for pointer collecting. Staying on same CPU eliminates
> +			 * described issue.
> +			 *
> +			 * Dropping the lock also reduces the critical section by
> +			 * the time taken by the page allocator to obtain a page.
> +			 */
> +			raw_spin_unlock(&krcp->lock);
> +
>  			/*
>  			 * NOTE: For one argument of kvfree_rcu() we can
>  			 * drop the lock and get the page in sleepable
> @@ -3315,6 +3340,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  			 */
>  			bnode = (struct kvfree_rcu_bulk_data *)
>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
> +			raw_spin_lock(&krcp->lock);

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  		}
>  
>  		/* Switch to emergency path. */
> -- 
> 2.20.1
> 
