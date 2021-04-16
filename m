Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F8C433B4
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 01:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A4661132
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 01:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhDPBKv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 21:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhDPBKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 21:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE466610FA;
        Fri, 16 Apr 2021 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618535426;
        bh=DDPxXNXS/rJP4y5KwGUDxdlz3sVdU3Oosv2avVATV7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dopiHwRImzlmAeHlaRVruHDFBVQCEMPvDy5cnyWBXalL02byJ3FFfbTS56w8bYDkq
         G7AEaMFZ5u65EwANFgpuHPe+WrDxTAiEkeUDtMCjXomnSYKBmZpxL3+kh4AZjDcLL0
         ivp6lgLxqFvpeAACOxy8mY9VlkwbWpc8C0B+BXCC45S4/nemI/rGjXBigqH9SczuYw
         sTrhcWT0S2OQMxGMRg33bfbXhQQHRBGb5wj3GcG3pfGGNwjAdLMdXi+j1VazQsuD1m
         5hCmIsG9odnFJogFHHrI+hCLjtLpSRefjoLX9SZKiENszyCPj+ZglLCCGLt+YskfZI
         argFzXRNY6YFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 901EC5C013E; Thu, 15 Apr 2021 18:10:26 -0700 (PDT)
Date:   Thu, 15 Apr 2021 18:10:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20210416011026.GD4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210415172000.15086-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 15, 2021 at 07:19:55PM +0200, Uladzislau Rezki (Sony) wrote:
> This is a v2 of a small series. See the changelog below:
> 
> V1 -> V2:
> - document the rcu_delay_page_cache_fill_msec parameter;
> - drop the "kvfree_rcu: introduce "flags" variable" patch;
> - reword commit messages;
> - in the patch [1], do not use READ_ONCE() instances in
>   get_cached_bnode()/put_cached_bnode() it is protected
>   by the lock.
> - Capitalize the word following by ":" in commit messages.
> 
> Uladzislau Rezki (Sony) (4):
> [1]  kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
> [2]  kvfree_rcu: Add a bulk-list check when a scheduler is run
> [3]  kvfree_rcu: Update "monitor_todo" once a batch is started
> [4]  kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
> 
> Zhang Qiang (1):
> [5]  kvfree_rcu: Release a page cache under memory pressure

I have queued these, thank you both!  And they pass touch tests, but
could you please check that "git am -3" correctly resolved a couple of
conflicts, one in Documentation/admin-guide/kernel-parameters.txt and
the other in kernel/rcu/tree.c?

						Thanx, Paul

>  .../admin-guide/kernel-parameters.txt         |  5 +
>  kernel/rcu/tree.c                             | 92 +++++++++++++++----
>  2 files changed, 77 insertions(+), 20 deletions(-)
> 
> -- 
> 2.20.1
> 
