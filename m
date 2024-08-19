Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06615C125
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058718; cv=none; b=GfZtxdzt77IRtlA3gkpwC/1loqnVc+a9GJqqpXfwiCxKTbHC58v3xhP953SHSCyQ1OLS3gTeIaOXZ+OAMUYg/N8/j7upJwDG3myMeMs6G7PNaDvtZr7Io7xUzPAmoa5B/EijkeXKd82QqRnADCGUjXXdE6KKmGGf7c7Cb9EGThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058718; c=relaxed/simple;
	bh=jlaoihLvWo3+t+Pi3GuGZQPY9eOKD2usrzhIeLKTYVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmN0E9w6SlWtfKNZUD0V9sOJE3zdEeOhRXcB68NxT6T0hDEOXWPYTF/CcstqWs9QbtaUQGaBCzaa4zeqQHPy117RojZA68A+1LHpi+aM2sI58jDWlIlR4TmstvwTl9ytEU1dCTcCA9zFkEbbRvMxWCdhqPDHB+QYfsk5uQBz6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYNI0uqS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYNI0uqS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1603427a12.2
        for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058716; x=1724663516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXl3+1coPfiFUT5f488wpSxzD0oc6IOdWLyNoqBxlQc=;
        b=HYNI0uqSdxpbXWBLyWcLP0BIe73MYBcuC2YBEJ3pa+YdePsBUhqeSXMY+nEdAWUuWA
         ukMm/U31yEZh7Zn1pzyWcn+gSKZbgWXUOSQTyaHW3Dkki5CObGhiL4umugg7NKjkFJhv
         DOVx3p8hGlKBJqQHv/6kcpZA8C8sHOS/roH8Q5nSjUPgvuA0F3/FDrfE0DdAfQC+tw/M
         9M5kOSn6YjjWs5rjBSv4CQKwTrXQwDXpTQvO6CH3yi1puHUsNYVqMvHXRwiSDuhL+wPU
         HEOyEvWPkvGOPf/AE6MoC3FNOkzBsJ4agqlV7qFNcNLVsif+9n2nNrRZw2+4LNMuOgTL
         ofbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058716; x=1724663516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXl3+1coPfiFUT5f488wpSxzD0oc6IOdWLyNoqBxlQc=;
        b=roGSeMpR8/erADKwVQ/WiPBR2v6hPex2pDSZqCwxo9/Pru/7qGXlkJxfe/K9H5U/Ul
         7JvRHD+6dftEsQXM7lU2fVCpyplWX7375CWMPCutyK2VSW+nP3CKrMz0gsSAw0Vk+T2y
         T1hWUwdHvrr5Hng84xVrAqRR9Wb/VfbA9z2cJPZr1hXZ3Bd1IYKoZAfMJfHhcfU3pi3O
         N3uMHqHLXash74hhuYAyZMdKCKDLoa7wsgRNklfmZEF50hvOP458GzqSkmiRuus45PW8
         yAIzFib05DQhiNnD5SbXaOVhdh7rnnFsiqZtVrcu6pgpZL+ELHGnxG/9P4p6odZDHKWg
         RQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlPDpvwkhE9awOLTilNpchPDOZbKQkHMdaeKd2g64zdkeHW5xG/M3vOm8ePA7LNO4+0YsCjUZ6FtBGPcXJYXtSFYzN
X-Gm-Message-State: AOJu0Yx3SQp7RNCCFAIQgbPFhz2F+PTKTRKGwKb/9ikqXnbh/7oGGxQh
	ULJfalvtTsFxiBBm7FL0AEZ6k+Vgg10//VSIWZPIBMv4NoDH2FcWswiY/Oq4YbMfhHVP1lACNaf
	93pDUd2mtFvEz4xjqW+xnPHfar/wIsIFyVAJYLw==
X-Google-Smtp-Source: AGHT+IF1hr+z74Eltteb0mKq+8VfSJduE6VS1SJakAdZ8A/xbN3Sx4cpojPbg1524uCrgEyQEFjSyXdy/iAOA4YLTHY=
X-Received: by 2002:a17:90a:bc81:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2d3dfc75e41mr11249110a91.20.1724058715779; Mon, 19 Aug 2024
 02:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408191537.5ab14400-lkp@intel.com>
