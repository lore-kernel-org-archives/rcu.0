Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D66C433ED
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3541F611BD
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhETWZc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhETWZc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 18:25:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360AC061761
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 15:24:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y15so2046522pfn.13
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CHwuBMgkdhVe0iejtZCF6OX+NC1qkDJM2YShYg1AeY=;
        b=MdI29En2NqSGimN2eeG11GdauAY+kEOd+XqPwJ9rgsfX1vhF11ZxG0nzXU/19a0cJq
         ex/mv6EINVnTf9W6frfJSKhNuP8RCXqLgtudEl/6BULyY5e9ux6v9xEErpbZTRkJ6DG8
         id9AS4+KAtLrp7JO8yR0Z6MFGI0E9p56A8mG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CHwuBMgkdhVe0iejtZCF6OX+NC1qkDJM2YShYg1AeY=;
        b=oU7TIZuENJuoMoKrXehm96JUOyagorRMHEhNsJfpVo+Nr7OJ9Y0KfSq+jG0E5oqz/d
         3nko8m4MqZQrXaNZaj4UWvJcVmpgGop86Cwohuz9dsoA660sZsnSIqT7Qz+54I5zBYbr
         tT1YTXHNosp8RaHDnL60fjNbxwbq+95+rM0eHV9VW9AC+zmTjFxwg4tTV7UW+NubWLNI
         vFRXKnyPmzhYACNp2T6I75qSc4UY2Pw2Dra7L6GujrjB5LFuYdA8+PvbAmt0tfvWSPYQ
         q7xIpas+TfPv/RCOfHyukAsBygd9PyQmj28CTA1jvoTs3AJziwzKcgG/8jDlzrAD1WkK
         63Pg==
X-Gm-Message-State: AOAM532jrn8NPnmXd8hscmIXq9Yv3uBZ4C0zvwjSx4ORqNKgO1hOinOY
        efBIqo9/SOHXIX1GIsrqk/cOOw==
X-Google-Smtp-Source: ABdhPJyMEcqqutfjE2EyqFktXmv7TaIuNRK4nX8yiAVasgSv4Uf8NvA3xpDEwGaUHH5lfkf4RDWI0A==
X-Received: by 2002:a63:4c41:: with SMTP id m1mr6526173pgl.394.1621549449109;
        Thu, 20 May 2021 15:24:09 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id j27sm2913274pgb.54.2021.05.20.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 15:24:08 -0700 (PDT)
Date:   Fri, 21 May 2021 07:24:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKbhg30Q6YlerCoz@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
 <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/20 07:53), Paul E. McKenney wrote:
> On Thu, May 20, 2021 at 03:18:07PM +0900, Sergey Senozhatsky wrote:
> > On (21/05/18 16:15), Paul E. McKenney wrote:
> > > 
> > > In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> > > guest migration and debugger breakpoints, correct?  Either way, I am
> > > wondering if rcu_cpu_stall_reset() should take a lighter touch.  Right
> > > now, it effectively disables all stalls for the current grace period.
> > > Why not make it restart the stall timeout when the stoppage is detected?
> > 
> > rcu_cpu_stall_reset() is used in many other places, not sure if we can
> > change its behaviour rcu_cpu_stall_reset().
> 
> There was some use case back in the day where they wanted an indefinite
> suppression of RCU CPU stall warnings for the current grace period, but
> all the current use cases look fine with restarting the stall timeout.
> 
> However, please see below.
> 
> > Maybe it'll be possible to just stop calling it from PV-clock and do
> > something like this
> 
> This was in fact one of the things I was considering, at least until
> I convinced myself that I needed to ask some questions.
> 
> One point of possibly unnecessary nervousness on my part is resetting
> the start of the grace period, which might confuse diagnostics.
> 
> But how about something like this?
> 
> void rcu_cpu_stall_reset(void)
> {
> 	WRITE_ONCE(rcu_state.jiffies_stall,
> 		   jiffies + rcu_jiffies_till_stall_check());
> }
> 
> Would something like that work?

This should work.

On a side note.

I wish we didn't have to put kvm_check_and_clear_guest_paused() all
over the place.

We do load jiffies at the start of check_cpu_stall(). So, in theory,
we can just use that captured jiffies (which can become obsolete but
so will grace period timestamps) value and never read current system
jiffies because they can jump way forward. IOW

	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;

instead of

	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;

Then we probably can remove kvm_check_and_clear_guest_paused().

But that "don't load current jiffies" is rather fragile.

kvm_check_and_clear_guest_paused() is not pretty, but at least it's
explicit.

---

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 49dda86a0e84..24f749bc1f90 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -695,19 +695,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
-	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
 	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
@@ -717,14 +709,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
