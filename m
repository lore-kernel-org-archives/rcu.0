Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794623065;
	b=UAKgF22rBcPsREsFaQE/yyfBtasAevMdmczDFQk2dXDekHHdMGHToRsiK/vnGXZWjIxh
	 Dt3X7cEX/4HApktEMoCOURNKhI4g9IfvdoiWCB/mTOVfwhFr1Tr/qe92o8FUMP7Nco1+X
	 bqipU74w9ABfKPOx34MDC/Y5G9usx7t+ZbafiJueTJNN6M7b2W1tHPhULGRH9DkH6FHeS
	 jUshOw4xBQleup9sMrTpJrg5rmzyI63YNlZlNgu/kvCSFCv5x195MB4dda/6rYnF6wsHZ
	 RgsL78YxS6LaE6zsocVBiZRmFVSDPF5faPLYI/vOitz4KkN6XWPDFwDK+7CTbLM9how==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623065;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:References:
	 Date:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=pfTfdXu3L5OFlWQyk002244ztNSmP+yZNWJOAOIlzFo=;
	b=EkJ7JjZtlnXiLScGct7PHvhBq0ffzDT1oA94HY2rHUeea1iOmElcDSJC3BwWp3ybX3Sy
	 pzSgUO/5DJQYVWryQs0eTrvfetGqh5UryY6UG+yEewnbSUAzZFujM1CEn9JuEkE6ZP+zB
	 IPDQtKTZ3DP3JBPBraijAPubSTuTWHRt1sf+yhHYi9T4SobtyxygH6RoK2HdMrs5+qdnf
	 HWnUXNDOxrcpdTrxJVm8Cc903ugqgkAPdUAyJM05GwNvaFI/yXbPI0gYdqdwueZYMDwYC
	 PZQqIUoo6XRbxUOIenQ6UOv/BzTI/8qXtZk3a+BwSijYVq5uRljWiNtSclOoRs8HT0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Sl3o106G;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46088606A323
	for <rcu@vger.kernel.org>; Sat, 14 Nov 2026 02:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46088606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Sl3o106G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794623060; bh=pfTfdXu3L5OFlWQyk002244ztNSmP+yZNWJOAOIlzFo=;
	h=From:To:Cc:Subject:References:Date;
	b=Sl3o106GOKHri/Ez0UUB5hDpv/sBCiFmEA+uhTZ87W31ay47qLurUhIE2zBiED0dx
	 ozXRV10rHMOHIIwlCYTMm6qT+mP5y5A+CIKosVZSnwMn3x0OEVF5fnRpDASUA3syZi
	 V4jSESvk2BpGYRnoy1P1uo5ouxpHn66GdxbQp+2s=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 61294AE8; Sat, 14 Nov 2026 10:24:18 +0800
X-QQ-mid: xmsmtpt1794623058t474ixiin
Message-ID: <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/Vy5/iPDS9fDjwOnC2a3cKNPsTkp/82Cye/KhmYsRt+l2Mzxl5L
	 al8eq6PeTGOQFd+FtTGPVxFzjCyFIosp8vys4ZUBQZhKFJ4Y+9lejGUtGhNNJ3UL8H9nwcnvNjpt
	 PGz/E0acj0rfR50Vncj1B62fxl+put5Bz63P8IYdouljN0PcShnKUK+8iz7IMSLTfQBGzPvH97al
	 +I6X6gpTfabRh6R/xDAE5poXxgpEpEZZnmokiUg9BM1y9fLRuoNz8kI3iGtpmNxWs+HxHaDrH9Sq
	 9wB4J6PLOH23ugrukcWenUVg7/IAu91ceE0TgDtZf5Luem00Dtc+wOnwliHvfkad4sBAnoIuPWXB
	 tTxRKeYRYfP76n9sxHXxue9c/Q2vnGH6dhLmL5dp18ERdnOkWtYtg35MOEbCX2gpH73YGN8iFt12
	 7tLPaWGN5SE6CNjhVQooZ8kw+/f1ckbzVoKHDuPPFU+7jsigL7zunDuHBysYaDMoZNiVUS6kVyjR
	 JZr6FCl5y0J60Im1v+gvdMoW8vmuomIuGbKk0gPKq6QW7tKVZKoqKNBu8JutMbM33OQ2/Zhh4Vrw
	 YLH5oiT1/t3iYTGWcAFeBRnuEdnEKwCjh1vA/gCPCi8fU1mdJZDdyJDpRhezbtveHoySLJriKPr0
	 d0EU2fm/TkN63ZGhN24XSvQXqoMvu7FOHsw1+ei/dHIn/tltwL72reeLh87s+vy1h3qLiAMSKpgA
	 B8eHwftNvIffBqGA7BexITYH7Pm40NpZ6jTIAbQ+fX+0UYG6LO6zzxafsZUZ3z0YBdkTIozhMs9q
	 u4eAnkhWM8JQWfl/ZfMNPUrtuZ78/8zHhOmIoRZNJt+PQDT1wUfk6qsdajs4HHG57ysQj+OiG2Yu
	 eKIfJZUPus0mDuHnGqlEzvAZ3XIGk/b09R/FTGuuJixOyl5VsobXBUY+EZ8BU01VRBcNZMiWXlZj
	 ZDUmOLppksxiz+31UwxF5nSHeT++/aVxZrcU2JlEmR82CYEtrw79xSzRpUp2wrznF800GXXyiq2i
	 kA1etJxpHwlSTBQGFPsDXbKxZVsewQSkPEv3GDwA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Guikun Yang <yangguikun19@qq.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 rcu@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Bug report] srcu_module_coming() dereferences unvalidated
 ___srcu_struct_ptrs entries - wild kernel-memory write on module load
