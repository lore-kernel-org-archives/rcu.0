Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C6EC43334
	for <rcu@archiver.kernel.org>; Mon, 27 Jun 2022 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiF0WE1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiF0WD1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jun 2022 18:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A91EC7C;
        Mon, 27 Jun 2022 15:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 531A560EC2;
        Mon, 27 Jun 2022 22:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0E1C34115;
        Mon, 27 Jun 2022 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656367328;
        bh=3y+4OUbLcC0/yZPll44HqMz1xr/6OTXCkUJnS1fTw/A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J3ajaKZMSj3Cuwt9hX6EvdU+h/E7LCwiFe2zCO3IdtzIhbM0jGZndYa05szBelTnc
         gBk7wLECxK6jA0lJ8iKdZOOUgCoyTJ1W9NlljBTjk4cXZ4bmOaOoLICZyHAVyXA/NS
         QyeyX+u3zWacxSBFv8I+6DFqvPdwCV4FAd2O7ucEBh7TOggbZC3G2g8aTZzzl9Pf0g
         4qACbJ4yPjbNPGlHy9pInTwo2qnKZnmsqzAM4bIZLrFUVTax4NYRc5by5OzlqMWMDn
         rCu1qtxrkl5CMhwhjDhkvyJTAf15vWC/kmovQBR9CFaaYtWdgpDNgp14jAhSQZxeeB
         1MGRYHWq858dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 530CE5C04B1; Mon, 27 Jun 2022 15:02:07 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:02:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Update rcu_preempt_deferred_qs() comments for no
 preemptible RCU
Message-ID: <20220627220207.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620064224.2630382-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620064224.2630382-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 20, 2022 at 02:42:24PM +0800, Zqiang wrote:
> For no preemptible RCU, the rcu_preempt_deferred_qs() only report
> expedited QS state of current CPU, since preemption does not occur
> in RCU critical sections, there are no tasks insert to leaf rnp
> blocked-tasks list, that is to say the tasks structure's ->rcu_blocked_node
> and the leaf rnp structure's  ->blkd_tasks are always empty.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch -- that comment is quite misleading.

Is the wordsmithed version shown below OK?

							Thanx, Paul

------------------------------------------------------------------------

commit 5ddf65777c8d0f60ff9137eef3b23dd4c77e6108
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Jun 20 14:42:24 2022 +0800

    rcu: Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels
    
    In non-premptible kernels, tasks never do context switches within
    RCU read-side critical sections.  Therefore, in such kernels, each
    leaf rcu_node structure's ->blkd_tasks list will always be empty.
    The comment on the non-preemptible version of rcu_preempt_deferred_qs()
    confuses this point, so this commit therefore fixes it.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 86772c95ed0ae..4152816dd29f6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -932,10 +932,13 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 
-// Except that we do need to respond to a request by an expedited grace
-// period for a quiescent state from this CPU.  Note that requests from
-// tasks are handled when removing the task from the blocked-tasks list
-// below.
+// Except that we do need to respond to a request by an expedited
+// grace period for a quiescent state from this CPU.  Note that in
+// non-preemptible kernels, there can be no context switches within RCU
+// read-side critical sections, which in turn means that the leaf rcu_node
+// structure's blocked-tasks list is always empty.  is therefore no need to
+// actually check it.  Instead, a quiescent state from this CPU suffices,
+// and this function is only called from such a quiescent state.
 notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
