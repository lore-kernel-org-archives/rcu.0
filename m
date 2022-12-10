Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA3C4332F
	for <rcu@archiver.kernel.org>; Sat, 10 Dec 2022 03:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLJDWs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Dec 2022 22:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDWr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Dec 2022 22:22:47 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D7BCB9
        for <rcu@vger.kernel.org>; Fri,  9 Dec 2022 19:22:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn5so6842132ljb.2
        for <rcu@vger.kernel.org>; Fri, 09 Dec 2022 19:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYg7X0hR2+49T21Dz4DOnGVlGlLW6TGgih7L8YRQrjM=;
        b=dSyfLQ+8JRi5Ou8gLZB3aOUFC5NfKnfoUCHvprYbMoBky5W2nlJzDVjAzhOiagUZMU
         GJquSk3b22+l989Kk2IDZJo2evNjir7nCnYuoelNf3PdlvYyfJng4IWOc1n9WySAYha9
         VF3YcoVwMJQK7Hldl4073J8/Sy7D2B8wuEIPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYg7X0hR2+49T21Dz4DOnGVlGlLW6TGgih7L8YRQrjM=;
        b=RLd8vzN5z4ImgG5m7VmslHk7qMsxmF98PTQWN4BiAENW59rUeZgDMu/vuCSwJcOA5k
         mRymjWagPgPZZdoYbmz3xLGB89RDMKlxmAF/MA7nhu9V/nTKo716GBLvZaknykHc6cGp
         Yp1AFfxxkczQ8jggfsGmE/BuB7Qpqrvqb/kQ/9EgtMCGZroM3QJbArLodLslMJD4zu7f
         wRlHY1ZVOcvOihcFMnHYx+c0pTS5XbFl/6ZkzM31KZp03O9aH/Vum7/EjjydFd21ryaL
         nhwDlSJPkNWHfWV/VmpDd0nnUeTrBHA6cVIrfGV9lTy52bMtDHA9NJtH0ZqMaNxxmwZy
         t9FQ==
X-Gm-Message-State: ANoB5pmHCQJgNxx8Rp4LyLzD61ZLCuiccYb5He/g+HmaqlekasdU+2HT
        anSoAqlGIFBdf578BBWx1mTI+cAO4n92k7loqH/sJpghGl8x8h3EE68=
X-Google-Smtp-Source: AA0mqf7hOMHFR0s5yLZ7EuT02A4l3Oyq+syql0tcZKUbsFz/lp7iFG2Beh6R9DM3mlhv1bmTj4Bmwy5lIKaLA4Xajec=
X-Received: by 2002:a2e:a793:0:b0:27a:3e05:430d with SMTP id
 c19-20020a2ea793000000b0027a3e05430dmr158792ljf.313.1670642562342; Fri, 09
 Dec 2022 19:22:42 -0800 (PST)
MIME-Version: 1.0
References: <Y5PF8vismgZLzFam@google.com>
In-Reply-To: <Y5PF8vismgZLzFam@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 10 Dec 2022 03:22:30 +0000
Message-ID: <CAEXW_YT5GKi1QndkQOqQOOr=BkRza1Q60Gt=sZq9ChqOjmdaVw@mail.gmail.com>
Subject: Re: [Report] v4.19 TREE03 splat (stable kernel with ChromeOS patches)
To:     rcu@vger.kernel.org, Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 9, 2022 at 11:34 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello,
>
> I see this an hour into the run for TREE03 on v4.19:
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 60
>
> Checking to see if Qiang has any thoughts as I saw him comment about a similar
> issue in [1].
>
> [ 3243.844445] ------------[ cut here ]------------^M
> [ 3243.847112] WARNING: CPU: 1 PID: 0 at kernel/kthread.c:411 __kthread_bind_mask+0x19/0x60^M
> [ 3243.851585] Modules linked in:^M
> [ 3243.853295] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.267+ #1^M
> [ 3243.856699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014^M
> [ 3243.860052] RIP: 0010:__kthread_bind_mask+0x19/0x60^M
> [ 3243.861769] Code: 48 89 42 20 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 55 41 54 55 48 89 f5 48 89 d6 53 48 89 fb e8 3c e9 00 00 48 85 c0 75 09 <0f> 0b 5b 5d 41 5c 41 5d c3 4c 8d ab b4 07 00 00 4c 89 ef e8 6f 28^M
> [ 3243.867751] RSP: 0000:ffffa54b8014fec0 EFLAGS: 00010246^M
> [ 3243.868959] RAX: 0000000000000000 RBX: ffff95555ee3c240 RCX: 0000000000000000^M
> [ 3243.870606] RDX: ffff95555f063d80 RSI: 0000000000000246 RDI: 00000000ffffffff^M
> [ 3243.872246] RBP: ffffffffb720a010 R08: af82bdcb11f9f4ff R09: 0000000000000000^M
> [ 3243.873894] R10: ffffa54b8014fe70 R11: 00000000621ccdc2 R12: 0000000000000000^M
> [ 3243.875538] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000^M
> [ 3243.877181] FS:  0000000000000000(0000) GS:ffff95555f040000(0000) knlGS:0000000000000000^M
> [ 3243.878698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [ 3243.879747] CR2: 0000000000000000 CR3: 000000001300a000 CR4: 00000000000006e0^M
> [ 3243.881050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
> [ 3243.882358] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
> [ 3243.883660] Call Trace:^M
> [ 3243.884925]  kthread_unpark+0x52/0x60^M
> [ 3243.885613]  cpuhp_online_idle+0x31/0x50^M
> [ 3243.886341]  cpu_startup_entry+0x62/0x70^M
> [ 3243.887063]  start_secondary+0x186/0x1b0^M
> [ 3243.887783]  secondary_startup_64+0xa4/0xb0^M
>
> [1] https://groups.google.com/g/syzkaller-bugs/c/w_LARy6pxvQ/m/dKjQyHAxAQAJ
>

This set of scheduler patches seems to make it go away, however I am
running a long weekend test to collect more data:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/torture/v4.19.fixes.wip.120922

Thanks.
