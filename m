Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E8C433FE
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiDHPl5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiDHPlz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 11:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FDDE098;
        Fri,  8 Apr 2022 08:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330836201B;
        Fri,  8 Apr 2022 15:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9009C385A3;
        Fri,  8 Apr 2022 15:39:48 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:39:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408113946.056c083e@gandalf.local.home>
In-Reply-To: <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
References: <20220408045734.1158817-1-kaleshsingh@google.com>
        <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 8 Apr 2022 06:21:03 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > +       default !PREEMPT_RT && NR_CPUS <= 32  
> 
> What is the benefit of turning it off on PREEMPT_RT, even if
> PREEMPT_RT does not use expedited GPs much post-boot? I would think in
> the future if PREEMPT_RT ever uses expedited GPs, they would want this
> feature even more. I'd rather be future-proof now as I don't see any
> advantages of disabling it on !PREEMPT_RT (And a drawback that the fix
> won't apply to those systems). Also will keep the config simple.

The default kthread priority is 1. This should not affect PREEMPT_RT, as
PREEMPT_RT users are usually more concerned by the performance of their
higher priority tasks. Priority 1 is not considered an issue.

I do not see why PREEMPT_RT is special here. Why was it singled out?

-- Steve
