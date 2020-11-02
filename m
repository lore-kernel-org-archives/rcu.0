Return-Path: <SRS0=CE9U=EI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D86C388F2
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4A8223AB
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HdJsWBmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4BqOPjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKBPmT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBPmT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Nov 2020 10:42:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BEC0617A6
        for <rcu@vger.kernel.org>; Mon,  2 Nov 2020 07:42:19 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:42:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604331737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdWNl/+7K9bqNDtlrQ32c0pCdOzYiGFpqwyuHl/4L6s=;
        b=HdJsWBmzmY5oTtrGJaY21diXmg1yRy2xMtPXyuQPqTMva0guttVak0PrKgr+drdYKaNJfi
        wK+72fd6u0W2J40VFcz1UQbO94om9ZdDbl9Xi6dzaeD14i4DjlgMLlzCdU7Ea4qNlLIQci
        CuSAHOUNToTlzA5D56VMxTa7ZpZ+K9odk+444dHcY+wjUR+qIh9+xaeJzp1vKnzbbA5YHK
        /Q1Bp2B07z2V9g94mdAMTLIeVAfEARzcvD5orufoIahLcw4nfjV5mkL8cAKf3+omwPcNVp
        3HOOOVsUIyLqiIPdeSMlMls876fsLc+E1xVc7//7QZ7SM85IvaJtTYyNq0rtXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604331737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdWNl/+7K9bqNDtlrQ32c0pCdOzYiGFpqwyuHl/4L6s=;
        b=p4BqOPjt25khan6ajbQJEHH/z01rgCy0Y/E1H7I3RZHUWfyNFvdIVrBwoPVTmjFIEQh5JL
        ck89AEyvI3uew7DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RCU stall uses try_invoke_on_locked_down_task() with disabled
 interrupts
Message-ID: <20201102154215.ejbkk33fvme45kyt@linutronix.de>
References: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
 <20201030140032.GS3249@paulmck-ThinkPad-P72>
 <20201030171537.ichx22kn3omioilx@linutronix.de>
 <20201102145326.GX3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102145326.GX3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-11-02 06:53:26 [-0800], Paul E. McKenney wrote:
> If you supply your Tested-by, I will give it a shot.

I pulled that commit into into v5.10-rc1-rt2 after I run into the
reported splat because I forgot to end the RCU read section I started.
So it was easy to reproduce and the patch fixed the lockdep related
backtrace. So

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> 							Thanx, Paul

Sebastian
