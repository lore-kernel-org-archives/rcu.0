Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8438C43334
	for <rcu@archiver.kernel.org>; Wed,  8 Jun 2022 03:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiFHDnM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiFHDmx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jun 2022 23:42:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD45322B78D
        for <rcu@vger.kernel.org>; Tue,  7 Jun 2022 17:53:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fu3so36919700ejc.7
        for <rcu@vger.kernel.org>; Tue, 07 Jun 2022 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etq8qMmhaN7ugLnV7RZs9EOZ5FNck0lKRTXvUG09V/g=;
        b=Jd2rP9mE0IvUS+nOkS/NEV13OXXcrwWBP+xVcYf/TdwxVG7FTqd+CAO4vvkeHPgmdR
         /OZgb0NY1QfVAmRhonJvZdPME3P1MWaB/GgvHv7H5APR7Cj/SNgjN2RMzxtKE4IfJaOF
         yNEZ8nonNLyPeq26H3dzyQjp9mjQSq3WMCLM+su0giNlbOXnDAETjONds1qIkFE8dsRy
         gfqptDbTEwhi/2CCOavYnmuNI5sVpY+2OEWf2LIOFiGlwQLb+ZvY0AdO3N2cuocSdu/V
         j/2D9ljB1N4rrpnCn1eDJJC1IUbPMR024DYLY3TqTE5HBRvjjbI6eXWcHyVo4GJyF6Ub
         pYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etq8qMmhaN7ugLnV7RZs9EOZ5FNck0lKRTXvUG09V/g=;
        b=g58j+ZYr2GtwW+fzKD3HS/axEZ2mQ7IqWsxREetUaZNIihxv1SpMvCnyTIQZvv1Cfy
         x1tglXnjR8d5GYBxWp4R4L4WW/CwoeZLPzqykD3k30RU93o5HDVoVYd5XFZMaGMUldUc
         4tf3QxCrCIfTi7MJbAYXiioOr9R8Zzpc4uzaODaOqwlp+FP4HkwiB1nY04xNJtzRSowE
         +i+eeO+vwPZ35Cl3al+AtEdcJCaZ/bD7VABYTYNur/Ebnp/9KdclH/jndR4NzBsrMrtD
         M1J10QTOXuKI+mb7Mz81lw9WK7CZZbAmXPdqzOIDvj4vKj/ND92VPAL+6L6b7mcP2/5k
         WctQ==
X-Gm-Message-State: AOAM533LyLioSZbrRcI6A5BT1bZZ+MyJiQ20RVXyOfNoZnOAGT7Q8vAr
        17IJ/Hv43tFXGDrtQKj4/BomB4wTIo6+FkOf8C4=
X-Google-Smtp-Source: ABdhPJwNzybx1RdvFOCnLDr/BaxFZ6rsemwIUmKtS8mcxS+lxvYCnOjbYmBX9DqkYNvZlMyiwZlpva3+Wr/uAUwG4t8=
X-Received: by 2002:a17:906:1cc3:b0:711:24e4:70e1 with SMTP id
 i3-20020a1709061cc300b0071124e470e1mr17435350ejh.551.1654649585084; Tue, 07
 Jun 2022 17:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220527003909.18998-1-zhouzhouyi@gmail.com> <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 8 Jun 2022 08:52:53 +0800
Message-ID: <CAABZP2wmdxdWATMXux+4oTiqMJ1Htwfi-gf9eXRDoov_cji_NQ@mail.gmail.com>
Subject: Re: [PATCH rcu/dev] RFC: temporarily reduce rcu tasks kthread sleep
 time for PROVE_RCU
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, urezki@gmail.com,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul
    Thank you for your constant guidance and encouragement!