In-Reply-To: <202408191537.5ab14400-lkp@intel.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 19 Aug 2024 17:11:44 +0800
Message-ID: <CALm+0cXaHPibx13EYveJJcS8gxrzjCzu6ZX58iGS_EmywzXvCQ@mail.gmail.com>
Subject: Re: [paulmckrcu:dev.2024.08.05a] [srcu] a7adbae9c5: WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
To: kernel test robot <oliver.sang@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
> hi, Paul,
>
> we actually want to consult you about this patch. by it, the config has b=
elow
> diff with parent in this tests (we use randconfig here)
>
> --- /pkg/linux/i386-randconfig-004-20240810/gcc-12/157f4b896656dfe6ad6d37=
c94ca9a885d52f35ab/.config     2024-08-12 04:00:50.715727095 +0800
> +++ /pkg/linux/i386-randconfig-004-20240810/gcc-12/a7adbae9c55d7f85b3b8c0=
e8e9417e5d52793137/.config     2024-08-12 04:02:38.647990561 +0800
> @@ -136,7 +136,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=3Dy
>  CONFIG_TREE_RCU=3Dy
>  CONFIG_PREEMPT_RCU=3Dy
>  CONFIG_RCU_EXPERT=3Dy
> -CONFIG_TREE_SRCU=3Dy
> +CONFIG_TINY_SRCU=3Dy
>  CONFIG_TASKS_RCU_GENERIC=3Dy
>  CONFIG_FORCE_TASKS_RCU=3Dy
>  CONFIG_NEED_TASKS_RCU=3Dy
>
>
> then we saw issue show for this commit:
>
> 157f4b896656dfe6 a7adbae9c55d7f85b3b8c0e8e94
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           67%           6:6     rcutorture.busted_srcud.fai=
l
>            :6           83%           6:6     dmesg.EIP:rcu_torture_stats=
_print
>            :6           83%           6:6     dmesg.WARNING:at_kernel/rcu=
/rcutorture.c:#rcu_torture_stats_print[rcutorture]
>
>
> another diff is, for parent, we can see:
>
> [  465.948962] busted_srcud-torture:--- End of test: SUCCESS: nreaders=3D=
1 nfakewriters=3D4 stat_interval=3D60 verbose=3D1 test_no_idle_hz=3D1 shuff=
le_interval=3D3 stutter=3D5 irqreader=3D1 fqs_duration=3D0 fqs_holdoff=3D0 =
fqs_stutter=3D3 test_boost=3D1/0 test_boost_interval=3D7 test_boost_duratio=
n=3D4 shutdown_secs=3D0 stall_cpu=3D0 stall_cpu_holdoff=3D10 stall_cpu_irqs=
off=3D0 stall_cpu_block=3D0 stall_cpu_repeat=3D0 n_barrier_cbs=3D0 onoff_in=
terval=3D0 onoff_holdoff=3D0 read_exit_delay=3D13 read_exit_burst=3D16 nocb=
s_nthreads=3D0 nocbs_toggle=3D1000 test_nmis=3D0
>
>
> but for this commit:
>
>
> [  417.566774] busted_srcud-torture:--- End of test: FAILURE: nreaders=3D=
1 nfakewriters=3D4 stat_interval=3D60 verbose=3D1 test_no_idle_hz=3D1 shuff=
le_interval=3D3 stutter=3D5 irqreader=3D1 fqs_duration=3D0 fqs_holdoff=3D0 =
fqs_stutter=3D3 test_boost=3D1/0 test_boost_interval=3D7 test_boost_duratio=
n=3D4 shutdown_secs=3D0 stall_cpu=3D0 stall_cpu_holdoff=3D10 stall_cpu_irqs=
off=3D0 stall_cpu_block=3D0 stall_cpu_repeat=3D0 n_barrier_cbs=3D0 onoff_in=
terval=3D0 onoff_holdoff=3D0 read_exit_delay=3D13 read_exit_burst=3D16 nocb=
s_nthreads=3D0 nocbs_toggle=3D1000 test_nmis=3D0
>
>
> are these expected? below full report FYI.


Due to setting ->extendables=3DRCUTORTURE_MAX_EXTEND for busted_srcud testi=
ng,
they use abnormal reader critical sections,   this is expected
behavior. not a problem.


