Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA88C83F2C
	for <rcu@archiver.kernel.org>; Sun,  3 Sep 2023 03:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbjICDaA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 2 Sep 2023 23:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjICD37 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 2 Sep 2023 23:29:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660A18C
        for <rcu@vger.kernel.org>; Sat,  2 Sep 2023 20:29:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ccc462deca6so375726276.0
        for <rcu@vger.kernel.org>; Sat, 02 Sep 2023 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693711796; x=1694316596; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1SlPD/HlZl3/ApL2bHNmig99TpQMcnUsVn2m8D0Vgg=;
        b=WpRR5frdEXxh01O09bk3FcE2FMTPRjAxz35m0yDr+YghiEjvvxR6Fx6WbwfxibUggJ
         slW5SNqqKoS+frbGutIKr3X/TVFKiuTo12puLoo46bln3MPSPgrHcleqFc3zNxLV28GJ
         rvfIAmvKf9G2sPWuYUcCE1+Vl/U6/O4j7eRRu5NqEV2TperIYVa+MxrItAwVFfRC9pDg
         pkfV+ayR9CjA3d/U50TvROMPt87c5dOvqrH9MmCjB0JMofyqlwjLLwW6qyUzDVzkbh0r
         vskLscmQutR7zLXGRi9kMHXaGRZsXh+xpdKsfIstcX/pDKHvt6IhhiNzjXaZ/0Z6B6n+
         5/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693711796; x=1694316596;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1SlPD/HlZl3/ApL2bHNmig99TpQMcnUsVn2m8D0Vgg=;
        b=FcsS7UT8cVXVI/vMtYE9Y8vODaYQCQpFviZ6KYZ9R9B/reHhLX1UZJGRdgnCCGV/6E
         CjSogJ3nmUZv9euqbCL2Pz3HHPzS5X/fZCDSJlk6oReIlalGdYxZDMlVN2E6SL0EfHCL
         F53Zi9E0WOVp4E9A9iH9Rcctp4zwfKitnHqYXyaZvloSDVsOhM1td3Z2ziBBItfv/R/y
         0u2vfeoEawAolGeUXqxkA6sGjtKNhTRIL809hsxnPWpEhRBeGjnFRde9Mdd558KE/LB2
         TC1KXb/p4864FW/cLg6o9kZAwWWhm3eFSlpd70+WPL6JbCj+8/QI+rS4T5uEglruz/j8
         qASg==
X-Gm-Message-State: AOJu0Yzfwx4iSAEIsEvWt6E15bff2X0SQFzJvulRlDMNSX9tEid5alY7
        rhUo0fVPY3gxLp7FoQZVDVuhUHmha2lnnGj44AGeOA==
X-Google-Smtp-Source: AGHT+IGndHoq+5l4aEFGeXil4nuAmF24mwgZ/R2voWQcfpcvYa+TQsPZaW1RHIgPYVQ6+7sXrw2xOw==
X-Received: by 2002:a0d:d90e:0:b0:579:e8de:3580 with SMTP id b14-20020a0dd90e000000b00579e8de3580mr7343592ywe.9.1693711795653;
        Sat, 02 Sep 2023 20:29:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p189-20020a815bc6000000b0054bfc94a10dsm1954015ywb.47.2023.09.02.20.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 20:29:55 -0700 (PDT)
Date:   Sat, 2 Sep 2023 20:29:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Hugh Dickins <hughd@google.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP:
 kvfree_rcu_bulk)
In-Reply-To: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
Message-ID: <c9893a21-5873-7f26-7bed-79f5cd441e82@google.com>
References: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 3 Sep 2023, Bagas Sanjaya wrote:

> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > I've just made the transition from 6.4.14 to 6.5.1 and my Haswell-EP X99 machine took way longer to boot (55 seconds instead of 16 seconds). The following trace was seen in dmesg which was also not present on 6.4.14 (and might be the cause for the long boot time); this is on bare metal.
> > 
> > [  +0,000021] CPU: 13 PID: 338 Comm: kworker/13:1 Not tainted 6.5.1-3.1-cachyos-lto #1 c414458bd5e5db6e6f9addca639c3a78811b24e7
> > [  +0,000003] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> > [  +0,000002] Workqueue: events kfree_rcu_work
> > [  +0,000004] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000004] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 72 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 05 df ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> > [  +0,000002] RSP: 0018:ffff8fe4611cbd90 EFLAGS: 00010206
> > [  +0,000002] RAX: 0000000000000048 RBX: ffff8fe8e04f7000 RCX: fffffffffffffffc
> > [  +0,000002] RDX: 0000000000000000 RSI: ffff8fe8e04f7000 RDI: ffff8fe9df95cac8
> > [  +0,000001] RBP: ffff8fe4611cbe40 R08: 8080808080808080 R09: fefefefefefefeff
> > [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> > [  +0,000001] R13: ffff8fe4611cbde0 R14: ffff8fe9df95cac8 R15: ffff8fe4611cbdd0
> > [  +0,000001] FS:  0000000000000000(0000) GS:ffff8fe9df940000(0000) knlGS:0000000000000000
> > [  +0,000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0,000002] CR2: 00007f8287bff008 CR3: 00000005e8f73001 CR4: 00000000001706e0
> > [  +0,000001] Call Trace:
> > [  +0,000003]  <TASK>
> > [  +0,000001]  ? __warn+0x9e/0x160
> > [  +0,000004]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000004]  ? report_bug+0x112/0x180
> > [  +0,000003]  ? handle_bug+0x3d/0x80
> > [  +0,000003]  ? exc_invalid_op+0x16/0x40
> > [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> > [  +0,000005]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000003]  kfree_rcu_work+0xcd/0x200
> > [  +0,000005]  process_one_work+0x21a/0x620
> > [  +0,000004]  ? wake_up_process+0x1d3/0x1720
> > [  +0,000004]  worker_thread+0x12b/0x4c0
> > [  +0,000003]  ? compat_get_bitmap+0xa0/0xa0
> > [  +0,000003]  kthread+0xf1/0x160
> > [  +0,000004]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork+0x30/0x40
> > [  +0,000005]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork_asm+0x11/0x20
> > [  +0,000005]  </TASK>
> > [  +0,000001] ---[ end trace 0000000000000000 ]---
> 
> Later, the reporter came up with another trace:
> 
> > I just saw a patch from Hugh Dickins on the LKML (https://www.spinics.net/lists/kernel/msg4919906.html) and indeed, with my self-compiled 6.5.1 Kernel, the trace is now downgraded to a warning (see below). However, the slow boot still remains and also my games won't load up due to missing a rendering device. But that might be a different issue.
> > 
> > 
> > [  +0,000227] ------------[ cut here ]------------
> > [  +0,000002] WARNING: CPU: 21 PID: 345 at kernel/rcu/tree.c:2952 kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000011] Modules linked in: pkcs8_key_parser crypto_user fuse loop zram bpf_preload ip_tables x_tables ext4 crc32c_generic mbcache crc16 jbd2 usbhid amdgpu mfd_core drm_buddy drm_suballoc_helper crc32c_i>
> > [  +0,000027] CPU: 21 PID: 345 Comm: kworker/21:1 Not tainted 6.5.1-3.1-cachyos-lto #1 de6495663682da00bbe0d80bdc163dd768b25681
> > [  +0,000004] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> > [  +0,000002] Workqueue: events kfree_rcu_work
> > [  +0,000006] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000006] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 52 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 e5 de ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> > [  +0,000003] RSP: 0018:ffff8df57a5ffd90 EFLAGS: 00010206
> > [  +0,000003] RAX: 0000000000000020 RBX: ffff8df44cb40000 RCX: fffffffffffffffc
> > [  +0,000003] RDX: 0000000000000000 RSI: ffff8df44cb40000 RDI: ffff8df91fb5cac8
> > [  +0,000002] RBP: ffff8df57a5ffe40 R08: 8080808080808080 R09: fefefefefefefeff
> > [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> > [  +0,000002] R13: ffff8df57a5ffde0 R14: ffff8df91fb5cac8 R15: ffff8df57a5ffdd0
> > [  +0,000002] FS:  0000000000000000(0000) GS:ffff8df91fb40000(0000) knlGS:0000000000000000
> > [  +0,000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0,000002] CR2: 000055fe51d3f700 CR3: 000000065de7d002 CR4: 00000000001706e0
> > [  +0,000002] Call Trace:
> > [  +0,000003]  <TASK>
> > [  +0,000002]  ? __warn+0x9e/0x160
> > [  +0,000006]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000005]  ? report_bug+0x112/0x180
> > [  +0,000005]  ? handle_bug+0x3d/0x80
> > [  +0,000005]  ? exc_invalid_op+0x16/0x40
> > [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> > [  +0,000007]  ? kvfree_rcu_bulk+0x13b/0x160
> > [  +0,000006]  kfree_rcu_work+0xcd/0x200
> > [  +0,000006]  process_one_work+0x21a/0x620
> > [  +0,000006]  ? wake_up_process+0x1d3/0x1720
> > [  +0,000005]  worker_thread+0x12b/0x4c0
> > [  +0,000005]  ? compat_get_bitmap+0xa0/0xa0
> > [  +0,000004]  kthread+0xf1/0x160
> > [  +0,000006]  ? getreg32+0x1e0/0x1e0
> > [  +0,000004]  ret_from_fork+0x30/0x40
> > [  +0,000007]  ? getreg32+0x1e0/0x1e0
> > [  +0,000003]  ret_from_fork_asm+0x11/0x20
> > [  +0,000009]  </TASK>
> > [  +0,000001] ---[ end trace 0000000000000000 ]---
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217864
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217864

Sorry, please delete me from this thread: I'm no expert on system
slowdowns or cachyos or kvfree_rcu_bulk(), and have to stick to those
things which I might be able to help with.

IIRC sometimes slowdowns like that come from an area of uncached memory
getting to be used by mistake; and presumably two bisections of 6.4->6.5
on that machine would help identify where the slowdown and the warning
come in - but I shall not be participating.

The 6.6 patch of mine which Marcus applied is not wrong on 6.5, but not
helpful there either; and not relevant to whatever is going on here.

He shows it as "changing" a warning with the first few lines left out
to a warning with the first few lines included i.e. no change,
so no need for me to get involved.

Hugh