On Wed, Jun 8, 2022 at 7:42 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 08:39:09AM +0800, Zhouyi Zhou wrote:
> > Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
> > to have all required grace periods.
> >
> > Temporarily reduce rcu tasks kthread sleep time for PROVE_RCU to get all
> > required grace periods.
> >
> > Both this patch and her sister
> > "wait extra jiffies for rcu_tasks_verify_self_tests"
> > https://lore.kernel.org/rcu/20220517004522.25176-1-zhouzhouyi@gmail.com/
> > have their short comings:
> >
> > 1) this patch don't slow down the Linux boot time but will increase
> > the energe consumption during the boot because of reduced sleep time.
> >
> > 2) "wait extra jiffies for rcu_tasks_verify_self_tests" may slow the boot
> > process but has not energe problems.
> >
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Hi Paul
> >
> > I have proposed some possible solutions to fix rcu_tasks_verify_self_tests
> > failure. Both of them are not perfect. Only tries to break the ice,
> > hoping to arouse the attension ;-)
>
> First, please accept my apologies for the delay, and especially thank
> you for continuing to dig into this!
You are very welcome ;-) And thank you for your deep consideration!
I am currenlly doing research on torture.sh on linux-next these days
(both on my Dell PowerEdge R720 server and my Thinkpad P1 gen 4), it
seems
that the message generated by lock_torture_print_module_parms and
rcu_torture_print_module_parms do not reach uart_console_write which
will lead to test failure,
I think I am near the answer.
>
> Your approach is not at all at all bad, but it would be good to leave
> the underlying implementation alone if we can.  One way to do this is to
> wait for up to a fixed period of time for the grace period to complete,
> for example, as shown in the patch below.
Your patch is fantastic indeed! It overcomes all the shortcomings of
my proposals! Why didn't I think of such method.
>
> Thoughts?
I have tested dev for 30 minutes (500 boots), none of them fail.
Then I revert this fix:
zzy@zzy-ThinkPad-P1-Gen-4i:~/Program/linux-rcu$ git checkout
504312bb6d39c22d6d0415993c2f9af6ce2b2bba
Previous HEAD position was 3e95d4b287b3 rcu-tasks: Be more patient for
RCU Tasks boot-time testing
HEAD is now at 504312bb6d39 rcu-tasks: Update comments
my test script reports the failure on the first boot.

Conclusion:
The patch below fixed the problem reported by Matthew and I elegantly.

Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Thanks
Zhouyi
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 3e95d4b287b37ee5f7f82e5ebd749ab89fd706c2
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 7 15:23:52 2022 -0700
>
>     rcu-tasks: Be more patient for RCU Tasks boot-time testing
>
>     The RCU-Tasks family of grace-period primitives can take some time to
>     complete, and the amount of time can depend on the exact hardware and
>     software configuration.  Some configurations boot up fast enough that the
>     RCU-Tasks verification process gets false-positive failures.  This commit
>     therefore allows up to 30 seconds for the grace periods to complete, with
>     this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
>     kernel boot parameter.
>
>     Reported-by: Matthew Wilcox <willy@infradead.org>
>     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f1209ce621c51..1a4c3adc5c397 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
>  module_param(rcu_task_ipi_delay, int, 0644);
>
>  /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
> +#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
>  #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
>  static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
>  module_param(rcu_task_stall_timeout, int, 0644);
> @@ -1778,23 +1779,24 @@ struct rcu_tasks_test_desc {
>         struct rcu_head rh;
>         const char *name;
>         bool notrun;
> +       unsigned long runstart;
>  };
>
>  static struct rcu_tasks_test_desc tests[] = {
>         {
>                 .name = "call_rcu_tasks()",
>                 /* If not defined, the test is skipped. */
> -               .notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> +               .notrun = IS_ENABLED(CONFIG_TASKS_RCU),
>         },
>         {
>                 .name = "call_rcu_tasks_rude()",
>                 /* If not defined, the test is skipped. */
> -               .notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> +               .notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
>         },
>         {
>                 .name = "call_rcu_tasks_trace()",
>                 /* If not defined, the test is skipped. */
> -               .notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> +               .notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
>         }
>  };
>
> @@ -1805,23 +1807,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>
>         pr_info("Callback from %s invoked.\n", rttd->name);
>
> -       rttd->notrun = true;
> +       rttd->notrun = false;
>  }
>
>  static void rcu_tasks_initiate_self_tests(void)
>  {
> +       unsigned long j = jiffies;
> +
>         pr_info("Running RCU-tasks wait API self tests\n");
>  #ifdef CONFIG_TASKS_RCU
> +       tests[0].runstart = j;
>         synchronize_rcu_tasks();
>         call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>  #endif
>
>  #ifdef CONFIG_TASKS_RUDE_RCU
> +       tests[1].runstart = j;
>         synchronize_rcu_tasks_rude();
>         call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
>  #endif
>
>  #ifdef CONFIG_TASKS_TRACE_RCU
> +       tests[2].runstart = j;
>         synchronize_rcu_tasks_trace();
>         call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
>  #endif
> @@ -1831,11 +1838,18 @@ static int rcu_tasks_verify_self_tests(void)
>  {
>         int ret = 0;
>         int i;
> +       unsigned long bst = rcu_task_stall_timeout;
>
> +       if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
> +               bst = RCU_TASK_BOOT_STALL_TIMEOUT;
>         for (i = 0; i < ARRAY_SIZE(tests); i++) {
> -               if (!tests[i].notrun) {         // still hanging.
> -                       pr_err("%s has been failed.\n", tests[i].name);
> -                       ret = -1;
> +               while (tests[i].notrun) {               // still hanging.
> +                       if (time_after(jiffies, tests[i].runstart + bst)) {
> +                               pr_err("%s has failed boot-time tests.\n", tests[i].name);
> +                               ret = -1;
> +                               break;
> +                       }
> +                       schedule_timeout_uninterruptible(1);
>                 }
>         }
>
