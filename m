Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A32AF1E;
	Tue, 25 Feb 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505288; cv=none; b=EON2J1jIlTVD6Ygbvi+wBmRgfm1lKhJsmIr751TbDeZzavO89pwBwVqMa6z/IN6bxeimlfbopgu2uDUKiWk2nxwIB+zrm+TYHh6ALGMc1tatEUyoCuVTUyKmWfdtQZAYMmWDL8bNTV86G8qfUO9tjpuJJNpliR2eGKuSgQiBLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505288; c=relaxed/simple;
	bh=zwNwtLOGPEbKxEDJG3ir/jA0Zv73WpvXFOn5sEteQQU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP8m1orOtSIytI5yHdlkpsc3A1SXseIhzWjoDR3qzboaU8tsVwd+l/okV0yuPUD/fI+PTd2Mmk6DThlzXMb6333agfVlm+p32UJgCdlGgj6bsYv/LgEEnoE+s0RdbPemVoQ/expCDjCmxR3UXFJS4O2xH6wVp+OoohleLkTQPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acv71CTl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acv71CTl"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30738a717ffso46151831fa.0;
        Tue, 25 Feb 2025 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740505284; x=1741110084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5I0Gh7oHoYbf3JrUTgHAlRAt4Em/lhq6oj6z2kkeWE=;
        b=acv71CTlK7DXHfP/BmY+AfX3QtO5JizDDmrxjPU2zV5/cjnZ5j/MEs0c0s/qlpYeEF
         dO+62+wLoBT6o9RZkR3QJC4gXQ6L0iqnI0TJ4HM5TZaxexMAGxDom7oiZ9ubT1IA8L5B
         T7igGnQr8RCG8g1Yygcp5nbAzjmjoZqG2t+5uRu8V2z0lbqaxvC71Cat3Xp43K97fKFV
         +8T0F5sPCr6WI5QUX7xrX5K3zvgNl/J2ZtOpgFDpWGQEaw977Zedn8mKBA5K3pirezGi
         5kq0byV/W4wUR3vlXfW8ZfxBNRTijuXFNvYzFo+jWDIMjLK4GXQlaXS9AyQiLRNZBoh/
         PwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740505284; x=1741110084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5I0Gh7oHoYbf3JrUTgHAlRAt4Em/lhq6oj6z2kkeWE=;
        b=P72EZSwpp247qsmupRifmTiFoA+rdgt4EUZEYpfxZvyb9zriejklxd85UqmFy9p3sQ
         Ae6WkyRb03I7w5IKU/rBWllnYhk3SgRWu99WaIws0lBaQ8nUFcj2romdt2WaODqDIeCv
         vFBdKoGJaCPKtrGEyBjXMYwj8sY7wjuPb60pHtZNOVcYH9veZXwQR92ujS1uLHNHq2Pt
         lqw+Fruo4uerUXX6+RYsyhn2qUYPBrq95ZYy2byQbTuqScKkO/77NmnNc4iAM5zLvYIQ
         j3HnoH+dOQ0LHNbEl8ne5eNsRZ+t9DD6+wge4cmAAzp4YNJKKhDde9qcOjv5MI934POi
         34fA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Kc7x/0nPXwWo1/43+SiAsxubkDQYV2pSxJJl9FVK6IKeg+znnfJzbqNaNEq3x8XyJ2iUixSrYi+qtoo=@vger.kernel.org, AJvYcCXHIAZfg1enouuoJPbNN6fuE6h5IUyQnRUiOFMF2InRX2+P8tt4ySUyJDQpIGgTXrBEFAst@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFxHHXf+QYm2TpKHQ8LQ57eYj2M0duXGIZ2Z4lW47b5gbsVDq
	gHjJQ93jhZ6E1pFtr6HXIWv9Z+b2Hsk6MsojdJzfHwAiIm6dnPZQsoM2xH/B
