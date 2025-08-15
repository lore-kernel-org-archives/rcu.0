Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824B1FF60A
	for <rcu@vger.kernel.org>; Fri, 15 Aug 2025 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298405; cv=none; b=JRoDdBiFVatR8w8g2oHv0EdzJo/1RmWzRWZjzLL7K99kxeAbJH8WmRtJ0cWMVIUSmasWdxJ1po24j6/Y6jTIeI4TGqyq3J4of+YmEozI0HaXOdqw45X3Pl01TJru/zXoiWJ2IxlcFnEdS97HvwRcOPlsaHnFNTtYdImaecTW7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298405; c=relaxed/simple;
	bh=IO2RxDt6ZIFbbcEW5ySBkmxEqOyDNZUQ+LtuP3NzRGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XcIScDmGO2i1FOosOGD8Rj2wrsjtv+J8cLk3Vvuq+FVVVLKxlevICR5EIKQBpwaNnYiMg5UBaNONaStiYP51vyF8yhmLsEFOagXYF5IEfsDSQf6vAnAw+SVJSxdcjCtG+fdc4uBbH158rrEqBMVjCx63UTPpvBj6nYQtvX1OP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RbO9+zGp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbO9+zGp"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445812598bso54323515ad.2
        for <rcu@vger.kernel.org>; Fri, 15 Aug 2025 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755298403; x=1755903203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFMLvpP6SQOf3Z5/hje0uPsmcH8OWRP/M8qsuDbYAZA=;
        b=RbO9+zGp9w5GrdBp9JQYI8J3o8Yu1DxCtLOERJk79L6jn7BCBv1p7rlWCYzChttPMv
         jI/URBvANm4M90oE3ixPR9b6z/iX/hhuBrcIeUaDyD3I+zXquxqgK+2fL1h6MP+GYT06
         yfVxB2kYd4yQ80bgDtBnNujZN39iHB438UZYpPtW2bNgRCBe3+mA2AHwk/LA4cSpPMEP
         ECDHR83axcQTxGWuI7FlNLrP9pX7Qyzvsex27f9cMAL6vYQan09XlQSrLvNSQg9xd2BN
         t2a46IKkyQNfB9hlstBw2JLuqIxmVblCIuEszUsGLqGo5BBqTmw98AlOhkmh4D5msPVh
         TiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755298403; x=1755903203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFMLvpP6SQOf3Z5/hje0uPsmcH8OWRP/M8qsuDbYAZA=;
        b=LavAxC3/9u/7BPONlKwEyTxC9+lIjAqLXPng8H0g8fsf0qZEms+Ag2vQWBTxwmGBgv
         u2svS4srHuFueuUe/Phw6dz2ycmnmxpq49ohuWuBEREoA6wGg469yuwK9NPNNANI7z7L
         5UI0smFxYq36zYh4hN0orAT9gGSBv1izsfZ2xug8bZCr/K/5/xm6xSNyE1+a2v9hsrud
         xBaixZdyv+qTvXyranS+2u8vZQMFXSEfF4llVJTzVWGawSLGpMj72+k8GRkmpfaFvCV8
         E1qRWk+5fFxQD7QF6pzuuzsULwqhqPxGyZZAG/5UEeVfQHgALddSfRLbrPDly4oxZIl4
         UehA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ51Y9Cynl/0t9p015XcFLO6fTifGNv3nwBwt+qse7QRxiorNknmjQQja7E1PkQSdtyV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyp+JT2jdmKO57VFrW+eritYCjgIp92qgpKpmoJ3nmw1Fd5KGW
	wmiWAKL+R8RGM9EKlpcaxSbembbX1FEMHDUEhbv0r9me8JjI4+tj6YujMljd6D6p2k6PBBytWi1
	LEc2pGOv7HHGN52m8ew==
