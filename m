Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E41F2388;
	Fri, 21 Feb 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155435; cv=none; b=kO7Cjb9MfuXDufZserkme9169TueP9AMXh7IlIzFBt2pjk3WDfSO9iLdlKkuYA5s0FBupADiqDvnzTvtq6Z0tq5WfEHEzpUR4qnrH9On521zlSQgEsxoj/SRrThFmQuBV+Iwh0H1Z/hgpLguQcDa8Mw1H3sa+kJ0JuKnwDl3QbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155435; c=relaxed/simple;
	bh=peJoIjn/lcRBU6pV4UiXQxxm+ZfErwKhGJ/8tg/aPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVYRmXHXQWFvS8uumS4Ig4Em7qRR7ne+vRlHzX5ptcvafM4Sp89HafDdFWPmKXQeAYjkvkN/I8sPKhcPOKlojxtniGIBN14szAOP4jkI8uED0z93AapM9qn7Yy0Fp6jvop9nXRadM6nKzhc6OyG8sWi/IvBzl5FXiyEt5EQ7ESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBrZU0d8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBrZU0d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702AC4CED6;
	Fri, 21 Feb 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740155435;
	bh=peJoIjn/lcRBU6pV4UiXQxxm+ZfErwKhGJ/8tg/aPdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBrZU0d8BAYwdl1hhWZIz2ADAu1Bb4i21ZBFgizW6LukDfTPfF2IEFSzn70jG1+Lq
	 H3y8mbF6U2kySYBGPxfok4RIbRSiVorznbcfL4hoC38izjBtQfHHq9RxR5fSDY6rAb
	 N0gvdlVliwjj+dMS5uLu3EsFhxm38xL0FZCLkUAJVe/9sXZdrRR8Yno0Jp4QS1VezO
	 cMz2BJl/kJMu3OUZIStoQNmEKo8mnkyc+BA46GqyZL2wTUkobyU+OalyQtS4oVg9yH
	 IRcz68b5DjF6QDcPaBaJRzBqcLHK8rI3p3LsFDTijbNkZP37TGrHlp07eiMcmHHI0e
	 uWw0ojmIpRufg==
Date: Fri, 21 Feb 2025 09:30:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z7iqJtCjHKfo8Kho@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>

On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> We would like to replace call_rcu() users with kfree_rcu() where the
> existing callback is just a kmem_cache_free(). However this causes
> issues when the cache can be destroyed (such as due to module unload).
> 
> Currently such modules should be issuing rcu_barrier() before
> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> This barrier is however not sufficient for kfree_rcu() in flight due
> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> kfree_rcu() batching").
> 
> This is not a problem for kmalloc caches which are never destroyed, but
> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> that might be destroyed.
> 
> In order not to complicate the API, put the responsibility for handling
> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> caches, but has to be done earlier, as the latter only needs to wait for
> the empty slab pages to finish freeing, and not objects from the slab.
> 
> Users of call_rcu() with arbitrary callbacks should still issue
> rcu_barrier() before destroying the cache and unloading the module, as
> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> callbacks may be invoking module code or performing other actions that
> are necessary for a successful unload.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c40227d5fa07..1a2873293f5d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s) || !kasan_check_byte(s))
>  		return;
>  
> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> +	kvfree_rcu_barrier();
> +
>  	cpus_read_lock();
>  	mutex_lock(&slab_mutex);

This patch appears to be triggering a new warning in certain conditions
when tearing down an nvme namespace's block device. Stack trace is at
the end.

The warning indicates that this shouldn't be called from a
WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
and tearing down block devices, so this is a memory reclaim use AIUI.
I'm a bit confused why we can't tear down a disk from within a memory
reclaim workqueue. Is the recommended solution to simply remove the WQ
flag when creating the workqueue?

  ------------[ cut here ]------------
  workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
  WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
  Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) iTCO_wdt(E) xhci_pci(E) mlx5_ib(E) ipmi_si(E) iTCO_vendor_support(E) i2c_i801(E) ipmi_devintf(E) evdev(E) kvm(E) xhci_hcd(E) ib_uverbs(E) acpi_cpufreq(E) wmi(E) i2c_smbus(E) ipmi_msghandler(E) button(E) efivarfs(E) autofs4(E)
  CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
  Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
  Workqueue: nvme-wq nvme_scan_work
  RIP: 0010:check_flush_dependency+0x112/0x120
  Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 c7 c7 90 64 5a 82 49 89 d8 e8 7e 4f 88 ff <0f> 0b eb 8c cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 41 57 41
  RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
  RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
  RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
  RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
  R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
  R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
  CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __warn+0xa4/0x140
   ? check_flush_dependency+0x112/0x120
   ? report_bug+0xe1/0x140
   ? check_flush_dependency+0x112/0x120
   ? handle_bug+0x5e/0x90
   ? exc_invalid_op+0x16/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? timer_recalc_next_expiry+0x190/0x190
   ? check_flush_dependency+0x112/0x120
   ? check_flush_dependency+0x112/0x120
   __flush_work.llvm.1643880146586177030+0x174/0x2c0
   flush_rcu_work+0x28/0x30
   kvfree_rcu_barrier+0x12f/0x160
   kmem_cache_destroy+0x18/0x120
   bioset_exit+0x10c/0x150
   disk_release.llvm.6740012984264378178+0x61/0xd0
   device_release+0x4f/0x90
   kobject_put+0x95/0x180
   nvme_put_ns+0x23/0xc0
   nvme_remove_invalid_namespaces+0xb3/0xd0
   nvme_scan_work+0x342/0x490
   process_scheduled_works+0x1a2/0x370
   worker_thread+0x2ff/0x390
   ? pwq_release_workfn+0x1e0/0x1e0
   kthread+0xb1/0xe0
   ? __kthread_parkme+0x70/0x70
   ret_from_fork+0x30/0x40
   ? __kthread_parkme+0x70/0x70
   ret_from_fork_asm+0x11/0x20
   </TASK>
  ---[ end trace 0000000000000000 ]---
