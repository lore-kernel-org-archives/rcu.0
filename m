Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168C376463
	for <rcu@vger.kernel.org>; Thu,  6 Aug 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023176; cv=none; b=Xc+Mn35rJwAHXOnFUlEQxmkYC7W400bep1x98F3qhIwhA/X62+y8CN8Q9TjG0hHRWK0iQYDTxQMFsNC+CAf/4RLHgJKRg3qdOs1oFJJlwNO0qGYB+jFIfryzmc8d//VS60LYQmR3Ip7jMvVYqeYTdleH0Rm/7cGM1ir/hXUJwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023176; c=relaxed/simple;
	bh=xs8MoWCfZQVdVW8VW0NekylzA3RTtiy7eWgRKCTDo6A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=rWoifCi8SKiVf4pOP8qo7vJZBQec++oJ4XpKdTecW/XDZDtZ83ST4qM6XUCmD0TT0WEjdWulxhmQqHcUyc58fK/Cng71y//HiJ2asuIidfOO7IYJCnV3yV0oXVd7ju7+s/e96iGOkn95xwQQ4FD5tcTGYCCZaq+DdRratarEs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e9ekHQT7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e9ekHQT7"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786023159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yXKHIliu4nNH6rdKiQNfMKmkJok+mA9W8j4ZPZGOSY=;
	b=e9ekHQT7TiZ1RzdCVOYo5hER8oAzvAB5A6gPwE9AkKq2JCwbJpcqOELXEqK8rRwLwV9j6o
	yxrYO4+5d9U0BxQRWAi3CnBGraeSv4lGP/EdApRPusLDjDlOa1FzaYTvlUXX95NzgxFZkC
	Fst9uqMYSmiFP6+a3CiS4ZRcnYwhc6c=
Date: Thu, 06 Aug 2026 13:32:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <2b6ec84c0a2469eea964d881de295ae2e156713b@linux.dev>
TLS-Required: No
Subject: Re: [linux-next:master] [srcu] 05c3e88488: RIP:cleanup_srcu_struct
To: "kernel test robot" <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, "Paul E. McKenney"
 <paulmck@kernel.org>, rcu@vger.kernel.org, oliver.sang@intel.com