>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_tortur=
e_stats_print[rcutorture]" on:
>
> commit: a7adbae9c55d7f85b3b8c0e8e9417e5d52793137 ("srcu: Enable Tiny SRCU=
 On all CONFIG_SMP=3Dn kernels")
> https://github.com/paulmckrcu/linux dev.2024.08.05a
>
> in testcase: rcutorture
> version:
> with following parameters:
>
>         runtime: 300s
>         test: default
>         torture_type: busted_srcud
>
>
>
> compiler: gcc-12
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408191537.5ab14400-lkp@intel.=
com
>
>
> [  180.101544][  T569] busted_srcud-torture: !!!
> [  180.101750][  T569] ------------[ cut here ]------------
> [  180.103079][  T569] WARNING: CPU: 0 PID: 569 at kernel/rcu/rcutorture.=
c:2263 rcu_torture_stats_print+0x361/0x5a2 [rcutorture]
> [  180.104531][  T569] Modules linked in: rcutorture torture intel_rapl_m=
sr ipmi_devintf ipmi_msghandler mousedev bochs drm_vram_helper intel_rapl_c=
ommon drm_ttm_helper crc32_pclmul ttm aesni_intel crypto_simd serio_raw drm=
_kms_helper rapl fuse drm drm_panel_orientation_quirks backlight i2c_core
> [  180.108333][  T569] CPU: 0 UID: 0 PID: 569 Comm: rcu_torture_sta Taint=
ed: G                T  6.11.0-rc1-00103-ga7adbae9c55d #1 89f8a658c4adbda32=
12056ebb1acba93a3453734
> [  180.110128][  T569] Tainted: [T]=3DRANDSTRUCT
> [  180.110676][  T569] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  180.111951][  T569] EIP: rcu_torture_stats_print+0x361/0x5a2 [rcutortu=
re]
> [  180.112889][  T569] Code: 74 02 0f 0b 6a 00 31 c9 b8 98 4d 54 ef 0f b6=
 db e8 9d 96 c1 c1 31 c9 89 da b8 80 4d 54 ef 6a 00 e8 8d 96 c1 c1 4e 58 5a=
 7e 02 <0f> 0b 6a 00 b8 68 4d 54 ef 31 c9 89 da e8 76 96 c1 c1 58 68 8d 96
> [  180.115329][  T569] EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 000=
00000
> [  180.116208][  T569] ESI: 00000002 EDI: 00000000 EBP: b6be3f64 ESP: b6b=
e3ee8
> [  180.116977][  T569] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAG=
S: 00010202
> [  180.117817][  T569] CR0: 80050033 CR2: 08082db0 CR3: 069fb000 CR4: 000=
40690
> [  180.118722][  T569] Call Trace:
> [  180.119180][  T569]  ? show_regs+0x65/0x71
> [  180.119838][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture=
 c084aa8ea4885af620a5fd08bf5503a17a237677]
> [  180.121034][  T569]  ? __warn+0x92/0xd3
> [  180.121591][  T569]  ? report_bug+0xdd/0x156
> [  180.122212][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture=
 c084aa8ea4885af620a5fd08bf5503a17a237677]
> [  180.123567][  T569]  ? exc_overflow+0x3d/0x3d
> [  180.124162][  T569]  ? handle_bug+0x2b/0x4b
> [  180.124693][  T569]  ? exc_invalid_op+0x24/0x61
> [  180.125262][  T569]  ? handle_exception+0x164/0x164
> [  180.125896][  T569]  ? exc_overflow+0x3d/0x3d
> [  180.126448][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture=
 c084aa8ea4885af620a5fd08bf5503a17a237677]
> [  180.127705][  T569]  ? exc_overflow+0x3d/0x3d
> [  180.128320][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture=
 c084aa8ea4885af620a5fd08bf5503a17a237677]
> [  180.129584][  T569]  rcu_torture_stats+0x3f/0x60 [rcutorture c084aa8ea=
4885af620a5fd08bf5503a17a237677]
> [  180.130712][  T569]  kthread+0x109/0x10e
> [  180.131226][  T569]  ? rcu_torture_stats_print+0x5a2/0x5a2 [rcutorture=
 c084aa8ea4885af620a5fd08bf5503a17a237677]
> [  180.136140][  T569]  ? list_del_init+0x25/0x25
> [  180.136464][  T569]  ret_from_fork+0x34/0x4d
> [  180.136776][  T569]  ? list_del_init+0x25/0x25
> [  180.137093][  T569]  ret_from_fork_asm+0x12/0x20
> [  180.137422][  T569]  entry_INT80_32+0x124/0x124
> [  180.137758][  T569] irq event stamp: 1025
> [  180.138078][  T569] hardirqs last  enabled at (1047): [<b10bdcb0>] con=
sole_unlock+0x9b/0xfd
> [  180.138658][  T569] hardirqs last disabled at (1056): [<b10bdc97>] con=
sole_unlock+0x82/0xfd
> [  180.139225][  T569] softirqs last  enabled at (1042): [<b106fcea>] han=
dle_softirqs+0x28a/0x2f3
> [  180.139838][  T569] softirqs last disabled at (1033): [<b1b627cf>] __d=
o_softirq+0xf/0x13
> [  180.140398][  T569] ---[ end trace 0000000000000000 ]---
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240819/202408191537.5ab14400-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
