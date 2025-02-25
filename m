Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309619F462;
	Tue, 25 Feb 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507687; cv=none; b=ULjHrrobB+QDKhIJVD7+oaZoBqyBxnXOwkl++a23r4t++7tIpdQYSGbvaVi9m9tYj/p5TXU/i+yCRax+CAOKX9tCss7+a1bib0pCmuZssuQj08hcVA1dJimorpF6Noq2OTB7WlbR5FgpFRNzh30BecXnLPxZxGon86nyh6m19gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507687; c=relaxed/simple;
	bh=In/wmbZC8wivdFbDncEhunu0KwZlK51p2s5A0eITppw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipt4lLAjW+BchXR2oR98EcBru0euo0jIoYP87ZxXk2O/djjDc8O8iksb7n+HB97jDHOlYLe6ka9Mppmwplq7SNl/TMJrj8hkUOvD0BGNHcVF0YhEg9K8MjeQfgnGBS6hH3ZjrjWEw1g+xxhdm2qkdmXzsKGI0ehiLW33i5zT+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6s2gQTm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6s2gQTm"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307bc125e2eso55196741fa.3;
        Tue, 25 Feb 2025 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507683; x=1741112483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LM39+n13BPvn+J2rcwr32WzrTD41uNSLl8+j9j8BSvA=;
        b=L6s2gQTmOLdf7RTp4yWW5B+Oz58il/lz2Ku0AnxgWhBMsIwbc01ikayn7jZa9Rrww2
         Wafdy9yzH5MEep3F7s4goe/NlE+6lN6TfV7LyI1I8vqP50TlBCIKPcMo4IweQs/LbpRR
         rhWmkPtZSgyuTXfCm6lBmbOuI2dw5ArDdrtCvMXg5Ll9W4OaNceT7JF0POxSIC1NHcgC
         8ytwizol7G7ZwbTexZxsEN+iX+71iz5eKu1PY/oNWeQGqp0aEOJqqTKF4lH314F+oswf
         Wr9VdJ/k7vzICwTtVQeno50k0R1zE8MLTY5JL0jVHTTkBSUpSts83qaQb8sylik0ZBY+
         844w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507683; x=1741112483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM39+n13BPvn+J2rcwr32WzrTD41uNSLl8+j9j8BSvA=;
        b=MjgwnU2Q9aQbRfr/sXFYHwg5PFPNsGHhZzPLmK999sfL/lvvSCfM7PGrLvl6Rjn+IO
         kvjxE3Gj9L/EwoUWminYMGOg320H7SUyd5smb0UcGsD2cPYNsr/X2uPXEeDM6bKDOlnZ
         yh0R8sVkWAE+zLwdzFtzxdmxrTs96Wm8/X659DJHgbd8CqGvpyNCHNaUwKZNoz5H5VfQ
         ae6/1rldf6Y2o6uAfpEBOoAGTXRKQz9w9cASZAvGgc9mNQVlxW0PEgdmwzSxmMsV2YRG
         WILNdgyeF5vHl6eDPtZglsf2fIBLofC2yH75k3e6bkUp9oQYi7H68sF2Kf9NneA05U3C
         Nsrw==
X-Forwarded-Encrypted: i=1; AJvYcCWaaNhBoKFk1Bq9caFaI8CQKsnpPbhOC0oeLd0frhMvRVo+xE9zEjcaZHcAf6knNlfngLog@vger.kernel.org, AJvYcCXmhbyj6noE+nCecLHDOdDcVNiyQVwftNmm+N1/u1jyzEhQcJcEu4qyXFEYc+MS2ivN9yfV1ND8yShnPf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzgk86pMb09HDPBxDjCiXPis59WxD67Jiv2QDBKeewHXUSHMS5
	LZGqFo6tX/Wlb8GJiQMNkrh31sIifB1zXLzEn9/6nb5n7gSrqwGq
X-Gm-Gg: ASbGncvjdf/vH8lLs3d2ccKPi+cmUYV0PTvhls6thlojM3A9kL8wsMg6n9w8EjdLXV1
	Nwc8jqqkK1xlyW4AUhbSvbeNuVLQFLVS7vMqFoG20jbb1EoVLNCFIq5JtLXQoHPaAtirlOxqJLU
	YB4LvCHDU//MvCNOFVDI5JJPhTn4jl6txyXlyskjJ0lJMzu4kmyWitbNS1P9UW2V1HH4AMihRoc
	daPlCNCWn53vOVZkzPx/ceu5BMITOX/RD62IAFqqQfVXXx6zTAVHz3hH3btly6bbH2lyQDIBCqd
	0i9hVkJkUb8ZW5v0huLDwhnGgO9oEQbou/GgeOStRawIW6ag
