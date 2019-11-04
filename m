Return-Path: <SRS0=8dNv=Y4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F873CA9EA0
	for <rcu@archiver.kernel.org>; Mon,  4 Nov 2019 11:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CED22184C
	for <rcu@archiver.kernel.org>; Mon,  4 Nov 2019 11:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sf/cUGcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKDLdL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:33:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDLdK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Nov 2019 06:33:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so3826746otr.13
        for <rcu@vger.kernel.org>; Mon, 04 Nov 2019 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m1wIA4TogLEd7/d6SljBL6tr4IXzU8yJ7HR3M7Fnbw=;
        b=sf/cUGcdMUQt1h9zbB3HK/h4JkmcuPDeI7QsUB8TwmFrJ0/2hZkNVCmSspVy/TS4h1
         Qn/txBgmUAGrRNIih853tomXvmCsSSyyx7t8z9CvAIrfqbx7jppYw+kBD4WUqHT65mBn
         T2zCLiyN0LpGjZ/9IG3EZS8CF1ZHhs3aCpi3IFmIVyNV5PVbWIahMraj9IN4MF+hx/ha
         oYNl5X6iqBXw3WrtjGvm/cSELuU0XxX2r6FCE9sZYmafAeLSKBXu6NtSFv7MZI6GPWN2
         mczOdEN3FL2hGEiqJKR0v5pAlW76Z4u0RHtuvSKjjxuZuW3pHKWt0NzxVJE0CU1dUmdh
         vdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m1wIA4TogLEd7/d6SljBL6tr4IXzU8yJ7HR3M7Fnbw=;
        b=EJmim1omGiGS5D5NhgJJKwgoxCKGUD8p+V9K/Ib3MmTpyq9nbTQujDJO+zRylGRoab
         SKDlFozlf1kMBvqJQ9H5IT6L652vsbfwxWcLsNfNwfmlP9k065xM+CBYws80qGgWQRFa
         9HBI9+Km/0kYVRIJNnp7iVGzx+Zxx0exP/p5Hfc+Uc5GGkt7yDR+If539HYAVdWJFKGH
         2aubOJjaiLWeP2ingarEZjsH7X+VBll8uKnz3+GsxXrC+9MpBeTjKDqfdUbdnaccxZmU
         nEt+sN3p9+BPMD0sVd2aFRwlcoDa3abMozge5jRBNE7WahikYGUYWK83iumoQboJDgB6
         O8Kg==
X-Gm-Message-State: APjAAAVPkdTGbmCgXdlilkKiMHMz2xocImPng5prsDrbexM19dDUAYHE
        ZuClqY1GYMgAkIgC0G7DUHfBndKe/YaKOK15Kh3RQQ==
X-Google-Smtp-Source: APXvYqyPczi1eyZUKIrXKTRFKN1/7adCfjT0nKKLXSm46iILcLQbwSUcGqLNmQjpdjP5ck7OC8WfWxhYohTIeFEGBbw=
X-Received: by 2002:a9d:7308:: with SMTP id e8mr573623otk.17.1572867189226;
 Mon, 04 Nov 2019 03:33:09 -0800 (PST)
MIME-Version: 1.0
References: <000000000000411e4b059683a39c@google.com>
In-Reply-To: <000000000000411e4b059683a39c@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Nov 2019 12:32:57 +0100
Message-ID: <CANpmjNMegMA6d5n1cV5JLmMbbe-3TkH5q3sNt9+E+wb8esjvoA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus
To:     syzbot <syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        darrick.wong@oracle.com, Johannes Weiner <hannes@cmpxchg.org>,
        jack@suse.cz, josef@toxicpanda.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+RCU folks

On Mon, 4 Nov 2019 at 12:30, syzbot
<syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=1296ff50e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=99f4ddade3c22ab0cf23
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus
>
> read to 0xffffffff85a7d440 of 8 bytes by task 7624 on cpu 0:
>   rcu_read_unlock_special kernel/rcu/tree_plugin.h:615 [inline]
>   __rcu_read_unlock+0x381/0x3c0 kernel/rcu/tree_plugin.h:383
>   rcu_read_unlock include/linux/rcupdate.h:652 [inline]
>   filemap_map_pages+0x5b3/0x990 mm/filemap.c:2687
>   do_fault_around mm/memory.c:3450 [inline]
>   do_read_fault mm/memory.c:3484 [inline]
>   do_fault mm/memory.c:3618 [inline]
>   handle_pte_fault mm/memory.c:3849 [inline]
>   __handle_mm_fault+0x2554/0x2cb0 mm/memory.c:3973
>   handle_mm_fault+0x21b/0x530 mm/memory.c:4010
>   do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
>   __do_page_fault+0x3fb/0x9e0 arch/x86/mm/fault.c:1506
>   do_page_fault+0x54/0x233 arch/x86/mm/fault.c:1530
>   page_fault+0x34/0x40 arch/x86/entry/entry_64.S:1202
>
> write to 0xffffffff85a7d440 of 8 bytes by task 7353 on cpu 1:
>   sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
>   sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
>   rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
>   wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: rcu_gp wait_rcu_exp_gp
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: rcu_gp wait_rcu_exp_gp
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xf5/0x159 lib/dump_stack.c:113
>   panic+0x210/0x640 kernel/panic.c:221
>   kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
>   __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
>   __tsan_write8 kernel/kcsan/kcsan.c:36 [inline]
>   __tsan_write8+0x32/0x40 kernel/kcsan/kcsan.c:36
>   sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
>   sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
>   rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
>   wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> Shutting down cpus with NMI
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
