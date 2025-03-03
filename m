Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43D2505BD;
	Mon,  3 Mar 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020381; cv=none; b=MJ7WESUxaR0YTu3yq/14C01ScFUFcOKk2DdtV4tuzciW2VLp2Gitdflv59MPkCPulUbyzYs6r2Sqnc8a2MD/YiM4e1dGyoGC/tqabA4VqlUOzx/jah12eS/1kjBYvg8WePaE1IlzJlqcQtLaYEWx2ToZEYSNX4YnmaII0AfKVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020381; c=relaxed/simple;
	bh=OhfpnZjrvebWNqV98EvnWQ6iJ1rGWFw6/hGUxvKhZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghk9I1q+fmGgXnE8gjQGcefMqm7JTXtjZ+uDkYT90y4aJjujMuJln5nLeV+BgFt7ZcSVphOXRIJy9wWcUTiqYNBwS0cC0CjQr6ne5kigYK8osGKQTxpcj0B+28PiRC5bGjhyvzZ5xy5vL5cGYunKJcYUXL0xsCs8pl1XnUNv1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31C4C4CED6;
	Mon,  3 Mar 2025 16:46:19 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:47:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Strforexc yn <strforexc@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <20250303114711.12716d05@gandalf.local.home>
In-Reply-To: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 08:44:48 +0800
Strforexc yn <strforexc@gmail.com> wrote:

