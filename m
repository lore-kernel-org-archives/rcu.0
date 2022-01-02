Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21274C433EF
	for <rcu@archiver.kernel.org>; Sun,  2 Jan 2022 00:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiABA1n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 1 Jan 2022 19:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiABA1n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 1 Jan 2022 19:27:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C65EC061574
        for <rcu@vger.kernel.org>; Sat,  1 Jan 2022 16:27:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z9so51917310edm.10
        for <rcu@vger.kernel.org>; Sat, 01 Jan 2022 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uaVdOdDRk3QsQkX5aFk6whgDs6gmVWo2RGl472tGtw=;
        b=QTd2RBrzi4NjlKSyWE1fX4AbAvIKrTFWfWhIyULoIsKotfmzVDgFTyihz3axI4X1sw
         bR7M+BEVDn/eiQ87B5jUr7zxfXmUUFzH8tMLKcC6amNFcG1XEBdl3KUmkBGBn+trIqrW
         4emPcYQjCSwh4IT4zW0pWXu78xfytyXKpyZ2ZvbCgm4YcHTnRp5uqQAnXqPakaPyFEFs
         p7kpOPGW4NHUi2dSN2Vv86MG5Irtu8wKjGm8dktGC/XtxVFZw5SjQ8+VjNcgrCbEKm5K
         QlZMIqopJFys8jJ5FtZJ6nGjCRZM+lYEUugDUAa4Tfe7ablC22nMRx+8BT0O/HaXnISp
         /XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uaVdOdDRk3QsQkX5aFk6whgDs6gmVWo2RGl472tGtw=;
        b=oQHVIozK4tTNPQ4lE4XKam8UmTkYeXux3Poxzk8CoPkvTEn5ZNHjWm68CXUvpC0V+1
         ismsoLF1/bh78CApwoHC1U57Mmmr/jtHJ/JbQYC57FTECCae418bT+ymmAV8T2CETQU7
         X0y4b0zWim56sRn3vXR2+w2+RCbKUnEGO0O3whUhdui4U0SWWjwTbON7BNy+1b7ifPyF
         LAn/++oCg6ysPRpa4Rvpt5Txbr5uIpwg1prFNm3BpLgd4DrC0ZedC0HEJwDQIpX0Lt6Y
         btX3KHi/AXtLOGPZWj3HmXTiFw+M2ssQzAUmWSDKgHeY49EgjIAh638Xk/uQ5DheAk3W
         lraQ==
X-Gm-Message-State: AOAM532PgKKglAGRvzAgsSvHNqMJTM3VNKJ3k0c8miJ/Wdhk3YnW6bv+
        6B6RfzhUAivLLWWhSSmZPJpfL0Q8lWLswMzqgKk=
X-Google-Smtp-Source: ABdhPJxFqv+K3Q1uEUobO2sz2Bnbw7VIA1T/G8OwS2xoL2eALOiaS2lY7webLuZ/ym9Qcyw5HIPMOATWQPe11shTSaE=
X-Received: by 2002:a05:6402:1a49:: with SMTP id bf9mr38308815edb.18.1641083261207;
 Sat, 01 Jan 2022 16:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20211214045758.GA1713844@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
 <CANpmjNMpm0ZnWKzpWOFRtOU8EfFDP2t2spyOnW2Rx8LFGO2S-w@mail.gmail.com> <CAABZP2w8+bZWWP_bRi+Vfokm-xDwOga5TrjFnJwEmx2zGiMHiw@mail.gmail.com>
In-Reply-To: <CAABZP2w8+bZWWP_bRi+Vfokm-xDwOga5TrjFnJwEmx2zGiMHiw@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 2 Jan 2022 08:27:29 +0800
Message-ID: <CAABZP2xWFVLYmrMF0ADDm2zaHtxizfZMbCfHeNDDqpqyEO4MNA@mail.gmail.com>
Subject: Re: FYI, a few new KCSAN splats
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks Paul and Marco for giving me valuable advice.

I studied the structure of kvm.sh and I found enabling
CONFIG_KCSAN_STRICT and lower kcsan.skip_watch will make the KCSAN
detect RCU's data-race within half an hour (I tried this for two
times).
Following is my command:
linux-rcu$git config --get remote.origin.url
https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/
linux-rcu$tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus
--duration 10h --configs "TREE01" --kcsan --kmake-arg "CC=clang-12"
--trust-make --kconfig CONFIG_KCSAN_STRICT=y --bootargs
kcsan.skip_watch=1000


