Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A6C6FD1F
	for <rcu@archiver.kernel.org>; Mon, 20 Mar 2023 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCTC6X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Mar 2023 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTC6V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Mar 2023 22:58:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C41CC21
        for <rcu@vger.kernel.org>; Sun, 19 Mar 2023 19:58:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e65so11369268ybh.10
        for <rcu@vger.kernel.org>; Sun, 19 Mar 2023 19:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679281099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWm8u4mUJCOEU0qVnUHDKnm0t685QLVHM4K6EwLLr5A=;
        b=XZmNPIFrvceXKA1vkh712+y4ViagW1OIN+snTHSEz5oMCeM6IK+4Yd03YJrkribJST
         k39uGCHBIN0cNXrtadTPpY97xCyvNdcLNNe30+663sfwWuxIEG4Lh9t0vQvpOz2MYbfI
         ZZJVsv73dANH8mwSrOyo2hY29myOYk7jVIT+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679281099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWm8u4mUJCOEU0qVnUHDKnm0t685QLVHM4K6EwLLr5A=;
        b=YAoWzy8Ykm++if4TxATckwZpQ4rfXqUgKRalJLOH/IU0mJzTUM5VvJl7jrLqUaCPe9
         7caibpnwX30eAjo6NsHEM51cSy9uZ2GoS4PBvlUghhc9KjHvys5VDDkKdqQj7aSTDuM3
         uQ8KcXBAlkh6Y2NUcvJPZT845fcL3QV7ooDlWlrNz56HBvyTkgnpmzU4Rqwc74ZJRgtn
         k6qJMIEIy5LOIk4PaiQQ0PTzXBSiS6pjyAOJvAHVTs0CIUpEKnNbzT+NyeBGdPdEASFN
         LbOspBkBEH/C4vZlsnn90AC+RunV81eYUrw1wmuOfq/3j3ZnogANYCX7x/O98eaFWF+j
         OxNg==
X-Gm-Message-State: AO0yUKWQE/K5u5X7idVmVpaLByBDeMPw1J5BzkbsZulGS03vGk/KCGdj
        19Lofie3QVAvn+8rql846hIiVcy4d3iRw/2OBAGIXg==
X-Google-Smtp-Source: AK7set/tnimjTNdynKjPXyI+Xye25QFyuru0oZLWo18qZuT+ttK8zY8ccH9v2emsBSTzJOe93zxXtYuiYjWg2zr+kMs=
X-Received: by 2002:a05:6902:18d1:b0:b6a:2590:6c7f with SMTP id
 ck17-20020a05690218d100b00b6a25906c7fmr2105350ybb.2.1679281099392; Sun, 19
 Mar 2023 19:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230320003316.3897447-1-qiang1.zhang@intel.com>
In-Reply-To: <20230320003316.3897447-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 19 Mar 2023 22:58:08 -0400
Message-ID: <CAEXW_YSCXhgeSgvf=HnoQDrT8T1F7q8m=dobEYHanXjnSUmCHw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Convert schedule_timeout_uninterruptible() to
 mdelay() in rcu_torture_stall()
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 19, 2023 at 8:28=E2=80=AFPM Zqiang <qiang1.zhang@intel.com> wro=
te:
>
> For kernels built with enable PREEMPT_NONE and CONFIG_DEBUG_ATOMIC_SLEEP,
> running the RCU stall tests.
>
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4"
> bootparams=3D"nokaslr console=3DttyS0 rcutorture.stall_cpu=3D30
> rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_irqsoff=3D1
> rcutorture.stall_cpu_block=3D1" -d
>
> [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> [   10.841073] rcu_torture_stall start on CPU 3.
> [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> ....
> [   10.841108] Call Trace:
> [   10.841110]  <TASK>
> [   10.841112]  dump_stack_lvl+0x64/0xb0
> [   10.841118]  dump_stack+0x10/0x20
> [   10.841121]  __schedule_bug+0x8b/0xb0
> [   10.841126]  __schedule+0x2172/0x2940
> [   10.841157]  schedule+0x9b/0x150
> [   10.841160]  schedule_timeout+0x2e8/0x4f0
> [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> [   10.841195]  rcu_torture_stall+0x2e8/0x300
> [   10.841199]  kthread+0x175/0x1a0
> [   10.841206]  ret_from_fork+0x2c/0x50
>
> The above calltrace occurs in the local_irq_disable/enable() critical
> section call schedule_timeout(), and invoke schedule_timeout() also
> implies a quiescent state, of course it also fails to trigger RCU stall,
> this commit therefore use mdelay() instead of schedule_timeout() to
> trigger RCU stall.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d06c2da04c34..fe4f5a4074e3 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
>  #ifdef CONFIG_PREEMPTION
>                                 preempt_schedule();
>  #else
> -                               schedule_timeout_uninterruptible(HZ);
> +                               mdelay(HZ);

mdelay accepts milliseconds but HZ is jiffies correct? So this is
broken for systems with HZ !=3D 1000.

So you need to call mdelay(jiffies_to_msecs(HZ)) instead.

 - Joel
