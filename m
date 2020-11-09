Return-Path: <SRS0=VCsE=EP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F2C2D0A3
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB981206CB
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcGdbeqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgKIMXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIMXj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Nov 2020 07:23:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF2C0613D3;
        Mon,  9 Nov 2020 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hElt3BjZoDAKcnNC0PKLQXKgb0IojHcRSCI9KVMCbJE=; b=QcGdbeqEhJuP4IMcgPzq4ULOLA
        BcgcuzO2xpaizHtmebW/NoCpFu/f/ZroWP//nQihcnQqEeQu09TThmJM1e3RQNhdkwEcQy30GI9mc
        ozGMfcKVC6FaZMsvEN9fl4fUrLiGmfmCBUskgxiYYWHKPdN9t/ZHr2DpGPWe1uQG1zOKfRbq/C1F0
        KGTF5HgEyFBKX20RrmtnvLtUOEtCu5g8mO6/LbaGCrWQY87L0GojFUPoCdE8PYJjX0p65qc57X18B
        SNV+f8Ic47P+iNDNKlfTve6WAVb2cUsy8ST+pOlgSaT4IaO1yeg1TG3Dc73qcV3UyrczlUYJ6hFEG
        gpklj7MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc6Cd-0001Gf-9V; Mon, 09 Nov 2020 12:23:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC957306102;
        Mon,  9 Nov 2020 13:23:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8ACC203C5334; Mon,  9 Nov 2020 13:23:17 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:23:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements
 with a bit about design
Message-ID: <20201109122317.GM2594@hirez.programming.kicks-ass.net>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105230510.18660-2-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 05, 2020 at 03:05:08PM -0800, paulmck@kernel.org wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> The rcu_barrier() section of the "Hotplug CPU" section discusses
> deadlocks, however the description of deadlocks other than those involving
> rcu_barrier() is rather incomplete.
> 
> This commit therefore continues the section by describing how RCU's
> design handles CPU hotplug in a deadlock-free way.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 1ae79a1..98557fe 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
>  to allow the various kernel subsystems (including RCU) to respond
>  appropriately to a given CPU-hotplug operation. Most RCU operations may
>  be invoked from CPU-hotplug notifiers, including even synchronous
> -grace-period operations such as ``synchronize_rcu()`` and
> -``synchronize_rcu_expedited()``.

I was under the impression that this rst crap now recognises func() and
you no longer need to make the text unreadable with "``".
