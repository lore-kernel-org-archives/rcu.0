Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A82AE72
	for <rcu@vger.kernel.org>; Mon, 30 Dec 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584509; cv=none; b=Q3fut/OMx+4ajcFvcxXVLgcefsw+1cd24fErYGNA1SfwCaLAETksbYM/+uPvhEYjYSXZ0mjoxjjFnJ/3Va3VeThUjQ2WUeAgTFy4cIIqa7omsUDu+gW9IIdauyLW8WmNR/ZbOC4NsQUOOE8EqYRXu+78vLd0T4xpnL5Hf92qkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584509; c=relaxed/simple;
	bh=vOZPK99jwJnyV+ZU5YfMuB4gVnhvvcDavetQ180+0Ss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UlpqHmZ9CdEb7SFTZ30N59xQWvL/UFfBlZ3LkWSIW7Sprm4SQqGcIDBlUxIUM9xGehbn2zAUNzKilaFJ30+e9aoQ8Lgx6R22eug0Nyy8kZWrKS/61rKkxwQDx8VrBYQ293cwtaW+UhFr4Xo0akTENkv8cAXTWAVtqTa4TvI3O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjO2kOx6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjO2kOx6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8e8445219so82925696d6.0
        for <rcu@vger.kernel.org>; Mon, 30 Dec 2024 10:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735584506; x=1736189306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xi7aqx4A/jEA+larur7YEd0n59I4ZMjIDGC7lOz02u0=;
        b=CjO2kOx6avSKKdyxreWBP9YyzqRA1C4DkFFzI1uKDjkzazaZWEO0W+HGNaPxvH87Q/
         516KvyUvS0UoMyq7daE4fyLR8AVtkfR+nqYLGoxkCCrx4lx/Qso/sUVOh7Dn7b2oGAnn
         RjomBJXEhrp6NflT3Ybh/cEq2PfFc3tVRhbuNQPM999R/eP97XujYVcUhYltkAuOZgWU
         vKGwmcvN6LayMVV5SuY/OvllV5UyMgb7w+BliZHQk48VOjg8mQGyFc+ah9ZJ0WdoKMi5
         uLx6/wAdl+mif24Hj7z4IBSoUUqz2KSS0x1799wkhcljEEZ4lJf8lf9ONBRIM7T2wdXm
         Ns7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735584506; x=1736189306;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi7aqx4A/jEA+larur7YEd0n59I4ZMjIDGC7lOz02u0=;
        b=g+s67O5NX3lHL/MX7jMZ35XrbakwylEJSk6+nCHEM5TAQMl84oQBkF6ywbAU71yLHz
         MqQkb6UkckA4zVxrd+6d2Cq79uaT+McTlKwLYUms7tb5QP1KxT/NDSQNBCtzX64mdp2J
         Iue9xY5lvVwG3te8jyKg+LHGg8WreIyz5mjRvkR8FtRBpKrsfADMKnerG0LX17OjHly1
         vYpCiCM5Y8KUwKGRU58sb6MScNYWSxUqNycyGtJmQ/SiiZoDcO47Br024GP3Eovsd3Pa
         MIGo/0rtuhY7juxIvOyI/r/+CCj9XFolQkt9OBGWw1KEDnPwnX7bsSRu3UPlmwIc4Wz1
         teoA==
X-Gm-Message-State: AOJu0Yw6Pv1ZKsw5f5kOGjq4shqwxm0DLY4dOnrDB4YBhs4lXVuBuPPp
	DH6Sn1N5jztBoX2XaS5lDwMazjcOfJAjOcH9TXHWYUzmD5dWDXYHdOJnqXfQtI49SVm4GssIJuc
	32w8Wg1+JKPDrkOcuJfxlWJT2azU=
X-Gm-Gg: ASbGnct9ZiKKQGS0TdKu0fncfxbuvf2fxHncsNp4m1HEyd2jgDpGF2l7lvOmqvlZcK+
	CYg6RdwFx8dRjgC7fWABpGqaaX5FXdeb1CyqHzb37
X-Google-Smtp-Source: AGHT+IGRif8wLCRI4aK1Wz39oO3AGoUgO4EiQAeC8H0JrbRteRYNI2SvNxTgJYEEzyOqtGwO65NsYakHzoKzU3tE44c=
X-Received: by 2002:a05:6214:1c8b:b0:6d8:8289:26ac with SMTP id
 6a1803df08f44-6dd233b7e53mr639489416d6.45.1735584505505; Mon, 30 Dec 2024
 10:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Mon, 30 Dec 2024 13:48:14 -0500
Message-ID: <CA+-ZZ_jhePUUqh6UB0X3jeRdXn0Bp9=acJZfGTvGM_z6tMW9cQ@mail.gmail.com>
Subject: reproducible 'rcu_preempt detected stalls' in v6.12
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	urezki@gmail.com
Cc: rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following rcu stall in Linux kernel 6.12, which generally can be
reproduced within a second in a QEMU VM. To our knowledge, this problem has not
been observed by Syzbot so we would like to report it for your reference.

- dmesg
[   29.143477] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   29.146544] rcu: 0-...!: (6 ticks this GP)
idle=f6ec/1/0x4000000000000000 softirq=1509/1509 fqs=1
[   29.150609] rcu: (detected by 1, t=5306452861497 jiffies, g=1613,
q=209 ncpus=4)
[   29.154039] Sending NMI from CPU 1 to CPUs 0:
[5306452890.645663] NMI backtrace for cpu 0
[5306452890.645671] CPU: 0 PID: 105 Comm: systemd-journal Tainted: G S
                6.10.0 #2
