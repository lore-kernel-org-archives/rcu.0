Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7A79C4;
	Wed, 23 Oct 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699001; cv=none; b=f6u1E3lP7RAIyJ4QIp6Ro/mTgnrVKzAECWqVrMoNvqTO7gc/zqWHliXqai0jdAUHTBEd9ouSh2i9HBAG7i6FfPqIzW190EZc9d3xAdM6u6YCR5wikXoGLMoiUxlkg67DFILnw9+nKEFN/IQKQcUZy5ICyat5kHGb+3Z24cGrAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699001; c=relaxed/simple;
	bh=1Ba0sZeAnvUhCaXJ8dnugwhq/HEb2znLVY+FK/Szapo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNk3w8iMVs6NxOkE9bMS4o7KJ7VBd2lKcIdSR2QgkmwNWViQjyNmhQtkUiwLvOMcmOsUfdxmuKOmwsf7pQTz+f1IwdrLm0xikZfsl6jP2a8mue1PBIh4nO9T1nxq292RWSoIAGGEErvyM0dVNre8Auq8J9u3MfH0sTtDDFA32wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS9kKj7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS9kKj7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DA4C4CEC6;
	Wed, 23 Oct 2024 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729699000;
	bh=1Ba0sZeAnvUhCaXJ8dnugwhq/HEb2znLVY+FK/Szapo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS9kKj7CP27g2voHKdUDfoV+MZSlhJHkdyomNvWnaMBrG+15ruArCggOZKq/BmBlz
	 wVKLZVzBxo9hWEUavQnHGG3EeFzQ0EArzF07yz1hOAGzccDtO3JkVl7f0eZVtBFg99
	 Sk/TvlBoqqRjCESsm2d1VD0ybGtEeLJlyhOnU4FSgi2flupInIoyR6P56NZkC39dTq
	 o6VyRGlvccdUjYU9eIRuju84YcRThsnjwdfz2R+Rg5pefOuJvHWUXY89KHguVnIa77
	 FckEKp8aivLhCbQrOb+LLZz+WVSAVYbeuXMe+mefNx342rXdNUjCf0qtaU5Xh6iCzs
	 oAtjwOfgreh4Q==
Date: Wed, 23 Oct 2024 17:56:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
Subject: Re: [PATCH] rcu/kvfree: Fix data-race in __mod_timer /
 kvfree_call_rcu
Message-ID: <ZxkctYE8sktPV9-b@localhost.localdomain>
References: <20241022105307.2857-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022105307.2857-1-urezki@gmail.com>

Le Tue, Oct 22, 2024 at 12:53:07PM +0200, Uladzislau Rezki (Sony) a écrit :
> KCSAN reports a data race when access the krcp->monitor_work.timer.expires
> variable in the schedule_delayed_monitor_work() function:
> 
> <snip>
> BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu
> 
> read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
>  schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]
>  kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
>  trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
>  bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
>  generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
>  bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
>  __sys_bpf+0x2e5/0x7a0
>  __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
>  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
>  __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
>  add_timer_global+0x51/0x70 kernel/time/timer.c:1330
>  __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
>  queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
>  queue_delayed_work include/linux/workqueue.h:677 [inline]
>  schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
>  kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
>  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events_unbound kfree_rcu_monitor
> <snip>
> 
> kfree_rcu_monitor() rearms the work if a "krcp" has to be still
> offloaded and this is done without holding krcp->lock, whereas
> the kvfree_call_rcu() holds it.
> 
> Fix it by acquiring the "krcp->lock" for kfree_rcu_monitor() so
> both functions do not race anymore.
> 
> Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/ZxZ68KmHDQYU0yfD@pc636/T/
> Fixes: 8fc5494ad5fa ("rcu/kvfree: Move need_offload_krc() out of krcp->lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Applied, thanks!