X-Google-Smtp-Source: AGHT+IH7JBK049AunCZUq+7FOlhgfZ1QYyvLcXJcq8h6JxKHDaYqMNRfr1A1z7pyw1f+47LqRRmiZD6Bg10U5YM=
X-Received: from plcm7.prod.google.com ([2002:a17:902:f207:b0:243:31a:f8e2])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0c:b0:243:8f:6d7d with SMTP id d9443c01a7336-2446d93d241mr44547495ad.50.1755298402798;
 Fri, 15 Aug 2025 15:53:22 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:53:00 -0700
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815225259.3012455-2-sudarsanm@google.com>
Subject: Re: [PATCH v5 00/14] SLUB percpu sheaves
From: Sudarsan Mahendran <sudarsanm@google.com>
To: vbabka@suse.cz
Cc: Liam.Howlett@oracle.com, cl@gentwo.org, harry.yoo@oracle.com, 
	howlett@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Vlastimil,

I ported this patch series on top of v6.17.
I had to resolve some merge conflicts because of 
fba46a5d83ca8decb338722fb4899026d8d9ead2

The conflict resolution looks like:

@@ -5524,20 +5335,19 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
        MA_WR_STATE(wr_mas, mas, entry);
-       int ret = 0;
-       int request;

        mas_wr_prealloc_setup(&wr_mas);
        mas->store_type = mas_wr_store_type(&wr_mas);
-       request = mas_prealloc_calc(&wr_mas, entry);
-       if (!request)
+       mas_prealloc_calc(&wr_mas, entry);
+       if (!mas->node_request)
                goto set_flag;

        mas->mas_flags &= ~MA_STATE_PREALLOC;
-       mas_node_count_gfp(mas, request, gfp);
+       mas_alloc_nodes(mas, gfp);
        if (mas_is_err(mas)) {
-               mas_set_alloc_req(mas, 0);
-               ret = xa_err(mas->node);
+               int ret = xa_err(mas->node);
+
+               mas->node_request = 0;
                mas_destroy(mas);
                mas_reset(mas);
                return ret;
@@ -5545,7 +5355,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)

 set_flag:
        mas->mas_flags |= MA_STATE_PREALLOC;
-       return ret;
+       return 0;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);



When I try to boot this kernel, I see kernel panic
with rcu_free_sheaf() doing recursion into __kmem_cache_free_bulk()

Stack trace:

[    1.583673] Oops: stack guard page: 0000 [#1] SMP NOPTI
[    1.583676] CPU: 103 UID: 0 PID: 0 Comm: swapper/103 Not tainted 6.17.0-smp-sheaves2 #1 NONE
[    1.583679] RIP: 0010:__kmem_cache_free_bulk+0x57/0x540
[    1.583684] Code: 48 85 f6 0f 84 b8 04 00 00 49 89 d6 49 89 ff 48 85 ff 0f 84 fe 03 00 00 49 83 7f 08 00 0f 84 f3 03 00 00 0f 1f 44 00 00 31 c0 <48> 89 44 24 18 65 8b 05 6d 26 dc 02 89 44 24 2c 31 ff 89 f8 c7 44
[    1.583685] RSP: 0018:ff40dbc49b048fc0 EFLAGS: 00010246
[    1.583687] RAX: 0000000000000000 RBX: 0000000000000012 RCX: ffffffff939e8640
[    1.583687] RDX: ff2afe75213e6c90 RSI: 0000000000000012 RDI: ff2afe750004ad00
[    1.583688] RBP: ff40dbc49b049130 R08: ff2afe75368c2500 R09: ff2afe75368c3b00
[    1.583689] R10: ff2afe75368c2500 R11: ff2afe75368c3b00 R12: ff2aff31ba00b000
[    1.583690] R13: ffffffff939e8640 R14: ff2afe75213e6c90 R15: ff2afe750004ad00
[    1.583690] FS:  0000000000000000(0000) GS:ff2aff31ba00b000(0000) knlGS:0000000000000000
[    1.583691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.583692] CR2: ff40dbc49b048fb8 CR3: 0000000017c3e001 CR4: 0000000000771ef0
[    1.583692] PKRU: 55555554
[    1.583693] Call Trace:
[    1.583694]  <IRQ>
[    1.583696]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583698]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583700]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583702]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583703]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583705]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583707]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583708]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583710]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583711]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583713]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583715]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583716]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583718]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583719]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583721]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583723]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583724]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583726]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583727]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583729]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583731]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583732]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583734]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583735]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583737]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583739]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583740]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583742]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583743]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583745]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583747]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583748]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583750]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583751]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583753]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583755]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583756]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583758]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583759]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583761]  ? update_group_capacity+0xad/0x1f0
[    1.583763]  ? sched_balance_rq+0x4f6/0x1e80
[    1.583765]  __kmem_cache_free_bulk+0x2c7/0x540
[    1.583767]  ? update_irq_load_avg+0x35/0x480
[    1.583768]  ? __pfx_rcu_free_sheaf+0x10/0x10
[    1.583769]  rcu_free_sheaf+0x86/0x110
[    1.583771]  rcu_do_batch+0x245/0x750
[    1.583772]  rcu_core+0x13a/0x260
[    1.583773]  handle_softirqs+0xcb/0x270
[    1.583775]  __irq_exit_rcu+0x48/0xf0
[    1.583776]  sysvec_apic_timer_interrupt+0x74/0x80
[    1.583778]  </IRQ>
[    1.583778]  <TASK>
[    1.583779]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    1.583780] RIP: 0010:cpuidle_enter_state+0x101/0x290
[    1.583781] Code: 85 f4 ff ff 49 89 c4 8b 73 04 bf ff ff ff ff e8 d5 44 d4 ff 31 ff e8 9e c7 37 ff 80 7c 24 04 00 74 05 e8 12 45 d4 ff fb 85 ed <0f> 88 ba 00 00 00 89 e9 48 6b f9 68 4c 8b 44 24 08 49 8b 54 38 30
[    1.583782] RSP: 0018:ff40dbc4809afe80 EFLAGS: 00000202
[    1.583782] RAX: ff2aff31ba00b000 RBX: ff2afe75614b0800 RCX: 000000005e64b52b
[    1.583783] RDX: 000000005e73f761 RSI: 0000000000000067 RDI: 0000000000000000
[    1.583783] RBP: 0000000000000002 R08: fffffffffffffff6 R09: 0000000000000000
[    1.583784] R10: 0000000000000380 R11: ffffffff908c38d0 R12: 000000005e64b535
[    1.583784] R13: 000000005e5580da R14: ffffffff92890b10 R15: 0000000000000002
[    1.583784]  ? __pfx_read_tsc+0x10/0x10
[    1.583787]  cpuidle_enter+0x2c/0x40
[    1.583788]  do_idle+0x1a7/0x240
[    1.583790]  cpu_startup_entry+0x2a/0x30
[    1.583791]  start_secondary+0x95/0xa0
[    1.583794]  common_startup_64+0x13e/0x140
[    1.583796]  </TASK>
[    1.583796] Modules linked in:
[    1.583798] ---[ end trace 0000000000000000 ]---
[    1.583798] RIP: 0010:__kmem_cache_free_bulk+0x57/0x540
[    1.583800] Code: 48 85 f6 0f 84 b8 04 00 00 49 89 d6 49 89 ff 48 85 ff 0f 84 fe 03 00 00 49 83 7f 08 00 0f 84 f3 03 00 00 0f 1f 44 00 00 31 c0 <48> 89 44 24 18 65 8b 05 6d 26 dc 02 89 44 24 2c 31 ff 89 f8 c7 44
[    1.583800] RSP: 0018:ff40dbc49b048fc0 EFLAGS: 00010246
[    1.583801] RAX: 0000000000000000 RBX: 0000000000000012 RCX: ffffffff939e8640
[    1.583801] RDX: ff2afe75213e6c90 RSI: 0000000000000012 RDI: ff2afe750004ad00
[    1.583801] RBP: ff40dbc49b049130 R08: ff2afe75368c2500 R09: ff2afe75368c3b00
[    1.583802] R10: ff2afe75368c2500 R11: ff2afe75368c3b00 R12: ff2aff31ba00b000
[    1.583802] R13: ffffffff939e8640 R14: ff2afe75213e6c90 R15: ff2afe750004ad00
[    1.583802] FS:  0000000000000000(0000) GS:ff2aff31ba00b000(0000) knlGS:0000000000000000
[    1.583803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.583803] CR2: ff40dbc49b048fb8 CR3: 0000000017c3e001 CR4: 0000000000771ef0
[    1.583803] PKRU: 55555554
[    1.583804] Kernel panic - not syncing: Fatal exception in interrupt
[    1.584659] Kernel Offset: 0xf600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