[5306452890.645682] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[5306452890.645688] RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x60
[5306452890.645937] Code: 8b 80 68 0a 00 00 c3 cc cc cc cc 0f 1f 80 00
00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
48 8b 34 24 <65> 48 8b 05 40 cb bf 7e 65 8b 15 41 cb bf 7e f7 c2 00 01
ff 00 74
[5306452890.645947] RSP: 0018:ffff88806d209ce8 EFLAGS: 00000046
[5306452890.645981] RAX: ffff88800a7a5a00 RBX: 000000006775306a RCX:
0000000000000000
[5306452890.645988] RDX: 0000000080010003 RSI: ffffffff81364388 RDI:
000000006775306a
[5306452890.645994] RBP: ffff88806d209de0 R08: 000f424000000000 R09:
ffffed100da41399
[5306452890.646001] R10: ffffed100da41398 R11: 0000000000000003 R12:
0000000000000000
[5306452890.646007] R13: 000000006775306a R14: 001dcd6500000000 R15:
0007f250df000000
[5306452890.646013] FS:  00007f6410257900(0000)
GS:ffff88806d200000(0000) knlGS:0000000000000000
[5306452890.646045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5306452890.646053] CR2: 00007f640f6fdc98 CR3: 0000000008d4a000 CR4:
00000000000006f0
[5306452890.646059] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[5306452890.646065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[5306452890.646071] Call Trace:
[5306452890.646077]  <NMI>
[5306452890.646081]  ? show_regs+0x73/0x80
[5306452890.646109]  ? nmi_cpu_backtrace+0x108/0x1e0
[5306452890.646189]  ? nmi_cpu_backtrace_handler+0xc/0x20
[5306452890.646203]  ? nmi_handle+0xb2/0x2e0
[5306452890.646216]  ? __sanitizer_cov_trace_pc+0x8/0x60
[5306452890.646229]  ? default_do_nmi+0x53/0x180
[5306452890.646243]  ? exc_nmi+0x132/0x170
[5306452890.646256]  ? end_repeat_nmi+0xf/0x53
[5306452890.646285]  ? second_overflow+0x2d8/0x3f0
[5306452890.646309]  ? __sanitizer_cov_trace_pc+0x8/0x60
[5306452890.646322]  ? __sanitizer_cov_trace_pc+0x8/0x60
[5306452890.646335]  ? __sanitizer_cov_trace_pc+0x8/0x60
[5306452890.646349]  </NMI>
[5306452890.646352]  <IRQ>
[5306452890.646355]  second_overflow+0x2d8/0x3f0
[5306452890.646366]  timekeeping_advance+0x210/0x800
[5306452890.646377]  ? __pfx_timekeeping_advance+0x10/0x10
[5306452890.646387]  ? _raw_spin_lock+0x80/0xe0
[5306452890.646402]  ? __pfx__raw_spin_lock+0x10/0x10
[5306452890.646416]  ? delta_to_ns_safe+0x1c/0xe0
[5306452890.646431]  ? __pfx_tick_nohz_handler+0x10/0x10
[5306452890.646448]  update_wall_time+0x10/0x30
[5306452890.646458]  tick_do_update_jiffies64+0x1a0/0x270
[5306452890.646474]  tick_nohz_handler+0x3f1/0x4b0
[5306452890.646484]  ? __pfx_tick_nohz_handler+0x10/0x10
[5306452890.646498]  __hrtimer_run_queues+0x2d2/0x6c0
[5306452890.646513]  ? __pfx_sched_clock_cpu+0x10/0x10
[5306452890.646540]  ? __pfx___hrtimer_run_queues+0x10/0x10
[5306452890.646554]  ? ktime_get_update_offsets_now+0x1ac/0x310
[5306452890.646566]  hrtimer_interrupt+0x2cf/0x6e0
[5306452890.646583]  __sysvec_apic_timer_interrupt+0x88/0x290
[5306452890.646600]  sysvec_apic_timer_interrupt+0x69/0x90
[5306452890.646612]  </IRQ>
[5306452890.646615]  <TASK>
[5306452890.646618]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[5306452890.646633] RIP: 0010:_raw_spin_unlock_irqrestore+0x3e/0x70
[5306452890.646648] Code: fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07
38 d0 7f 04 84 c0 75 2c c6 07 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d
ca 52 1f 7c <74> 09 48 83 c4 10 c3 cc cc cc cc 0f 1f 44 00 00 48 83 c4
10 c3 cc
[5306452890.646657] RSP: 0018:ffff88800d64f6f0 EFLAGS: 00000282
[5306452890.646666] RAX: 0000000000000000 RBX: 000000000000003f RCX:
0000000000000000
[5306452890.646672] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
ffff88807ffdc8a0
[5306452890.646678] RBP: ffffea00001cc880 R08: ffffea00001cc8c8 R09:
1ffffd400003991a
[5306452890.646684] R10: 0000000000000020 R11: 1ffff1100fffb8b5 R12:
ffff88807ffdc4c0
[5306452890.646690] R13: ffff88806d23e080 R14: ffffea00001cc888 R15:
dffffc0000000000
[5306452890.646701]  __rmqueue_pcplist+0x8fb/0x1440
[5306452890.646742]  ? string_nocheck+0x173/0x1e0
[5306452890.646752]  ? __pfx_string_nocheck+0x10/0x10
[5306452890.646760]  ? __pfx___rmqueue_pcplist+0x10/0x10
[5306452890.646770]  ? __pfx__raw_spin_trylock+0x10/0x10
[5306452890.646784]  ? format_decode+0x220/0x970
[5306452890.646799]  get_page_from_freelist+0x3c6/0x31f0
[5306452890.646812]  ? vsnprintf+0x422/0x14d0
[5306452890.646823]  ? make_vfsuid+0xa0/0xf0
[5306452890.646851]  ? __pfx_make_vfsuid+0x10/0x10
[5306452890.646865]  ? __pfx_get_page_from_freelist+0x10/0x10
[5306452890.646876]  ? generic_permission+0x1c6/0x5b0
[5306452890.646902]  ? make_vfsuid+0xa0/0xf0
[5306452890.646914]  ? __pfx_make_vfsuid+0x10/0x10
[5306452890.646927]  __alloc_pages_noprof+0x2c5/0x5b0
[5306452890.646940]  ? link_path_walk.part.0+0x128/0xb90
[5306452890.646955]  ? __pfx___alloc_pages_noprof+0x10/0x10
[5306452890.646968]  ? dput+0x12/0x4d0
[5306452890.646980]  ? mntput+0x10/0xc0
[5306452890.646992]  ? terminate_walk+0x2bc/0x570
[5306452890.647004]  new_slab+0xc4/0x2f0
[5306452890.647014]  ___slab_alloc+0x635/0xaf0
[5306452890.647024]  ? __d_alloc+0x31/0x8b0
[5306452890.647036]  __slab_alloc.isra.0+0x1a/0x40
[5306452890.647046]  kmem_cache_alloc_lru_noprof+0x227/0x230
[5306452890.647057]  ? d_same_name+0xc5/0x280
[5306452890.647067]  ? __d_alloc+0x31/0x8b0
[5306452890.647077]  __d_alloc+0x31/0x8b0
[5306452890.647088]  d_alloc+0x44/0x200
[5306452890.647099]  lookup_one_qstr_excl+0xc0/0x180
[5306452890.647114]  do_renameat2+0x44f/0xa60
[5306452890.647127]  ? __pfx_do_renameat2+0x10/0x10
[5306452890.647173]  ? __pfx_vfs_read+0x10/0x10
[5306452890.647192]  ? __seccomp_filter+0x52d/0x11a0
[5306452890.647207]  ? __kasan_slab_alloc+0x59/0x70
[5306452890.647220]  ? strncpy_from_user+0x199/0x260
[5306452890.647299]  ? getname_flags+0x24d/0x590
[5306452890.647308]  __x64_sys_rename+0x81/0xa0
[5306452890.647320]  do_syscall_64+0x4b/0x110
[5306452890.647333]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[5306452890.647346] RIP: 0033:0x7f6410a75ed7
[5306452890.647355] Code: e8 6e 82 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8
5d c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00
00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 89 8f 17 00 f7 d8 64
89 02 b8
[5306452890.647364] RSP: 002b:00007ffc5f1c18f8 EFLAGS: 00000202
ORIG_RAX: 0000000000000052
[5306452890.647373] RAX: ffffffffffffffda RBX: 00007f6410c23000 RCX:
00007f6410a75ed7
[5306452890.647380] RDX: 0000000000000012 RSI: 00005625b0e6dad0 RDI:
00005625b0e32350
[5306452890.647386] RBP: 00005625b0e63560 R08: 00005625b0e31940 R09:
00005625b0e6db00
[5306452890.647392] R10: 00062a80f2437d09 R11: 0000000000000202 R12:
00005625b0e32350
[5306452890.647399] R13: 00005625b0e323b8 R14: 0000000000000001 R15:
ffffffffffffffff
[5306452890.647407]  </TASK>
[5306452890.647412] INFO: NMI handler (nmi_cpu_backtrace_handler) took
too long to run: 1.750 msecs
[   29.158147] rcu: rcu_preempt kthread timer wakeup didn't happen for
5306452861487 jiffies! g1613 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   29.423702] rcu: Possible timer handling issue on cpu=3 timer-softirq=397
[   29.426248] rcu: rcu_preempt kthread starved for 5306452861490
jiffies! g1613 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=3
[   29.430254] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[   29.433534] rcu: RCU grace-period kthread stack dump:
[   29.435425] task:rcu_preempt     state:I stack:29880 pid:15
tgid:15    ppid:2      flags:0x00004000
[   29.438828] Call Trace:
[   29.439785]  <TASK>
[   29.440628]  __schedule+0x9f4/0x2010
[   29.442013]  ? kvm_sched_clock_read+0x16/0x30
[   29.443653]  ? __pfx___schedule+0x10/0x10
[   29.445169]  ? enqueue_timer+0x2d1/0x3f0
[   29.446652]  ? internal_add_timer+0xb7/0x110
[   29.448272]  ? __pfx_internal_add_timer+0x10/0x10
[   29.450041]  schedule+0x66/0x140
[   29.451281]  schedule_timeout+0x3c6/0x5d0
[   29.452783]  ? rcu_dynticks_snap+0x46/0x90
[   29.454336]  ? __pfx_schedule_timeout+0x10/0x10
[   29.456029]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   29.457914]  ? __pfx_process_timeout+0x10/0x10
[   29.459577]  ? prepare_to_swait_event+0xb1/0x3b0
[   29.461308]  rcu_gp_fqs_loop+0x4c1/0xaf0
[   29.462796]  ? rcu_gp_init+0x779/0x12e0
[   29.464239]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
[   29.465924]  ? finish_swait+0x8d/0x240
[   29.467351]  rcu_gp_kthread+0x300/0x420
[   29.468807]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   29.470450]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   29.472324]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[   29.474155]  ? __kthread_parkme+0xe3/0x160
[   29.475691]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   29.477326]  kthread+0x2c7/0x3c0
[   29.478584]  ? __pfx_kthread+0x10/0x10
[   29.480000]  ret_from_fork+0x48/0x80
[   29.481357]  ? __pfx_kthread+0x10/0x10
[   29.482787]  ret_from_fork_asm+0x1a/0x30
[   29.484285]  </TASK>
[   29.485154] rcu: Stack dump where RCU GP kthread last ran:
[   29.487175] Sending NMI from CPU 1 to CPUs 3:
[   29.488933] NMI backtrace for cpu 3
[   29.488945] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S
   6.10.0 #2
