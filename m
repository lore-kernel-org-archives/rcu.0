Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A9C433EF
	for <rcu@archiver.kernel.org>; Mon, 27 Jun 2022 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiF0Ulq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0Ulp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jun 2022 16:41:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661F1E3F0
        for <rcu@vger.kernel.org>; Mon, 27 Jun 2022 13:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E018CE1D9A
        for <rcu@vger.kernel.org>; Mon, 27 Jun 2022 20:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CEDC34115;
        Mon, 27 Jun 2022 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656362500;
        bh=E53LiL0iSr2PDmsoKzByJcHV8uG3g3Z356y7lPVCNcQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mPD5ksVeazKgfEnV9oT3VBM8GSGckbkWbshhAkzJPflYWuFVUOhsJ97ALDiD+bZTZ
         hSm/bY3hzGdY1n4p83GGD+1NXMHnreHy6YSZU9FBmV6rSDyy6GqlB79/RTpA/BzQp5
         9M8vwvexgtLgByr7ay6XzXSo+Lf4Fxql0B+YDgXjL3QpeQVhNF5Fcwe3SlQkMTG9FT
         keWMlAkbEb3/LQB44QHp6C4BjOeyXxRu0sCuBDKMpmb2+Frh9yiWYDX6GYiawQRa+T
         H3anyXvd3qxzNu8cwy8mM8ya9MBMIFL9cMrVKbMr5dYFHI4YjcO91eqjD1OKN794nM
         di8AZEmfEPXgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A98BA5C04B1; Mon, 27 Jun 2022 13:41:39 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:41:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        rcu@vger.kernel.org, urezki@gmail.com, uladzislau.rezki@sony.com