> [   92.191636][T12405] bcachefs (loop4): accounting_read... done
> [   92.214058][T12405] bcachefs (loop4): alloc_read... done
> [   92.214581][T12405] bcachefs (loop4): stripes_read... done
> [   92.215097][T12405] bcachefs (loop4): snapshots_read... done
> [   92.216897][T12405] bcachefs (loop4): check_allocations...
> [   92.218389][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.218403][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 4fe84214937890c3 written 32 min_key POS_MIN durability: 1 ptr: 0:26:0 gen 0, fixing
> [   92.233508][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.233524][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq a22d880bb51b703b written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0, fixing
> [   92.254034][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.254049][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq b5d608e41b3af1cf written 24 min_key POS_MIN durability: 1 ptr: 0:41:0 gen 0, fixing
> [   92.264601][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.264618][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 92b180ffcc5b04f1 written 16 min_key POS_MIN durability: 1 ptr: 0:35:0 gen 0, fixing
> [   92.273945][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.273962][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 8aae33f84eb959b0 written 16 min_key POS_MIN durability: 1 ptr: 0:32:0 gen 0, fixing
> [   92.277063][T12405] btree ptr not marked in member info btree allocated bitmap
> [   92.277077][T12405]   u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 487388c888b02d23 written 32 min_key POS_MIN durability: 1 ptr: 0:29:0 gen 0, fixing
> [   92.286810][T12405]  done
> [   92.295665][T12405] bcachefs (loop4): going read-write
> [   92.297599][T12405] bcachefs (loop4): journal_replay...
> [   92.318551][   T28] ------------[ cut here ]------------
> [   92.319525][   T28] ==================================================================
> [   92.320184][   T28] BUG: KASAN: global-out-of-bounds in string+0x4b3/0x500

This is likely a side effect of the real bug.

> [   92.320780][   T28] Read of size 1 at addr ffffffff8b8e8d55 by task kworker/u10:0/28
> [   92.321502][   T28] 
> [   92.321714][   T28] CPU: 1 UID: 0 PID: 28 Comm: kworker/u10:0 Not tainted 6.14.0-rc4 #1
> [   92.321728][   T28] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   92.321737][   T28] Workqueue: btree_update btree_interior_update_work
> [   92.321753][   T28] Call Trace:
> [   92.321758][   T28]  <TASK>
> [   92.321763][   T28]  dump_stack_lvl+0x116/0x1b0
> [   92.321780][   T28]  print_address_description.constprop.0+0x2c/0x420
> [   92.321802][   T28]  ? string+0x4b3/0x500
> [   92.321815][   T28]  print_report+0xaa/0x270
> [   92.321832][   T28]  ? string+0x4b3/0x500
> [   92.321845][   T28]  ? kasan_addr_to_slab+0x27/0x80
> [   92.321862][   T28]  ? string+0x4b3/0x500
> [   92.321874][   T28]  kasan_report+0xbd/0x100
> [   92.321892][   T28]  ? string+0x4b3/0x500
> [   92.321908][   T28]  string+0x4b3/0x500
> [   92.321923][   T28]  ? __pfx_string+0x10/0x10
> [   92.321937][   T28]  ? this_cpu_in_panic+0x5c/0x80
> [   92.321952][   T28]  ? _prb_read_valid+0x272/0x320
> [   92.321966][   T28]  vsnprintf+0x620/0x1120
> [   92.321985][   T28]  ? __pfx_vsnprintf+0x10/0x10
> [   92.322004][   T28]  vprintk_store+0x34f/0xb90
> [   92.322021][   T28]  ? __pfx_vprintk_store+0x10/0x10
> [   92.322036][   T28]  ? tick_nohz_tick_stopped+0x6c/0xb0
> [   92.322057][   T28]  ? __irq_work_queue_local+0xd9/0x260
> [   92.322079][   T28]  ? irq_work_queue+0x2d/0x80
> [   92.322098][   T28]  ? __wake_up_klogd+0xbe/0x110
> [   92.322110][   T28]  ? vprintk_emit+0x1cf/0x330
> [   92.322126][   T28]  ? check_path.constprop.0+0x24/0x70
> [   92.322143][   T28]  ? check_noncircular+0xe8/0x270
> [   92.322162][   T28]  ? is_printk_cpu_sync_owner+0x32/0x50
> [   92.322182][   T28]  vprintk_emit+0x151/0x330
> [   92.322198][   T28]  ? __pfx_vprintk_emit+0x10/0x10
> [   92.322217][   T28]  __warn_printk+0x162/0x320
> [   92.322247][   T28]  ? __pfx___warn_printk+0x10/0x10
> [   92.322265][   T28]  ? hlock_class+0x4e/0x140
> [   92.322278][   T28]  ? __pfx_validate_chain+0x10/0x10
> [   92.322296][   T28]  ? hlock_class+0x4e/0x140
> [   92.322309][   T28]  ? mark_lock+0x38/0x400
> [   92.322328][   T28]  look_up_lock_class+0xad/0x160

The print is likely this from the look_up_lock_class() function:

			/*
			 * Huh! same key, different name? Did someone trample
			 * on some memory? We're most confused.
			 */
			WARN_ONCE(class->name != lock->name &&
				  lock->key != &__lockdep_no_validate__,
				  "Looking for class \"%s\" with key %ps, but found a different class \"%s\" with the same key\n",
				  lock->name, lock->key, class->name);

So it may be that the lock being passed in is corrupted.

> [   92.322347][   T28]  register_lock_class+0xb2/0xfc0
> [   92.322366][   T28]  ? __lock_acquire+0xb97/0x16a0
> [   92.322386][   T28]  ? __pfx_register_lock_class+0x10/0x10
> [   92.322407][   T28]  ? do_perf_trace_lock.isra.0+0x10b/0x570
> [   92.322427][   T28]  __lock_acquire+0xc3/0x16a0
> [   92.322446][   T28]  ? __pfx___lock_release+0x10/0x10
> [   92.322466][   T28]  ? rcu_is_watching+0x12/0xd0
> [   92.322486][   T28]  lock_acquire+0x181/0x3a0
> [   92.322505][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> [   92.322522][   T28]  ? __pfx_lock_acquire+0x10/0x10
> [   92.322541][   T28]  ? debug_object_active_state+0x2f1/0x3f0
> [   92.322557][   T28]  ? do_raw_spin_trylock+0xb4/0x190
> [   92.322570][   T28]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   92.322583][   T28]  ? __kmalloc_cache_noprof+0x1b9/0x450
> [   92.322604][   T28]  _raw_spin_trylock+0x76/0xa0
> [   92.322619][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> [   92.322636][   T28]  srcu_gp_start_if_needed+0x1a9/0x5f0

The lock taken is from the passed in rcu_pending pointer.

> [   92.322655][   T28]  rcu_pending_enqueue+0x686/0xd30
> [   92.322676][   T28]  ? __pfx_rcu_pending_enqueue+0x10/0x10
> [   92.322693][   T28]  ? trace_lock_release+0x11a/0x180
> [   92.322708][   T28]  ? bkey_cached_free+0xa3/0x170
> [   92.322725][   T28]  ? lock_release+0x13/0x180
> [   92.322744][   T28]  ? bkey_cached_free+0xa3/0x170
> [   92.322760][   T28]  bkey_cached_free+0xfd/0x170

Which has:

static void bkey_cached_free(struct btree_key_cache *bc,
                             struct bkey_cached *ck)
{
        kfree(ck->k);
        ck->k           = NULL;
        ck->u64s        = 0;
                
        six_unlock_write(&ck->c.lock);
        six_unlock_intent(&ck->c.lock);

        bool pcpu_readers = ck->c.lock.readers != NULL;
        rcu_pending_enqueue(&bc->pending[pcpu_readers], &ck->rcu);
        this_cpu_inc(*bc->nr_pending);
}

So if that bc->pending[pcpu_readers] gets corrupted in anyway, that could trigger this.

-- Steve


> [   92.322776][   T28]  bch2_btree_key_cache_drop+0xe7/0x770
> [   92.322795][   T28]  ? bch2_btree_insert_key_leaf+0x4c6/0xa00
> [   92.322812][   T28]  ? __pfx_bch2_btree_node_flush0+0x10/0x10
> [   92.322830][   T28]  bch2_trans_commit_write_locked.constprop.0+0x2bc6/0x3bc0
> [   92.322852][   T28]  ? __pfx_bch2_trans_commit_write_locked.constprop.0+0x10/0x10
> [   92.322875][   T28]  ? do_bch2_trans_commit.isra.0+0x7a6/0x12f0
> [   92.322892][   T28]  do_bch2_trans_commit.isra.0+0x7a6/0x12f0
> [   92.322913][   T28]  __bch2_trans_commit+0x1018/0x18e0
> [   92.322933][   T28]  ? __pfx___bch2_trans_commit+0x10/0x10
> [   92.322955][   T28]  btree_update_nodes_written+0x1352/0x2210
> [   92.322968][   T28]  ? btree_interior_update_work+0xd2/0x100
> [   92.322983][   T28]  ? __mutex_unlock_slowpath+0x145/0x400
> [   92.323003][   T28]  ? __pfx_btree_update_nodes_written+0x10/0x10
> [   92.323017][   T28]  ? process_one_work+0x7e2/0x18c0
> [   92.323035][   T28]  btree_interior_update_work+0xda/0x100
> [   92.323049][   T28]  process_one_work+0x109d/0x18c0
> [   92.323072][   T28]  ? __pfx_lock_acquire+0x10/0x10
> [   92.323091][   T28]  ? __pfx_process_one_work+0x10/0x10
> [   92.323109][   T28]  ? assign_work+0x194/0x250
> [   92.323123][   T28]  worker_thread+0x677/0xe90
> [   92.323141][   T28]  ? __pfx_worker_thread+0x10/0x10
> [   92.323157][   T28]  kthread+0x3b3/0x760
> [   92.323172][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.323187][   T28]  ? _raw_spin_unlock_irq+0x23/0x60
> [   92.323202][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.323217][   T28]  ret_from_fork+0x48/0x80
> [   92.323248][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.323262][   T28]  ret_from_fork_asm+0x1a/0x30
> [   92.323281][   T28]  </TASK>
> [   92.323286][   T28] 
> [   92.363491][   T28] The buggy address belongs to the variable:
> [   92.363982][   T28]  str__rcu__trace_system_name+0x815/0xb40
> [   92.364488][   T28] 
> [   92.364699][   T28] The buggy address belongs to the physical page:
> [   92.365242][   T28] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb8e8
> [   92.365971][   T28] flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
> [   92.366602][   T28] raw: 00fff00000002000 ffffea00002e3a08 ffffea00002e3a08 0000000000000000
> [   92.367288][   T28] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   92.368032][   T28] page dumped because: kasan: bad access detected
> [   92.368600][   T28] page_owner info is not present (never set?)
> [   92.369138][   T28] 
> [   92.369371][   T28] Memory state around the buggy address:
> [   92.369880][   T28]  ffffffff8b8e8c00: f9 f9 f9 f9 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9
> [   92.370592][   T28]  ffffffff8b8e8c80: 00 00 00 00 00 00 01 f9 f9 f9 f9 f9 00 00 00 07
> [   92.371307][   T28] >ffffffff8b8e8d00: f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9 00 00 00 06
> [   92.372015][   T28]                                                  ^
> [   92.372621][   T28]  ffffffff8b8e8d80: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 01 f9
> [   92.373336][   T28]  ffffffff8b8e8e00: f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9 00 00 00 00
> [   92.374046][   T28] ==================================================================
> [   92.374767][   T28] Kernel panic - not syncing: KASAN: panic_on_warn set ...
> [   92.375399][   T28] CPU: 1 UID: 0 PID: 28 Comm: kworker/u10:0 Not tainted 6.14.0-rc4 #1
> [   92.376108][   T28] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   92.376928][   T28] Workqueue: btree_update btree_interior_update_work
> [   92.377541][   T28] Call Trace:
> [   92.377857][   T28]  <TASK>
> [   92.378118][   T28]  dump_stack_lvl+0x3d/0x1b0
> [   92.378523][   T28]  panic+0x6d5/0x790
> [   92.378872][   T28]  ? __pfx_panic+0x10/0x10
> [   92.379269][   T28]  ? __pfx_do_perf_trace_lock.isra.0+0x10/0x10
> [   92.379771][   T28]  ? __pfx__printk+0x10/0x10
> [   92.380179][   T28]  ? end_report+0x2f/0xa0
> [   92.380580][   T28]  ? string+0x4b3/0x500
> [   92.380949][   T28]  check_panic_on_warn+0xb1/0xc0
> [   92.381416][   T28]  ? string+0x4b3/0x500
> [   92.381800][   T28]  end_report+0x83/0xa0
> [   92.382187][   T28]  kasan_report+0xcd/0x100
> [   92.382599][   T28]  ? string+0x4b3/0x500
> [   92.382967][   T28]  string+0x4b3/0x500
> [   92.383305][   T28]  ? __pfx_string+0x10/0x10
> [   92.383702][   T28]  ? this_cpu_in_panic+0x5c/0x80
> [   92.384143][   T28]  ? _prb_read_valid+0x272/0x320
> [   92.384568][   T28]  vsnprintf+0x620/0x1120
> [   92.384934][   T28]  ? __pfx_vsnprintf+0x10/0x10
> [   92.385335][   T28]  vprintk_store+0x34f/0xb90
> [   92.385725][   T28]  ? __pfx_vprintk_store+0x10/0x10
> [   92.386179][   T28]  ? tick_nohz_tick_stopped+0x6c/0xb0
> [   92.386652][   T28]  ? __irq_work_queue_local+0xd9/0x260
> [   92.387131][   T28]  ? irq_work_queue+0x2d/0x80
> [   92.387572][   T28]  ? __wake_up_klogd+0xbe/0x110
> [   92.388027][   T28]  ? vprintk_emit+0x1cf/0x330
> [   92.388451][   T28]  ? check_path.constprop.0+0x24/0x70
> [   92.388935][   T28]  ? check_noncircular+0xe8/0x270
> [   92.389371][   T28]  ? is_printk_cpu_sync_owner+0x32/0x50
> [   92.389843][   T28]  vprintk_emit+0x151/0x330
> [   92.390259][   T28]  ? __pfx_vprintk_emit+0x10/0x10
> [   92.390713][   T28]  __warn_printk+0x162/0x320
> [   92.391114][   T28]  ? __pfx___warn_printk+0x10/0x10
> [   92.391566][   T28]  ? hlock_class+0x4e/0x140
> [   92.391972][   T28]  ? __pfx_validate_chain+0x10/0x10
> [   92.392437][   T28]  ? hlock_class+0x4e/0x140
> [   92.392851][   T28]  ? mark_lock+0x38/0x400
> [   92.393242][   T28]  look_up_lock_class+0xad/0x160
> [   92.393676][   T28]  register_lock_class+0xb2/0xfc0
> [   92.394118][   T28]  ? __lock_acquire+0xb97/0x16a0
> [   92.394561][   T28]  ? __pfx_register_lock_class+0x10/0x10
> [   92.395056][   T28]  ? do_perf_trace_lock.isra.0+0x10b/0x570
> [   92.395571][   T28]  __lock_acquire+0xc3/0x16a0
> [   92.395999][   T28]  ? __pfx___lock_release+0x10/0x10
> [   92.396462][   T28]  ? rcu_is_watching+0x12/0xd0
> [   92.396863][   T28]  lock_acquire+0x181/0x3a0
> [   92.397251][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> [   92.397743][   T28]  ? __pfx_lock_acquire+0x10/0x10
> [   92.398180][   T28]  ? debug_object_active_state+0x2f1/0x3f0
> [   92.398676][   T28]  ? do_raw_spin_trylock+0xb4/0x190
> [   92.399120][   T28]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   92.399585][   T28]  ? __kmalloc_cache_noprof+0x1b9/0x450
> [   92.400055][   T28]  _raw_spin_trylock+0x76/0xa0
> [   92.400470][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> [   92.400933][   T28]  srcu_gp_start_if_needed+0x1a9/0x5f0
> [   92.401418][   T28]  rcu_pending_enqueue+0x686/0xd30
> [   92.401874][   T28]  ? __pfx_rcu_pending_enqueue+0x10/0x10
> [   92.402367][   T28]  ? trace_lock_release+0x11a/0x180
> [   92.402813][   T28]  ? bkey_cached_free+0xa3/0x170
> [   92.403231][   T28]  ? lock_release+0x13/0x180
> [   92.403621][   T28]  ? bkey_cached_free+0xa3/0x170
> [   92.404041][   T28]  bkey_cached_free+0xfd/0x170
> [   92.404465][   T28]  bch2_btree_key_cache_drop+0xe7/0x770
> [   92.404943][   T28]  ? bch2_btree_insert_key_leaf+0x4c6/0xa00
> [   92.405471][   T28]  ? __pfx_bch2_btree_node_flush0+0x10/0x10
> [   92.406018][   T28]  bch2_trans_commit_write_locked.constprop.0+0x2bc6/0x3bc0
> [   92.406683][   T28]  ? __pfx_bch2_trans_commit_write_locked.constprop.0+0x10/0x10
> [   92.407343][   T28]  ? do_bch2_trans_commit.isra.0+0x7a6/0x12f0
> [   92.407855][   T28]  do_bch2_trans_commit.isra.0+0x7a6/0x12f0
> [   92.408364][   T28]  __bch2_trans_commit+0x1018/0x18e0
> [   92.408825][   T28]  ? __pfx___bch2_trans_commit+0x10/0x10
> [   92.409315][   T28]  btree_update_nodes_written+0x1352/0x2210
> [   92.409818][   T28]  ? btree_interior_update_work+0xd2/0x100
> [   92.410295][   T28]  ? __mutex_unlock_slowpath+0x145/0x400
> [   92.410769][   T28]  ? __pfx_btree_update_nodes_written+0x10/0x10
> [   92.411302][   T28]  ? process_one_work+0x7e2/0x18c0
> [   92.411743][   T28]  btree_interior_update_work+0xda/0x100
> [   92.412233][   T28]  process_one_work+0x109d/0x18c0
> [   92.412690][   T28]  ? __pfx_lock_acquire+0x10/0x10
> [   92.413144][   T28]  ? __pfx_process_one_work+0x10/0x10
> [   92.413628][   T28]  ? assign_work+0x194/0x250
> [   92.414054][   T28]  worker_thread+0x677/0xe90
> [   92.414476][   T28]  ? __pfx_worker_thread+0x10/0x10
> [   92.414941][   T28]  kthread+0x3b3/0x760
> [   92.415322][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.415740][   T28]  ? _raw_spin_unlock_irq+0x23/0x60
> [   92.416208][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.416604][   T28]  ret_from_fork+0x48/0x80
> [   92.416982][   T28]  ? __pfx_kthread+0x10/0x10
> [   92.417365][   T28]  ret_from_fork_asm+0x1a/0x30
> [   92.417813][   T28]  </TASK>
> [   92.418176][   T28] Kernel Offset: disabled
> [   92.418562][   T28] Rebooting in 86400 seconds..
> 
> VM DIAGNOSIS:
> 14:25:54  Registers:
> info registers vcpu 0
> RAX=0000000000000102 RBX=00000000ee9d0cc0 RCX=ffffffff89d1d46a RDX=0000000000000001
> RSI=0000000000000007 RDI=0000000000000001 RBP=0000000000000001 RSP=ffffc90000007c90
> R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000001 R11=0000000000000000
> R12=ffff88804dadb400 R13=ffff88804dadb430 R14=0000000000000001 R15=00000000ffffae95
> RIP=ffffffff81be0c6a RFL=00000246 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 ffffffff 00c00000
> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0000 0000000000000000 ffffffff 00c00000
> DS =0000 0000000000000000 ffffffff 00c00000
> FS =0000 00007faacddf9700 ffffffff 00c00000
> GS =0000 ffff88802b600000 ffffffff 00c00000
> LDT=0000 0000000000000000 ffffffff 00c00000
> TR =0040 fffffe0000003000 00004087 00008b00 DPL=0 TSS64-busy
> GDT=     fffffe0000001000 0000007f
> IDT=     fffffe0000000000 00000fff
> CR0=80050033 CR2=00007faac001c738 CR3=000000002862e000 CR4=000006f0
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
> DR6=00000000fffe0ff0 DR7=0000000000000400
> EFER=0000000000000d01
> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
> XMM00=00000000000000ff 0000000000000000 XMM01=0a0a0a0a0a0a0a0a 0a0a0a0a0a0a0a0a
> XMM02=0000000000000000 0000000000000000 XMM03=0000000000000000 0000000000000000
> XMM04=0000000000000000 0000000000000000 XMM05=7074736e6f632e6e 6f69747069726373
> XMM06=65645f7373657264 64615f746e697270 XMM07=20205d3832542020 205b5d3038373132
> XMM08=79656b5f6e696d20 3233206e65747469 XMM09=ffff0000000000ff 000000000000ffff
> XMM10=0000000000000000 0000000000000000 XMM11=ffff000000000000 00000000000000ff
> XMM12=0000000000000000 0000000000000000 XMM13=0000000000000000 0000000000000000
> XMM14=0000000000000000 0000000000000000 XMM15=0000000000000000 0000000000000000
> info registers vcpu 1
> RAX=0000000000000063 RBX=00000000000003f8 RCX=0000000000000000 RDX=00000000000003f8
> RSI=0000000000000000 RDI=ffffffff9b037a00 RBP=ffffffff9b0379c0 RSP=ffffc900004fe7c8
> R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
> R12=0000000000000000 R13=0000000000000063 R14=ffffffff9b0379c0 R15=0000000000000000
> RIP=ffffffff8540d9bf RFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 ffffffff 00c00000
> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =0000 0000000000000000 ffffffff 00c00000
> FS =0000 0000000000000000 ffffffff 00c00000
> GS =0000 ffff88807ee00000 ffffffff 00c00000
> LDT=0000 0000000000000000 ffffffff 00c00000
> TR =0040 fffffe000004a000 00004087 00008b00 DPL=0 TSS64-busy
> GDT=     fffffe0000048000 0000007f
> IDT=     fffffe0000000000 00000fff
> CR0=80050033 CR2=0000000000000000 CR3=000000006b6c8000 CR4=000006f0
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
> DR6=00000000fffe0ff0 DR7=0000000000000400
> EFER=0000000000000d01
> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
> XMM00=0000000000000000 0000000000000000 XMM01=0000000000000000 0000000000000000
> XMM02=00007f563e9bbf75 000000000001675a XMM03=00007ffc421e7a28 0000003000000030
> XMM04=4fc6796f43afd700 0000000000000000 XMM05=0000000000000000 00524f5252450040
> XMM06=0000000000000000 00007ffc421e7ba0 XMM07=00007ffc421e7cf0 0000000000000032
> XMM08=0000000000000000 0000000000000000 XMM09=0000000000000000 0000000000000000
> XMM10=0000000000000000 0000000000000000 XMM11=0000000000000000 0000000000000000
> XMM12=0000000000000000 0000000000000000 XMM13=0000000000000000 0000000000000000
> XMM14=0000000000000000 0000000000000000 XMM15=0000000000000000 0000000000000000

