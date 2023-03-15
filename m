Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17934C6FD1D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjCOONU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjCOONC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 10:13:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856349F047
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 07:12:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536af432ee5so371751377b3.0
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678889536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVSHFVa/FQgQAJ2kukgdYyHpqxG+0TIN6eOsflI5G+4=;
        b=hdc03m96nUP82sY6Bu4YSFRUVBQZq1vVyztCHgoD7mgCh+7nqnNhUyTiDdV52lvefr
         5QW0NU+JZ4VesLRlLVBbgUFn+kpBMkhhKquqpfAckyB80lBxo7J/G6bWAncY3uw37zYj
         FARxiGzDHFL5i06QI5B9+pdqHB0KluwlU/wWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVSHFVa/FQgQAJ2kukgdYyHpqxG+0TIN6eOsflI5G+4=;
        b=wp11hHnPJxV6vgbju0BpXEuUyD5CyFbCALeKEQIn2s47lPxQJ0obDBOH9lIX4MOSN+
         +Aq7jzAxf0iAAK5bjn+z5wK0wXsP5/TMLf3FtWBg6nL2TkB1/fEvHvDdeUuvcSuqi8Wa
         WCm418gLokZwb5Xy9MlBtXxKbcZJsuYfTR0sGz09MZ+lzgG7WxzpxZB9H5cUn9fKP+0C
         n7qL87PXdYrKgBHIgvux7VndqWT6i0WdnjGCxujVP8haB84EUKRtZGvQuHiT+qP3KeZo
         5AnRNZoWjFQ6xbTBIy7/o8rVfXbHcgJKsOmVfbut0fJsB/ipl8GPoEZR3brMZ8UXv3Es
         IEIA==
X-Gm-Message-State: AO0yUKU2X2HoUCgBg8bx/gIP6tPh2+8TtldtN3hWajJdlV8BofPOD4wa
        Taa13jNcYdOZDTYwLi7TizZ7qAhu44Ndh8C3YMtW54d3g1OfnoyC
X-Google-Smtp-Source: AK7set/kxEpfFgcMC1wVVL5no9/zUdMTCVsvBo+xKu3cdvEaqjHM/FuVGMFduxsq7q0Z/W+jrA24IbqVPc4JFh6+b5I=
X-Received: by 2002:a81:a807:0:b0:536:4ad1:f71 with SMTP id
 f7-20020a81a807000000b005364ad10f71mr2633ywh.9.1678889536191; Wed, 15 Mar
 2023 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com> <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
 <IA1PR11MB6171EA9F4437346FECB73F3189BF9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6171EA9F4437346FECB73F3189BF9@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 10:12:05 -0400
Message-ID: <CAEXW_YRatZhejsW-o1PXK3V8QxOcc-krvRdjwaDudFSfUotAKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 15, 2023 at 10:07=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com>=
 wrote:
[...]
> >
> > I do applaud minmimizing the size of the patch, but in this case could =
you
> > please pull the kfree_scale_cleanup() function ahead of its first use?
> >
>
> I thought about it, but was also concerned that would make the patch bigg=
er
> while the effective changes were just only a few lines ...
>
> Pulling the kfree_scale_cleanup() function ahead of rcu_scale_cleanup() a=
lso needs
> to pull another two kfree_* variables ahead used by kfree_scale_cleanup()=
.
> This looks like will mess up kfree_* and rcu_scale_* functions/variables =
in the source file.
>
> How about to pull the rcu_scale_cleanup() function after kfree_scale_clea=
nup().
> This groups kfree_* functions and groups rcu_scale_* functions.
> Then the code would look cleaner.
> So, do you think the changes below are better?

IMHO, I don't think doing such a code move is better. Just add a new
header file and declare the function there. But see what Paul says
first.

thanks,

 - Joel



