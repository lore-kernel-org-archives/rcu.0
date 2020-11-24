Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B77FC56202
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6442068D
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgKXUcx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbgKXUcx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Nov 2020 15:32:53 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C409620678;
        Tue, 24 Nov 2020 20:32:47 +0000 (UTC)
Date:   Tue, 24 Nov 2020 15:32:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org, boqun.feng@gmail.com,
        tglx@linutronix.de
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201124153245.5bda420d@oasis.local.home>
In-Reply-To: <20201124194308.GC8957@C02TD0UTHF1T.local>
References: <20201119170259.GA2134472@elver.google.com>
        <20201119184854.GY1437@paulmck-ThinkPad-P72>
        <20201119193819.GA2601289@elver.google.com>
        <20201119213512.GB1437@paulmck-ThinkPad-P72>
        <20201119225352.GA5251@willie-the-truck>
        <20201120103031.GB2328@C02TD0UTHF1T.local>
        <20201120140332.GA3120165@elver.google.com>
        <20201123193241.GA45639@C02TD0UTHF1T.local>
        <20201124140310.GA811510@elver.google.com>
        <20201124150146.GH1437@paulmck-ThinkPad-P72>
        <20201124194308.GC8957@C02TD0UTHF1T.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 24 Nov 2020 19:43:08 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> AFAICT, the issue is that arch_cpu_idle() can be dynamically traced with
> ftrace, and hence the tracing code can unexpectedly run without RCU
> watching. Since that's dynamic tracing, we can avoid it by marking
> arch_cpu_idle() and friends as noinstr.

Technically, ftrace doesn't care if RCU is watching or not, but the
callbacks might, and they need to do the rcu_is_watching() check if
they do.

Although, there's work to keep those areas from being traced, but to do
so, they really need to be minimal, where you don't ever want to trace
them.

-- Steve
