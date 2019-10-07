Return-Path: <SRS0=xd98=YA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C37C352AA
	for <rcu@archiver.kernel.org>; Mon,  7 Oct 2019 10:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A904D2084D
	for <rcu@archiver.kernel.org>; Mon,  7 Oct 2019 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6HzdJBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJGKEa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:04:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45923 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJGKE3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Oct 2019 06:04:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so11093213oib.12
        for <rcu@vger.kernel.org>; Mon, 07 Oct 2019 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYT1x2/n140JP+1FiTJ0CmclfsvjrAD1h2tPOsxcDtk=;
        b=N6HzdJBtIpQoxnOBdY0HnLqWIl4ZGqrWy52I2zIQx6jUsIW0YliTbMjw3kdcQDsmQF
         WDmsktR5U8xqyStXSgOAjksxTeVxGWSEqOH7Gf8wad2mvgc2NEXwJyF4sRnMPsKCrVX+
         JlFN2i4zOZK1TOsyVruHJNguL4GzRFAGoB8NJSfZZOZlDZ2YuqmvQxz2b8t7q+/bJNz+
         W80qUvbBpdwcSyvj25sSkenbt7sn2nLonZFaU/QifQ51fPKU3DlrSzXNMii5YY/zsHde
         JXu4Ipbl36u5D5dN7SQqN7nLl7Fgy41BpH9t0uNNilMtYGmn5u6YtV4p/zLb3OdNEI3D
         GFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYT1x2/n140JP+1FiTJ0CmclfsvjrAD1h2tPOsxcDtk=;
        b=bcW5c6q1EMtlub0ep4+I5Fq1AHuvnyZie6w+ZBrAfUB4S3v1TrkWVsIP9VXa7s3n7o
         WfnoBSSFHRojuSXOFuNiol8KYaNF4NYNuPYhx/LndKXwie6SykqPTPgyNn95kIdlvmEv
         RpgWFp5oYtwS3ZbDpG4weOmRhVh3PH8babanXPZpRp+/FFfNdZNQirREGSDDI5uDXTdC
         dzUjf7y4holzOcDt7f2rNElpKD2oVCq3RW973NgO88iHSB4WaFfpT3aRCo3gJQZPurOQ
         dlgWF+g2+Xw8m7oxxa93lITatnPOrMaGPTyR1PcXlT//a8PGwbM2toMk+xcEK11ci74U
         0vDA==
X-Gm-Message-State: APjAAAUMFuc9mn28GsP2ZHh3ruoCa4qKsewWC8NIR/ReOp03wDYta963
        SefH4ZVJxqWj+pT3LrqWF7nyHnvvx+E+dnHPynEwMQ==
X-Google-Smtp-Source: APXvYqwq5iX3haMgW2pDDYlUcZQMS6VSvjATAwVAdUQyT2N2RAgpJ9Jgfm6V7j6yYCXNmqZhgSgI0P2elMaMnbZ3S04=
X-Received: by 2002:a05:6808:13:: with SMTP id u19mr566370oic.83.1570442667301;
 Mon, 07 Oct 2019 03:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000604e8905944f211f@google.com>
In-Reply-To: <000000000000604e8905944f211f@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Oct 2019 12:04:16 +0200
Message-ID: <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in find_next_bit / rcu_report_exp_cpu_mult
To:     syzbot <syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com>,
        paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Cc:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+RCU maintainers
This might be a data-race in RCU itself.

On Mon, 7 Oct 2019 at 12:01, syzbot
<syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=11edb20d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=134336b86f728d6e55a0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in find_next_bit / rcu_report_exp_cpu_mult
>
> write to 0xffffffff85a7f140 of 8 bytes by task 7 on cpu 0:
>   rcu_report_exp_cpu_mult+0x4f/0xa0 kernel/rcu/tree_exp.h:244
>   rcu_report_exp_rdp+0x6c/0x90 kernel/rcu/tree_exp.h:254
>   rcu_preempt_deferred_qs_irqrestore+0x3bb/0x580 kernel/rcu/tree_plugin.h:475
>   rcu_read_unlock_special+0xec/0x370 kernel/rcu/tree_plugin.h:659
>   __rcu_read_unlock+0xcf/0xe0 kernel/rcu/tree_plugin.h:394
>   rcu_read_unlock include/linux/rcupdate.h:645 [inline]
>   batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:411 [inline]
>   batadv_nc_worker+0x13a/0x390 net/batman-adv/network-coding.c:718
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>
> read to 0xffffffff85a7f140 of 8 bytes by task 7251 on cpu 1:
>   _find_next_bit lib/find_bit.c:39 [inline]
>   find_next_bit+0x57/0xe0 lib/find_bit.c:70
>   sync_rcu_exp_select_node_cpus+0x28e/0x510 kernel/rcu/tree_exp.h:375
>   sync_rcu_exp_select_cpus+0x30c/0x590 kernel/rcu/tree_exp.h:439
>   rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
>   wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7251 Comm: kworker/1:4 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: rcu_gp wait_rcu_exp_gp
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