[   29.488954] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   29.488958] RIP: 0010:mce_rdmsrl+0x24/0x80
[   29.488976] Code: 90 90 90 90 90 90 66 0f 1f 00 41 54 41 89 fc 53
0f 1f 44 00 00 65 8a 05 3d 3b 20 7c 84 c0 75 24 0f 1f 44 00 00 44 89
e1 0f 32 <49> 89 d4 49 c1 e4 20 49 09 c4 0f 1f 44 00 00 4c 89 e0 5b 41
5c c3
[   29.488983] RSP: 0018:ffff88806d389c60 EFLAGS: 00000246
[   29.488990] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000401
[   29.488995] RDX: 0000000000000000 RSI: ffffffff810da777 RDI: 0000000000000401
[   29.488999] RBP: 0000000000000401 R08: ffffed100da71394 R09: ffffed100da74f71
[   29.489003] R10: ffffed100da74f70 R11: ffff88806d3a7b87 R12: 0000000000000401
[   29.489008] R13: ffff88806d3a11a0 R14: dffffc0000000000 R15: 0000000000000001
[   29.489013] FS:  0000000000000000(0000) GS:ffff88806d380000(0000)
knlGS:0000000000000000
[   29.489038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.489044] CR2: 00007fc7918fa4d0 CR3: 000000000bff2000 CR4: 00000000000006f0
[   29.489049] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.489053] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.489057] Call Trace:
[   29.489062]  <NMI>
[   29.489066]  ? show_regs+0x73/0x80
[   29.489077]  ? nmi_cpu_backtrace+0x108/0x1e0
[   29.489089]  ? nmi_cpu_backtrace_handler+0xc/0x20
[   29.489100]  ? nmi_handle+0xb2/0x2e0
[   29.489109]  ? mce_rdmsrl+0x24/0x80
[   29.489120]  ? default_do_nmi+0x53/0x180
[   29.489130]  ? exc_nmi+0x132/0x170
[   29.489139]  ? end_repeat_nmi+0xf/0x53
[   29.489151]  ? machine_check_poll+0x167/0x390
[   29.489161]  ? mce_rdmsrl+0x24/0x80
[   29.489171]  ? mce_rdmsrl+0x24/0x80
[   29.489182]  ? mce_rdmsrl+0x24/0x80
[   29.489192]  </NMI>
[   29.489194]  <IRQ>
[   29.489196]  machine_check_poll+0x16e/0x390
[   29.489206]  ? __pfx_machine_check_poll+0x10/0x10
[   29.489216]  ? __pfx__raw_spin_lock+0x10/0x10
[   29.489227]  ? enqueue_timer+0xf6/0x3f0
[   29.489236]  ? __pfx_mce_timer_fn+0x10/0x10
[   29.489244]  ? __pfx_mce_timer_fn+0x10/0x10
[   29.489253]  cmci_mc_poll_banks+0x2b/0x40
[   29.489263]  mce_timer_fn+0x5d/0x100
[   29.489272]  ? __pfx_mce_timer_fn+0x10/0x10
[   29.489280]  call_timer_fn+0x36/0x230
[   29.489288]  ? __pfx_mce_timer_fn+0x10/0x10
[   29.489297]  __run_timer_base.part.0+0x5cf/0x8f0
[   29.489307]  ? __pfx___run_timer_base.part.0+0x10/0x10
[   29.489316]  ? kvm_clock_read+0x2c/0x50
[   29.489338]  ? ktime_get+0xe2/0x170
[   29.489346]  ? lapic_next_event+0x11/0x20
[   29.489356]  ? clockevents_program_event+0x23c/0x310
[   29.489366]  ? tick_program_event+0x84/0x110
[   29.489376]  run_timer_softirq+0x77/0x1b0
[   29.489385]  handle_softirqs+0x165/0x520
[   29.489398]  irq_exit_rcu+0x7f/0xb0
[   29.489409]  sysvec_apic_timer_interrupt+0x6e/0x90
[   29.489418]  </IRQ>
[   29.489444]  <TASK>
[   29.489448]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   29.489460] RIP: 0010:default_idle+0x1e/0x30
[   29.489470] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
0f 1f 44 00 00 eb 0c 0f 1f 44 00 00 0f 00 2d 79 d9 3f 00 0f 1f 44 00
00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
90 90
[   29.489477] RSP: 0018:ffff888006f47e68 EFLAGS: 00000216
[   29.489483] RAX: ffff88806d380000 RBX: 0000000000000003 RCX: ffffffff83e26864
[   29.489488] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 000000000015b60c
[   29.489492] RBP: dffffc0000000000 R08: ffff888008b340c8 R09: ffffed100da76a99
[   29.489497] R10: ffffed100da76a98 R11: ffff88806d3b54c3 R12: ffffffff856175d0
[   29.489502] R13: 1ffff11000de8fd2 R14: 0000000000000000 R15: 0000000000000000
[   29.489507]  ? ct_kernel_exit.constprop.0+0xb4/0xe0
[   29.489517]  default_idle_call+0x38/0x60
[   29.489526]  do_idle+0x2e8/0x3a0
[   29.489534]  ? __pfx_do_idle+0x10/0x10
[   29.489541]  ? complete_with_flags+0x75/0xa0
[   29.489551]  cpu_startup_entry+0x4f/0x60
[   29.489558]  start_secondary+0x1ba/0x210
[   29.489568]  common_startup_64+0x12c/0x138
[   29.489577]  </TASK>
[   30.333994] msr: Write to unrecognized MSR 0x10 by syz-executor (pid: 248).
[   30.336675] msr: See
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for
details.
[5306453164.764899] rcu: INFO: rcu_preempt self-detected stall on CPU
[5306453164.767644] rcu: 0-...0: (8 ticks this GP)
idle=f6ec/1/0x4000000000000000 softirq=1509/1509 fqs=2
[5306453164.771464] rcu: (t=5306453135629 jiffies g=1613 q=436 ncpus=4)
[5306453164.774056] rcu: rcu_preempt kthread starved for 274132
jiffies! g1613 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=2
[5306453164.778380] rcu: Unless rcu_preempt kthread gets sufficient
CPU time, OOM is now expected behavior.
[5306453164.782227] rcu: RCU grace-period kthread stack dump:
[5306453164.784434] task:rcu_preempt     state:R  running task
stack:29880 pid:15    tgid:15    ppid:2      flags:0x00004000
[5306453164.788943] Call Trace:
[5306453164.790157]  <TASK>
[5306453164.791280]  __schedule+0x9f4/0x2010
[5306453164.792969]  ? kvm_sched_clock_read+0x16/0x30
[5306453164.794935]  ? __pfx___schedule+0x10/0x10
[5306453164.796758]  ? enqueue_timer+0x2d1/0x3f0
[5306453164.798576]  ? internal_add_timer+0xb7/0x110
[5306453164.800519]  ? __pfx_internal_add_timer+0x10/0x10
[5306453164.802601]  schedule+0x66/0x140
[5306453164.804177]  schedule_timeout+0x3c6/0x5d0
[5306453164.806021]  ? __pfx_schedule_timeout+0x10/0x10
[5306453164.808032]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[5306453164.810305]  ? __pfx_process_timeout+0x10/0x10
[5306453164.812344]  ? prepare_to_swait_event+0xb1/0x3b0
[5306453164.814392]  rcu_gp_fqs_loop+0x4c1/0xaf0
[5306453164.816214]  ? rcu_gp_init+0x779/0x12e0
[5306453164.817978]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
[5306453164.819980]  ? finish_swait+0x8d/0x240
[5306453164.821705]  rcu_gp_kthread+0x300/0x420
[5306453164.823453]  ? __pfx_rcu_gp_kthread+0x10/0x10
[5306453164.825408]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[5306453164.827632]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[5306453164.829783]  ? __kthread_parkme+0xe3/0x160
[5306453164.831659]  ? __pfx_rcu_gp_kthread+0x10/0x10
[5306453164.833632]  kthread+0x2c7/0x3c0
[5306453164.835147]  ? __pfx_kthread+0x10/0x10
[5306453164.836867]  ret_from_fork+0x48/0x80
[5306453164.838557]  ? __pfx_kthread+0x10/0x10
[5306453164.840276]  ret_from_fork_asm+0x1a/0x30
[5306453164.842135]  </TASK>
[5306453164.843235] rcu: Stack dump where RCU GP kthread last ran:
[5306453164.845644] Sending NMI from CPU 0 to CPUs 2:
[  303.358193] NMI backtrace for cpu 2
[  303.358209] CPU: 2 PID: 144 Comm: rsyslogd Tainted: G S
    6.10.0 #2