>
> ---
>  kernel/rcu/rcuscale.c | 201 ++++++++++++++++++++++--------------------
>  1 file changed, 103 insertions(+), 98 deletions(-)
>
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 91fb5905a008..5a000d26f03e 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -522,89 +522,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *c=
ur_ops, const char *tag)
>                  scale_type, tag, nrealreaders, nrealwriters, verbose, sh=
utdown);
>  }
>
> -static void
> -rcu_scale_cleanup(void)
> -{
> -       int i;
> -       int j;
> -       int ngps =3D 0;
> -       u64 *wdp;
> -       u64 *wdpp;
> -
> -       /*
> -        * Would like warning at start, but everything is expedited
> -        * during the mid-boot phase, so have to wait till the end.
> -        */
> -       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> -               SCALEOUT_ERRSTRING("All grace periods expedited, no norma=
l ones to measure!");
> -       if (rcu_gp_is_normal() && gp_exp)
> -               SCALEOUT_ERRSTRING("All grace periods normal, no expedite=
d ones to measure!");
> -       if (gp_exp && gp_async)
> -               SCALEOUT_ERRSTRING("No expedited async GPs, so went with =
async!");
> -
> -       if (torture_cleanup_begin())
> -               return;
> -       if (!cur_ops) {
> -               torture_cleanup_end();
> -               return;
> -       }
> -
> -       if (reader_tasks) {
> -               for (i =3D 0; i < nrealreaders; i++)
> -                       torture_stop_kthread(rcu_scale_reader,
> -                                            reader_tasks[i]);
> -               kfree(reader_tasks);
> -       }
> -
> -       if (writer_tasks) {
> -               for (i =3D 0; i < nrealwriters; i++) {
> -                       torture_stop_kthread(rcu_scale_writer,
> -                                            writer_tasks[i]);
> -                       if (!writer_n_durations)
> -                               continue;
> -                       j =3D writer_n_durations[i];
> -                       pr_alert("%s%s writer %d gps: %d\n",
> -                                scale_type, SCALE_FLAG, i, j);
> -                       ngps +=3D j;
> -               }
> -               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: =
%d batches: %ld\n",
> -                        scale_type, SCALE_FLAG,
> -                        t_rcu_scale_writer_started, t_rcu_scale_writer_f=
inished,
> -                        t_rcu_scale_writer_finished -
> -                        t_rcu_scale_writer_started,
> -                        ngps,
> -                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> -                                          b_rcu_gp_test_started));
> -               for (i =3D 0; i < nrealwriters; i++) {
> -                       if (!writer_durations)
> -                               break;
> -                       if (!writer_n_durations)
> -                               continue;
> -                       wdpp =3D writer_durations[i];
> -                       if (!wdpp)
> -                               continue;
> -                       for (j =3D 0; j < writer_n_durations[i]; j++) {
> -                               wdp =3D &wdpp[j];
> -                               pr_alert("%s%s %4d writer-duration: %5d %=
llu\n",
> -                                       scale_type, SCALE_FLAG,
> -                                       i, j, *wdp);
> -                               if (j % 100 =3D=3D 0)
> -                                       schedule_timeout_uninterruptible(=
1);
> -                       }
> -                       kfree(writer_durations[i]);
> -               }
> -               kfree(writer_tasks);
> -               kfree(writer_durations);
> -               kfree(writer_n_durations);
> -       }
> -
> -       /* Do torture-type-specific cleanup operations.  */
> -       if (cur_ops->cleanup !=3D NULL)
> -               cur_ops->cleanup();
> -
> -       torture_cleanup_end();
> -}
> -
>  /*
>   * Return the number if non-negative.  If -1, the number of CPUs.
>   * If less than -1, that much less than the number of CPUs, but
> @@ -624,21 +541,6 @@ static int compute_real(int n)
>         return nr;
>  }
>
> -/*
> - * RCU scalability shutdown kthread.  Just waits to be awakened, then sh=
uts
> - * down system.
> - */
> -static int
> -rcu_scale_shutdown(void *arg)
> -{
> -       wait_event(shutdown_wq,
> -                  atomic_read(&n_rcu_scale_writer_finished) >=3D nrealwr=
iters);
> -       smp_mb(); /* Wake before output. */
> -       rcu_scale_cleanup();
> -       kernel_power_off();
> -       return -EINVAL;
> -}
> -
>  /*
>   * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs f=
or number
>   * of iterations and measure total time and number of GP for all iterati=
ons to complete.
> @@ -875,6 +777,109 @@ kfree_scale_init(void)
>         return firsterr;
>  }
>
> +static void
> +rcu_scale_cleanup(void)
> +{
> +       int i;
> +       int j;
> +       int ngps =3D 0;
> +       u64 *wdp;
> +       u64 *wdpp;
> +
> +       /*
> +        * Would like warning at start, but everything is expedited
> +        * during the mid-boot phase, so have to wait till the end.
> +        */
> +       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> +               SCALEOUT_ERRSTRING("All grace periods expedited, no norma=
l ones to measure!");
> +       if (rcu_gp_is_normal() && gp_exp)
> +               SCALEOUT_ERRSTRING("All grace periods normal, no expedite=
d ones to measure!");
> +       if (gp_exp && gp_async)
> +               SCALEOUT_ERRSTRING("No expedited async GPs, so went with =
async!");
> +
> +       if (kfree_rcu_test) {
> +               kfree_scale_cleanup();
> +               return;
> +       }
> +
> +       if (torture_cleanup_begin())
> +               return;
> +       if (!cur_ops) {
> +               torture_cleanup_end();
> +               return;
> +       }
> +
> +       if (reader_tasks) {
> +               for (i =3D 0; i < nrealreaders; i++)
> +                       torture_stop_kthread(rcu_scale_reader,
> +                                            reader_tasks[i]);
> +               kfree(reader_tasks);
> +       }
> +
> +       if (writer_tasks) {
> +               for (i =3D 0; i < nrealwriters; i++) {
> +                       torture_stop_kthread(rcu_scale_writer,
> +                                            writer_tasks[i]);
> +                       if (!writer_n_durations)
> +                               continue;
> +                       j =3D writer_n_durations[i];
> +                       pr_alert("%s%s writer %d gps: %d\n",
> +                                scale_type, SCALE_FLAG, i, j);
> +                       ngps +=3D j;
> +               }
> +               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: =
%d batches: %ld\n",
> +                        scale_type, SCALE_FLAG,
> +                        t_rcu_scale_writer_started, t_rcu_scale_writer_f=
inished,
> +                        t_rcu_scale_writer_finished -
> +                        t_rcu_scale_writer_started,
> +                        ngps,
> +                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> +                                          b_rcu_gp_test_started));
> +               for (i =3D 0; i < nrealwriters; i++) {
> +                       if (!writer_durations)
> +                               break;
> +                       if (!writer_n_durations)
> +                               continue;
> +                       wdpp =3D writer_durations[i];
> +                       if (!wdpp)
> +                               continue;
> +                       for (j =3D 0; j < writer_n_durations[i]; j++) {
> +                               wdp =3D &wdpp[j];
> +                               pr_alert("%s%s %4d writer-duration: %5d %=
llu\n",
> +                                       scale_type, SCALE_FLAG,
> +                                       i, j, *wdp);
> +                               if (j % 100 =3D=3D 0)
> +                                       schedule_timeout_uninterruptible(=
1);
> +                       }
> +                       kfree(writer_durations[i]);
> +               }
> +               kfree(writer_tasks);
> +               kfree(writer_durations);
> +               kfree(writer_n_durations);
> +       }
> +
> +       /* Do torture-type-specific cleanup operations.  */
> +       if (cur_ops->cleanup !=3D NULL)
> +               cur_ops->cleanup();
> +
> +       torture_cleanup_end();
> +}
> +
> +/*
> + * RCU scalability shutdown kthread.  Just waits to be awakened, then sh=
uts
> + * down system.
> + */
> +static int
> +rcu_scale_shutdown(void *arg)
> +{
> +       wait_event(shutdown_wq,
> +                  atomic_read(&n_rcu_scale_writer_finished) >=3D nrealwr=
iters);
> +       smp_mb(); /* Wake before output. */
> +       rcu_scale_cleanup();
> +       kernel_power_off();
> +       return -EINVAL;
> +}
> +
>  static int __init
>  rcu_scale_init(void)
>  {
> --
> 2.17.1
>
> > [...]
>
