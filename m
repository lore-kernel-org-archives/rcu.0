Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49C3C388F9
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE021D7B
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444195AbgJUPy5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444194AbgJUPy4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 11:54:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269C32177B;
        Wed, 21 Oct 2020 15:54:54 +0000 (UTC)
Date:   Wed, 21 Oct 2020 11:54:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, guoren@kernel.org, atishp@atishpatra.org,
        mhiramat@kernel.org, greentime.hu@sifive.com,
        colin.king@canonical.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
Message-ID: <20201021115451.44424566@gandalf.local.home>
In-Reply-To: <20201021154456.GM3249@paulmck-ThinkPad-P72>
References: <20201021073839.43935-1-zong.li@sifive.com>
        <20201021101216.4d840e15@gandalf.local.home>
        <20201021101522.3d1f3865@gandalf.local.home>
        <20201021154456.GM3249@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 21 Oct 2020 08:44:56 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:


> Or let me know if you would like me to take it, target v5.11.

I'm not sure if these can wait, as I believe they are fixing a regression
with RISCV function tracing.

Probably best to have them go through the RISCV tree.

-- Steve