[  303.358222] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  303.358230] RIP: 0033:0x7f8c1e0936e3
[  303.358242] Code: 8b 15 e1 b9 ff ff 48 0f af c2 48 01 c3 48 d3 eb
48 8b 0d d8 b9 ff ff 41 8b 00 41 39 c1 75 95 48 81 fb ff c9 9a 3b 76
18 31 d2 <48> 81 eb 00 ca 9a 3b 83 c2 01 48 81 fb ff c9 9a 3b 77 ed 48
01 d1
[  303.358253] RSP: 002b:00007ffc1cb796e0 EFLAGS: 00000212
[  303.358264] RAX: 0000000000005120 RBX: 3527dc5666fa5853 RCX: 00000001a3bcf264
[  303.358272] RDX: 00000000052a2078 RSI: 0000000000000000 RDI: 00007ffc1cb79730
[  303.358279] RBP: 00007ffc1cb79720 R08: 00007f8c1e08f080 R09: 0000000000005120
[  303.358286] R10: 7fffffffffffffff R11: 4000000000000000 R12: 00007ffc1cb79800
[  303.358293] R13: 0000000000000000 R14: 00007f8c1e090000 R15: 000000518007829b
[  303.358300] FS:  00007f8c1db24240 GS:  0000000000000000
[5306453164.848643] CPU: 0 PID: 105 Comm: systemd-journal Tainted: G S
                6.10.0 #2
