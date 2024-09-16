Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF514659B;
	Mon, 16 Sep 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479947; cv=none; b=gOotGfELovVodmY5RujfkkOt289c8vK48tEslCnr2+VVN8ghByxg1uwv3DBzUyQoG9Aowxlq29SJIf4ntKv629aeLzBMEavGCMfxh0hm67VBba4xdG1OBXYZ5wzyWdfMEeEeHhMH9CJeyrneHFpbq1XRrkQR1teDjPoQTf5UTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479947; c=relaxed/simple;
	bh=ZP6IlhCFQSXBOlPLFUuSiI/deIP2kNdsSosI0P0BNvo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=h6w1W24wdCngBS0+PpUNLudXdXj7Mbx+QLt5yo5g5lJfWhY8GrvgWLiiPntzrY7Y8msPZZlM0UwzK/9bKVv5aqA6s7AIZ1lkf/kGpuWQxULVcaa7vGh4owiHrP9CG5/pg6zrgLLqz1+F6Pm4LSG0EONafvXWsKSQxtbvosu45ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNmsrOxM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaC1hZE8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNmsrOxM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaC1hZE8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNmsrOxM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaC1hZE8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNmsrOxM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaC1hZE8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1215C1F88D;
	Mon, 16 Sep 2024 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726479943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=cM4aii+aW5wMMuHHJM0Iq+28oaKMI54qtVFRm1O04QY=;
	b=QNmsrOxMTuxW14ceYNIOOhaminYeZ7wCjtlp7us5ypj0BQO2j6G0pBJLIFRP9L569vyB95
	Tx06esaDg+gPaGvz9NiJ6Ib33B2X/liINXoFPTMSWZyzgtHRxB8tMjfZZ5yFj59tVmJ2F8
	AItkSpI6ykRgUPINL7mTJbHucCYpY0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726479943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=cM4aii+aW5wMMuHHJM0Iq+28oaKMI54qtVFRm1O04QY=;
	b=NaC1hZE8pEVJgfoAwV+vYEUp3uTIU3mu11DbG0MKZw8RD+2ZciuWZJSKrMuP3arakN1dK9
	dTijw1T6QNjeiUDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QNmsrOxM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NaC1hZE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726479943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=cM4aii+aW5wMMuHHJM0Iq+28oaKMI54qtVFRm1O04QY=;
	b=QNmsrOxMTuxW14ceYNIOOhaminYeZ7wCjtlp7us5ypj0BQO2j6G0pBJLIFRP9L569vyB95
	Tx06esaDg+gPaGvz9NiJ6Ib33B2X/liINXoFPTMSWZyzgtHRxB8tMjfZZ5yFj59tVmJ2F8
	AItkSpI6ykRgUPINL7mTJbHucCYpY0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726479943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=cM4aii+aW5wMMuHHJM0Iq+28oaKMI54qtVFRm1O04QY=;
	b=NaC1hZE8pEVJgfoAwV+vYEUp3uTIU3mu11DbG0MKZw8RD+2ZciuWZJSKrMuP3arakN1dK9
	dTijw1T6QNjeiUDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED0791397F;
	Mon, 16 Sep 2024 09:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nbldOUb+52bTVwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 16 Sep 2024 09:45:42 +0000
Message-ID: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
Date: Mon, 16 Sep 2024 11:45:42 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christian Brauner <brauner@kernel.org>,
 RCU <rcu@vger.kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Language: en-US
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1215C1F88D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12

There's a small conflict with the rcu tree:
https://lore.kernel.org/lkml/20240812124748.3725011b@canb.auug.org.au/

For Christian's kmem_cache_create refactoring series, a commit in the vfs.file
tree was merged as a prerequisity, and you have already merged vfs.file. Due to
vfs.tree based on 6.11-rc4 and slab on v6.11-rc5, the git pull-rq generated
diffstat below now however seems to contain also changes from rc5 commits. The
shortlog is accurate.

Thanks,
Vlastimil

======================================

