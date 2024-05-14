Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939D1E487;
	Tue, 14 May 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698481; cv=none; b=mHoNvTulEG0w/XkT7E9WPK2JSd5CTpQ2C9T+JEHRqEGYvt8qKPgVCJZ+/WVcO8US8YxsIVj2hHf4Vqteu6OaD/NZrs0ZxmKqu9vp+H4IwvEHN4eesLGzdka1o5qrfP5liaeI49KQ1nbCE8yZBHqX/vzdekVw51EvX7jtwPip0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698481; c=relaxed/simple;
	bh=HOwIRMzpnJvkClQKoEnwY3A/tf2uA45b0gQU7xVPuLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/unLr5S6+CH8FjQexKx7id4h88oIRMskKBvzxh6vAaAJxMv1XGTrfut1UPJItOem5tO0Pj7lYYdXuH08biF+n9/hVMcqIv4w8M4hr4KRA61z8DfxmcOVIAwwagEp32GefXAoWiiM5YIZJhXkzZfeSrCMQuyG5wUPGYPS7d0pM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbxi77x7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbxi77x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36722C2BD10;
	Tue, 14 May 2024 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715698481;
	bh=HOwIRMzpnJvkClQKoEnwY3A/tf2uA45b0gQU7xVPuLo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dbxi77x7ysfb1XlxjZ53exVbupkB1lKBKAGyu5gPCO+gWdO0IPJ9g3nBOuXlP4KJ1
	 ORTA3QQZSrD5VGgCSxRcJfFaKJo755kYtoyXWPSCIWnv0y9QdVowQK3mCd0S8Yjnln
	 hq5nHXaFmz2o7sGYePrcmE281Ct+pxTWqPmM8bOzd285Ei+4vLlk2zgRtodj3L8YOC
	 CYv2otGNxgulmhMO87qhCi2UK5WzRvD/rPUWpFbWccVimxxZq2vQo2f2g2KzDLNCQv
	 v7FmKqwIkbM8xypuOi2KRAQ5NtdfdFuB8EpYhD7tsjaZ5j/aJCC1jvk/eGBlGl4ath
	 reRyX8aZAT8WQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98CA7CE0443; Tue, 14 May 2024 07:54:40 -0700 (PDT)
Date: Tue, 14 May 2024 07:54:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix using smp_processor_id() in preemptible
 warning
Message-ID: <d2a9a579-ffcf-4812-a857-2f091f7c65b5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240509074046.15629-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509074046.15629-1-qiang.zhang1211@gmail.com>

On Thu, May 09, 2024 at 03:40:46PM +0800, Zqiang wrote:
> Currently, the this_cpu_ptr(&rcu_data) in rcu_rdp_is_offloaded() is called
> before the condition "!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())"
> is checked, and occurs in preemptible task context, this will trigger the
> following warning.
> 
> [ 4.106221][ T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.108547][ T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [ 4.109667][ T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 4.111064][ T18] Call Trace:
> [ 4.111064][ T18]  <TASK>
> [ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.111064][ T18] kthread (kernel/kthread.c:388)
> [ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 4.111064][ T18]  </TASK>
> 
> This commit fix this warning by priority check the condition 
> "!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())" , to
> ensure whether the this_cpu_ptr(&rcu_data) can be executed in
> rcu_rdp_is_offloaded().
> 
> Fixes: 8feeeba60711 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Hearing no objections, I have queued this wordsmithed version.  As always,
please let me know if I have messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 5271ad1de0fbcf0bd9caebcf721670c164e5fa9c
Author: Zqiang <qiang.zhang1211@gmail.com>
Date:   Thu May 9 15:40:46 2024 +0800

    rcu/nocb: Don't use smp_processor_id() in preemptible code
    
    Currently, rcu_rdp_is_offloaded() invokes this_cpu_ptr(&rcu_data) before
    the condition "!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())"
    is checked.  When invoked in preemptible context in preemptible kernels,
    this will trigger the following warning:
    
    [ 4.106221][ T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
    [ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
    [ 4.108547][ T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
    [ 4.109667][ T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
    [ 4.111064][ T18] Call Trace:
    [ 4.111064][ T18]  <TASK>
    [ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
    [ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
    [ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
    [ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
    [ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
    [ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
    [ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
    [ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
    [ 4.111064][ T18] kthread (kernel/kthread.c:388)
    [ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
    [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
    [ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
    [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
    [ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
    [ 4.111064][ T18]  </TASK>
    
    This commit therefore fixes this warning by checking the condition
    "!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())" before invoking
    this_cpu_ptr(), thus avoiding preemptible invocations.
    
    Fixes: 8feeeba60711 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
    Tested-by: kernel test robot <oliver.sang@intel.com>
    Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 31c539f09c150..475e20ebec5a5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
+		    rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
