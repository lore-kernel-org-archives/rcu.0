Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8176C07E9A
	for <rcu@archiver.kernel.org>; Mon, 12 Jul 2021 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CA2611C1
	for <rcu@archiver.kernel.org>; Mon, 12 Jul 2021 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhGLQRz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGLQRy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jul 2021 12:17:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80010C0613E5
        for <rcu@vger.kernel.org>; Mon, 12 Jul 2021 09:15:04 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s23so10287299oij.0
        for <rcu@vger.kernel.org>; Mon, 12 Jul 2021 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQBfcP6oCKq0X5PB40wsxkaY2AyI2mZMPM6ogzszKIQ=;
        b=AbpB9NFkivLNuosYIWvKL71WOfuPwi8YqR7L8+G4VIKzwgw0I0TZzvktCDfen0QAk4
         b6S6jvJu20o1MOKm38nzot3ALqyqfbf4T5qQ421/2iNWqN16E2KzlznryHqFZzZqDhkd
         MK3LM9ULwa+hjaLJsqTSUh0y3qh2FXEA+otUK2pfqnlvMjUSziU8e8kIU1CsqqxsrtNW
         HMq6L55484zxw4NAnGspGoB6DmwVXXdNwbDoYUNpw8C4SVHiIT4OjNDaRzXW4Jcu0CLS
         DQzMXSpmQwszFg/DWghgxEt5MYq5eFh+ULV90B+oPIvp6cvx2l8SguSbo7qEo+jvfi+O
         8obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQBfcP6oCKq0X5PB40wsxkaY2AyI2mZMPM6ogzszKIQ=;
        b=HiNlSIfAc/BRy3RcMe+qTKTgiNZMxakstsALSt3gkOktnJnfcOnovfHJRtafbZwluY
         ETp83G3xoW/JQYL+z3xs57DftRsA7bfv4o2yFNodKueY+SbNJMu17jKD74E2iSNa8Okf
         U02RbTZN3E2kLXsdFSFbGoSHNWk8BeVgkVN8kP8LoFVfYauCPwmvgJmFN3k17HW/+Ua4
         VV1NsN2RF6N3xSStHAXA2p4Itz7gh7plVv6P9hJ0OfRa3ogpQadKY53/gFQAYW0msyT3
         7WIhT9IziBiXjNHbbB0rOzKMy4qHCjd+mgrHZMXtAhjZzfdGdeTye9mxPscpDq2XPKv5
         dOMg==
X-Gm-Message-State: AOAM531GD9u5KVM3IFKTaNvl+eu3vKYcM1zK5yTJiaa51DmoZMzzQNdE
        52CuVqwWz1zMQb9+h4hlOFQhlevepHytc0gdOppKYg==
X-Google-Smtp-Source: ABdhPJyLF+HJKYz9ORQ3Boka9gZdd71uRQq9T6PQLP7dSPLRKMAB1YdJqaaUiHwCFm6SnBVl0V43xixkVYB1KdKJYWE=
X-Received: by 2002:a05:6808:284:: with SMTP id z4mr5073375oic.70.1626106503239;
 Mon, 12 Jul 2021 09:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000080403805c6ef586d@google.com>
In-Reply-To: <00000000000080403805c6ef586d@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Jul 2021 18:14:37 +0200
Message-ID: <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
To:     syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[-Bcc: fsdevel]
[+Cc: Paul, rcu@vger.kernel.org]

On Mon, 12 Jul 2021 at 18:09, syzbot
<syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e73f0f0e Linux 5.14-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=172196d2300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e73542d774430b
> dashboard link: https://syzkaller.appspot.com/bug?extid=e08a83a1940ec3846cd5
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in call_rcu / rcu_gp_kthread
>
> write to 0xffffffff837328a0 of 8 bytes by task 11 on cpu 0:
>  rcu_gp_fqs kernel/rcu/tree.c:1949 [inline]
>  rcu_gp_fqs_loop kernel/rcu/tree.c:2010 [inline]
>  rcu_gp_kthread+0xd78/0xec0 kernel/rcu/tree.c:2169
>  kthread+0x262/0x280 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>
> read to 0xffffffff837328a0 of 8 bytes by task 30193 on cpu 1:
>  __call_rcu_core kernel/rcu/tree.c:2946 [inline]
>  __call_rcu kernel/rcu/tree.c:3062 [inline]
>  call_rcu+0x4b0/0x6c0 kernel/rcu/tree.c:3109
>  file_free fs/file_table.c:58 [inline]
>  __fput+0x43e/0x4e0 fs/file_table.c:298
>  ____fput+0x11/0x20 fs/file_table.c:313
>  task_work_run+0xae/0x130 kernel/task_work.c:164
>  get_signal+0x156c/0x15e0 kernel/signal.c:2581
>  arch_do_signal_or_restart+0x2a/0x220 arch/x86/kernel/signal.c:865
>  handle_signal_work kernel/entry/common.c:148 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>  exit_to_user_mode_prepare+0x109/0x190 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x20/0x40 kernel/entry/common.c:302
>  do_syscall_64+0x49/0x90 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> value changed: 0x0000000000000f57 -> 0x0000000000000f58
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 30193 Comm: syz-executor.5 Tainted: G        W         5.14.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000080403805c6ef586d%40google.com.
