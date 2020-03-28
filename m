Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC544C43331
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 23:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43320748
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585438988;
	bh=8F71ls7LTfaSvQwEnfaxYVz5lj1N1vsQKt2LOAk29EQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hzXOFGRyaVe60YSIg2cil3iSJXLaDS5Odvg10p11Ewwk8QtMgWLeP8YeIKkaMLD8Y
	 yTTbkxvqn38Xkk9NNq4zGzB8VHnuTCp10fJWw4mbxNRzc8fiWbfAzy7wURhlWEabFq
	 ZzDXzG8eoJET2gJ1XFYJlbzeP9IJHa21c32gfTAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgC1XnI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1XnH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 19:43:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1555920716;
        Sat, 28 Mar 2020 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585438987;
        bh=8F71ls7LTfaSvQwEnfaxYVz5lj1N1vsQKt2LOAk29EQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zWqeW4Byiv022nOtsnEbub+KQiNfiX4TOzaJ6hxmErzytUkabLE/2P9exka8iqCHN
         SPWVGFClHCkP6cjo2UcQfAb4cdsKf5ARgo/kGQ85eNQiQfjuLkDAcwW8laqylZYJT/
         RtS8GRPH5BHMybeHXQD3p4LJAjcsBwZ04ud9Bpac=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 979A83522755; Sat, 28 Mar 2020 16:43:06 -0700 (PDT)
Date:   Sat, 28 Mar 2020 16:43:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v2 0/4] RCU dyntick nesting counter cleanups
Message-ID: <20200328234306.GC19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200328221703.48171-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328221703.48171-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 28, 2020 at 06:16:59PM -0400, Joel Fernandes (Google) wrote:
> These patches clean up the usage of dynticks nesting counters simplifying the
> code, while preserving the usecases.
> 
> It is a much needed simplification, makes the code less confusing, and prevents
> future bugs such as those that arise from forgetting that the
> dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> common situations.
> 
> rcutorture testing with all TREE RCU configurations succeed with
> CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.

Heh!  We now have a three-way collision between Thomas's and Peter's
series, the RCU Tasks Trace series, and this series.  ;-)

Remind me once v5.7-rc1 comes out and let's see what fits where.

							Thanx, Paul

> v1->v2:
> - Rebase on v5.6-rc6
> 
> Joel Fernandes (Google) (4):
> Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
> ->dynticks counter")
> rcu/tree: Add better tracing for dyntick-idle
> rcu/tree: Clean up dynticks counter usage
> rcu/tree: Remove dynticks_nmi_nesting counter
> 
> .../Data-Structures/Data-Structures.rst       |  31 +--
> Documentation/RCU/stallwarn.txt               |   6 +-
> include/linux/rcutiny.h                       |   3 -
> include/trace/events/rcu.h                    |  29 +--
> kernel/rcu/rcu.h                              |   4 -
> kernel/rcu/tree.c                             | 188 +++++++-----------
> kernel/rcu/tree.h                             |   4 +-
> kernel/rcu/tree_stall.h                       |   4 +-
> 8 files changed, 105 insertions(+), 164 deletions(-)
> 
> --
> 2.26.0.rc2.310.g2932bb562d-goog
> 
