Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA0C433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53549206F7
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IbUErGQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbgFXP5R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404718AbgFXP5Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 11:57:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78BC061795
        for <rcu@vger.kernel.org>; Wed, 24 Jun 2020 08:57:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so2249151qkg.12
        for <rcu@vger.kernel.org>; Wed, 24 Jun 2020 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jZYzs8OyHucPngtfa3rnlFCl1zhe+pFCEDNvHAi29U8=;
        b=IbUErGQEAYWMvoLjyGAk425gR0i5lwgLpntmHS+QHu9bhEmU3AY6VBdIaTj/2TOzMc
         OKDL3hAf1ZbscbPlWIXwKQiMMAK1vTBBOgRCOJ7Fw/lO3jUfQ1K1l0BR1ahGAa4mtfy2
         uRYp1zOb47kIH1gWy2EyX6B0JPkWfiJDYWcWuIQGGoNfX4wEO1L0VLZDlhNSdCoG0xYd
         lI1JpmdK+xupMWM7ExZVsDk55aRlFJ34/IcbLEyvseKw1UMPHE5imSPdTFj+T03bcE7s
         Alc5Yu3R8Obtz+0NiMm+nbcdkhE2JflDHuFgyv+7ZIumwncJw4qibehaXIp4OE3STeoB
         V3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jZYzs8OyHucPngtfa3rnlFCl1zhe+pFCEDNvHAi29U8=;
        b=TwZxIvE2d2cChEm7Ekfy/HdcE7Tqkijs9hIAxWG4UO+o5s/VHAtPy20biPu2hSZbT8
         btGGx3QapRQoNJ8Ro1xPMeSd7I59/86I8nkFZy0J57suL3SZi1SeHi49Qih2xJjyi4z6
         rTnfScOjZcjV3cI45UeN2EEEYOSaUowlrKOZg4lD2Df4b/VnjoI4jiR/NkeJkfc7aeTc
         S4Vq5pQxBdoCmKKn8XU1L+8dlcCLiKufAFV2R+3pOKH13ak3cw2LibJ/0AC2mCJ944Ga
         CxX+iRpO4S8STM9etozWG+WlJcyMs6PDiBZ8DYGFf/Hkq6B9VPe9oVMkOD9au/hntYbq
         JSbg==
X-Gm-Message-State: AOAM530V68uWWHtjkaRQ73qgNS3wBoWVjGx/z9HCR/TG6A0XX7Qd6NFD
        qIoKEn0LjabE3gfQUXm7fekZ4Q==
X-Google-Smtp-Source: ABdhPJxiBzUIpNvmMf5asVsKH9SyMy6oN7t91xT2ZCVkBRmIuCeJU5UxviSvLsog1PSu8pEiIvn6fQ==
X-Received: by 2002:a37:c4b:: with SMTP id 72mr4991601qkm.359.1593014234745;
        Wed, 24 Jun 2020 08:57:14 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i13sm4109354qtc.83.2020.06.24.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:57:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:57:07 -0400
From:   Qian Cai <cai@lca.pw>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, paulmck@kernel.org,
        rcu@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Null-ptr-deref due to "vfs, fsinfo: Add an RCU safe per-ns mount
 list"
Message-ID: <20200624155707.GA1259@lca.pw>
References: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
 <2961585.1589326192@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2961585.1589326192@warthog.procyon.org.uk>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 13, 2020 at 12:29:52AM +0100, David Howells wrote:
> Qian Cai <cai@lca.pw> wrote:
> 
> > Reverted the linux-next commit ee8ad8190cb1 (“vfs, fsinfo: Add an RCU safe per-ns mount list”) fixed the null-ptr-deref.
> 
> Okay, I'm dropping this commit for now.

What's the point of re-adding this buggy patch to linux-next again since
0621 without fixing the previous reported issue at all? Reverting the
commit will still fix the crash below immediately, i.e.,

dbc87e74d022 ("vfs, fsinfo: Add an RCU safe per-ns mount list")

# runc run root