X-Gm-Gg: ASbGnctZjNwY7FgbNPj5JaQ8+kYPfdNNvT+Xj0LedfXObtsHcy5jQyuiEC3Xf1tRapB
	1NmIICifjFD8b35kbFXXikdG0bxZKg/5xrCAIYWUBKYKNW7skoraTqCPLEt2kD06xTam/bpq7B4
	mz0/3AF2fCoSjdDrjv3SZbrNUWIKSHzLaCi4XpdcNeC4M2iZoXzHX45ZVNwK1Net50fBbt5p5K/
	LSlTwiRTPbth6jJCgBm5sjKHvFOB8ZIQz5MXA/hkpGTuC73c36WGSbD+beodA1SVbDYy28gBfs/
	JSpXK3B8RcHU3Uypg4q0ZJ+4WMRvXzggMJiA4PnTtBJTmdbC
X-Google-Smtp-Source: AGHT+IERP4ZmgyXaES6UzO4zr1+NRzgRjYLzr48ZZE9JhLwNo3qlzKZThk4M0ZROHzByK2v+768Rzg==
X-Received: by 2002:a2e:8642:0:b0:307:e302:a34 with SMTP id 38308e7fff4ca-30a598f6edemr66652541fa.20.1740505283628;
        Tue, 25 Feb 2025 09:41:23 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f5e4asm2812131fa.63.2025.02.25.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:41:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 18:41:19 +0100
To: Keith Busch <keith.busch@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <Z74Av6tlSOqcfb-q@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>

