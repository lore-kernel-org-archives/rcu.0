Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED1C433B4
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC4F6112F
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 00:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhETAzt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 May 2021 20:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETAzt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 May 2021 20:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 862E66112F;
        Thu, 20 May 2021 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621472069;
        bh=hjBeTHSzYWy9v1O+Drq6tKItvMTUDsuzqft2T93yh/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcPXE4oJCXN8wUgdzQCnvMIF14P6mGM1yvqwN34pV2v0+RfT4UHLYYUBvDwxwqJEf
         lurNjwszb5qyPQCXqVnwi+nTX7Q1r/Aj2j7EywjdejDiRvXVUXHfDqScA39jsS7fVw
         Ch94wTg81i64g7V7otRDUMtU18QgPnkZ6I1naxgF77TMZcfQ+dmlZ16TRFTy/a4pFB
         pMjmlrRSpnhFdigfh7w1D5zhAmEz01UHcVmmZtlABnkKhxWwMnYoWDYqbaiKBVV5OL
         TjnnplvzU/MzCNLrXcI+vti2L6YSWDIbehfwZgJFmk+5SVZMWlCnPGJJjOdsKdUxg/
         U7vGhA8HuFs2w==
Date:   Thu, 20 May 2021 02:54:26 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu: Assume rcu_report_dead() always deals with
 local CPU
Message-ID: <20210520005426.GB22836@lothringen>
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-4-frederic@kernel.org>
 <20210519185107.GB4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519185107.GB4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 19, 2021 at 11:51:07AM -0700, Paul E. McKenney wrote:
> On Wed, May 19, 2021 at 02:09:30AM +0200, Frederic Weisbecker wrote:
> > rcu_report_dead() is always called locally from the idle path. Passing
> > a CPU number to it suggests otherwise and is rather error-prone as the
> > code inside relies on locality.
> > 
> > Robustify the function prototype and refine the name along the way.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Makes a lot of sense, thank you!
> 
> On the function name, here is the list:
> 
> int rcutree_prepare_cpu(unsigned int cpu) -- notifier from any CPU.
> void rcu_cpu_starting(unsigned int cpu) -- direct call on incoming CPU.
> int rcutree_online_cpu(unsigned int cpu) -- notifier from any CPU.
> 
> int rcutree_offline_cpu(unsigned int cpu) -- notifier from any CPU.
> void rcu_report_dead(unsigned int cpu) -- direct call on outgoing CPU.
> void rcutree_migrate_callbacks(int cpu) -- direct call from surviving CPU.
> int rcutree_dead_cpu(unsigned int cpu) -- notifier from any CPU.
> 
> Note that rcu_report_dead() can also be invoked from cpu_die_early() on
> other CPU when onlining a CPU fails.  This happens on arm64.  Which might
> be an arm64 bug, but unless I am missing something it is a case where
> rcu_report_dead() is called non-locally.

Hmm, I see it only called with smp_processor_id() from cpu_die_early().

> 
> And the naming is currently a bit random, isn't it?  :-/
> 
> Maybe rcutree_*_cpu() if there is a CPU parameter and rcutree_*_self()
> if all calls run on the CPU in question?

Makes sense. Or rcutree_*_curr_cpu() but it's going to produce long names.


> I cannot immediately think of a reason to make names reflect whether
> the corresponding functions are directly called or are called via notifier.
> Thoughts?

No indeed, let's wait for some convention to ever emerge :)

Thanks!
