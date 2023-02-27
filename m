Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B76C64ED6
	for <rcu@archiver.kernel.org>; Mon, 27 Feb 2023 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjB0NPx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Feb 2023 08:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjB0NPo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Feb 2023 08:15:44 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B110413
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 05:15:40 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y10so1790196qtj.2
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jc21i23Rg07EIMNuVPclP7K+DTgeY29JrkLV46Sf/4=;
        b=Fdk+SPO1Ftq2pYDZP9SQXcuFEh0AJmLiojT++78lt6nlH/sJ88wXzB7P0EOgySnYv/
         Z+xhewJ3vnaL8QMS47KrRcCr2tX2Ey7iquUQDNyi9suv4g1qem1nFDJiwUmXJfbm7oxZ
         ueMHILNizWWPkONak7r0SRrdlE2/xrAhv5Seo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jc21i23Rg07EIMNuVPclP7K+DTgeY29JrkLV46Sf/4=;
        b=MrOD4xJGunbPYx++P103rfOGi3gbKZda2pW1H1dMmIUHV33GBh8FqHoV+jC45lTMtQ
         HlGeA5yIsWO0ucNNtE2Gk0ZdvUty7o+BQY18xErSvdW6UUJhQuF6rfmCVrcXfmuGqBzY
         4MG2yLljWstwKGM9DwcqBKcVZmsyTHzGZiLhGkbGmYnEzjySV0m6oaiiilRLTnKArwyG
         dC5ziSCaYGCJZljOXjH6OfkUwL+w+AhAvgnCNq498uiwPLpQqJlzztvAckMIMh0u9nQg
         IvpD8EY/RTQQ+shykiIT9jeu9248hMS4L9zoYZUp+505k15Y3EprlUg0fdJDfVIuRgjl
         jB6A==
X-Gm-Message-State: AO0yUKWFFHNlD6sX4bItYvCYMXBylgGBlgLSdIOweK3fGBhxfsoNY8aC
        a4uZK0AueuV+bTehiSmhcVB+mQ==
X-Google-Smtp-Source: AK7set/werNL47gBoN7nAATgrUHKAIb6pF2lgjbVjkefw/+nZBX1nz3H9x53WZOHrfHlI7Hv6e5vtw==
X-Received: by 2002:ac8:7d10:0:b0:3ba:101e:88c6 with SMTP id g16-20020ac87d10000000b003ba101e88c6mr42854222qtb.48.1677503739039;
        Mon, 27 Feb 2023 05:15:39 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id j128-20020a378786000000b00739e7e10b71sm1872720qkd.114.2023.02.27.05.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:15:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
Date:   Mon, 27 Feb 2023 08:15:26 -0500
Message-Id: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
Cc:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, contact@pgazz.com
In-Reply-To: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Feb 27, 2023, at 3:03 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>=20
> =EF=BB=BFHi
>=20
>> On Mon, Feb 27, 2023 at 2:30=E2=80=AFPM Sanan Hasanov
>> <sanan.hasanov@knights.ucf.edu> wrote:
>>=20
>> Good day, dear maintainers,
>>=20
>> We found a bug using a modified kernel configuration file used by syzbot.=

>>=20
>> We enhanced the coverage of the configuration file using our tool, klocal=
izer.
>>=20
>> Kernel Branch: 6.2.0-next-20230221
>> Kernel config: https://drive.google.com/file/d/1QKAQV11zjOwISifUc-skRBoTo=
3EXhutY/view?usp=3Dshare_link
>> C Reproducer: Unfortunately, there is no reproducer yet.

Sanan/Zhoui,
Could you also provide the full kernel dmesg? Could you enable CONFIG_DEBUG_=
INFO_DWARF5 and provide the vmlinux after the crash?

More comments below:

>>=20
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> #PF: supervisor instruction fetch in kernel mode
>> #PF: error_code(0x0010) - not-present page
>> PGD 53756067 P4D 53756067 PUD 0
>> Oops: 0010 [#1] PREEMPT SMP KASAN
>> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.2.0-next-20230221 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
>> RIP: 0010:0x0
>> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
>> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
>> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
>> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
>> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
>> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
>> Call Trace:
>> <IRQ>
>> rcu_core+0x85d/0x1960
>> __do_softirq+0x2e5/0xae2
>> __irq_exit_rcu+0x11d/0x190
>> irq_exit_rcu+0x9/0x20
>> sysvec_apic_timer_interrupt+0x97/0xc0
>> </IRQ>
>> <TASK>
>> asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> RIP: 0010:default_idle+0xf/0x20
>> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff f=
f cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e 0=
f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
>> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
>> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
>> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
>> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
>> default_idle_call+0x67/0xa0
>> do_idle+0x361/0x440
>> cpu_startup_entry+0x18/0x20
>> start_secondary+0x256/0x300
>> secondary_startup_64_no_verify+0xce/0xdb
>> </TASK>
>> Modules linked in:
>> CR2: 0000000000000000
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:0x0
>> Code: Unable to access opcode bytes at 0xffffffffffffffd6.

I have seen this exact signature when the processor tries to execute a funct=
ion that has a NULL address. That causes IP to goto 0 and the exception. Sou=
nds like something corrupted rcu_head (Just a guess).

>> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
>>=20
>> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
>> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
>> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
>> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
>> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
>> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
>> ----------------
>> Code disassembly (best guess):
>>   0:   89 07                   mov    %eax,(%rdi)
>>   2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
>>   9:   4d 29 c8                sub    %r9,%r8
>>   c:   4c 01 c7                add    %r8,%rdi
>>   f:   4c 29 c2                sub    %r8,%rdx
>>  12:   e9 76 ff ff ff          jmp    0xffffff8d
>>  17:   cc                      int3
>>  18:   cc                      int3
>>  19:   cc                      int3
>>  1a:   cc                      int3
>>  1b:   f3 0f 1e fa             endbr64
>>  1f:   eb 07                   jmp    0x28
>>  21:   0f 00 2d e3 8a 34 00    verw   0x348ae3(%rip)        # 0x348b0b
>>  28:   fb                      sti
>>  29:   f4                      hlt
>> * 2a:   fa                      cli <-- trapping instruction

This probably happened before the crash and it is likely unrelated IMO. cli j=
ust means interrupts were enabled, the actual problem happened after softirq=
 fired (likely at the tail end of the interrupt).

Thanks,

 - Joel=20


>>  2b:   c3                      ret
>>  2c:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>>  33:   00 00 00 00
>>  37:   0f 1f 40 00             nopl   0x0(%rax)
>>  3b:   f3 0f 1e fa             endbr64
>>  3f:   65                      gs
>>=20