On Tue, Feb 25, 2025 at 10:05:37AM -0700, Keith Busch wrote:
> On Tue, Feb 25, 2025 at 09:03:38AM -0700, Keith Busch wrote:
> > On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
> > > I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> > > it's too simple, or racy, and thus we are not flushing any of the queues from
> > > kvfree_rcu_barrier()?
> >
> > Thanks, your test readily triggers it for me, but only if I load
> > rcutorture at the same time.
> 
> Oops, I sent the wrong kernel messages. This is the relevant part:
> 
> [  142.371052] workqueue: WQ_MEM_RECLAIM
> test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is
> flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> [  142.371072] WARNING: CPU: 11 PID: 186 at kernel/workqueue.c:3715
> check_flush_dependency.part.0+0xad/0x100
> [  142.375748] Modules linked in: slub_kunit(E) rcutorture(E)
> torture(E) kunit(E) iTCO_wdt(E) iTCO_vendor_support(E)
> intel_uncore_frequency_common(E) skx_edac_common(E) nfit(E)
> libnvdimm(E) kvm_intel(E) kvm(E) evdev(E) bochs(E) serio_raw(E)
> drm_kms_helper(E) i2c_i801(E) e1000e(E) i2c_smbus(E) intel_agp(E)
> intel_gtt(E) lpc_ich(E) agpgart(E) mfd_core(E) drm_shm]
> [  142.384553] CPU: 11 UID: 0 PID: 186 Comm: kworker/u64:11 Tainted: G
>            E    N 6.13.0-04839-g5e7b40f0ddce-dirty #831
> [  142.386755] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
> [  142.387849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  142.390236] Workqueue: test_kfree_rcu_destroy_wq
> cache_destroy_workfn [slub_kunit]
> [  142.391863] RIP: 0010:check_flush_dependency.part.0+0xad/0x100
> [  142.393183] Code: 75 dc 48 8b 55 18 49 8d 8d 78 01 00 00 4d 89 f0
> 48 81 c6 78 01 00 00 48 c7 c7 00 e1 9a 82 c6 05 4f 39 c5 02 01 e8 53
> bd fd ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 80 3d 39 39 c5 02 00 75 83
> 41 8b
> [  142.396981] RSP: 0018:ffffc900007cfc90 EFLAGS: 00010092
> [  142.398124] RAX: 000000000000008f RBX: ffff88803e9b10a0 RCX: 0000000000000027
> [  142.399605] RDX: ffff88803eba0d08 RSI: 0000000000000001 RDI: ffff88803eba0d00
> [  142.401092] RBP: ffff888007d9a480 R08: ffffffff83b8c808 R09: 0000000000000003
> [  142.402548] R10: ffffffff8348c820 R11: ffffffff83a11d58 R12: ffff888007150000
> [  142.404098] R13: ffff888005961400 R14: ffffffff813221a0 R15: ffff888005961400
> [  142.405561] FS:  0000000000000000(0000) GS:ffff88803eb80000(0000)
> knlGS:0000000000000000
> [  142.407297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  142.408658] CR2: 00007f826bd1a000 CR3: 00000000069db002 CR4: 0000000000772ef0
> [  142.410259] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  142.411871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  142.413341] PKRU: 55555554
> [  142.414038] Call Trace:
> [  142.414658]  <TASK>
> [  142.415249]  ? __warn+0x8d/0x180
> [  142.416035]  ? check_flush_dependency.part.0+0xad/0x100
> [  142.417182]  ? report_bug+0x160/0x170
> [  142.418041]  ? handle_bug+0x4f/0x90
> [  142.418861]  ? exc_invalid_op+0x14/0x70
> [  142.419853]  ? asm_exc_invalid_op+0x16/0x20
> [  142.420877]  ? kfree_rcu_shrink_scan+0x120/0x120
> [  142.422029]  ? check_flush_dependency.part.0+0xad/0x100
> [  142.423244]  __flush_work+0x38a/0x4a0
> [  142.424157]  ? find_held_lock+0x2b/0x80
> [  142.425070]  ? flush_rcu_work+0x26/0x40
> [  142.425953]  ? lock_release+0xb3/0x250
> [  142.426785]  ? __mutex_unlock_slowpath+0x2c/0x270
> [  142.427906]  flush_rcu_work+0x30/0x40
> [  142.428756]  kvfree_rcu_barrier+0xe9/0x130
> [  142.429649]  kmem_cache_destroy+0x2b/0x1f0
> [  142.430578]  cache_destroy_workfn+0x20/0x40 [slub_kunit]
> [  142.431729]  process_one_work+0x1cd/0x560
> [  142.432620]  worker_thread+0x183/0x310
> [  142.433487]  ? rescuer_thread+0x330/0x330
> [  142.434428]  kthread+0xd8/0x1d0
> [  142.435248]  ? ret_from_fork+0x17/0x50
> [  142.436165]  ? lock_release+0xb3/0x250
> [  142.437106]  ? kthreads_online_cpu+0xf0/0xf0
> [  142.438133]  ret_from_fork+0x2d/0x50
> [  142.439045]  ? kthreads_online_cpu+0xf0/0xf0
> [  142.440428]  ret_from_fork_asm+0x11/0x20
> [  142.441476]  </TASK>
> [  142.442152] irq event stamp: 22858
> [  142.443002] hardirqs last  enabled at (22857): [<ffffffff82044ef4>]
> _raw_spin_unlock_irq+0x24/0x30
> [  142.445032] hardirqs last disabled at (22858): [<ffffffff82044ce3>]
> _raw_spin_lock_irq+0x43/0x50
> [  142.451450] softirqs last  enabled at (22714): [<ffffffff810bfdbc>]
> __irq_exit_rcu+0xac/0xd0
> [  142.453345] softirqs last disabled at (22709): [<ffffffff810bfdbc>]
> __irq_exit_rcu+0xac/0xd0
> [  142.455305] ---[ end trace 0000000000000000 ]---
Thanks!

I can trigger this also:

