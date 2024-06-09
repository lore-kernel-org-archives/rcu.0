Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F61C01
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717893815; cv=none; b=fYCRAh4C1yjOx5u2fqUg1GVs1tdct6Z0vCMZ+QDwiAhtRf1KQyF1Yus16qJUM/B+RFfIFc2Jpmz//ug/6lBhSOpGQuNWRMtbOL78FE6DK18GDf7e7rUfxVe5kkogfCYz7Qup67SI+4yA/hnuz1GoeI8kGs1mvvv13Jw9KotHmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717893815; c=relaxed/simple;
	bh=a44StvyeWnvLvVb8D5x5bGdS0D0jg8hdGQQPGz8g0b4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IR9v2irsds4eNC4gqWwNQd5MaWDl7FBLdOgFZ+ygn1jzFgbJ7lHf+04a8wSaUPdvoKTELGOrCgWx/whUQUmQUPWckvOG5YEoBPMhh9xKyFEniyxRfw+LPUyFrZGDezfalXAKLNspMMAiGABxRGX3B/VY07TyyLwUiswRpYK/6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cSIBDtRs; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cSIBDtRs"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717893809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=NNT6Ss8/cc0eS3r5pYUkNSTCimTskG5kKOwUANorJUY=;
	b=cSIBDtRsW42zYArQiWpZRYm33dMjnpbN74HIfC9EnPeGrDiQlz+XwYDJyulWDtcNOZry7y
	H1jxSlYDzOxGMBqk93yxyA29aW+W8P6lfjMACTCLwUGBVKLHDkt2GBKI5hY4Ic8fg2j/j9
	A7ijo5hhFFtb2tDmYuBNSvXmCC36thY=
X-Envelope-To: rcu@vger.kernel.org
Date: Sat, 8 Jun 2024 20:43:25 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: srcu_cleanup warning
Message-ID: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

syzbot's been hitting this, and I just started hitting it in my CI (so I
can finally repro), but I have no idea what's going on.

it seems the srcu struct is still in use? but there's no readers, we're
not hitting that warning - and I've got my own asserts for leaking
btree_trans objects, which are what take srcu read locks.

so there seems to be an outstanding grace period, but I can't follow the
code to see how that's supposed to end - and adding an explicit
srcu_barrier() to my shutdown path doesn't fix it...