X-Google-Smtp-Source: AGHT+IFoRObJBmJo9tEE6zKnPjMDesmLGd9MWFxr0CK/4CAxinoSjkausHa4uzqAObVBev170EdBPA==
X-Received: by 2002:a2e:860e:0:b0:306:10d6:28a5 with SMTP id 38308e7fff4ca-30a80c0ede0mr21557411fa.1.1740507683218;
        Tue, 25 Feb 2025 10:21:23 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebffesm2996571fa.43.2025.02.25.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:21:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 19:21:19 +0100
To: Keith Busch <keith.busch@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Keith Busch <keith.busch@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <Z74KHyGGMzkhx5f-@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74Av6tlSOqcfb-q@pc636>

On Tue, Feb 25, 2025 at 06:41:19PM +0100, Uladzislau Rezki wrote:
> On Tue, Feb 25, 2025 at 10:05:37AM -0700, Keith Busch wrote:
> > On Tue, Feb 25, 2025 at 09:03:38AM -0700, Keith Busch wrote:
> > > On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
> > > > I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> > > > it's too simple, or racy, and thus we are not flushing any of the queues from
> > > > kvfree_rcu_barrier()?
> > >
> > > Thanks, your test readily triggers it for me, but only if I load
> > > rcutorture at the same time.
> > 
> > Oops, I sent the wrong kernel messages. This is the relevant part:
> > 
> > [  142.371052] workqueue: WQ_MEM_RECLAIM
> > test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is
> > flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> > [  142.371072] WARNING: CPU: 11 PID: 186 at kernel/workqueue.c:3715
> > check_flush_dependency.part.0+0xad/0x100
> > [  142.375748] Modules linked in: slub_kunit(E) rcutorture(E)
> > torture(E) kunit(E) iTCO_wdt(E) iTCO_vendor_support(E)
> > intel_uncore_frequency_common(E) skx_edac_common(E) nfit(E)
> > libnvdimm(E) kvm_intel(E) kvm(E) evdev(E) bochs(E) serio_raw(E)
> > drm_kms_helper(E) i2c_i801(E) e1000e(E) i2c_smbus(E) intel_agp(E)
> > intel_gtt(E) lpc_ich(E) agpgart(E) mfd_core(E) drm_shm]
> > [  142.384553] CPU: 11 UID: 0 PID: 186 Comm: kworker/u64:11 Tainted: G
> >            E    N 6.13.0-04839-g5e7b40f0ddce-dirty #831
> > [  142.386755] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
> > [  142.387849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [  142.390236] Workqueue: test_kfree_rcu_destroy_wq
> > cache_destroy_workfn [slub_kunit]
> > [  142.391863] RIP: 0010:check_flush_dependency.part.0+0xad/0x100
> > [  142.393183] Code: 75 dc 48 8b 55 18 49 8d 8d 78 01 00 00 4d 89 f0
> > 48 81 c6 78 01 00 00 48 c7 c7 00 e1 9a 82 c6 05 4f 39 c5 02 01 e8 53
> > bd fd ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 80 3d 39 39 c5 02 00 75 83
> > 41 8b
> > [  142.396981] RSP: 0018:ffffc900007cfc90 EFLAGS: 00010092
> > [  142.398124] RAX: 000000000000008f RBX: ffff88803e9b10a0 RCX: 0000000000000027
> > [  142.399605] RDX: ffff88803eba0d08 RSI: 0000000000000001 RDI: ffff88803eba0d00
> > [  142.401092] RBP: ffff888007d9a480 R08: ffffffff83b8c808 R09: 0000000000000003
> > [  142.402548] R10: ffffffff8348c820 R11: ffffffff83a11d58 R12: ffff888007150000
> > [  142.404098] R13: ffff888005961400 R14: ffffffff813221a0 R15: ffff888005961400
> > [  142.405561] FS:  0000000000000000(0000) GS:ffff88803eb80000(0000)
> > knlGS:0000000000000000
> > [  142.407297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  142.408658] CR2: 00007f826bd1a000 CR3: 00000000069db002 CR4: 0000000000772ef0
> > [  142.410259] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  142.411871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  142.413341] PKRU: 55555554
> > [  142.414038] Call Trace:
> > [  142.414658]  <TASK>
> > [  142.415249]  ? __warn+0x8d/0x180
> > [  142.416035]  ? check_flush_dependency.part.0+0xad/0x100
> > [  142.417182]  ? report_bug+0x160/0x170
> > [  142.418041]  ? handle_bug+0x4f/0x90
> > [  142.418861]  ? exc_invalid_op+0x14/0x70
> > [  142.419853]  ? asm_exc_invalid_op+0x16/0x20
> > [  142.420877]  ? kfree_rcu_shrink_scan+0x120/0x120
> > [  142.422029]  ? check_flush_dependency.part.0+0xad/0x100
> > [  142.423244]  __flush_work+0x38a/0x4a0
> > [  142.424157]  ? find_held_lock+0x2b/0x80
> > [  142.425070]  ? flush_rcu_work+0x26/0x40
> > [  142.425953]  ? lock_release+0xb3/0x250
> > [  142.426785]  ? __mutex_unlock_slowpath+0x2c/0x270
> > [  142.427906]  flush_rcu_work+0x30/0x40
> > [  142.428756]  kvfree_rcu_barrier+0xe9/0x130
> > [  142.429649]  kmem_cache_destroy+0x2b/0x1f0
> > [  142.430578]  cache_destroy_workfn+0x20/0x40 [slub_kunit]
> > [  142.431729]  process_one_work+0x1cd/0x560
> > [  142.432620]  worker_thread+0x183/0x310
> > [  142.433487]  ? rescuer_thread+0x330/0x330
> > [  142.434428]  kthread+0xd8/0x1d0
> > [  142.435248]  ? ret_from_fork+0x17/0x50
> > [  142.436165]  ? lock_release+0xb3/0x250
> > [  142.437106]  ? kthreads_online_cpu+0xf0/0xf0
> > [  142.438133]  ret_from_fork+0x2d/0x50
> > [  142.439045]  ? kthreads_online_cpu+0xf0/0xf0
> > [  142.440428]  ret_from_fork_asm+0x11/0x20
> > [  142.441476]  </TASK>
> > [  142.442152] irq event stamp: 22858
> > [  142.443002] hardirqs last  enabled at (22857): [<ffffffff82044ef4>]
> > _raw_spin_unlock_irq+0x24/0x30
> > [  142.445032] hardirqs last disabled at (22858): [<ffffffff82044ce3>]
> > _raw_spin_lock_irq+0x43/0x50
> > [  142.451450] softirqs last  enabled at (22714): [<ffffffff810bfdbc>]
> > __irq_exit_rcu+0xac/0xd0
> > [  142.453345] softirqs last disabled at (22709): [<ffffffff810bfdbc>]
> > __irq_exit_rcu+0xac/0xd0
> > [  142.455305] ---[ end trace 0000000000000000 ]---
> Thanks!
> 
> I can trigger this also:
> 
> <snip>
> [   21.712856] KTAP version 1
> [   21.712862] 1..1
> [   21.714486]     KTAP version 1
> [   21.714490]     # Subtest: slub_test
> [   21.714492]     # module: slub_kunit
> [   21.714495]     1..10
> [   21.750359]     ok 1 test_clobber_zone
> [   21.750955]     ok 2 test_next_pointer
> [   21.751532]     ok 3 test_first_word
> [   21.751991]     ok 4 test_clobber_50th_byte
> [   21.752493]     ok 5 test_clobber_redzone_free
> [   21.753004] stackdepot: allocating hash table of 1048576 entries via kvcalloc
> [   21.756176]     ok 6 test_kmalloc_redzone_access
> [   21.806549]     ok 7 test_kfree_rcu
> [   22.058010] ------------[ cut here ]------------
> [   22.058015] workqueue: WQ_MEM_RECLAIM test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> [   22.058039] WARNING: CPU: 19 PID: 474 at kernel/workqueue.c:3715 check_flush_dependency.part.0+0xbe/0x130
> [   22.058047] Modules linked in: slub_kunit(E) kunit(E) binfmt_misc(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E) ppdev(E) drm_kms_helper(E) snd_pcm(E) sg(E) snd_timer(E) evdev(E) snd(E) joydev(E) parport_pc(E) parport(E) soundcore(E) serio_raw(E) button(E) pcspkr(E) drm(E) fuse(E) dm_mod(E) efi_pstore(E) configfs(E) loop(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) sd_mod(E) cdrom(E) ata_generic(E) ata_piix(E) libata(E) scsi_mod(E) i2c_piix4(E) psmouse(E) e1000(E) i2c_smbus(E) scsi_common(E) floppy(E)
> [   22.058091] CPU: 19 UID: 0 PID: 474 Comm: kworker/u257:0 Kdump: loaded Tainted: G            E    N 6.14.0-rc1+ #286
> [   22.058096] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
> [   22.058097] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   22.058099] Workqueue: test_kfree_rcu_destroy_wq cache_destroy_workfn [slub_kunit]
> [   22.058103] RIP: 0010:check_flush_dependency.part.0+0xbe/0x130
> [   22.058106] Code: 75 d0 48 8b 55 18 49 8d 8d c0 00 00 00 4d 89 f0 48 81 c6 c0 00 00 00 48 c7 c7 b0 7d c8 bd c6 05 6c 78 53 01 01 e8 a2 ae fd ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc f6 c4 08 74 94 31 ed
> [   22.058108] RSP: 0018:ffff95e5c123fd50 EFLAGS: 00010086
> [   22.058111] RAX: 0000000000000000 RBX: ffff89a4ff22d5a0 RCX: 0000000000000000
> [   22.058113] RDX: 0000000000000003 RSI: ffffffffbdce1697 RDI: 00000000ffffffff
> [   22.058114] RBP: ffff89961043a780 R08: 0000000000000000 R09: 0000000000000003
> [   22.058116] R10: ffff95e5c123fbe8 R11: ffff89a53fefefa8 R12: ffff89960cb6b080
> [   22.058117] R13: ffff899600051400 R14: ffffffffbcf2ba80 R15: ffff89960005a800
> [   22.058120] FS:  0000000000000000(0000) GS:ffff89a4ff2c0000(0000) knlGS:0000000000000000
> [   22.058122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.058124] CR2: 000055bf2cbc6038 CR3: 000000010dc1e000 CR4: 00000000000006f0
> [   22.058128] Call Trace:
> [   22.058130]  <TASK>
> [   22.058133]  ? __warn+0x85/0x130
> [   22.058137]  ? check_flush_dependency.part.0+0xbe/0x130
> [   22.058139]  ? report_bug+0x18d/0x1c0
> [   22.058142]  ? prb_read_valid+0x17/0x20
> [   22.058147]  ? handle_bug+0x58/0x90
> [   22.058151]  ? exc_invalid_op+0x13/0x60
> [   22.058154]  ? asm_exc_invalid_op+0x16/0x20
> [   22.058158]  ? __pfx_kfree_rcu_work+0x10/0x10
> [   22.058162]  ? check_flush_dependency.part.0+0xbe/0x130
> [   22.058165]  __flush_work+0xd6/0x320
> [   22.058168]  flush_rcu_work+0x39/0x50
> [   22.058171]  kvfree_rcu_barrier+0xe9/0x130
> [   22.058174]  kmem_cache_destroy+0x18/0x140
> [   22.058177]  process_one_work+0x184/0x3a0
> [   22.058180]  worker_thread+0x24d/0x360
> [   22.058183]  ? __pfx_worker_thread+0x10/0x10
> [   22.058185]  kthread+0xfc/0x230
> [   22.058189]  ? finish_task_switch.isra.0+0x85/0x2a0
> [   22.058192]  ? __pfx_kthread+0x10/0x10
> [   22.058195]  ret_from_fork+0x30/0x50
> [   22.058199]  ? __pfx_kthread+0x10/0x10
> [   22.058202]  ret_from_fork_asm+0x1a/0x30
> [   22.058206]  </TASK>
> [   22.058207] ---[ end trace 0000000000000000 ]---
> [   23.123507]     ok 8 test_kfree_rcu_wq_destroy
> [   23.151033]     ok 9 test_leak_destroy
> [   23.151612]     ok 10 test_krealloc_redzone_zeroing
> [   23.151617] # slub_test: pass:10 fail:0 skip:0 total:10
> [   23.151619] # Totals: pass:10 fail:0 skip:0 total:10
> [   23.151620] ok 1 slub_test
> urezki@pc638:~$
> <snip>
> 
> but i had to adapt slightly the Vlastimil's test:
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index f11691315c2f..222f6d204b0d 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
>  #include "../mm/slab.h"
> 
>  static struct kunit_resource resource;
> @@ -181,6 +182,63 @@ static void test_kfree_rcu(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 0, slab_errors);
>  }
> 
> +struct cache_destroy_work {
> +        struct work_struct work;
> +        struct kmem_cache *s;
> +};
> +
> +static void cache_destroy_workfn(struct work_struct *w)
> +{
> +       struct cache_destroy_work *cdw;
> +
> +       cdw = container_of(w, struct cache_destroy_work, work);
> +       kmem_cache_destroy(cdw->s);
> +}
> +
> +#define KMEM_CACHE_DESTROY_NR 10
> +
> +static void test_kfree_rcu_wq_destroy(struct kunit *test)
> +{
> +       struct test_kfree_rcu_struct *p;
> +       struct cache_destroy_work cdw;
> +       struct workqueue_struct *wq;
> +       struct kmem_cache *s;
> +       unsigned int rnd;
> +       int i;
> +
> +       if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
> +               kunit_skip(test, "can't do kfree_rcu() when test is built-in");
> +
> +       INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
> +       wq = alloc_workqueue("test_kfree_rcu_destroy_wq",
> +                       WQ_HIGHPRI | WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +
> +       if (!wq)
> +               kunit_skip(test, "failed to alloc wq");
> +
> +       for (i = 0; i < KMEM_CACHE_DESTROY_NR; i++) {
> +               s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
> +                               sizeof(struct test_kfree_rcu_struct),
> +                               SLAB_NO_MERGE);
> +
> +               if (!s)
> +                       kunit_skip(test, "failed to create cache");
> +
> +               rnd = get_random_u8() % 255;
> +               p = kmem_cache_alloc(s, GFP_KERNEL);
> +               kfree_rcu(p, rcu);
> +
> +               cdw.s = s;
> +
> +               msleep(rnd);
> +               queue_work(wq, &cdw.work);
> +               flush_work(&cdw.work);
> +       }
> +
> +       destroy_workqueue(wq);
> +       KUNIT_EXPECT_EQ(test, 0, slab_errors);
> +}
> +
>  static void test_leak_destroy(struct kunit *test)
>  {
>         struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
> @@ -254,6 +312,7 @@ static struct kunit_case test_cases[] = {
>         KUNIT_CASE(test_clobber_redzone_free),
>         KUNIT_CASE(test_kmalloc_redzone_access),
>         KUNIT_CASE(test_kfree_rcu),
> +       KUNIT_CASE(test_kfree_rcu_wq_destroy),
>         KUNIT_CASE(test_leak_destroy),
>         KUNIT_CASE(test_krealloc_redzone_zeroing),
>         {}
> 
> --
> Uladzislau Rezki
>
WQ_MEM_RECLAIM-patch fixes this for me:

<snip>
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..1b5ed5512782 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
 static int rcu_delay_page_cache_fill_msec = 5000;
 module_param(rcu_delay_page_cache_fill_msec, int, 0444);

+static struct workqueue_struct *rcu_reclaim_wq;
+
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
@@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
        if (delayed_work_pending(&krcp->monitor_work)) {
                delay_left = krcp->monitor_work.timer.expires - jiffies;
                if (delay < delay_left)
-                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
                return;
        }
-       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
 }

 static void
@@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
                        // "free channels", the batch can handle. Break
                        // the loop since it is done with this CPU thus
                        // queuing an RCU work is _always_ success here.
-                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
                        WARN_ON_ONCE(!queued);
                        break;
                }
