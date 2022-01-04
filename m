Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA9BC433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Jan 2022 22:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiADWwC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiADWwC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Jan 2022 17:52:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09459C061761
        for <rcu@vger.kernel.org>; Tue,  4 Jan 2022 14:52:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so155491801edc.0
        for <rcu@vger.kernel.org>; Tue, 04 Jan 2022 14:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=312YDKHvEqjeLpisDlsuCZnaUqH0yKEBaMAo377ckUI=;
        b=e3fv01g2qZ+tRhvNU1OCJcaUH8XrTWgJNALcWLwu0Zr1OC6avBEqWbZoOAtDM+c08E
         i9w2AMxb315DGGLnmWyiXXc78haTamLEvyNe2WNXWjGuMgyoi0V2znPNHGSSg1zNI8Jn
         Lg4zAhC3DbOugQ4SSKBk7GY5WHp5qiavNG0Sq8ACHJae6DGXw6w2egMPgQqrbTGSLpIS
         20gh6B3D2heZRHvbjySShHD8gQozDHaZ0+SMlRNLtLBguk+MKOVgCCw3x0XTWglR7eIJ
         Qid/a/1c7EN0EA2RDLZuD2EurbBQFDaAYlutfVKpMVqQ0b0x+izibjkjiDY/kyV6Khgo
         gvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=312YDKHvEqjeLpisDlsuCZnaUqH0yKEBaMAo377ckUI=;
        b=fn093TirVq0PvOUvRc4saMp5yJXa4gBf7XS0UuqeWwJCj9yGIqva970aJgU9Ydpkqq
         V+KBonVN6vyTICVKAz2DlqiHws2kjshS3ZAmKYb0+VqNQFt7EHW7/SwB/hxIcksvhNYU
         3TuClZtGpZXRt+94pOS8KZSAvqvsY7CNRWU5oe4hTVuNkikmEAO7tQ/bmDgxUlv0n6Sh
         /XC9ULUa7yvNRxP7971tThttwHDCoaivNKPgY1bRhER39noR0jYDNje2C/xvTybRu2Rf
         n+/kLskSVq4/HSzdJx5POAk3yq19CprMbR0qp+1Vuk3rrN/WvhAEtnDhde9wlfQlZGhB
         zU9Q==
X-Gm-Message-State: AOAM5339/i2MUAamJSD2r/9p95JpbD/LcmaRbZSCQa+/sS5I9/lv3Rkk
        ZAa5SF2ed7E+bDfhJrbNy/f35aegAyotR0CJzeU=
X-Google-Smtp-Source: ABdhPJwCq684A3mMbVcvfBXh0mTfj0HHlPexGv5kMfziIzxjDVw/xgtKCXF1D9pczSY8KmUae+ybnGfN9AEVT6TqZ5U=
X-Received: by 2002:aa7:dd59:: with SMTP id o25mr49635783edw.288.1641336720617;
 Tue, 04 Jan 2022 14:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20211214045758.GA1713844@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
 <CANpmjNMpm0ZnWKzpWOFRtOU8EfFDP2t2spyOnW2Rx8LFGO2S-w@mail.gmail.com>
 <CAABZP2w8+bZWWP_bRi+Vfokm-xDwOga5TrjFnJwEmx2zGiMHiw@mail.gmail.com>
 <CAABZP2xWFVLYmrMF0ADDm2zaHtxizfZMbCfHeNDDqpqyEO4MNA@mail.gmail.com> <20220104184253.GE4202@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220104184253.GE4202@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 5 Jan 2022 06:51:49 +0800
Message-ID: <CAABZP2zX_iD9s7JGevOUmKwibE7nMPhBnc_f1+qoxE19Q9oD6Q@mail.gmail.com>
Subject: Re: FYI, a few new KCSAN splats
To:     paulmck@kernel.org
Cc:     Marco Elver <elver@google.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank Paul for your encouragement

May I make bold to suggest a possible small modification to git log as
below (use the knowledge and terms I learned from perfbook)