[ 1289.504892] rcu: De-offloading 5^M
[ 1289.761495] rcu: De-offloading 7^M
[ 1289.763556] ==================================================================^M
[ 1289.764531] BUG: KCSAN: data-race in call_rcu / rcu_nocb_cb_kthread^M
[ 1289.765388] ^M
[ 1289.765599] read (marked) to 0xffff94f2db7ec608 of 1 bytes by
interrupt on cpu 7:^M
[ 1289.766588]  call_rcu+0xad/0xfd0^M
[ 1289.767035]  rcu_torture_timer+0xdc/0xf0^M
[ 1289.767566]  call_timer_fn+0x87/0x150^M
[ 1289.768065]  __run_timers+0x2fd/0x450^M
[ 1289.768562]  run_timer_softirq+0x29/0x60^M
[ 1289.769093]  __do_softirq+0x1d9/0x35c^M
[ 1289.769540]  __irq_exit_rcu+0x13d/0x150^M
[ 1289.770047]  irq_exit_rcu+0x5/0x20^M
[ 1289.770520]  sysvec_apic_timer_interrupt+0x8d/0xb0^M
[ 1289.771168]  asm_sysvec_apic_timer_interrupt+0x12/0x20^M
[ 1289.771854]  _raw_spin_unlock_irqrestore+0x33/0x50^M
[ 1289.772499]  rdp_offload_toggle+0xc9/0x150^M
[ 1289.773050]  rcu_nocb_rdp_deoffload+0x163/0x2c0^M
[ 1289.773670]  work_for_cpu_fn+0x28/0x40^M
[ 1289.774185]  process_one_work+0x50f/0x800^M
[ 1289.774726]  worker_thread+0x71c/0x9f0^M
[ 1289.775237]  kthread+0x23e/0x270^M
[ 1289.775675]  ret_from_fork+0x22/0x30^M
[ 1289.776162] ^M
[ 1289.776377] 3 locks held by kworker/7:2/294:^M
[ 1289.776955]  #0: ffff94f2c1050738
((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x49c/0x800^M
[ 1289.778245]  #1: ffffa5434093bde0
((work_completion)(&wfc.work)){+.+.}-{0:0}, at:
process_one_work+0x4cd/0x800^M
[ 1289.779605]  #2: ffffa5434029cdf8 ((&t)){+.-.}-{0:0}, at:
call_timer_fn+0x51/0x150^M
[ 1289.780666] irq event stamp: 215649^M
[ 1289.781186] hardirqs last  enabled at (215648):
[<ffffffff8d6afec2>] __local_bh_enable_ip+0xc2/0x120^M
[ 1289.782471] hardirqs last disabled at (215649):
[<ffffffff8d77c6a3>] call_rcu+0x73/0xfd0^M
[ 1289.783632] softirqs last  enabled at (214628):
[<ffffffff8d6b03dd>] __irq_exit_rcu+0x13d/0x150^M
[ 1289.784866] softirqs last disabled at (215635):
[<ffffffff8d6b03dd>] __irq_exit_rcu+0x13d/0x150^M
[ 1289.786147] ^M
[ 1289.786379] write to 0xffff94f2db7ec608 of 1 bytes by task 63 on cpu 15:^M
[ 1289.787342]  rcu_nocb_cb_kthread+0x2f7/0x740^M
[ 1289.787970]  kthread+0x23e/0x270^M
[ 1289.788450]  ret_from_fork+0x22/0x30^M
[ 1289.788964] ^M

The reader is at
0xffffffff8117c6dd: file kernel/rcu/tree.c, line 2991
2986        local_irq_save(flags);
2987        kasan_record_aux_stack(head);
2988        rdp = this_cpu_ptr(&rcu_data);
2989
2990        /* Add the callback to our list. */
2991        if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
2992            // This can trigger due to call_rcu() from offline CPU:
2993            WARN_ON_ONCE(rcu_scheduler_active != RCU_SCHEDULER_INACTIVE);
2994            WARN_ON_ONCE(!rcu_is_watching());
2995            // Very early boot, before rcu_init().  Initialize if needed

The writer is at
0xffffffff81191977: file kernel/rcu/rcu_segcblist.h, line 65
60    }
61
62    static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
63                             int flags)
64    {
65        rsclp->flags &= ~flags;
66    }
67

I gained a lot during the study ;-)

Many thanks
Zhouyi

On Wed, Dec 15, 2021 at 1:59 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Thank Marco for giving me such valuable advice.
>
> Both RCU and KCSAN are very attractive and amazing to me, I have
> carefully read your advice and will strive to acquire expertise in the
> following days.
>
> Thanks again
> Zhouyi
>
> On Wed, Dec 15, 2021 at 12:57 AM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 14 Dec 2021 at 09:38, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > [...]
> > > 2) The KCSAN kernel compile with clang-12:
> > > CONFIG_HAVE_ARCH_KCSAN=y
> > > CONFIG_HAVE_KCSAN_COMPILER=y
> > > CONFIG_KCSAN=y
> > > CONFIG_KCSAN_SELFTEST=y
> > > # CONFIG_KCSAN_EARLY_ENABLE is not set
> > > CONFIG_KCSAN_NUM_WATCHPOINTS=64
> > > CONFIG_KCSAN_UDELAY_TASK=80
> > > CONFIG_KCSAN_UDELAY_INTERRUPT=20
> > > CONFIG_KCSAN_DELAY_RANDOMIZE=y
> > > CONFIG_KCSAN_SKIP_WATCH=4000
> > > CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
> > > # CONFIG_KCSAN_INTERRUPT_WATCHER is not set
> > > CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
> > > # CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
> > > # CONFIG_KCSAN_STRICT is not set
> > > CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y
> > > # CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is not set
> > > CONFIG_KCSAN_IGNORE_ATOMICS=y
> > > CONFIG_KCSAN_PERMISSIVE=y
> >
> > Note, rcutorture selects CONFIG_KCSAN_STRICT=y, which may be one part
> > of the issue.  The other is that the -rcu tree has KCSAN enhancements
> > not yet available in mainline, which are enabled together with
> > CONFIG_KCSAN_STRICT, and make KCSAN slightly more aggressive (i.e.
> > finds data races faster) as well. Although you can also locally make
> > KCSAN a bit more aggressive by lowering CONFIG_KCSAN_SKIP_WATCH (boot
> > param kcsan.skip_watch=), to e.g. 2000-3000, but too low and you'll
> > hurt forward-progress.
> >
> > -- Marco
