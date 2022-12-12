Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C6C4332F
	for <rcu@archiver.kernel.org>; Mon, 12 Dec 2022 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiLLOFT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiLLOFQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Dec 2022 09:05:16 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4744F6F
        for <rcu@vger.kernel.org>; Mon, 12 Dec 2022 06:05:14 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1442977d77dso8443055fac.6
        for <rcu@vger.kernel.org>; Mon, 12 Dec 2022 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUm1WDvdDbW25rUZDoWfk4kT2F6an1j8RE4HnBKyuQ0=;
        b=a2GbfRQRLoLHOYvG4wjTqzUETxxAhX18wav4aRtTejMIYFE75I79fTqdZ90pTweRrS
         9ckERp4orm4qVqXmaRsWxghkTJLL1DHHk6Q7oIZRgupULjHaJ/WBz/Lbx5DpadcJTi2F
         VeeqZgcz4dDyWLAWN5+CB0HkU+ADLYEdmej/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUm1WDvdDbW25rUZDoWfk4kT2F6an1j8RE4HnBKyuQ0=;
        b=IfoarrUe4W5egR35A3PDCI1IppMiP8BBkElfH/XiWXUbUnVQ/gDZOffq4nbX/wcStP
         zbtfe7pLXCNTYb9g32Fzve53riRiC3jp0dQOghKvP5064FcaDaAiHyeIfFVOWT/egBhr
         7Dmhj2q+V2pI/A7h26SyMHvLB3bxcPjz3JV+kswDk1uRvwH9Dr0BUHV5NKPt9jF2lsir
         5S9U9NMKExudU93F4lcxZNX7S29pKkXRW5ruBRsNt+ceZmfz9vi9JP8UStJxvAjc1vZi
         B0fCxsJKjXNvZTg9tHUFwC9aIcSSkIN2G9RC+9HZGKoCO3kTfU/KgyL33lQDxffW1TSc
         mR7Q==
X-Gm-Message-State: ANoB5plQE6wLDZJg9krxM+MxTnEPOW/+o77jmdvjfi979QOQSutvLN9w
        e0fVvVD4WSMAOueChm4BLuy1SQ53jO0NWeS4
X-Google-Smtp-Source: AA0mqf7Igvo8PE88YnxRLy31LJ9rarAnaNlR+v4zN8nQuI2USOEMYLO/uTO+b4tKK+bZyx/F8/L/ZQ==
X-Received: by 2002:a05:6358:4e04:b0:e0:3017:39e1 with SMTP id cf4-20020a0563584e0400b000e0301739e1mr396087rwb.9.1670853913047;
        Mon, 12 Dec 2022 06:05:13 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a067300b006fa4ac86bfbsm5680934qkh.55.2022.12.12.06.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 06:05:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Report] v4.19 TREE03 splat (stable kernel with ChromeOS patches)
Date:   Mon, 12 Dec 2022 09:05:01 -0500
Message-Id: <D00B9D88-368D-48E1-BE16-532417EDB7F5@joelfernandes.org>
References: <PH0PR11MB5880569A84B6DCAA1D5F4837DAE29@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     rcu@vger.kernel.org, paulmck@kernel.org
In-Reply-To: <PH0PR11MB5880569A84B6DCAA1D5F4837DAE29@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 12, 2022, at 6:45 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:=