Thanks
Zhouyi
On Wed, Jan 5, 2022 at 2:42 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jan 02, 2022 at 08:27:29AM +0800, Zhouyi Zhou wrote:
> > Thanks Paul and Marco for giving me valuable advice.
> >
> > I studied the structure of kvm.sh and I found enabling
> > CONFIG_KCSAN_STRICT and lower kcsan.skip_watch will make the KCSAN
> > detect RCU's data-race within half an hour (I tried this for two
> > times).
> > Following is my command:
> > linux-rcu$git config --get remote.origin.url
> > https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/
> > linux-rcu$tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus
> > --duration 10h --configs "TREE01" --kcsan --kmake-arg "CC=clang-12"
> > --trust-make --kconfig CONFIG_KCSAN_STRICT=y --bootargs
> > kcsan.skip_watch=1000
> >
> >
> > [ 1289.504892] rcu: De-offloading 5^M
> > [ 1289.761495] rcu: De-offloading 7^M
> > [ 1289.763556] ==================================================================^M
> > [ 1289.764531] BUG: KCSAN: data-race in call_rcu / rcu_nocb_cb_kthread^M
> > [ 1289.765388] ^M
> > [ 1289.765599] read (marked) to 0xffff94f2db7ec608 of 1 bytes by
> > interrupt on cpu 7:^M
> > [ 1289.766588]  call_rcu+0xad/0xfd0^M
> > [ 1289.767035]  rcu_torture_timer+0xdc/0xf0^M
> > [ 1289.767566]  call_timer_fn+0x87/0x150^M
> > [ 1289.768065]  __run_timers+0x2fd/0x450^M
> > [ 1289.768562]  run_timer_softirq+0x29/0x60^M
> > [ 1289.769093]  __do_softirq+0x1d9/0x35c^M
> > [ 1289.769540]  __irq_exit_rcu+0x13d/0x150^M
> > [ 1289.770047]  irq_exit_rcu+0x5/0x20^M
> > [ 1289.770520]  sysvec_apic_timer_interrupt+0x8d/0xb0^M
> > [ 1289.771168]  asm_sysvec_apic_timer_interrupt+0x12/0x20^M
> > [ 1289.771854]  _raw_spin_unlock_irqrestore+0x33/0x50^M
> > [ 1289.772499]  rdp_offload_toggle+0xc9/0x150^M
> > [ 1289.773050]  rcu_nocb_rdp_deoffload+0x163/0x2c0^M
> > [ 1289.773670]  work_for_cpu_fn+0x28/0x40^M
> > [ 1289.774185]  process_one_work+0x50f/0x800^M
> > [ 1289.774726]  worker_thread+0x71c/0x9f0^M
> > [ 1289.775237]  kthread+0x23e/0x270^M
> > [ 1289.775675]  ret_from_fork+0x22/0x30^M
> > [ 1289.776162] ^M
> > [ 1289.776377] 3 locks held by kworker/7:2/294:^M
> > [ 1289.776955]  #0: ffff94f2c1050738
> > ((wq_completion)events){+.+.}-{0:0}, at:
> > process_one_work+0x49c/0x800^M
> > [ 1289.778245]  #1: ffffa5434093bde0
> > ((work_completion)(&wfc.work)){+.+.}-{0:0}, at:
> > process_one_work+0x4cd/0x800^M
> > [ 1289.779605]  #2: ffffa5434029cdf8 ((&t)){+.-.}-{0:0}, at:
> > call_timer_fn+0x51/0x150^M
> > [ 1289.780666] irq event stamp: 215649^M
> > [ 1289.781186] hardirqs last  enabled at (215648):
> > [<ffffffff8d6afec2>] __local_bh_enable_ip+0xc2/0x120^M
> > [ 1289.782471] hardirqs last disabled at (215649):
> > [<ffffffff8d77c6a3>] call_rcu+0x73/0xfd0^M
> > [ 1289.783632] softirqs last  enabled at (214628):
> > [<ffffffff8d6b03dd>] __irq_exit_rcu+0x13d/0x150^M
> > [ 1289.784866] softirqs last disabled at (215635):
> > [<ffffffff8d6b03dd>] __irq_exit_rcu+0x13d/0x150^M
> > [ 1289.786147] ^M
> > [ 1289.786379] write to 0xffff94f2db7ec608 of 1 bytes by task 63 on cpu 15:^M
> > [ 1289.787342]  rcu_nocb_cb_kthread+0x2f7/0x740^M
> > [ 1289.787970]  kthread+0x23e/0x270^M
> > [ 1289.788450]  ret_from_fork+0x22/0x30^M
> > [ 1289.788964] ^M
> >
> > The reader is at
> > 0xffffffff8117c6dd: file kernel/rcu/tree.c, line 2991
> > 2986        local_irq_save(flags);
> > 2987        kasan_record_aux_stack(head);
> > 2988        rdp = this_cpu_ptr(&rcu_data);
> > 2989
> > 2990        /* Add the callback to our list. */
> > 2991        if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
> > 2992            // This can trigger due to call_rcu() from offline CPU:
> > 2993            WARN_ON_ONCE(rcu_scheduler_active != RCU_SCHEDULER_INACTIVE);
> > 2994            WARN_ON_ONCE(!rcu_is_watching());
> > 2995            // Very early boot, before rcu_init().  Initialize if needed
> >
> > The writer is at
> > 0xffffffff81191977: file kernel/rcu/rcu_segcblist.h, line 65
> > 60    }
> > 61
> > 62    static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
> > 63                             int flags)
> > 64    {
> > 65        rsclp->flags &= ~flags;
> > 66    }
> > 67
> >
> > I gained a lot during the study ;-)
>
> Glad the process was educational.  ;-)
>
> Thoughts on the alleged fix below?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 66b153e7e3980067de018ec8c478aa0aaf7ba2bd
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jan 4 10:34:34 2022 -0800
>
>     rcu: Mark writes to the rcu_segcblist structure's ->flags field
>
>     KCSAN reports data races between the rcu_segcblist_clear_flags() and
>     rcu_segcblist_set_flags() functions, though misreporting the latter
>     as a call to rcu_segcblist_is_enabled() from call_rcu().  This commit
       as a call to rcu_segcblist_is_enabled() from call_rcu() because
the compiler
       optimizes the intermediate functions away. This commit
>     converts the updates of this field to WRITE_ONCE(), relying on the
>     resulting unmarked reads to continue to detect buggy concurrent writes
>     to this field.
>
>     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Frederic Weisbecker <frederic@kernel.org>
>
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index e373fbe44da5e..431cee212467d 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -56,13 +56,13 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
>  static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
>                                            int flags)
>  {
> -       rsclp->flags |= flags;
> +       WRITE_ONCE(rsclp->flags, rsclp->flags | flags);
>  }
>
>  static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
>                                              int flags)
>  {
> -       rsclp->flags &= ~flags;
> +       WRITE_ONCE(rsclp->flags, rsclp->flags & ~flags);
>  }
>
>  static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