<snip>
[   21.712856] KTAP version 1
[   21.712862] 1..1
[   21.714486]     KTAP version 1
[   21.714490]     # Subtest: slub_test
[   21.714492]     # module: slub_kunit
[   21.714495]     1..10
[   21.750359]     ok 1 test_clobber_zone
[   21.750955]     ok 2 test_next_pointer
[   21.751532]     ok 3 test_first_word
[   21.751991]     ok 4 test_clobber_50th_byte
[   21.752493]     ok 5 test_clobber_redzone_free
[   21.753004] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[   21.756176]     ok 6 test_kmalloc_redzone_access
[   21.806549]     ok 7 test_kfree_rcu
[   22.058010] ------------[ cut here ]------------
[   22.058015] workqueue: WQ_MEM_RECLAIM test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
[   22.058039] WARNING: CPU: 19 PID: 474 at kernel/workqueue.c:3715 check_flush_dependency.part.0+0xbe/0x130
[   22.058047] Modules linked in: slub_kunit(E) kunit(E) binfmt_misc(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E) ppdev(E) drm_kms_helper(E) snd_pcm(E) sg(E) snd_timer(E) evdev(E) snd(E) joydev(E) parport_pc(E) parport(E) soundcore(E) serio_raw(E) button(E) pcspkr(E) drm(E) fuse(E) dm_mod(E) efi_pstore(E) configfs(E) loop(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) sd_mod(E) cdrom(E) ata_generic(E) ata_piix(E) libata(E) scsi_mod(E) i2c_piix4(E) psmouse(E) e1000(E) i2c_smbus(E) scsi_common(E) floppy(E)
[   22.058091] CPU: 19 UID: 0 PID: 474 Comm: kworker/u257:0 Kdump: loaded Tainted: G            E    N 6.14.0-rc1+ #286
[   22.058096] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
[   22.058097] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   22.058099] Workqueue: test_kfree_rcu_destroy_wq cache_destroy_workfn [slub_kunit]
[   22.058103] RIP: 0010:check_flush_dependency.part.0+0xbe/0x130
[   22.058106] Code: 75 d0 48 8b 55 18 49 8d 8d c0 00 00 00 4d 89 f0 48 81 c6 c0 00 00 00 48 c7 c7 b0 7d c8 bd c6 05 6c 78 53 01 01 e8 a2 ae fd ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc f6 c4 08 74 94 31 ed
[   22.058108] RSP: 0018:ffff95e5c123fd50 EFLAGS: 00010086
[   22.058111] RAX: 0000000000000000 RBX: ffff89a4ff22d5a0 RCX: 0000000000000000
[   22.058113] RDX: 0000000000000003 RSI: ffffffffbdce1697 RDI: 00000000ffffffff
[   22.058114] RBP: ffff89961043a780 R08: 0000000000000000 R09: 0000000000000003
[   22.058116] R10: ffff95e5c123fbe8 R11: ffff89a53fefefa8 R12: ffff89960cb6b080
[   22.058117] R13: ffff899600051400 R14: ffffffffbcf2ba80 R15: ffff89960005a800
[   22.058120] FS:  0000000000000000(0000) GS:ffff89a4ff2c0000(0000) knlGS:0000000000000000
[   22.058122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.058124] CR2: 000055bf2cbc6038 CR3: 000000010dc1e000 CR4: 00000000000006f0
[   22.058128] Call Trace:
[   22.058130]  <TASK>
[   22.058133]  ? __warn+0x85/0x130
[   22.058137]  ? check_flush_dependency.part.0+0xbe/0x130
[   22.058139]  ? report_bug+0x18d/0x1c0
[   22.058142]  ? prb_read_valid+0x17/0x20
[   22.058147]  ? handle_bug+0x58/0x90
[   22.058151]  ? exc_invalid_op+0x13/0x60
[   22.058154]  ? asm_exc_invalid_op+0x16/0x20
[   22.058158]  ? __pfx_kfree_rcu_work+0x10/0x10
[   22.058162]  ? check_flush_dependency.part.0+0xbe/0x130
[   22.058165]  __flush_work+0xd6/0x320
[   22.058168]  flush_rcu_work+0x39/0x50
[   22.058171]  kvfree_rcu_barrier+0xe9/0x130
[   22.058174]  kmem_cache_destroy+0x18/0x140
[   22.058177]  process_one_work+0x184/0x3a0
[   22.058180]  worker_thread+0x24d/0x360
[   22.058183]  ? __pfx_worker_thread+0x10/0x10
[   22.058185]  kthread+0xfc/0x230
[   22.058189]  ? finish_task_switch.isra.0+0x85/0x2a0
[   22.058192]  ? __pfx_kthread+0x10/0x10
[   22.058195]  ret_from_fork+0x30/0x50
[   22.058199]  ? __pfx_kthread+0x10/0x10
[   22.058202]  ret_from_fork_asm+0x1a/0x30
[   22.058206]  </TASK>
[   22.058207] ---[ end trace 0000000000000000 ]---
[   23.123507]     ok 8 test_kfree_rcu_wq_destroy
[   23.151033]     ok 9 test_leak_destroy
[   23.151612]     ok 10 test_krealloc_redzone_zeroing
[   23.151617] # slub_test: pass:10 fail:0 skip:0 total:10
[   23.151619] # Totals: pass:10 fail:0 skip:0 total:10
[   23.151620] ok 1 slub_test
urezki@pc638:~$
<snip>