Subject: Re: rcu_sched detected expedited stalls in amdgpu after suspend
Message-ID: <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656357116.rhe0mufk6a.none@localhost>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 27, 2022 at 03:22:24PM -0400, Alex Xu (Hello71) wrote:
> Hi,
> 
> Since Linux 5.19-ish, I consistently get these types of errors when 
> resuming from S3:
> 
> [15652.909157] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 11-... } 7 jiffies s: 9981 root: 0x800/.
> [15652.909162] rcu: blocking rcu_node structures (internal RCU debug):
> [15652.909163] Task dump for CPU 11:
> [15652.909164] task:kworker/u24:65  state:R  running task     stack:    0 pid:210218 ppid:     2 flags:0x00004008
> [15652.909167] Workqueue: events_unbound async_run_entry_fn
> [15652.909172] Call Trace:
> [15652.909173]  <TASK>
> [15652.909174]  ? atom_get_src_int+0x38e/0x680
> [15652.909179]  ? atom_op_test+0x67/0x190
> [15652.909181]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
> [15652.909184]  ? atom_op_calltable+0xb1/0x110
> [15652.909186]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
> [15652.909189]  ? atom_op_calltable+0xb1/0x110
> [15652.909191]  ? amdgpu_atom_execute_table_locked+0x19a/0x300
> [15652.909193]  ? __switch_to+0x137/0x440
> [15652.909195]  ? amdgpu_atom_asic_init+0xe0/0x100
> [15652.909198]  ? pci_bus_read_config_dword+0x36/0x50
> [15652.909201]  ? amdgpu_device_resume+0x10b/0x3e0
> [15652.909203]  ? amdgpu_pmops_resume+0x32/0x60
> [15652.909204]  ? pci_pm_suspend+0x2b0/0x2b0
> [15652.909206]  ? dpm_run_callback+0x35/0x1f0
> [15652.909209]  ? device_resume+0x1ca/0x220
> [15652.909211]  ? async_resume+0x19/0xe0
> [15652.909213]  ? async_run_entry_fn+0x33/0x120
> [15652.909215]  ? process_one_work+0x1d6/0x350
> [15652.909218]  ? worker_thread+0x24d/0x480
> [15652.909220]  ? kthread+0x137/0x150
> [15652.909221]  ? worker_clr_flags+0x40/0x40
> [15652.909224]  ? kthread_blkcg+0x30/0x30
> [15652.909226]  ? ret_from_fork+0x22/0x30
> [15652.909227]  </TASK>
> [15653.015808] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 11-... } 7 jiffies s: 9985 root: 0x800/.
> [15653.015812] rcu: blocking rcu_node structures (internal RCU debug):
> [15653.015813] Task dump for CPU 11:
> [15653.015813] task:kworker/u24:65  state:R  running task     stack:    0 pid:210218 ppid:     2 flags:0x00004008
> [15653.015816] Workqueue: events_unbound async_run_entry_fn
> [15653.015820] Call Trace:
> [15653.015820]  <TASK>
> [15653.015821]  ? amdgpu_cgs_read_register+0x10/0x10
> [15653.015825]  ? smu7_copy_bytes_to_smc+0xd4/0x200
> [15653.015828]  ? polaris10_program_memory_timing_parameters+0x195/0x1b0
> [15653.015831]  ? sysvec_apic_timer_interrupt+0xa/0x80
> [15653.015834]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [15653.015836]  ? amdgpu_cgs_destroy_device+0x10/0x10
> [15653.015839]  ? sysvec_apic_timer_interrupt+0xa/0x80
> [15653.015841]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [15653.015843]  ? amdgpu_cgs_destroy_device+0x10/0x10
> [15653.015846]  ? amdgpu_device_rreg+0x8f/0xd0
> [15653.015847]  ? phm_wait_for_register_unequal+0x99/0xd0
> [15653.015850]  ? smu7_send_msg_to_smc+0x95/0x130
> [15653.015853]  ? smum_send_msg_to_smc+0x5d/0xa0
> [15653.015854]  ? amdgpu_cgs_read_ind_register+0xa0/0xa0
> [15653.015857]  ? smu7_enable_dpm_tasks+0x241f/0x28c0
> [15653.015859]  ? hwmgr_resume+0x31/0x70
> [15653.015861]  ? amdgpu_device_resume+0x1fa/0x3e0
> [15653.015863]  ? amdgpu_pmops_resume+0x32/0x60
> [15653.015864]  ? pci_pm_suspend+0x2b0/0x2b0
> [15653.015866]  ? dpm_run_callback+0x35/0x1f0
> [15653.015868]  ? device_resume+0x1ca/0x220
> [15653.015870]  ? async_resume+0x19/0xe0
> [15653.015872]  ? async_run_entry_fn+0x33/0x120
> [15653.015874]  ? process_one_work+0x1d6/0x350
> [15653.015877]  ? worker_thread+0x24d/0x480
> [15653.015878]  ? kthread+0x137/0x150
> [15653.015880]  ? worker_clr_flags+0x40/0x40
> [15653.015882]  ? kthread_blkcg+0x30/0x30
> [15653.015884]  ? ret_from_fork+0x22/0x30
> [15653.015886]  </TASK>
> 
> I have not noticed any resulting problems. I am reporting this in the 
> hope that it is easy to fix the issue and remove the error messages 
> which may obscure some future problem.

The usual way this happens is for a task to be spinning.  In this case,
that might be due to excessive lock contention on async_lock within the
async_run_entry_fn() function.  Or perhaps the problem is in one of the
functions preceded by "?" above.

One way to debug this is to place trace_printk()s or similar in the
functions called out above to track it down.

I bet that the reason this showed up in v5.19 is this guy:

28b3ae426598 ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

So do you have CONFIG_RCU_EXP_CPU_STALL_TIMEOUT set to some small
number of milliseconds?  If so, you can override this by adjusting the
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT Kconfig option or by booting with a
longer timeout via the rcupdate.rcu_exp_cpu_stall_timeout= kernel boot
parameter.

But if you are running on an Android platform, Uladzislau will be
interested in addressing the underlying issue, so I have added him on CC.

							Thanx, Paul
