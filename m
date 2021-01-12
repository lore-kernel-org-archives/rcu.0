Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3410C433DB
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809D7230FC
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 17:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbhALRvh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbhALRvh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jan 2021 12:51:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 224CC222F9;
        Tue, 12 Jan 2021 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610473856;
        bh=xdBUPFjlzytUuhyT0O7C8PJlI1bRIAh9KpxfnJ9siDI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EjgINcyt9c5d/2opD9jzsy/mprfu0QmtXYcJwYDTbFJrp7VokjEmpvSOQPdXvcjyd
         TQAMro0dNyX1uFHziLX4WfhNTq687uxvXGZYyab0ryrAb6/j1fMs94BxNKS+8IoanX
         hHQn/6tJcyOtvFKdlyLR4/1r3QNfDIIP2/17KxdWSy1nUlglLEH5xhulMEl7uTKnMo
         1ik7WsbQTDpS5TTpfvwxH63Q/E1G8xtvenP+XGH9JHH8xA/aTfs7rONplfip/XvPae
         cK1EMZezsEUbyQIxV5SaACWn70eXGdYH32bCGMReBIMu+DlUkrWILou3w5JsbBLTf9
         45HbFp6m8N1eg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E1CAD3522AC3; Tue, 12 Jan 2021 09:50:55 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:50:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     340442286@qq.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: remove surplus instrumentation_end in rcu_nmi_enter
Message-ID: <20210112175055.GI2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210111010859.7778-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111010859.7778-1-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 11, 2021 at 09:08:59AM +0800, Zhouyi Zhou wrote:
> In function rcu_nmi_enter, there is a surplus instrumentation_end
> in second branch of if statement, although objtool check -f vmlinux.o will
> not complain because of its inability to correctly cover all cases
> (objtool will visit the third branch first, which markes
>  following trace_rcu_dyntick as visited), I think remove the surplus
> instrumentation_end will make the code better.
> 
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good catch, applied, thank you!  As usual, I edited a bit, so please
check below to see if I messed anything up.

I did add Neeraj Upadhyay's Reported-by because he noted this, though you
beat him with a public posting, though mostly because I asked him whether
he could make this happen.  I also added the Fixes, but could you please
do that in the future?  You can use "git blame" or either "git log" and
"gitk" with appropriate options to find the offending commit.

							Thanx, Paul

------------------------------------------------------------------------

commit 3f91ff7fd4f76e7eb48bad79666c466bc3530324
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon Jan 11 09:08:59 2021 +0800

    rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
    
    In rcu_nmi_enter(), there is an erroneous instrumentation_end() in the
    second branch of the "if" statement.  Oddly enough, "objtool check -f
    vmlinux.o" fails to complain because it is unable to correctly cover
    all cases.  Instead, objtool visits the third branch first, which marks
    following trace_rcu_dyntick() as visited.  This commit therefore removes
    the spurious instrumentation_end().
    
    Fixes: 04b25a495bd6 ("rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr")
    Reported-by Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63c6dba..e04e336 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1050,7 +1050,6 @@ noinstr void rcu_nmi_enter(void)
 	} else if (!in_nmi()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
-		instrumentation_end();
 	} else  {
 		instrumentation_begin();
 	}