>=20
> =EF=BB=BFOn Fri, Dec 9, 2022 at 11:34 PM Joel Fernandes <joel@joelfernande=
s.org> wrote:
>>=20
>> Hello,
>>=20
>> I see this an hour into the run for TREE03 on v4.19:
>> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 60
>>=20
>> Checking to see if Qiang has any thoughts as I saw him comment about a si=
milar
>> issue in [1].
>>=20
>> [ 3243.844445] ------------[ cut here ]------------^M
>> [ 3243.847112] WARNING: CPU: 1 PID: 0 at kernel/kthread.c:411 __kthread_b=
ind_mask+0x19/0x60^M
>> [ 3243.851585] Modules linked in:^M
>> [ 3243.853295] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.267+ #1^M
>> [ 3243.856699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.0-debian-1.16.0-4 04/01/2014^M
>> [ 3243.860052] RIP: 0010:__kthread_bind_mask+0x19/0x60^M
>> [ 3243.861769] Code: 48 89 42 20 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 4=
1 55 41 54 55 48 89 f5 48 89 d6 53 48 89 fb e8 3c e9 00 00 48 85 c0 75 09 <0=
f> 0b 5b 5d 41 5c 41 5d c3 4c 8d ab b4 07 00 00 4c 89 ef e8 6f 28^M
>> [ 3243.867751] RSP: 0000:ffffa54b8014fec0 EFLAGS: 00010246^M
>> [ 3243.868959] RAX: 0000000000000000 RBX: ffff95555ee3c240 RCX: 000000000=
0000000^M
>> [ 3243.870606] RDX: ffff95555f063d80 RSI: 0000000000000246 RDI: 00000000f=
fffffff^M
>> [ 3243.872246] RBP: ffffffffb720a010 R08: af82bdcb11f9f4ff R09: 000000000=
0000000^M
>> [ 3243.873894] R10: ffffa54b8014fe70 R11: 00000000621ccdc2 R12: 000000000=
0000000^M
>> [ 3243.875538] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000^M
>> [ 3243.877181] FS:  0000000000000000(0000) GS:ffff95555f040000(0000) knlG=
S:0000000000000000^M
>> [ 3243.878698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> [ 3243.879747] CR2: 0000000000000000 CR3: 000000001300a000 CR4: 000000000=
00006e0^M
>> [ 3243.881050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000^M
>> [ 3243.882358] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400^M
>> [ 3243.883660] Call Trace:^M
>> [ 3243.884925]  kthread_unpark+0x52/0x60^M
>> [ 3243.885613]  cpuhp_online_idle+0x31/0x50^M
>> [ 3243.886341]  cpu_startup_entry+0x62/0x70^M
>> [ 3243.887063]  start_secondary+0x186/0x1b0^M
>> [ 3243.887783]  secondary_startup_64+0xa4/0xb0^M
>>=20
>> [1] https://groups.google.com/g/syzkaller-bugs/c/w_LARy6pxvQ/m/dKjQyHAxAQ=
AJ
>>=20
>>=20
>> This set of scheduler patches seems to make it go away, however I am
>> running a long weekend test to collect more data:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=3D=
rcu/torture/v4.19.fixes.wip.120922
>=20
>=20
> Hi Joel
>=20
> I also used the link above to do the TREE03 test, looks like the problem s=
till exists:
>=20
> 5834 [  966.016205]  kthread_unpark+0x50/0x60^M
> 5835 [  966.016440]  cpuhp_online_idle+0x31/0x50^M
> 5836 [  966.016678]  cpu_startup_entry+0x65/0x70^M
> 5837 [  966.016913]  start_secondary+0x18b/0x1c0^M
> 5838 [  966.017148]  secondary_startup_64+0xa4/0xb0^M
> 5839 [  966.017407] ---[ end trace 636953f76b8055db ]---^M
> 5840 [  966.017691] migration/1     R  running task    14952    18      2 0=
x80000000 last_sleep: 961405359084.  last_runna      ble: 961700816631^M
> 5841 [  966.018406] Call Trace:^M
> 5842 [  966.018559]  __schedule+0x75f/0x1320^M
> 5843 [  966.018775]  ? cpuhp_invoke_callback+0x88/0x600^M
> 5844 [  966.019042]  ? ___preempt_schedule+0x16/0x18^M
> 5845 [  966.019302]  ? sort_range+0x20/0x20^M
> 5846 [  966.019515]  preempt_schedule_common+0x32/0x80^M
> 5847 [  966.019776]  ___preempt_schedule+0x16/0x18^M
> 5848 [  966.020018]  _raw_spin_unlock_irq+0x1f/0x20^M
> 5849 [  966.020275]  smpboot_thread_fn+0x195/0x230^M
> 5850 [  966.020525]  kthread+0x139/0x160^M
> 5851 [  966.020717]  ? kthread_create_worker_on_cpu+0x60/0x60^M
> 5852 [  966.021014]  ret_from_fork+0x35/0x40^M
>=20
> =46rom the calltrace, the state of migration kthreads is not correct,=20
> I'm also looking at what's going wrong.

Thanks for checking. I also noticed that the state of those threads is runni=
ng instead of parked, causing the warning.

- Joel



> Thanks
> Zqiang
>=20
>>=20
>> Thanks.