but i had to adapt slightly the Vlastimil's test:

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index f11691315c2f..222f6d204b0d 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 #include "../mm/slab.h"

 static struct kunit_resource resource;
@@ -181,6 +182,63 @@ static void test_kfree_rcu(struct kunit *test)
        KUNIT_EXPECT_EQ(test, 0, slab_errors);
 }

+struct cache_destroy_work {
+        struct work_struct work;
+        struct kmem_cache *s;
+};
+
+static void cache_destroy_workfn(struct work_struct *w)
+{
+       struct cache_destroy_work *cdw;
+
+       cdw = container_of(w, struct cache_destroy_work, work);
+       kmem_cache_destroy(cdw->s);
+}
+
+#define KMEM_CACHE_DESTROY_NR 10
+
+static void test_kfree_rcu_wq_destroy(struct kunit *test)
+{
+       struct test_kfree_rcu_struct *p;
+       struct cache_destroy_work cdw;
+       struct workqueue_struct *wq;
+       struct kmem_cache *s;
+       unsigned int rnd;
+       int i;
+
+       if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
+               kunit_skip(test, "can't do kfree_rcu() when test is built-in");
+
+       INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
+       wq = alloc_workqueue("test_kfree_rcu_destroy_wq",
+                       WQ_HIGHPRI | WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+
+       if (!wq)
+               kunit_skip(test, "failed to alloc wq");
+
+       for (i = 0; i < KMEM_CACHE_DESTROY_NR; i++) {
+               s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
+                               sizeof(struct test_kfree_rcu_struct),
+                               SLAB_NO_MERGE);
+
+               if (!s)
+                       kunit_skip(test, "failed to create cache");
+
+               rnd = get_random_u8() % 255;
+               p = kmem_cache_alloc(s, GFP_KERNEL);
+               kfree_rcu(p, rcu);
+
+               cdw.s = s;
+
+               msleep(rnd);
+               queue_work(wq, &cdw.work);
+               flush_work(&cdw.work);
+       }
+
+       destroy_workqueue(wq);
+       KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+
 static void test_leak_destroy(struct kunit *test)
 {
        struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
@@ -254,6 +312,7 @@ static struct kunit_case test_cases[] = {
        KUNIT_CASE(test_clobber_redzone_free),
        KUNIT_CASE(test_kmalloc_redzone_access),
        KUNIT_CASE(test_kfree_rcu),
+       KUNIT_CASE(test_kfree_rcu_wq_destroy),
        KUNIT_CASE(test_leak_destroy),
        KUNIT_CASE(test_krealloc_redzone_zeroing),
        {}

--
Uladzislau Rezki