@@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
        if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
                        !atomic_xchg(&krcp->work_in_progress, 1)) {
                if (atomic_read(&krcp->backoff_page_cache_fill)) {
-                       queue_delayed_work(system_unbound_wq,
+                       queue_delayed_work(rcu_reclaim_wq,
                                &krcp->page_cache_work,
                                        msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
                } else {
@@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
        int i, j;
        struct shrinker *kfree_rcu_shrinker;

+       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",
+               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+       WARN_ON(!rcu_reclaim_wq);
+
        /* Clamp it to [0:100] seconds interval. */
        if (rcu_delay_page_cache_fill_msec < 0 ||
                rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
<snip>

it passes:

<snip>
[   15.972416] KTAP version 1
[   15.972421] 1..1
[   15.973467]     KTAP version 1
[   15.973470]     # Subtest: slub_test
[   15.973472]     # module: slub_kunit
[   15.973474]     1..10
[   15.974483]     ok 1 test_clobber_zone
[   15.974927]     ok 2 test_next_pointer
[   15.975308]     ok 3 test_first_word
[   15.975672]     ok 4 test_clobber_50th_byte
[   15.976035]     ok 5 test_clobber_redzone_free
[   15.976128] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[   15.979505]     ok 6 test_kmalloc_redzone_access
[   16.014408]     ok 7 test_kfree_rcu
[   17.726602]     ok 8 test_kfree_rcu_wq_destroy
[   17.750323]     ok 9 test_leak_destroy
[   17.750883]     ok 10 test_krealloc_redzone_zeroing
[   17.750887] # slub_test: pass:10 fail:0 skip:0 total:10
[   17.750890] # Totals: pass:10 fail:0 skip:0 total:10
[   17.750891] ok 1 slub_test
<snip>

--
Uladzislau Rezki