This time it's mostly refactoring and improving APIs for slab users in the
kernel, along with some debugging improvements.

* kmem_cache_create() refactoring (Christian Brauner)

  Over the years have been growing new parameters to kmem_cache_create() where
  most of them are needed only for a small number of caches - most recently the
  rcu_freeptr_offset parameter. To avoid adding new parameters to
  kmem_cache_create() and adjusting all its callers, or creating new wrappers
  such as kmem_cache_create_rcu(), we can now pass extra parameters using the
  new struct kmem_cache_args. Not explicitly initialized fields default to values
  interpreted as unused. kmem_cache_create() is for now a wrapper that works both
  with the new form: kmem_cache_create(name, object_size, args, flags) and the
  legacy form: kmem_cache_create(name, object_size, align, flags, ctor)

* kmem_cache_destroy() waits for kfree_rcu()'s in flight (Vlastimil Babka,
  Uladislau Rezki)

  Since SLOB removal, kfree() is allowed for freeing objects allocated by
  kmem_cache_create(). By extension kfree_rcu() as allowed as well, which can
  allow converting simple call_rcu() callbacks that only do kmem_cache_free(),
  as there was never a kmem_cache_free_rcu() variant. However, for caches that
  can be destroyed e.g. on module removal, the cache owners knew to issue
  rcu_barrier() first to wait for the pending call_rcu()'s, and this is not
  sufficient for pending kfree_rcu()'s due to its internal batching
  optimizations. Ulad has provided a new kvfree_rcu_barrier() and to make the
  usage less error-prone, kmem_cache_destroy() calls it. Additionally, destroying
  SLAB_TYPESAFE_BY_RCU caches now again issues rcu_barrier() synchronously
  instead of using an async work, because the past motivation for async work no
  longer applies. Users of custom call_rcu() callbacks should however keep
  calling rcu_barrier() before cache destruction.

* Debugging use-after-free in SLAB_TYPESAFE_BY_RCU caches (Jann Horn)

  Currently, KASAN cannot catch UAFs in such caches as it is legal to access
  them within a grace period, and we only track the grace period when trying to
  free the underlying slab page. The new CONFIG_SLUB_RCU_DEBUG option changes the
  freeing of individual object to be RCU-delayed, after which KASAN can poison
  them.

* Delayed memcg charging (Shakeel Butt)

  In some cases, the memcg is uknown at allocation time, such as receiving network
  packets in softirq context. With kmem_cache_charge() these may be now charged
  later when the user and its memcg is known.

* Misc fixes and improvements (Pedro Falcato, Axel Rasmussen, Christoph Lameter,
  Yan Zhen, Peng Fan, Xavier).

----------------------------------------------------------------
Axel Rasmussen (1):
      mm, slub: print CPU id (and its node) on slab OOM

Christian Brauner (17):
      slab: s/__kmem_cache_create/do_kmem_cache_create/g
      slab: add struct kmem_cache_args
      slab: port kmem_cache_create() to struct kmem_cache_args
      slab: port kmem_cache_create_rcu() to struct kmem_cache_args
      slab: port kmem_cache_create_usercopy() to struct kmem_cache_args
      slab: pass struct kmem_cache_args to create_cache()
      slab: pull kmem_cache_open() into do_kmem_cache_create()
      slab: pass struct kmem_cache_args to do_kmem_cache_create()
      slab: remove rcu_freeptr_offset from struct kmem_cache
      slab: port KMEM_CACHE() to struct kmem_cache_args
      slab: port KMEM_CACHE_USERCOPY() to struct kmem_cache_args
      slab: create kmem_cache_create() compatibility layer
      file: port to struct kmem_cache_args
      slab: remove kmem_cache_create_rcu()
      slab: make kmem_cache_create_usercopy() static inline
      slab: make __kmem_cache_create() static inline
      io_uring: port to struct kmem_cache_args

Christoph Lameter (1):
      Reenable NUMA policy support in the slab allocator