X-OQ-MSGID: <srcu-struct-ptrs-wildwrite-20261114@qq.com>
References: <mod-r-offset-oob-20261113@qq.com>
Date: Sat, 14 Nov 2026 09:30:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Guikun Yang <yangguikun19@qq.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
    rcu@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [Bug report] srcu_module_coming() dereferences unvalidated
 ___srcu_struct_ptrs entries - wild kernel-memory write on module load

Hi Paul, Luis,

The module loader hands the contents of the ___srcu_struct_ptrs section
to SRCU as an array of absolute struct srcu_struct * pointers, with no
validation of any entry. srcu_module_coming() then writes through each
one during the MODULE_STATE_COMING notification, inside init_module().
A crafted module whose synthetic section contains an arbitrary 64-bit
value therefore gets a kernel-heap pointer written to an
attacker-chosen address.

  Oops: general protection fault, probably for non-canonical address
  0xe00006aaa0000021: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  KASAN: probably user-memory-access in range
  [0x0000555500000108-0x000055550000010f]
  RIP: 0010:srcu_module_notify+0x480/0x610
  RAX: 0000607f57d191c0   (alloc_percpu return, the value being written)
  RBX: 0000555500000100   (the section entry, verbatim from the file)
  RDI: 0000555500000108   (&ssp->sda)
   notifier_call_chain
   blocking_notifier_call_chain_robust
   load_module
   __do_sys_init_module

## The three pieces

Loader, zero validation (kernel/module/main.c):

  mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
                                       sizeof(*mod->srcu_struct_ptrs),
                                       &mod->num_srcu_structs);

section_objs() counts entries and returns sh_addr; the bytes' validity
is entirely up to the ELF file.

Generator, absolute pointer (include/linux/srcutree.h):

  struct srcu_struct * const __srcu_struct_##name
        __section("___srcu_struct_ptrs") = &name

Unlike __tracepoints_ptrs (PREL32 self-relative on x86), this is a
link-time absolute address. In a hand-built section the bytes are
whatever the attacker writes, and since no .rela entry targets them,
apply_relocations() never touches them either.

Consumer, write on load (kernel/rcu/srcutree.c, unchanged from 7.3 to
mainline 2026-11-14):

  ssp = *(sspp++);
  ssp->sda = alloc_percpu(struct srcu_data);       /* wild write */
  if (WARN_ON_ONCE(!ssp->sda))
          return -ENOMEM;
  ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];        /* second write */

ssp->sda sits at offset 8, so an entry value V makes the kernel write
a freshly allocated percpu pointer to V+8, and a pointer derived from
it to V. The unload/rollback path (srcu_module_going()) dereferences
ssp->srcu_sup and frees ssp->sda through the same unchecked entries.

## Why this is more than a crash

The write value is a kernel heap address and the target is a fully
attacker-chosen 64-bit address. Pointing the entry at a
userland-readable mapping leaks the percpu allocation address directly
to userspace, defeating percpu-base randomization and contributing to
KASLR defeat. Pointing it at any zero-filled kernel address lands the
write. A non-canonical target gives the deterministic #GP above
(reproduced 7.3.0, KASAN inline, DEBUG_PAGEALLOC).

## The fix has an in-tree precedent

jump_label.c validates exactly this class of pointer in the same
module-notification path (kernel/jump_label.c:716):

  if (within_module((unsigned long)key, mod)) {
          static_key_set_entries(key, iter);
          continue;
  }

The suggested fix mirrors it in srcu_module_coming() and
srcu_module_going():

  for (i = 0; i < mod->num_srcu_structs; i++) {
          ssp = *(sspp++);
+         if (!ssp || !within_module((unsigned long)ssp, mod))
+                 return -EINVAL;
          ssp->sda = alloc_percpu(struct srcu_data);

__tracepoints_ptrs and __bpf_raw_tp_map are sibling pointer sections
with the same exposure; a shared check in find_module_sections()
would cover the class, but the SRCU entries are the concrete
write-what-where primitive demonstrated here.

This is the second report in this series: the relocation r_offset
bounds gap went out as <mod-r-offset-oob-20261113@qq.com> yesterday.
Both are cases of the module loader consuming section contents that
its ELF validity layer never checked.

## Reproducer

Carrier is a real xt_mark.ko built from the same tree as the test
kernel (vermagic, this_module size, 11 undefined symbols all
matching). A section synthesizer appends an 8-byte
___srcu_struct_ptrs entry (0x0000555500000100), fixing shstrtab,
e_shnum and e_shoff. Same boot, three steps:

  1. load original xt_mark.ko   -> 0
  2. unload                     -> 0
  3. load synthesized module    -> the Oops above

The A/B pair, the synthesizer and the reproducer are available on
request.

Tested on 7.3.0; kernel/rcu/srcutree.c and the loader path are
unchanged in mainline as of 2026-11-14.

Thanks,
Guikun Yang