In-Reply-To: <202608060833.bce92909-lkp@intel.com>
References: <202608060833.bce92909-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Hello,
>=20
>=20kernel test robot noticed "RIP:cleanup_srcu_struct" on:
>=20
>=20commit: 05c3e88488ed8c12129ca04db84e4c02a16d7ee9 ("srcu: Queue sdp->w=
ork when the delay timer is successfully deleted")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
>=20in testcase: blktests
> version: blktests-x86_64-6f5a1dc-1_20260728
> with following parameters:
>=20
>=20 disk: 1SSD
>  test: nvme-group-01
>  nvme_trtype: rdma
>  use_siw: true
>=20
>=20config: x86_64-rhel-9.4-func
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with=
 32G memory
>=20
>=20(please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@inte=
l.com

Please try it:


The WARN_ON() is meant to catch callers that forgot srcu_barrier()
before cleanup.  however, it can trigger even when srcu_barrier()
was properly called.

When a SRCU grace period ends and ss_state < SRCU_SIZE_BIG, the mask=3D~0
causes delay_work timer be queued on every CPU regardless of whether its
sdp->srcu_cblist has callbacks.  srcu_barrier() only wait srcu_barrier_he=
ad
callbacks to complete, however, the srcu_barrier_head will not be inserte=
d
into an empty sdp->srcu_cblist. when cleanup_srcu_struct() then finds a
pending delay_work timer on a CPU with no callbacks, triggering a false
positive.

This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(),  make the
warning triggers only when the timer is still pending and there are actua=
l
outstanding callbacks.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 35fface51d50..090dddfc7463 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
=20
=20		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
-		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
-					rcu_cpu_beenfullyonline(sdp->cpu))
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
+			rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+				rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
--=20
2.17.1



>=20
> kern :info : [ 42.171416] [ T3271] nvme nvme1: Removing ctrl: NQN "blkt=
ests-subsystem-1"
> kern :info : [ 42.220396] [ T3271] ------------[ cut here ]------------
> kern :warn : [ 42.221853] [ T3271] WARNING: kernel/rcu/srcutree.c:706 a=
t cleanup_srcu_struct+0x373/0xa70, CPU#10: nvme/3271
> kern :warn : [ 42.223306] [ T3271] Modules linked in: siw loop btrfs li=
bblake2b raid6_pq zstd_compress xor binfmt_misc snd_hda_codec_intelhdmi s=
nd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_=
scodec_component snd_hda_codec_generic intel_rapl_msr intel_uncore_freque=
ncy intel_uncore_frequency_common x86_pkg_temp_thermal snd_hda_intel snd_=
sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic i915 so=
undwire_intel intel_powerclamp snd_sof_intel_hda_sdw_bpt coretemp snd_sof=
_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_=
hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_soc_sdw_utils sn=
d_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quir=
ks soundwire_generic_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_s=
dca snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_hda_codec kvm_inte=
l snd_hda_core spi_pxa2xx_platform dw_dmac spi_pxa2xx_core snd_intel_dspc=
fg snd_intel_sdw_acpi intel_gtt snd_hwdep drm_buddy ttm kvm snd_soc_core =
iwlwifi drm_display_helper
> kern :warn : [ 42.223363] [ T3271] processor_thermal_device_pci process=
or_thermal_device btusb processor_thermal_wt_hint snd_compress platform_t=
emperature_control btrtl processor_thermal_soc_slider snd_pcm processor_t=
hermal_rfim spi_nor btintel cec irqbypass processor_thermal_rapl drm_clie=
nt_lib rapl intel_rapl_common btbcm think_lmi btmtk drm_kms_helper mtd sn=
d_timer intel_lpss_pci ahci intel_cstate processor_thermal_wt_req cfg8021=
1 firmware_attributes_class wmi_bmof bluetooth libahci processor_thermal_=
power_floor video mei_me intel_pmc_core snd intel_uncore i2c_i801 spi_int=
el_pci intel_lpss processor_thermal_mbox pl2303 pcspkr libata spi_intel i=
2c_smbus soundcore idma64 mei pmt_telemetry rfkill int340x_thermal_zone p=
mt_discovery wmi pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telem=
etry intel_vsec int3400_thermal acpi_pad pinctrl_tigerlake acpi_tad acpi_=
thermal_rel drm fuse [last unloaded: siw]
> kern :warn : [ 42.233209] [ T3271] CPU: 10 UID: 0 PID: 3271 Comm: nvme =
Tainted: G S W 7.2.0-rc3+ #1 PREEMPT(lazy)
> kern :warn : [ 42.235107] [ T3271] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=
=3DWARN
> kern :warn : [ 42.236721] [ T3271] Hardware name: LENOVO 90XW004HPL/336=
B, BIOS M5LKT1CA 01/06/2025
> kern :warn : [ 42.238213] [ T3271] RIP: 0010:cleanup_srcu_struct (rcu/s=
rcutree.c:706 (discriminator 2))
> kern :warn : [ 42.239837] [ T3271] Code: c1 ea 03 42 80 3c 22 00 0f 85 =
77 05 00 00 4a 03 1c f5 e0 dd 47 85 48 8d bb d8 00 00 00 e8 15 ca 07 00 8=
5 c0 0f 84 0e ff ff ff <0f> 0b 48 8d 8b 58 01 00 00 48 b8 00 00 00 00 00 =
fc ff df 48 89 ca
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>  0: c1 ea 03 shr $0x3,%edx
>  3: 42 80 3c 22 00 cmpb $0x0,(%rdx,%r12,1)
>  8: 0f 85 77 05 00 00 jne 0x585
>  e: 4a 03 1c f5 e0 dd 47 add -0x7ab82220(,%r14,8),%rbx
>  15: 85=20
>=20 16: 48 8d bb d8 00 00 00 lea 0xd8(%rbx),%rdi
>  1d: e8 15 ca 07 00 call 0x7ca37
>  22: 85 c0 test %eax,%eax
>  24: 0f 84 0e ff ff ff je 0xffffffffffffff38
>  2a:* 0f 0b ud2 <-- trapping instruction
>  2c: 48 8d 8b 58 01 00 00 lea 0x158(%rbx),%rcx
>  33: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>  3a: fc ff df=20
>=20 3d: 48 89 ca mov %rcx,%rdx
>=20
>=20Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  0: 0f 0b ud2
>  2: 48 8d 8b 58 01 00 00 lea 0x158(%rbx),%rcx
>  9: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>  10: fc ff df=20
>=20 13: 48 89 ca mov %rcx,%rdx
> kern :warn : [ 42.241383] [ T3271] RSP: 0018:ffffc900049778f0 EFLAGS: 0=
0010202
> kern :warn : [ 42.242985] [ T3271] RAX: 0000000000000001 RBX: ffffe8fff=
f622fc0 RCX: ffffffff817d27dd
> kern :warn : [ 42.244560] [ T3271] RDX: 1ffff110ea8e5ce0 RSI: 000000000=
0000246 RDI: ffff88875472e600
> kern :warn : [ 42.246197] [ T3271] RBP: 0000000000000000 R08: 000000000=
0000001 R09: ffffed10ea8e5cc5
> kern :warn : [ 42.247819] [ T3271] R10: ffff88875472e62f R11: 000000000=
0000040 R12: dffffc0000000000
> kern :warn : [ 42.249508] [ T3271] R13: fffffbfff0d0d6ee R14: 000000000=
0000000 R15: ffff88818083c0a8
> kern :warn : [ 42.251005] [ T3271] FS: 00007fd8541ea780(0000) GS:ffff88=
87ccda7000(0000) knlGS:0000000000000000
> kern :warn : [ 42.252678] [ T3271] CS: 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> kern :warn : [ 42.254204] [ T3271] CR2: 00007f7098b7e2c0 CR3: 000000088=
3d05005 CR4: 0000000000f72ef0
> kern :warn : [ 42.255916] [ T3271] PKRU: 55555554
> kern :warn : [ 42.257486] [ T3271] Call Trace:
> kern :warn : [ 42.259126] [ T3271] <TASK>
> kern :warn : [ 42.260726] [ T3271] ? __mutex_unlock_slowpath+0x4b3/0x53=
0
> kern :warn : [ 42.262369] [ T3271] blk_mq_free_tag_set (blk-mq.c:4976)
> kern :warn : [ 42.263861] [ T3271] nvme_rdma_teardown_io_queues+0xee/0x=
130
> kern :warn : [ 42.265514] [ T3271] nvme_rdma_delete_ctrl (nvme/host/rdm=
a.c:947 nvme/host/rdma.c:2157 nvme/host/rdma.c:2165)
> kern :warn : [ 42.267029] [ T3271] nvme_do_delete_ctrl (nvme/host/core.=
c:247)
> kern :warn : [ 42.268752] [ T3271] nvme_delete_ctrl_sync.cold (nvme/hos=
t/core.c:277)
> kern :warn : [ 42.270328] [ T3271] nvme_sysfs_delete (nvme/host/sysfs.c=
:498)
> kern :warn : [ 42.271987] [ T3271] kernfs_fop_write_iter (kernfs/file.c=
:345)
> kern :warn : [ 42.273601] [ T3271] vfs_write (read_write.c:595 read_wri=
te.c:687)
> kern :warn : [ 42.275278] [ T3271] ? __pfx_vfs_write (linux/fs.h:2733 (=
discriminator 1))
> kern :warn : [ 42.276750] [ T3271] ? kmem_cache_free (linux/kasan.h:235=
 slub.c:2705 slub.c:6405 slub.c:6532)
> kern :warn : [ 42.278425] [ T3271] ? fdget_pos (linux/instrumented.h:82=
 linux/atomic/atomic-instrumented.h:3188 linux/file_ref.h:215 file.c:1231=
 file.c:1257)
> kern :warn : [ 42.279916] [ T3271] ? do_sys_openat2 (linux/fs.h:2564 li=
nux/fs.h:2566 open.c:1367)
> kern :warn : [ 42.281536] [ T3271] ksys_write (read_write.c:739)
> kern :warn : [ 42.283048] [ T3271] ? __pfx_ksys_write (read_write.c:723=
)
> kern :warn : [ 42.284669] [ T3271] do_syscall_64 (x86/entry/syscall_64.=
c:63 x86/entry/syscall_64.c:94)
> kern :warn : [ 42.286196] [ T3271] ? ksys_read (read_write.c:716)
> kern :warn : [ 42.287822] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry=
/syscall_64.c:100)
> kern :warn : [ 42.289367] [ T3271] ? __pfx___do_sys_newfstat (stat.c:44=
6)
> kern :warn : [ 42.290855] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry=
/syscall_64.c:100)
> kern :warn : [ 42.292405] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry=
/syscall_64.c:100)
> kern :warn : [ 42.293886] [ T3271] ? __x64_sys_close (open.c:1511 open.=
c:1496 open.c:1496)
> kern :warn : [ 42.295469] [ T3271] ? do_syscall_64 (linux/randomize_kst=
ack.h:57 x86/entry/syscall_64.c:92)
> kern :warn : [ 42.296937] [ T3271] entry_SYSCALL_64_after_hwframe (x86/=
entry/entry_64.S:121)
> kern :warn : [ 42.298472] [ T3271] RIP: 0033:0x7fd8549a2687
> kern :warn : [ 42.299951] [ T3271] Code: 48 89 fa 4c 89 df e8 58 b3 00 =
00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 0=
0 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 =
de e8 23 ff ff ff
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>  0: 48 89 fa mov %rdi,%rdx
>  3: 4c 89 df mov %r11,%rdi
>  6: e8 58 b3 00 00 call 0xb363
>  b: 8b 93 08 03 00 00 mov 0x308(%rbx),%edx
>  11: 59 pop %rcx
>  12: 5e pop %rsi
>  13: 48 83 f8 fc cmp $0xfffffffffffffffc,%rax
>  17: 74 1a je 0x33
>  19: 5b pop %rbx
>  1a: c3 ret
>  1b: 0f 1f 84 00 00 00 00 nopl 0x0(%rax,%rax,1)
>  22: 00=20
>=20 23: 48 8b 44 24 10 mov 0x10(%rsp),%rax
>  28: 0f 05 syscall
>  2a:* 5b pop %rbx <-- trapping instruction
>  2b: c3 ret
>  2c: 0f 1f 80 00 00 00 00 nopl 0x0(%rax)
>  33: 83 e2 39 and $0x39,%edx
>  36: 83 fa 08 cmp $0x8,%edx
>  39: 75 de jne 0x19
>  3b: e8 23 ff ff ff call 0xffffffffffffff63
>=20
>=20Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  0: 5b pop %rbx
>  1: c3 ret
>  2: 0f 1f 80 00 00 00 00 nopl 0x0(%rax)
>  9: 83 e2 39 and $0x39,%edx
>  c: 83 fa 08 cmp $0x8,%edx
>  f: 75 de jne 0xffffffffffffffef
>  11: e8 23 ff ff ff call 0xffffffffffffff39
> kern :warn : [ 42.301560] [ T3271] RSP: 002b:00007ffdc9d84570 EFLAGS: 0=
0000202 ORIG_RAX: 0000000000000001
> kern :warn : [ 42.303102] [ T3271] RAX: ffffffffffffffda RBX: 00007fd85=
41ea780 RCX: 00007fd8549a2687
> kern :warn : [ 42.304724] [ T3271] RDX: 0000000000000001 RSI: 00007fd85=
4b4da0a RDI: 0000000000000004
> kern :warn : [ 42.306296] [ T3271] RBP: 00007fd854b4da0a R08: 000000000=
0000000 R09: 0000000000000000
> kern :warn : [ 42.307782] [ T3271] R10: 0000000000000000 R11: 000000000=
0000202 R12: 000055a417335e50
> kern :warn : [ 42.309390] [ T3271] R13: 00007ffdc9d86703 R14: 000055a41=
7335e50 R15: 000055a417336760
> kern :warn : [ 42.310924] [ T3271] </TASK>
> kern :warn : [ 42.312525] [ T3271] ---[ end trace 0000000000000000 ]---
>=20
>=20The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260806/202608060833.bce92909-=
lkp@intel.com
>=20
>=20--=20
>=200-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
