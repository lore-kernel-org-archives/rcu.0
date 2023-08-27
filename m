Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB55C83F11
	for <rcu@archiver.kernel.org>; Sun, 27 Aug 2023 21:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjH0Vsf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Aug 2023 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjH0VsF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Aug 2023 17:48:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C025C199
        for <rcu@vger.kernel.org>; Sun, 27 Aug 2023 14:47:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso38014491fa.0
        for <rcu@vger.kernel.org>; Sun, 27 Aug 2023 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693172870; x=1693777670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNOi3sW4pLOHSMd2syLeDDay6ZacVdngEbQyNBH6hq8=;
        b=jQW6Fh2hGNDD+7EkNMKeNlh612wjVxKTU19U6e23vXfouNbVg+Bl3jeR2p1naLjrnb
         QFh7ODQe/085jULbxcDJBajsLm7JtxSfp71IStVnE5lYJsdUoKvIKnBLCwtjxWOccUs1
         B2um3tg2vNKHxN3nWyWElTNMa17bCMeqPFmZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693172870; x=1693777670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNOi3sW4pLOHSMd2syLeDDay6ZacVdngEbQyNBH6hq8=;
        b=b/Wnhuc24mnQyU8iUZiDzb3XX4uW0fgnn/e8ZlmQfcTjI9VOlmvjGMufWZui1gH/J/
         6xqDHuSCu5fqpjPU72xQExGohO7X7J7jT21J5wqSblpSDeDi1mo3agwHp/1acUBcFwbY
         sqJRzAdgsePMJ6/LYxcFQGBAieNDGy6q7R/tC479J7tl7fAUsm8PwSen11rTZKLOVlC+
         CszgNs9WKTJ4fQQlFDqIu42FfQXr36Kyi+UKSsvFIcSSSgSL6jvulVBdAuwWaRKVyjsh
         zHnHDouJsS1BFLGzDUut+4l9Q+iu+hG7XciwDvRPwf/JiIetv16paWEPf+X7XhcCT5q4
         YAZw==
X-Gm-Message-State: AOJu0YywP0D+h8pAtJFiJW2eYF/Dvqi4cngGpDT5xGg+jI/TtyFwlgDx
        MbiKplynFpfiMRiTrobPlhHSLIkUlgAbBuXgf6ITLg7IYOX3YYU5
X-Google-Smtp-Source: AGHT+IEQq3oDVjtmbe77t9FUB9VcyjdXAEjMUoXbO0lCkrfE1481pzJyYpbetJJz/PDMZ3HMYoI9F7ezd7bjH728lKU=
X-Received: by 2002:a2e:9145:0:b0:2bc:c51d:da9e with SMTP id
 q5-20020a2e9145000000b002bcc51dda9emr16237078ljg.21.1693172869989; Sun, 27
 Aug 2023 14:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YSHKTgjc7yDAtnAVLcO-6zCwsWq1jVggwVjOHQqDAJemw@mail.gmail.com>
In-Reply-To: <CAEXW_YSHKTgjc7yDAtnAVLcO-6zCwsWq1jVggwVjOHQqDAJemw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 27 Aug 2023 17:47:39 -0400
Message-ID: <CAEXW_YRSC8dOd71qb0dT98hdyFUDX64wJENkH7G1fpL_PBawpw@mail.gmail.com>
Subject: Re: [BUG] TREE04 on 5.10 splats in irq_work_queue_on()
To:     rcu <rcu@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 17, 2023 at 12:47=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hello,
> I hit a rare splat on TREE04 on a 5.10 stable kernel. This is after
> several days of testing (doesn't run the whole day, just a few hours
> each day).
>
> I am posting it below for archival (I haven't looked too closely yet),
> at some point I'll start having my automation also post to the list
> automatically on such issues. All test artifacts are here:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.10.y/=
89/artifact/tools/testing/selftests/rcutorture/res/2023.08.17-04.01.54/TREE=
04/
>

Fixed and stable patches sent.

 - Joel

> [ 2819.565152] smpboot: CPU 3 is now offline
> [ 2821.366444] ------------[ cut here ]------------
> [ 2821.406212] smpboot: CPU 7 is now offline
> [ 2821.442438] WARNING: CPU: 0 PID: 2281 at kernel/irq_work.c:95
> irq_work_queue_on+0x70/0x80
> [ 2821.466994] Modules linked in:
> [ 2821.499250] CPU: 0 PID: 2281 Comm: kworker/0:1 Not tainted 5.10.191+ #=
242
> [ 2821.516861] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2821.540362] Workqueue: rcu_gp wait_rcu_exp_gp
> [ 2821.551740] RIP: 0010:irq_work_queue_on+0x70/0x80
> [ 2821.564221] Code: 00 75 1c 48 89 fe 89 cf e8 7d 21 fa ff 89 d8 5b
> c3 cc cc cc cc 31 db 89 d8 5b c3 cc cc cc cc 0f 0b eb e0 e8 f2 fe ff
> ff eb e3 <0f> 0b eb 9c 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 c7 c0 d8
> ad 02
> [ 2821.603978] RSP: 0018:ffffb6d0c025fe38 EFLAGS: 00010282
> [ 2821.618971] RAX: 0000000000000007 RBX: 0000000000000007 RCX: 000000000=
0000007
> [ 2821.633318] RDX: ffff94d3df5e2b28 RSI: 0000000000000007 RDI: ffff94d3d=
f5e2a40
> [ 2821.650157] RBP: 000000000007c8c0 R08: 0000000000000000 R09: ffffffff8=
b536788
> [ 2821.668728] R10: 0000000000000003 R11: 0000000000000001 R12: ffffffff8=
b536788
> [ 2821.700194] R13: 0000000000005208 R14: 000000000002e580 R15: ffffffff8=
b536740
> [ 2821.713002] FS:  0000000000000000(0000) GS:ffff94d3df400000(0000)
> knlGS:0000000000000000
> [ 2821.726975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2821.737078] CR2: 0000000000000000 CR3: 00000000024e0000 CR4: 000000000=
00006f0
> [ 2821.749616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 2821.763279] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 2821.776264] Call Trace:
> [ 2821.781516]  ? __warn+0x7c/0x100
> [ 2821.787860]  ? irq_work_queue_on+0x70/0x80
> [ 2821.795412]  ? report_bug+0x99/0xc0
> [ 2821.802790]  ? handle_bug+0x41/0x80
> [ 2821.809271]  ? exc_invalid_op+0x13/0x60
> [ 2821.816196]  ? asm_exc_invalid_op+0x12/0x20
> [ 2821.823808]  ? irq_work_queue_on+0x70/0x80
> [ 2821.831849]  tick_nohz_dep_set_cpu+0x59/0x70
> [ 2821.843360]  rcu_exp_wait_wake+0x3ce/0x410
> [ 2821.865209]  process_one_work+0x1e5/0x370
> [ 2821.889917]  worker_thread+0x45/0x3b0
> [ 2821.908011]  ? process_one_work+0x370/0x370
> [ 2821.915608]  kthread+0x110/0x130
> [ 2821.937705]  ? __kthread_bind_mask+0x60/0x60
> [ 2821.945581]  ret_from_fork+0x22/0x30
> [ 2821.962225] ---[ end trace 4ba8b82994399b6a ]---
> [ 2822.451287] smpboot: Booting Node 0 Processor 7 APIC 0x7
