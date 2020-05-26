Return-Path: <SRS0=yR10=7I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6AC433DF
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1ED2073B
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgEZQcO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 May 2020 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbgEZQcN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 May 2020 12:32:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEBFC03E96D;
        Tue, 26 May 2020 09:32:13 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdcUN-0006VB-5r; Tue, 26 May 2020 18:31:39 +0200
Date:   Tue, 26 May 2020 18:31:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH] srcu: Avoid local_irq_save() before acquiring spinlock_t
Message-ID: <20200526163139.frcfbomohqocuvme@linutronix.de>
References: <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
 <20200524190356.eqohmrmbilonm4u7@linutronix.de>
 <20200525032717.GV2869@paulmck-ThinkPad-P72>
 <20200526134134.5uq62linhbog43q3@linutronix.de>
 <20200526161609.GJ2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526161609.GJ2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-05-26 09:16:09 [-0700], Paul E. McKenney wrote:
> Queued, thank you!!!
thank you.

> 							Thanx, Paul

Sebastian