[5306453164.887378] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[5306453164.891212] RIP: 0010:_raw_spin_unlock_irqrestore+0x3e/0x70
[5306453164.893751] Code: fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07
38 d0 7f 04 84 c0 75 2c c6 07 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d
ca 52 1f 7c <74> 09 48 83 c4 10 c3 cc cc cc cc 0f 1f 44 00 00 48 83 c4
10 c3 cc
[5306453164.901236] RSP: 0018:ffff88800d64f6f0 EFLAGS: 00000282
[5306453164.903503] RAX: 0000000000000000 RBX: 000000000000003f RCX:
0000000000000000
[5306453164.906496] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
ffff88807ffdc8a0
[5306453164.909604] RBP: ffffea00001cc880 R08: ffffea00001cc8c8 R09:
1ffffd400003991a
[5306453164.912726] R10: 0000000000000020 R11: 1ffff1100fffb8b5 R12:
ffff88807ffdc4c0
[5306453164.915736] R13: ffff88806d23e080 R14: ffffea00001cc888 R15:
dffffc0000000000
[5306453164.918780] FS:  00007f6410257900(0000)
GS:ffff88806d200000(0000) knlGS:0000000000000000
[5306453164.922229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5306453164.924712] CR2: 00007f640f6fdc98 CR3: 0000000008d4a000 CR4:
00000000000006f0
[5306453164.927729] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[5306453164.930795] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[5306453164.933813] Call Trace:
[5306453164.935041]  <IRQ>
[5306453164.936074]  ? show_regs+0x73/0x80
[5306453164.937666]  ? rcu_dump_cpu_stacks+0x24f/0x3a0
[5306453164.939667]  ? rcu_sched_clock_irq+0x786/0x24b0
[5306453164.941689]  ? update_fast_timekeeper+0x43/0x70
[5306453164.943811]  ? timekeeping_update+0x318/0x450
[5306453164.945688]  ? __pfx_rcu_sched_clock_irq+0x10/0x10
[5306453164.947631]  ? timekeeping_advance+0x51b/0x800
[5306453164.949620]  ? cgroup_rstat_updated+0x32/0x5f0
[5306453164.951850]  ? hrtimer_run_queues+0x17/0x370
[5306453164.954005]  ? update_process_times+0xbe/0x140
[5306453164.956211]  ? tick_nohz_handler+0x395/0x4b0
[5306453164.958364]  ? __pfx_tick_nohz_handler+0x10/0x10
[5306453164.960614]  ? __hrtimer_run_queues+0x2d2/0x6c0
[5306453164.962736]  ? __pfx___hrtimer_run_queues+0x10/0x10
[5306453164.964705]  ? kvm_clock_read+0x2c/0x50
[5306453164.966300]  ? ktime_get_update_offsets_now+0x1ac/0x310
[5306453164.968461]  ? hrtimer_interrupt+0x2cf/0x6e0
[5306453164.970255]  ? __sysvec_apic_timer_interrupt+0x88/0x290
[5306453164.972398]  ? sysvec_apic_timer_interrupt+0x69/0x90
[5306453164.974408]  </IRQ>
[5306453164.975410]  <TASK>
[5306453164.976403]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[5306453164.978522]  ? _raw_spin_unlock_irqrestore+0x3e/0x70
[5306453164.980506]  __rmqueue_pcplist+0x8fb/0x1440
[5306453164.982272]  ? string_nocheck+0x173/0x1e0
[5306453164.983951]  ? __pfx_string_nocheck+0x10/0x10
[5306453164.985744]  ? __pfx___rmqueue_pcplist+0x10/0x10
[5306453164.987605]  ? __pfx__raw_spin_trylock+0x10/0x10
[5306453164.989553]  ? format_decode+0x220/0x970
[5306453164.991185]  get_page_from_freelist+0x3c6/0x31f0
[5306453164.993060]  ? vsnprintf+0x422/0x14d0
[5306453164.994571]  ? make_vfsuid+0xa0/0xf0
[5306453164.996071]  ? __pfx_make_vfsuid+0x10/0x10
[5306453164.997778]  ? __pfx_get_page_from_freelist+0x10/0x10
[5306453164.999786]  ? generic_permission+0x1c6/0x5b0
[5306453165.001647]  ? make_vfsuid+0xa0/0xf0
[5306453165.003137]  ? __pfx_make_vfsuid+0x10/0x10
[5306453165.004853]  __alloc_pages_noprof+0x2c5/0x5b0
[5306453165.006616]  ? link_path_walk.part.0+0x128/0xb90
[5306453165.008542]  ? __pfx___alloc_pages_noprof+0x10/0x10
[5306453165.010500]  ? dput+0x12/0x4d0
[5306453165.011814]  ? mntput+0x10/0xc0
[5306453165.013177]  ? terminate_walk+0x2bc/0x570
[5306453165.014841]  new_slab+0xc4/0x2f0
[5306453165.016239]  ___slab_alloc+0x635/0xaf0
[5306453165.017772]  ? __d_alloc+0x31/0x8b0
[5306453165.019235]  __slab_alloc.isra.0+0x1a/0x40
[5306453165.020910]  kmem_cache_alloc_lru_noprof+0x227/0x230
[5306453165.022860]  ? d_same_name+0xc5/0x280
[5306453165.024444]  ? __d_alloc+0x31/0x8b0
[5306453165.025886]  __d_alloc+0x31/0x8b0
[5306453165.027267]  d_alloc+0x44/0x200
[5306453165.028604]  lookup_one_qstr_excl+0xc0/0x180
[5306453165.030314]  do_renameat2+0x44f/0xa60
[5306453165.031844]  ? __pfx_do_renameat2+0x10/0x10
[5306453165.033548]  ? __pfx_vfs_read+0x10/0x10
[5306453165.035125]  ? __seccomp_filter+0x52d/0x11a0
[5306453165.036944]  ? __kasan_slab_alloc+0x59/0x70
[5306453165.038676]  ? strncpy_from_user+0x199/0x260
[5306453165.040419]  ? getname_flags+0x24d/0x590
[5306453165.042021]  __x64_sys_rename+0x81/0xa0
[5306453165.043601]  do_syscall_64+0x4b/0x110
[5306453165.045161]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[5306453165.047153] RIP: 0033:0x7f6410a75ed7
[5306453165.048657] Code: e8 6e 82 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8
5d c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00
00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 89 8f 17 00 f7 d8 64
89 02 b8
[5306453165.055440] RSP: 002b:00007ffc5f1c18f8 EFLAGS: 00000202
ORIG_RAX: 0000000000000052
[5306453165.058376] RAX: ffffffffffffffda RBX: 00007f6410c23000 RCX:
00007f6410a75ed7
[5306453165.061093] RDX: 0000000000000012 RSI: 00005625b0e6dad0 RDI:
00005625b0e32350
[5306453165.063871] RBP: 00005625b0e63560 R08: 00005625b0e31940 R09:
00005625b0e6db00
[5306453165.066610] R10: 00062a80f2437d09 R11: 0000000000000202 R12:
00005625b0e32350
[5306453165.069319] R13: 00005625b0e323b8 R14: 0000000000000001 R15:
ffffffffffffffff
[5306453165.072040]  </TASK>
[5306452890.632819] clocksource: Long readout interval, skipping
watchdog check: cs_nsec: 0 wd_nsec: 5306452861753210652


