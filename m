Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B019BC4320E
	for <rcu@archiver.kernel.org>; Tue, 31 Aug 2021 17:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D53D604AC
	for <rcu@archiver.kernel.org>; Tue, 31 Aug 2021 17:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhHaRCV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbhHaRCU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Aug 2021 13:02:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531DCC061575
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 10:01:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t19so160752ejr.8
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUhWLNcWSWOnl5kqANocbTsE1QeFdXAz85Aj3mnCjBo=;
        b=QUFto79k64TAYN3H7IB68xAhGgy9oW1Mv+kVHRRFb6Kx7dUz6naOv45XL9G1MVMsXS
         /a8hrpln913QQWYRkTCu1LdXkVEaRtsjLeKYbj40LHsC1MsE3yccKewxj77WGnmmkCRk
         56JdYbURMd8vbEEKGegNGM7SmyIbqp5QqU6dn+WASbfcHNtDv/IDmJhF5sq9JzvBzAxM
         IpMbZFMttVQOBcGb5a1GdEQKQnVKPZdrtpbMzax03UCPht8G+yuzyBS78aTWrsQmpSfd
         2yrNVG7tv+Ks6+ladLFANIMXqtqVdVOtHIPRb2sSFdHeH3/1azvyXG3yjLP720Zeczra
         UZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUhWLNcWSWOnl5kqANocbTsE1QeFdXAz85Aj3mnCjBo=;
        b=prU6/+Np9jvL1jNz89ZhS68+Y9egKE5Y4gxLMX72Ur6FmzgtB1gh0G2XftiYHiMJuf
         zrj+o1CQ4zuj1rnHWSARzcq1L9ijDFcmCmjtBu5bdmJoPjphqXCcZWtTyxCI6c+umBg/
         N9Lbs5tOPRTZUXyYHwU5RZDFyI0zsW6DlEBIbQJB7Cyn40lSIsC108WPA5u2hF13vpgs
         Uajuhm9nxtw3dtRiZZlgOcASu4jqyMLPurffBwyc/ByG3S1/Rpf7NYPmJDFe21Uk3sLc
         V3QDjRKuEfnTxfHHICK4ImH0P/IxLk5oNVnlJQHjNKHbsrSHgOnbRqqHZzg/v5BoMW5e
         5bGQ==
X-Gm-Message-State: AOAM5316UxPD8p9H1k0hcC2vndoaQzXPAsOTb9GsdMKMMBfZA6biCbrv
        FF5T5N6SVdk8wjdxN+S2FQ5MDslrv62dkqUW/pw=
X-Google-Smtp-Source: ABdhPJz0gnb6PCm0K3MaVqstg2NfN2htDI9dKbMAjYIJBMa0gS5XmWE47gpsNXu+1uKuUKkoEC+ZEA2UCKStfsee9SM=
X-Received: by 2002:a17:906:6c8f:: with SMTP id s15mr31765631ejr.52.1630429283934;
 Tue, 31 Aug 2021 10:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210831152144.GA28128@trex>
In-Reply-To: <20210831152144.GA28128@trex>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 1 Sep 2021 01:01:11 +0800
Message-ID: <CAABZP2xGnSLVbgxqjKMq=Oj_H7rYfYjuCvmBpmZ4tRptGs3SEw@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
List-Id: <soc.lore.kernel.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I did an experiment just now on x86_64 virtual machines, rcu did not
complain after 10 minutes's test, I hope my effort can provide some
clue.

1. I clone the fresh new linux kernel (git clone
https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git)
2. compile the kernel without CONFIG_RCU_BOOST (: # CONFIG_RCU_BOOST is not set)
3. boot the kernel on a x86_64 VM (kvm -cpu host -smp 16  -hda
./debian10.qcow2 -m 4096 -net
user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
-vnc :30)
4. run the test (stress-ng --sequential 16  --class scheduler -t 5m --times)
5. monitor the system by constantly typing top and dmesg
6. after 10 minutes, nothing else happens except that the dmesg report
following two messages
[  672.528192] sched: DL replenish lagged too much
[  751.127790] hrtimer: interrupt took 12143 ns

So, I guess CONFIG_RCU_BOOST is not necessary for x86_64 virtual machines

Zhouyi

On Tue, Aug 31, 2021 at 11:24 PM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> Hi
>
> When enabling CONFIG_PREEMPT and running the stress-ng scheduler class
> tests on arm64 (xilinx zynqmp and imx imx8mm SoCs) we are observing the following.
>
> [   62.578917] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   62.585015]  (detected by 0, t=5253 jiffies, g=3017, q=2972)
> [   62.590663] rcu: All QSes seen, last rcu_preempt kthread activity 5254 (4294907943-4294902689), jiffies_till_next_fqs=1, root
> +->qsmask 0x0
> [   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> [   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [   62.622359] rcu: RCU grace-period kthread stack dump:
> [   62.627395] task:rcu_preempt     state:R  running task     stack:    0 pid:   14 ppid:     2 flags:0x00000028
> [   62.637308] Call trace:
> [   62.639748]  __switch_to+0x11c/0x190
> [   62.643319]  __schedule+0x3b8/0x8d8
> [   62.646796]  schedule+0x4c/0x108
> [   62.650018]  schedule_timeout+0x1ac/0x358
> [   62.654021]  rcu_gp_kthread+0x6a8/0x12b8
> [   62.657933]  kthread+0x14c/0x158
> [   62.661153]  ret_from_fork+0x10/0x18
> [   62.682919] BUG: scheduling while atomic: stress-ng-hrtim/831/0x00000002
> [   62.689604] Preemption disabled at:
> [   62.689614] [<ffffffc010059418>] irq_enter_rcu+0x30/0x58
> [   62.698393] CPU: 0 PID: 831 Comm: stress-ng-hrtim Not tainted 5.10.42+ #5
> [   62.706296] Hardware name: Zynqmp new (DT)
> [   62.710115] Call trace:
> [   62.712548]  dump_backtrace+0x0/0x240
> [   62.716202]  show_stack+0x2c/0x38
> [   62.719510]  dump_stack+0xcc/0x104
> [   62.722904]  __schedule_bug+0x78/0xc8
> [   62.726556]  __schedule+0x70c/0x8d8
> [   62.730037]  schedule+0x4c/0x108
> [   62.733259]  do_notify_resume+0x224/0x5d8
> [   62.737259]  work_pending+0xc/0x2a4
>
> The error results in OOM eventually.
>
> RCU priority boosting does work around this issue but it seems to me
> a workaround more than a fix (otherwise boosting would be enabled
> by CONFIG_PREEMPT for arm64 I guess?).
>
> The question is: is this an arm64 bug that should be investigated? or
> is this some known corner case of running stress-ng that is already
> understood?
>
> thanks
> Jorge
>
>
>