00458 ========= TEST   rereplicate
00458 
00458 WATCHDOG 60
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): mounting version 1.9: disk_accounting_v2
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): initializing new filesystem
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): going read-write
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): marking superblocks
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): initializing freespace
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): done initializing freespace
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): reading snapshots table
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): reading snapshots done
00458 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): done starting filesystem
00459 1024+0 records in
00459 1024+0 records out
00459 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.927488 s, 1.2 GB/s
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): shutting down
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): going read-only
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): finished waiting for writes to stop
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): flushing journal and stopping allocators, journal seq 72
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): flushing journal and stopping allocators complete, journal seq 75
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): shutdown complete, journal seq 76
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): marking filesystem clean
00459 bcachefs (5c0b0c7e-1883-4f8a-abde-8f223546d087): shutdown complete
00459 ------------[ cut here ]------------
00459 WARNING: CPU: 1 PID: 1577 at kernel/rcu/srcutree.c:664 cleanup_srcu_struct+0x168/0x1c0
00459 Modules linked in:
00459 CPU: 1 PID: 1577 Comm: umount Not tainted 6.10.0-rc2-ktest-g45acc58a039a #23170
00459 Hardware name: linux,dummy-virt (DT)
00459 pstate: 00001005 (nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
00459 pc : cleanup_srcu_struct+0x168/0x1c0
00459 lr : cleanup_srcu_struct+0x80/0x1c0
00459 sp : ffff0000c72efc10
00459 x29: ffff0000c72efc10 x28: ffff0000d8d8ae80 x27: 0000000000000000
00459 x26: 0000000000000010 x25: ffff0000f7183738 x24: ffff0000c1e73e00
00459 x23: ffff800080cc92a8 x22: ffff800080993010 x21: ffff0000f7183730
00459 x20: ffff800080cc8a30 x19: ffff0000fbdfeb40 x18: 00000000fffffffe
00459 x17: 656c706d6f63206e x16: 776f647475687320 x15: 0000000000000001
00459 x14: dead000000000122 x13: 0000000000000001 x12: 00000000f0000000
00459 x11: 0000000000000040 x10: ffff800080cdf538 x9 : ffff800080049624
00459 x8 : ffff0000c0400028 x7 : 0000000000000000 x6 : 0000000000000000
00459 x5 : ffff0000c0400000 x4 : 0000000000000000 x3 : 0000000000000000
00459 x2 : 0000000000000010 x1 : 0000000000000010 x0 : 000000000000023d
00459 Call trace:
00459  cleanup_srcu_struct+0x168/0x1c0
00459  bch2_fs_btree_iter_exit+0x1a0/0x1c8
00459  bch2_fs_release+0xf8/0x2f0
00459  kobject_put+0xa4/0xf0
00459  bch2_fs_free+0xf4/0x110
00459  bch2_kill_sb+0x24/0x38
00459  deactivate_locked_super+0x54/0xb0
00459  deactivate_super+0x70/0x90
00459  cleanup_mnt+0xa0/0x130
00459  __cleanup_mnt+0x18/0x28
00459  task_work_run+0xa8/0xf0
00459  do_notify_resume+0x120/0x130
00459  el0_svc+0x44/0x58
00459  el0t_64_sync_handler+0xb8/0xc0
00459  el0t_64_sync+0x14c/0x150
00459 ---[ end trace 0000000000000000 ]---
00459 rcu: cleanup_srcu_struct: Active srcu_struct 000000006c688d30 read state: 1 gp state: 573/576
00459 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
00459 Mem abort info:
00459   ESR = 0x0000000096000004
00459   EC = 0x25: DABT (current EL), IL = 32 bits
00459   SET = 0, FnV = 0
00459   EA = 0, S1PTW = 0
00459   FSC = 0x04: level 0 translation fault
00459 Data abort info:
00459   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
00459   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
00459   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
00459 user pgtable: 4k pages, 48-bit VAs, pgdp=000000011c75a000
00459 [0000000000000070] pgd=0000000000000000, p4d=0000000000000000
00459 Internal error: Oops: 0000000096000004 [#1] SMP
00459 Modules linked in:
00459 CPU: 0 PID: 1157 Comm: kworker/0:2 Tainted: G        W          6.10.0-rc2-ktest-g45acc58a039a #23170
00459 Hardware name: linux,dummy-virt (DT)
00459 Workqueue: rcu_gp srcu_invoke_callbacks
00459 pstate: 600010c5 (nZCv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
00459 pc : srcu_invoke_callbacks+0x74/0x210
00459 lr : srcu_invoke_callbacks+0x30/0x210
00459 sp : ffff00006ca5fd10
00459 x29: ffff00006ca5fd10 x28: ffff0000fbc5ac40 x27: ffff000005d71100
00459 x26: ffff800080cc6000 x25: ffff800080a98008 x24: ffff0000fbc5ab80
00459 x23: ffff0000fbc5ab40 x22: ffff0000fbc5ab88 x21: ffff0000fbc512c0
00459 x20: ffff0000fbc5ac40 x19: ffff0000f7183730 x18: 00000000e8d092ee
00459 x17: 000000006ba30620 x16: 00000000cf2823e1 x15: 00000000d2643b66
00459 x14: 0000000000000000 x13: ffff0000c17f9f00 x12: ffff0000c17f9da8
00459 x11: 0000000000000000 x10: 0000000000000940 x9 : ffff8000800a4968
00459 x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff000005d71100
00459 x5 : 000070675f756372 x4 : 000070675f756372 x3 : 0000000000000000
00459 x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0000fbc5ab88
00459 Call trace:
00459  srcu_invoke_callbacks+0x74/0x210
00459  process_scheduled_works+0x184/0x3d0
00459  worker_thread+0x174/0x318
00459  kthread+0xe8/0x100
00459  ret_from_fork+0x10/0x20
00459 Code: 54000be1 f9400a61 910122f6 aa1603e0 (f9403821) 
00459 ---[ end trace 0000000000000000 ]---
00459 Kernel panic - not syncing: Oops: Fatal exception
00459 SMP: stopping secondary CPUs
00459 Kernel Offset: disabled
00459 CPU features: 0x00,00000003,80000008,4240500b
00459 Memory Limit: none
00459 ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
00464 ========= FAILED TIMEOUT rereplicate in 60s