[ 9067.486969][T72863] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
[ 9067.543973][T72863] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[ 9067.586640][T72863] CPU: 24 PID: 72863 Comm: runc:[2:INIT] Not tainted 5.8.0-rc2-next-20200624+ #4
[ 9067.629285][T72863] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[ 9067.663809][T72863] RIP: 0010:umount_tree+0x4ec/0xcf0
[ 9067.688505][T72863] Code: 0f 85 61 04 00 00 49 83 c7 08 48 8b 43 b8 4c 89 fa 48 c1 ea 03 80 3c 2a 00 0f 85 33 04 00 00 4c 8b 7b c0 4c 89 fa 48 c1 ea 03 <80> 3c 2a 00 0f 85 09 04 00 00 49 89 07 48 85 c0 74 19 48 8d 78 08
[ 9067.782308][T72863] RSP: 0018:ffffc900259efcb0 EFLAGS: 00010246
[ 9067.810141][T72863] RAX: 0000000000000000 RBX: ffff8884b0cb8cd8 RCX: 1ffff92004b3dfa0
[ 9067.848310][T72863] RDX: 0000000000000000 RSI: ffff8884b0cb8cd8 RDI: ffffc900259efd08
[ 9067.886236][T72863] RBP: dffffc0000000000 R08: fffffbfff2bac7a6 R09: fffffbfff2bac7a6
[ 9067.922883][T72863] R10: ffffffff95d63d2f R11: fffffbfff2bac7a5 R12: ffff8884b0cb8c40
[ 9067.960156][T72863] R13: ffffc900259efd00 R14: 0000000000000001 R15: 0000000000000000
[ 9067.997069][T72863] FS:  00007fc286f88b80(0000) GS:ffff88881ed80000(0000) knlGS:0000000000000000
[ 9068.040907][T72863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9068.074258][T72863] CR2: 00007fc284141e00 CR3: 0000000fbc33a002 CR4: 00000000001706e0
[ 9068.111890][T72863] Call Trace:
[ 9068.126482][T72863]  ? rcu_read_unlock+0x50/0x50
[ 9068.148298][T72863]  ? unhash_mnt+0x450/0x450
[ 9068.169156][T72863]  ? rwlock_bug.part.1+0x90/0x90
[ 9068.191014][T72863]  do_mount+0x1132/0x1620
[ 9068.211042][T72863]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 9068.235399][T72863]  ? copy_mount_string+0x20/0x20
[ 9068.258407][T72863]  ? memdup_user+0x4f/0x80
[ 9068.278493][T72863]  __x64_sys_mount+0x15d/0x1b0
[ 9068.299948][T72863]  do_syscall_64+0x5f/0x310
[ 9068.320837][T72863]  ? trace_hardirqs_off+0x12/0x1a0
[ 9068.343781][T72863]  ? asm_exc_page_fault+0x8/0x30
[ 9068.367139][T72863]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 9068.394316][T72863] RIP: 0033:0x55d71f93e7ca
[ 9068.414833][T72863] Code: Bad RIP value.
[ 9068.433443][T72863] RSP: 002b:000000c00021af30 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[ 9068.473044][T72863] RAX: ffffffffffffffda RBX: 000000c000028000 RCX: 000055d71f93e7ca
[ 9068.510343][T72863] RDX: 000000c00010546a RSI: 000000c000105470 RDI: 000000c000105460
[ 9068.547999][T72863] RBP: 000000c00021afc8 R08: 0000000000000000 R09: 0000000000000000
[ 9068.587756][T72863] R10: 0000000000001000 R11: 0000000000000206 R12: 0000000000000148
[ 9068.624851][T72863] R13: 0000000000000147 R14: 0000000000000200 R15: 0000000000000100
[ 9068.662061][T72863] Modules linked in: loop vfio_pci vfio_virqfd vfio_iommu_type1 vfio kvm_intel kvm irqbypass efivars nls_ascii nls_cp437 vfat fat ip_tables x_tables sd_mod bnx2x hpsa mdio scsi_transport_sas firmware_class dm_mirror dm_region_hash dm_log dm_mod efivarfs
[ 9068.777205][T72863] ---[ end trace 9c03562d398fb10f ]---
[ 9068.802729][T72863] RIP: 0010:umount_tree+0x4ec/0xcf0
[ 9068.826630][T72863] Code: 0f 85 61 04 00 00 49 83 c7 08 48 8b 43 b8 4c 89 fa 48 c1 ea 03 80 3c 2a 00 0f 85 33 04 00 00 4c 8b 7b c0 4c 89 fa 48 c1 ea 03 <80> 3c 2a 00 0f 85 09 04 00 00 49 89 07 48 85 c0 74 19 48 8d 78 08
[ 9068.918966][T72863] RSP: 0018:ffffc900259efcb0 EFLAGS: 00010246
[ 9068.947083][T72863] RAX: 0000000000000000 RBX: ffff8884b0cb8cd8 RCX: 1ffff92004b3dfa0
[ 9068.985097][T72863] RDX: 0000000000000000 RSI: ffff8884b0cb8cd8 RDI: ffffc900259efd08
[ 9069.022555][T72863] RBP: dffffc0000000000 R08: fffffbfff2bac7a6 R09: fffffbfff2bac7a6
[ 9069.061621][T72863] R10: ffffffff95d63d2f R11: fffffbfff2bac7a5 R12: ffff8884b0cb8c40
[ 9069.101629][T72863] R13: ffffc900259efd00 R14: 0000000000000001 R15: 0000000000000000
[ 9069.138367][T72863] FS:  00007fc286f88b80(0000) GS:ffff88881ed80000(0000) knlGS:0000000000000000
[ 9069.180543][T72863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9069.209807][T72863] CR2: 00007fc284141e00 CR3: 0000000fbc33a002 CR4: 00000000001706e0
[ 9069.245727][T72863] Kernel panic - not syncing: Fatal exception
[ 9069.273756][T72863] Kernel Offset: 0x11c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 9069.327388][T72863] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
