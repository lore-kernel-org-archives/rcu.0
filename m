Return-Path: <SRS0=2gH0=EF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF3C4741F
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BA92075E
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUGtr43Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxxnqrTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3RPl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJ3RPk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Oct 2020 13:15:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84ADC0613CF
        for <rcu@vger.kernel.org>; Fri, 30 Oct 2020 10:15:40 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:15:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604078139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTRPSVlfANRIG9iTMYMieq/gc3fkliz+/6TLTcLWjBY=;
        b=CUGtr43QgiJgIYb06P7KlwFqrfRF+dcFFowptOgnTgWOctGy/TDr3Zo70rKBuO/Rirat/s
        4uxmUG4iKjC2Mf5Kix48VI3DRlbO88qcrNn1A77TOq5tiDVcK7tFygco8bKekzEgqILGFS
        kjbJyZi14cAelb7xqviQe8jYLt9GE25ErEr9B+2lBtsb+UESQMo8XomGx4vIkAmTklB5by
        V6ZLcIdF4RVdO3xsv0SZRXFRG8NKBb7QekopyEmLGIhn5Z1ZZ2wTz3VlITZS8qcCCxu16C
        d712nx7STcX4TSg5yntoIQXESAhiSk54azPVhHpGMwg2hnZx267AjiIcPUaiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604078139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTRPSVlfANRIG9iTMYMieq/gc3fkliz+/6TLTcLWjBY=;
        b=BxxnqrTiA7/IlaVEBhNamY4743y5ZU5RVb+bf7BX2RQndvFqRC0HUIAcIhWmKHTSmSRybn
        6d5VScBLABtZDxCg==
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
Message-ID: <20201030171537.ichx22kn3omioilx@linutronix.de>
References: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
 <20201030140032.GS3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030140032.GS3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-10-30 07:00:32 [-0700], Paul E. McKenney wrote:
> Is this fixed by the following commit 8a26c219cafe ("rcu: Don't invoke
> try_invoke_on_locked_down_task() with irqs disabled")?

Yes, thank you.

> If so, apologies, I failed to make the -rcu tree's for-v5.11 commits
> visible to -next until quite recently.  :-/

Since it affects v5.10-rc1, wouldn't it qualify to be applied now?

> 							Thanx, Paul
> 

Sebastian