- kernel config
https://drive.google.com/file/d/1ZfeXgVadChVJtIGx5zMhBqHnmlomP3Hf/view?usp=sharing

- bzImage
https://drive.google.com/file/d/1MJf0WQ9_eztvuBcaBwCGC-rb7VBQtuac/view?usp=sharing

- reproducer (compiled)
https://drive.google.com/file/d/1j2bMbEW2Fs9bzA0VCJzpoW_ynY_bpI7-/view?usp=sharing

- steps to reproduce
    1. Create the VM image
    We use the script
https://github.com/google/syzkaller/blob/master/tools/create-image.sh
    to create the image.
    2. Run the VM
    We run command: qemu-system-x86_64 -m 2G -smp 4 -kernel bzImage \
    -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
    -drive file=./bullseye.img,format=raw \
    -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
    -net nic,model=e1000 \
    -enable-kvm \
    -nographic \
    -pidfile vm.pid \
    2>&1 | tee vm.log`
    3. Run the reproducer
    We ssh into the VM and run the compiled binary `syz-executor` under root.

- reproducer (c)
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>

static unsigned long long procid;

static __thread int clone_ongoing;
static __thread int skip_segv;
static __thread jmp_buf segv_env;

static void segv_handler(int sig, siginfo_t* info, void* ctx)
{
        if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) != 0) {
                exit(sig);
        }
        uintptr_t addr = (uintptr_t)info->si_addr;
        const uintptr_t prog_start = 1 << 20;
        const uintptr_t prog_end = 100 << 20;
        int skip = __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) != 0;
        int valid = addr < prog_start || addr > prog_end;
        if (skip && valid) {
                _longjmp(segv_env, 1);
        }
        exit(sig);
}

static void install_segv_handler(void)
{
        struct sigaction sa;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = SIG_IGN;
        syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
        syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
        memset(&sa, 0, sizeof(sa));
        sa.sa_sigaction = segv_handler;
        sa.sa_flags = SA_NODEFER | SA_SIGINFO;
        sigaction(SIGSEGV, &sa, NULL);
        sigaction(SIGBUS, &sa, NULL);
}

#define NONFAILING(...) ({ int ok = 1; __atomic_fetch_add(&skip_segv,
1, __ATOMIC_SEQ_CST); if (_setjmp(segv_env) == 0) { __VA_ARGS__; }
else ok = 0; __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); ok;
})

static void sleep_ms(uint64_t ms)
{
        usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
        struct timespec ts;
        if (clock_gettime(CLOCK_MONOTONIC, &ts))
        exit(1);
        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
        char buf[1024];
        va_list args;
        va_start(args, what);
        vsnprintf(buf, sizeof(buf), what, args);
        va_end(args);
        buf[sizeof(buf) - 1] = 0;
        int len = strlen(buf);
        int fd = open(file, O_WRONLY | O_CLOEXEC);
        if (fd == -1)
                return false;
        if (write(fd, buf, len) != len) {
                int err = errno;
                close(fd);
                errno = err;
                return false;
        }
        close(fd);
        return true;
}

static long syz_open_dev(volatile long a0, volatile long a1, volatile long a2)
{
        if (a0 == 0xc || a0 == 0xb) {
                char buf[128];
                sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" :
"block", (uint8_t)a1, (uint8_t)a2);
                return open(buf, O_RDWR, 0);
        } else {
                char buf[1024];
                char* hash;
                strncpy(buf, (char*)a0, sizeof(buf) - 1);
                buf[sizeof(buf) - 1] = 0;
                while ((hash = strchr(buf, '#'))) {
                        *hash = '0' + (char)(a1 % 10);
                        a1 /= 10;
                }
                return open(buf, a2, 0);
        }
}

static long syz_open_procfs(volatile long a0, volatile long a1)
{
        char buf[128];
        memset(buf, 0, sizeof(buf));
        if (a0 == 0) {
                snprintf(buf, sizeof(buf), "/proc/self/%s", (char*)a1);
        } else if (a0 == -1) {
                snprintf(buf, sizeof(buf), "/proc/thread-self/%s", (char*)a1);
        } else {
                snprintf(buf, sizeof(buf), "/proc/self/task/%d/%s",
(int)a0, (char*)a1);
        }
        int fd = open(buf, O_RDWR);
        if (fd == -1)
                fd = open(buf, O_RDONLY);
        return fd;
}

static void setup_gadgetfs();
static void setup_binderfs();
static void setup_fusectl();
static void sandbox_common_mount_tmpfs(void)
{
        write_file("/proc/sys/fs/mount-max", "100000");
        if (mkdir("./syz-tmp", 0777))
        exit(1);
        if (mount("", "./syz-tmp", "tmpfs", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot", 0777))
        exit(1);
        if (mkdir("./syz-tmp/newroot/dev", 0700))
        exit(1);
        unsigned bind_mount_flags = MS_BIND | MS_REC | MS_PRIVATE;
        if (mount("/dev", "./syz-tmp/newroot/dev", NULL,
bind_mount_flags, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/proc", 0700))
        exit(1);
        if (mount("syz-proc", "./syz-tmp/newroot/proc", "proc", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/selinux", 0700))
        exit(1);
        const char* selinux_path = "./syz-tmp/newroot/selinux";
        if (mount("/selinux", selinux_path, NULL, bind_mount_flags, NULL)) {
                if (errno != ENOENT)
        exit(1);
                if (mount("/sys/fs/selinux", selinux_path, NULL,
bind_mount_flags, NULL) && errno != ENOENT)
        exit(1);
        }
        if (mkdir("./syz-tmp/newroot/sys", 0700))
        exit(1);
        if (mount("/sys", "./syz-tmp/newroot/sys", 0, bind_mount_flags, NULL))
        exit(1);
        if (mount("/sys/kernel/debug",
"./syz-tmp/newroot/sys/kernel/debug", NULL, bind_mount_flags, NULL) &&
errno != ENOENT)
        exit(1);
        if (mount("/sys/fs/smackfs",
"./syz-tmp/newroot/sys/fs/smackfs", NULL, bind_mount_flags, NULL) &&
errno != ENOENT)
        exit(1);
        if (mount("/proc/sys/fs/binfmt_misc",
"./syz-tmp/newroot/proc/sys/fs/binfmt_misc", NULL, bind_mount_flags,
NULL) && errno != ENOENT)
        exit(1);
        if (mkdir("./syz-tmp/pivot", 0777))
        exit(1);
        if (syscall(SYS_pivot_root, "./syz-tmp", "./syz-tmp/pivot")) {
                if (chdir("./syz-tmp"))
        exit(1);
        } else {
                if (chdir("/"))
        exit(1);
                if (umount2("./pivot", MNT_DETACH))
        exit(1);
        }
        if (chroot("./newroot"))
        exit(1);
        if (chdir("/"))
        exit(1);
        setup_gadgetfs();
        setup_binderfs();
        setup_fusectl();
}

static void setup_gadgetfs()
{
        if (mkdir("/dev/gadgetfs", 0777)) {
        }
        if (mount("gadgetfs", "/dev/gadgetfs", "gadgetfs", 0, NULL)) {
        }
}

static void setup_fusectl()
{
        if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
        }
}

static void setup_binderfs()
{
        if (mkdir("/dev/binderfs", 0777)) {
        }
        if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
        }
        if (symlink("/dev/binderfs", "./binderfs")) {
        }
}

static void loop();

static void sandbox_common()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        if (getppid() == 1)
        exit(1);
        struct rlimit rlim;
        rlim.rlim_cur = rlim.rlim_max = (200 << 20);
        setrlimit(RLIMIT_AS, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 32 << 20;
        setrlimit(RLIMIT_MEMLOCK, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 136 << 20;
        setrlimit(RLIMIT_FSIZE, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 1 << 20;
        setrlimit(RLIMIT_STACK, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 128 << 20;
        setrlimit(RLIMIT_CORE, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 256;
        setrlimit(RLIMIT_NOFILE, &rlim);
        if (unshare(CLONE_NEWNS)) {
        }
        if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
        }
        if (unshare(CLONE_NEWIPC)) {
        }
        if (unshare(0x02000000)) {
        }
        if (unshare(CLONE_NEWUTS)) {
        }
        if (unshare(CLONE_SYSVSEM)) {
        }
        typedef struct {
                const char* name;
                const char* value;
        } sysctl_t;
        static const sysctl_t sysctls[] = {
            {"/proc/sys/kernel/shmmax", "16777216"},
            {"/proc/sys/kernel/shmall", "536870912"},
            {"/proc/sys/kernel/shmmni", "1024"},
            {"/proc/sys/kernel/msgmax", "8192"},
            {"/proc/sys/kernel/msgmni", "1024"},
            {"/proc/sys/kernel/msgmnb", "1024"},
            {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
        };
        unsigned i;
        for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
                write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid)
{
        if (pid < 0)
        exit(1);
        int status = 0;
        while (waitpid(-1, &status, __WALL) != pid) {
        }
        return WEXITSTATUS(status);
}

static void drop_caps(void)
{
        struct __user_cap_header_struct cap_hdr = {};
        struct __user_cap_data_struct cap_data[2] = {};
        cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
        cap_hdr.pid = getpid();
        if (syscall(SYS_capget, &cap_hdr, &cap_data))
        exit(1);
        const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
        cap_data[0].effective &= ~drop;
        cap_data[0].permitted &= ~drop;
        cap_data[0].inheritable &= ~drop;
        if (syscall(SYS_capset, &cap_hdr, &cap_data))
        exit(1);
}

static int do_sandbox_none(void)
{
        if (unshare(CLONE_NEWPID)) {
        }
        int pid = fork();
        if (pid != 0)
                return wait_for_loop(pid);
        sandbox_common();
        drop_caps();
        if (unshare(CLONE_NEWNET)) {
        }
        write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
        sandbox_common_mount_tmpfs();
        loop();
        exit(1);
}

static void kill_and_wait(int pid, int* status)
{
        kill(-pid, SIGKILL);
        kill(pid, SIGKILL);
        for (int i = 0; i < 100; i++) {
                if (waitpid(-1, status, WNOHANG | __WALL) == pid)
                        return;
                usleep(1000);
        }
        DIR* dir = opendir("/sys/fs/fuse/connections");
        if (dir) {
                for (;;) {
                        struct dirent* ent = readdir(dir);
                        if (!ent)
                                break;
                        if (strcmp(ent->d_name, ".") == 0 ||
strcmp(ent->d_name, "..") == 0)
                                continue;
                        char abort[300];
                        snprintf(abort, sizeof(abort),
"/sys/fs/fuse/connections/%s/abort", ent->d_name);
                        int fd = open(abort, O_WRONLY);
                        if (fd == -1) {
                                continue;
                        }
                        if (write(fd, abort, 1) < 0) {
                        }
                        close(fd);
                }
                closedir(dir);
        } else {
        }
        while (waitpid(-1, status, __WALL) != pid) {
        }
}

static void setup_test()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        setpgrp();
        write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
        int iter = 0;
        for (;; iter++) {
                int pid = fork();
                if (pid < 0)
        exit(1);
                if (pid == 0) {
                        setup_test();
                        execute_one();
                        exit(0);
                }
                int status = 0;
                uint64_t start = current_time_ms();
                for (;;) {
                        sleep_ms(10);
                        if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
                                break;
                        if (current_time_ms() - start < 5000)
                                continue;
                        kill_and_wait(pid, &status);
                        break;
                }
        }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
                intptr_t res = 0;
        if (write(1, "executing program\n", sizeof("executing
program\n") - 1)) {}
        NONFAILING(memcpy((void*)0x20000180, "/proc/locks\000", 12));
        syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
/*file=*/0x20000180ul, /*flags=*/0, /*mode=*/0);
        NONFAILING(memcpy((void*)0x20000000, "/dev/cpu/#/msr\000", 15));
        NONFAILING(syz_open_dev(/*dev=*/0x20000000, /*id=*/0, /*flags=*/0));
        NONFAILING(memcpy((void*)0x20000000, "fd/4\000", 5));
        res = -1;
        NONFAILING(res = syz_open_procfs(/*pid=*/0, /*file=*/0x20000000));
        if (res != -1)
                r[0] = res;
        NONFAILING(*(uint64_t*)0x20000140 = 0x20000040);
        NONFAILING(memcpy((void*)0x20000040,
"\x19\xec\x29\x61\x2a\x45\x60\xa9", 8));
        NONFAILING(*(uint64_t*)0x20000148 = 8);
        syscall(__NR_pwritev, /*fd=*/r[0], /*vec=*/0x20000140ul,
/*vlen=*/1ul, /*off_low=*/0x10, /*off_high=*/0);

}
int main(void)
{
                syscall(__NR_mmap, /*addr=*/0x1ffff000ul,
/*len=*/0x1000ul, /*prot=*/0ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1,
/*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
/*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1,
/*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=*/-1, /*offset=*/0ul);
        const char* reason;
        (void)reason;
        install_segv_handler();
        for (procid = 0; procid < 2; procid++) {
                if (fork() == 0) {
                        do_sandbox_none();
                }
        }
        sleep(1000000);
        return 0;
}