Jann Horn (2):
      kasan: catch invalid free before SLUB reinitializes the object
      slub: Introduce CONFIG_SLUB_RCU_DEBUG

Pedro Falcato (1):
      slab: Warn on duplicate cache names when DEBUG_VM=y

Peng Fan (1):
      mm, slub: avoid zeroing kmalloc redzone

Shakeel Butt (1):
      memcg: add charging of already allocated slab objects

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Add kvfree_rcu_barrier() API

Vlastimil Babka (10):
      mm, slab: dissolve shutdown_cache() into its caller
      mm, slab: unlink slabinfo, sysfs and debugfs immediately
      mm, slab: move kfence_shutdown_cache() outside slab_mutex
      mm, slab: reintroduce rcu_barrier() into kmem_cache_destroy()
      mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
      kunit, slub: add test_kfree_rcu() and test_leak_destroy()
      Merge branch 'vfs.file' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs into slab/for-6.12/kmem_cache_args
      mm, slab: restore kerneldoc for kmem_cache_create()
      Merge branch 'slab/for-6.12/rcu_barriers' into slab/for-next
      Merge branch 'slab/for-6.12/kmem_cache_args' into slab/for-next

Xavier (1):
      mm/slab: Optimize the code logic in find_mergeable()

Yan Zhen (1):
      mm, slab: use kmem_cache_free() to free from kmem_buckets_cache

 Documentation/core-api/workqueue.rst               |   2 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |   1 +
 Documentation/filesystems/erofs.rst                |   2 +-
 Documentation/filesystems/smb/ksmbd.rst            |  26 +-
 Documentation/kbuild/llvm.rst                      |   2 +-
 MAINTAINERS                                        |  36 +-
 Makefile                                           |   4 +-
 arch/arm64/kvm/mmu.c                               |   9 +-
 arch/arm64/kvm/sys_regs.c                          |   6 +
 arch/arm64/kvm/vgic/vgic-debug.c                   |   2 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |   9 +-
 arch/arm64/kvm/vgic/vgic.c                         |   5 +
 arch/arm64/kvm/vgic/vgic.h                         |   7 +
 arch/mips/kernel/cevt-r4k.c                        |  15 +-
 arch/mips/kernel/cpu-probe.c                       |   4 +
 arch/s390/Kconfig                                  |  13 +
 arch/s390/boot/startup.c                           |  58 +--
 arch/s390/boot/vmem.c                              |  14 +-
 arch/s390/boot/vmlinux.lds.S                       |   7 +-
 arch/s390/include/asm/page.h                       |   3 +-
 arch/s390/kernel/setup.c                           |  19 +-
 arch/s390/kernel/vmlinux.lds.S                     |   2 +-
 arch/s390/tools/relocs.c                           |   2 +-
 block/blk-lib.c                                    |  25 +-
 drivers/accessibility/speakup/genmap.c             |   1 -
 drivers/accessibility/speakup/makemapdata.c        |   1 -
 drivers/acpi/video_detect.c                        |  22 ++
 drivers/ata/pata_macio.c                           |  30 +-
 drivers/bluetooth/btintel.c                        |  10 -
 drivers/bluetooth/btintel_pcie.c                   |   3 -
 drivers/bluetooth/btmtksdio.c                      |   3 -
 drivers/bluetooth/btrtl.c                          |   1 -
 drivers/bluetooth/btusb.c                          |   4 +-
 drivers/bluetooth/hci_qca.c                        |   4 +-
 drivers/bluetooth/hci_vhci.c                       |   2 -
 drivers/cxl/core/pci.c                             |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  18 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  20 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   2 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  19 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       |   9 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c           |   6 +
 drivers/gpu/drm/xe/Makefile                        |   2 +
 drivers/gpu/drm/xe/display/xe_display.c            |  28 +-
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c         |   8 +
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   3 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   9 +
 drivers/gpu/drm/xe/xe_bo.c                         |   6 +-
 drivers/gpu/drm/xe/xe_device.c                     |  32 ++
 drivers/gpu/drm/xe/xe_device.h                     |   1 +
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  24 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   2 -
 drivers/gpu/drm/xe/xe_gsc.c                        |   8 +-
 drivers/gpu/drm/xe/xe_gt.c                         |  55 +++
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |  18 +-
 drivers/gpu/drm/xe/xe_gt_types.h                   |   6 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   4 +-
 drivers/gpu/drm/xe/xe_hw_fence.c                   |   9 +-
 drivers/gpu/drm/xe/xe_hw_fence_types.h             |   7 +-
 drivers/gpu/drm/xe/xe_mmio.c                       |  28 +-
 drivers/gpu/drm/xe/xe_observation.c                |   1 -
 drivers/gpu/drm/xe/xe_pat.c                        |  11 +-
 drivers/gpu/drm/xe/xe_pm.c                         |  11 +-
 drivers/gpu/drm/xe/xe_preempt_fence.c              |   3 +-
 drivers/gpu/drm/xe/xe_preempt_fence_types.h        |   2 +
 drivers/gpu/drm/xe/xe_sched_job.c                  |   3 +-
 drivers/gpu/drm/xe/xe_trace.h                      |   2 +-
 drivers/gpu/drm/xe/xe_wa.c                         |  18 +
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |   4 +-
 drivers/hid/hid-asus.c                             |   3 +
 drivers/hid/hid-cougar.c                           |   2 +-
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/hid-multitouch.c                       |  33 ++
 drivers/hid/wacom_wac.c                            |   4 +-
 drivers/input/joystick/adc-joystick.c              |   7 +-
 drivers/input/misc/uinput.c                        |  14 +
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/i8042-acpipnpio.h              |  29 +-
 drivers/input/serio/i8042.c                        |  10 +-
 drivers/input/touchscreen/ads7846.c                |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   6 +
 drivers/input/touchscreen/himax_hx83112b.c         |  14 +-
 drivers/iommu/iommufd/device.c                     |   2 +-
 drivers/iommu/iommufd/selftest.c                   |   2 +-
 drivers/mmc/core/mmc_test.c                        |   9 +-
 drivers/mmc/host/dw_mmc.c                          |   8 +
 drivers/mmc/host/mtk-sd.c                          |   8 +-
 drivers/net/bonding/bond_main.c                    |  21 +-
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |   5 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |   3 +-
 drivers/net/dsa/ocelot/felix.c                     | 126 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   5 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |   3 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   7 +-
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  47 +--
 drivers/net/ethernet/intel/igb/igb_main.c          |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |  23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  26 +-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         |   6 +-
 drivers/net/ethernet/mscc/ocelot.c                 | 279 ++++++++++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c            |   3 +-
 drivers/net/ethernet/mscc/ocelot_vcap.c            |   1 +
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |   8 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  25 +-
 drivers/net/phy/realtek.c                          |   3 +-
 drivers/net/virtio_net.c                           |   2 +-
 drivers/nvme/host/core.c                           |   2 +-
 drivers/nvme/host/nvme.h                           |   1 -
 drivers/platform/surface/aggregator/controller.c   |   3 +-
 .../platform/surface/surface_aggregator_registry.c |  58 ++-
 drivers/platform/x86/asus-wmi.c                    |  16 +-
 drivers/platform/x86/dell/Kconfig                  |   1 +
 drivers/platform/x86/dell/dell-uart-backlight.c    |   8 +
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   3 +-
 drivers/pmdomain/imx/imx93-pd.c                    |   5 +-
 drivers/pmdomain/imx/scu-pd.c                      |   5 -
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |   2 +-
 drivers/s390/crypto/ap_bus.c                       |   7 +-
 drivers/scsi/sd.c                                  |   3 +
 drivers/spi/spi-cadence-quadspi.c                  |  14 +-
 drivers/spi/spi-fsl-lpspi.c                        |  31 +-
 drivers/spi/spi-pxa2xx-pci.c                       |  15 +-
 drivers/spi/spi-pxa2xx-platform.c                  |  26 +-
 drivers/spi/spi-pxa2xx.c                           |  20 +-
 drivers/spi/spi-pxa2xx.h                           |   3 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  30 +-
 .../staging/media/atomisp/include/linux/atomisp.h  |   1 -
 drivers/thermal/thermal_debugfs.c                  |   6 +-
 drivers/thermal/thermal_of.c                       |  23 +-
 drivers/ufs/core/ufshcd.c                          |   6 +-
 drivers/ufs/host/ufs-qcom.c                        |   6 +-
 fs/bcachefs/alloc_background.c                     |  66 ++--
 fs/bcachefs/alloc_background_format.h              |   1 +
 fs/bcachefs/bcachefs_format.h                      |   3 +-
 fs/bcachefs/btree_cache.c                          |  25 ++
 fs/bcachefs/btree_cache.h                          |   2 +
 fs/bcachefs/btree_iter.h                           |   9 +
 fs/bcachefs/btree_key_cache.c                      |  31 +-
 fs/bcachefs/btree_update_interior.c                |  46 ++-
 fs/bcachefs/buckets.c                              |  74 ++--
 fs/bcachefs/buckets_waiting_for_journal.c          |   4 +-
 fs/bcachefs/data_update.c                          | 209 +++++-----
 fs/bcachefs/extents.c                              |  41 ++
 fs/bcachefs/extents.h                              |   1 +
 fs/bcachefs/fs-io-buffered.c                       |   2 +-
 fs/bcachefs/fs-ioctl.c                             |   3 +-
 fs/bcachefs/fsck.c                                 |   6 +-
 fs/bcachefs/journal.c                              |   2 +-
 fs/bcachefs/journal_sb.c                           |  15 +
 fs/bcachefs/movinggc.c                             |   2 +-
 fs/bcachefs/recovery.c                             |   9 +-
 fs/bcachefs/replicas.c                             |   3 +-
 fs/bcachefs/sb-downgrade.c                         |   8 +-
 fs/bcachefs/util.c                                 |   1 -
 fs/bcachefs/xattr.c                                |  12 +-
 fs/erofs/dir.c                                     |  35 +-
 fs/erofs/inode.c                                   |  18 +-
 fs/erofs/internal.h                                |   2 +-
 fs/erofs/super.c                                   |  26 +-
 fs/erofs/zutil.c                                   |   3 +-
 fs/file_table.c                                    |  11 +-
 fs/nfs/callback_xdr.c                              |   6 +-
 fs/nfs/delegation.c                                |  15 +-
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/nfs/pnfs.c                                      |   5 +-
 fs/nfs/super.c                                     |   2 +
 fs/smb/client/cifsfs.c                             |   6 +-
 fs/smb/client/cifsglob.h                           |   6 +-
 fs/smb/client/connect.c                            |   3 +
 fs/smb/client/file.c                               |   4 +-
 fs/smb/client/ioctl.c                              |   2 +
 fs/smb/client/link.c                               |   1 +
 fs/smb/client/reparse.c                            |  11 +-
 fs/smb/server/connection.c                         |  34 +-
 fs/smb/server/connection.h                         |   3 +-
 fs/smb/server/mgmt/user_session.c                  |   9 +
 fs/smb/server/oplock.c                             |   2 +-
 fs/smb/server/smb2pdu.c                            |  31 +-
 fs/smb/server/smb_common.h                         |   4 +-
 fs/super.c                                         |   4 +-
 include/acpi/video.h                               |   1 +
 include/linux/blkdev.h                             |   7 +-
 include/linux/dsa/ocelot.h                         |  47 +++
 include/linux/kasan.h                              |  63 ++-
 include/linux/panic.h                              |   1 +
 include/linux/rcutiny.h                            |   5 +
 include/linux/rcutree.h                            |   1 +
 include/linux/slab.h                               | 228 ++++++++++-
 include/net/bluetooth/hci.h                        |  17 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/dsa.h                                  |  16 +-
 include/net/kcm.h                                  |   1 +
 include/scsi/scsi_cmnd.h                           |   2 +-
 include/soc/mscc/ocelot.h                          |  12 +-
 include/soc/mscc/ocelot_vcap.h                     |   2 +
 include/trace/events/rpcrdma.h                     |  36 ++
 include/uapi/drm/xe_drm.h                          |   8 +-
 include/ufs/ufshcd.h                               |   8 +
 io_uring/io_uring.c                                |  14 +-
 io_uring/kbuf.c                                    |   9 +-
 kernel/cgroup/cpuset.c                             |  38 +-
 kernel/panic.c                                     |   8 +-
 kernel/printk/printk.c                             |   2 +-
 kernel/rcu/tree.c                                  | 109 +++++-
 kernel/workqueue.c                                 |  50 +--
 lib/slub_kunit.c                                   |  31 ++
 mm/Kconfig.debug                                   |  32 ++
 mm/kasan/common.c                                  |  62 +--
 mm/kasan/kasan_test.c                              |  46 +++
 mm/slab.h                                          |  13 +-
 mm/slab_common.c                                   | 354 ++++++-----------
 mm/slub.c                                          | 412 +++++++++++++-------
 net/bluetooth/hci_core.c                           |  19 +-
 net/bluetooth/hci_event.c                          |   2 +-
 net/bluetooth/mgmt.c                               |   4 +
 net/bluetooth/smp.c                                | 144 +++----
 net/core/netpoll.c                                 |   2 -
 net/dsa/tag.c                                      |   5 +-
 net/dsa/tag.h                                      | 135 +++++--
 net/dsa/tag_ocelot.c                               |  37 +-
 net/ipv4/inet_connection_sock.c                    |   5 +-
 net/ipv4/tcp_ipv4.c                                |  14 +
 net/ipv4/udp_offload.c                             |   3 +-
 net/ipv6/ip6_output.c                              |  10 +
 net/ipv6/ip6_tunnel.c                              |  12 +-
 net/iucv/iucv.c                                    |   4 +-
 net/kcm/kcmsock.c                                  |   4 +
 net/mctp/test/route-test.c                         |   2 +-
 net/mptcp/pm.c                                     |  13 -
 net/mptcp/pm_netlink.c                             | 142 ++++---
 net/mptcp/protocol.h                               |   3 -
 net/netfilter/nf_flow_table_inet.c                 |   3 +
 net/netfilter/nf_flow_table_ip.c                   |   3 +
 net/netfilter/nft_counter.c                        |   9 +-
 net/openvswitch/datapath.c                         |   2 +-
 net/sched/sch_netem.c                              |  47 ++-
 net/sunrpc/xprtrdma/ib_client.c                    |   6 +-
 samples/trace_events/trace_custom_sched.c          |   1 -
 scripts/Makefile.build                             |   2 +-
 scripts/Makefile.lib                               |  28 +-
 scripts/Makefile.modfinal                          |   2 +-
 scripts/Makefile.vmlinux                           |   2 +-
 scripts/Makefile.vmlinux_o                         |   2 +-
 scripts/kconfig/merge_config.sh                    |   2 +
 scripts/link-vmlinux.sh                            |   3 +-
 sound/soc/codecs/cs42l42.c                         |   1 -
 tools/testing/cxl/Kbuild                           |   1 +
 tools/testing/cxl/test/mock.c                      |  12 +
 .../selftests/drivers/net/mlxsw/ethtool_lanes.sh   |   3 +-
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |  54 ++-
 tools/testing/selftests/net/forwarding/lib.sh      |  57 +++
 .../selftests/net/forwarding/local_termination.sh  | 431 +++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  76 +++-
 tools/testing/selftests/net/udpgro.sh              |  53 +--
 tools/testing/selftests/tc-testing/tdc.py          |   1 -
 275 files changed, 4049 insertions(+), 1673 deletions(-)
