Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32284C64EC4
	for <rcu@archiver.kernel.org>; Tue, 28 Feb 2023 23:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB1Xvg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjB1Xvf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Feb 2023 18:51:35 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6AC37B44
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 15:51:33 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x6so6514691ljq.1
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 15:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677628292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AbmEAX+8plsYFEx9L1wRBcrzwVVgHc7lff59BO3ev4=;
        b=ZSmFRVFconRQbkoHbIlyHedx72Bbwx6SRdLAQCALJwBbZhSCsDHjCrW9KpvPXvW5Om
         kW6fI3+pIHOEHjSTSxiNolH3W37rZrzBRkA3TBu86TnbQBcqPQ+/8Kfu6DF3kd6ExdbI
         QU0YBgP6+wHyVnqx3mtyH3fCKttnKbs54wLeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677628292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AbmEAX+8plsYFEx9L1wRBcrzwVVgHc7lff59BO3ev4=;
        b=VtM1+Lfj0y5GnDfocIX19At4TDU90OU6W6VFBxML25928RfXfWnGMRfyb1lq9hOhwf
         Sa+nE2MFJOtF11j+XgU9dP2ZkxcHLqtQrP2rGqWH4yTdz4TiwJsS1ThipjeKfhjMeL0D
         6jZ7CzM5akRuZJMnzKTaKomOHvtKiRvvwHOGod1OGrOODBKjQjZXhNNzB30CxXAiNPAN
         OvL6D0aQSrVBgYxHiMlIy8c4B3v0U2RxKM/Oxy7CyHk1m3JZwfuGtXh2oEi0+ftqAmOC
         4uuFSrsOwJL3q6OCKBET+fzhFt6UUDYxAcdrHZibdTn18Ap5jGO1FNPzrwhykruhKshA
         sK5Q==
X-Gm-Message-State: AO0yUKUC1QEnUjYlekr8sJJ0XGYGDddRD4YLGsHg3fPX/GLoVmR1Tx+L
        78zkMKGW60eiAXw2cedYQI++xe8ssSsTAIKhiyZmQQ==
X-Google-Smtp-Source: AK7set89IkY9xGC0q/kyhcjnc57DfxeD3LKj1GRWriT0Qo0caQyZFkN0se/rdELScqzWZ7Tk9rfH+B9bkmmt7rf3lvU=
X-Received: by 2002:a05:651c:10af:b0:295:a8d1:8a28 with SMTP id
 k15-20020a05651c10af00b00295a8d18a28mr1390025ljn.3.1677628291958; Tue, 28 Feb
 2023 15:51:31 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org> <IA1PR11MB6171E006D288555B6223FBF789AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6171E006D288555B6223FBF789AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 18:51:19 -0500
Message-ID: <CAEXW_YSOZ_Nu-7KDzqoMnwY_xU+WoyEF+Ntu-0tih+hiM_jycg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 28, 2023 at 3:55=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Joel Fernandes <joel@joelfernandes.org>
> > Sent: Monday, February 27, 2023 9:15 PM
> > To: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Cc: Sanan Hasanov <sanan.hasanov@knights.ucf.edu>; paulmck@kernel.org;
> > frederic@kernel.org; quic_neeraju@quicinc.com; josh@joshtriplett.org;
> > rostedt@goodmis.org; mathieu.desnoyers@efficios.com;
> > jiangshanlai@gmail.com; rcu@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
> > syzkaller@googlegroups.com; contact@pgazz.com
> > Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
> > rcu_core
> >
> > ...
> > >> BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >> #PF: supervisor instruction fetch in kernel mode
> > >> #PF: error_code(0x0010) - not-present page PGD 53756067 P4D 53756067
> > >> PUD 0
> > >> Oops: 0010 [#1] PREEMPT SMP KASAN
> > >> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.2.0-next-20230221 #1
> > >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> > >> 04/01/2014
> > >> RIP: 0010:0x0
> > >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > >> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> > >> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> > >> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> > >> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> > >> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> > >> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> > >> FS:  0000000000000000(0000) GS:ffff888119f80000(0000)
> > >> knlGS:0000000000000000
> > >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> > >> Call Trace:
> > >> <IRQ>
> > >> rcu_core+0x85d/0x1960
> > >> __do_softirq+0x2e5/0xae2
> > >> __irq_exit_rcu+0x11d/0x190
> > >> irq_exit_rcu+0x9/0x20
> > >> sysvec_apic_timer_interrupt+0x97/0xc0
> > >> </IRQ>
> > >> <TASK>
> > >> asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > >> RIP: 0010:default_idle+0xf/0x20
> > >> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff
> > >> ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa>
> > >> c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> > >> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> > >> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> > >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > >> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> > >> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> > >> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
> > >> default_idle_call+0x67/0xa0
> > >> do_idle+0x361/0x440
> > >> cpu_startup_entry+0x18/0x20
> > >> start_secondary+0x256/0x300
> > >> secondary_startup_64_no_verify+0xce/0xdb
> > >> </TASK>
> > >> Modules linked in:
> > >> CR2: 0000000000000000
> > >> ---[ end trace 0000000000000000 ]---
> > >> RIP: 0010:0x0
> > >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> >
> > I have seen this exact signature when the processor tries to execute a
> > function that has a NULL address. That causes IP to goto 0 and the exce=
ption.
> > Sounds like something corrupted rcu_head (Just a guess).
>
> Did a quick test to directly invoke "call_rcu(head, NULL)", then the kern=
el got panic
> with almost the same call trace as above and with the same RIP:
>
>        RIP: 0010:0x0
>        Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>
> If invoke " call_rcu(head, NULL + 1)", then
>
>        RIP: 0010:0x1
>        Code: Unable to access opcode bytes at 0xffffffffffffffd7.
>
> If invoke " call_rcu(head, NULL + 2)", then
>
>        RIP: 0010:0x2
>        Code: Unable to access opcode bytes at 0xffffffffffffffd8.
>
> The log above tends to say your guess (a corrupted rcu_head) is reasonabl=
e. =F0=9F=98=8A
>

Good that you double checked and kept me honest about my analysis. ;-)

 - Joel
