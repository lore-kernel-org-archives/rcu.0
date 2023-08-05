Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86883C001DB
	for <rcu@archiver.kernel.org>; Sat,  5 Aug 2023 22:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjHEWpM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 5 Aug 2023 18:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHEWpL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 5 Aug 2023 18:45:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A22726
        for <rcu@vger.kernel.org>; Sat,  5 Aug 2023 15:45:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so53873201fa.2
        for <rcu@vger.kernel.org>; Sat, 05 Aug 2023 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691275505; x=1691880305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBvmQjo4/G5q4OEOFo7TpmyhmxzIQuk9NA5YEskEGD0=;
        b=MTHO6PqLhr6m5xYhfArXxt1R/hfRoBr6iqoJl74MZscQGK8OuXF+KizyO/LtoJzDEE
         NLP2M/mcmyqfNfH2GvpbTh+2ec9Hbw2MKaVakLlTMUqNwGK+VrG1JfdUzllN/6atstl6
         Z8as1/wUzVD4pzcsrkd0eQk6FueG25OV4JLek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691275505; x=1691880305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBvmQjo4/G5q4OEOFo7TpmyhmxzIQuk9NA5YEskEGD0=;
        b=LbhKw1ifje9RUXZDaBBFAMOkBFXwURXKVBUriSvYJ0h6ucBkC0nyq5phIxehqXHcvM
         4SXXAwwD5O7NgWoho9Eydiik49I6KQ+vjPvL1Rl27Ht4ajbw4W606fajANYVjhQvUd38
         o4R+yRhv7a9rriGCz1qwmvawMAQbh9YAgvZfVg/LveBSb1RVmM0ja+wJmt8e27VUxCmI
         aaz2QngMKSk2/sVzmma10/K69pgjrVisuZao6dsloPQd17XOyLE+faOQxUF64hZEDS+e
         MMZcr2vCRqgUMINXO7PvXVPM+3U7+0oMNiyXb537S3k4G+dSrPvW9G7W7DKlaulRLdlC
         L2jQ==
X-Gm-Message-State: AOJu0YxoOnLhKt4U/jsRABNMtgNWDwWTpjqpV2SMinSmGuByRG1ohpvM
        FMAz5atC3E2zcQW+fGKqpB6UZ9niiEzIVM6rod6+3A==
X-Google-Smtp-Source: AGHT+IEx2nT/l8NraJQDpLAE6f7yfUXYnFERNnjWiplcPgBsAclfx68kTARV2bPflmzNhis2JJbJzuER3ZECPuK5XN4=
X-Received: by 2002:a2e:780b:0:b0:2b6:fa71:5bae with SMTP id
 t11-20020a2e780b000000b002b6fa715baemr3881000ljc.12.1691275504746; Sat, 05
 Aug 2023 15:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop> <20230728032232.816584-1-paulmck@kernel.org>
In-Reply-To: <20230728032232.816584-1-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 5 Aug 2023 18:44:53 -0400
Message-ID: <CAEXW_YTwo-mADEU0zJTMHufnVtbw-hiLPUZ3bRhs0xHkUKY=ZA@mail.gmail.com>
Subject: Re: [PATCH rcu 1/2] torture: Add a kthread-creation callback to _torture_create_kthread()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Stultz <jstultz@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 27, 2023 at 11:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> This commit adds a kthread-creation callback to the
> _torture_create_kthread() function, which allows callers of a new
> torture_create_kthread_cb() macro to specify a function to be invoked
> after the kthread is created but before it is awakened for the first time=
.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: kernel-team@android.com
> ---
>  include/linux/torture.h | 7 +++++--
>  kernel/torture.c        | 6 +++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/torture.h b/include/linux/torture.h
> index 7038104463e4..bb466eec01e4 100644
> --- a/include/linux/torture.h
> +++ b/include/linux/torture.h
> @@ -108,12 +108,15 @@ bool torture_must_stop(void);
>  bool torture_must_stop_irq(void);
>  void torture_kthread_stopping(char *title);
>  int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, ch=
ar *m,
> -                            char *f, struct task_struct **tp);
> +                            char *f, struct task_struct **tp, void (*cbf=
)(struct task_struct *tp));
>  void _torture_stop_kthread(char *m, struct task_struct **tp);
>
>  #define torture_create_kthread(n, arg, tp) \
>         _torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
> -                               "Failed to create " #n, &(tp))
> +                               "Failed to create " #n, &(tp), NULL)
> +#define torture_create_kthread_cb(n, arg, tp, cbf) \
> +       _torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
> +                               "Failed to create " #n, &(tp), cbf)
>  #define torture_stop_kthread(n, tp) \
>         _torture_stop_kthread("Stopping " #n " task", &(tp))
>
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 8be83fdc6be1..b88a1a86d9da 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -932,7 +932,7 @@ EXPORT_SYMBOL_GPL(torture_kthread_stopping);
>   * it starts, you will need to open-code your own.
>   */
>  int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, ch=
ar *m,
> -                           char *f, struct task_struct **tp)
> +                           char *f, struct task_struct **tp, void (*cbf)=
(struct task_struct *tp))
>  {
>         int ret =3D 0;
>
> @@ -944,6 +944,10 @@ int _torture_create_kthread(int (*fn)(void *arg), vo=
id *arg, char *s, char *m,
>                 *tp =3D NULL;
>                 return ret;
>         }
> +
> +       if (cbf)
> +               cbf(*tp);
> +
>         wake_up_process(*tp);  // Process is sleeping, so ordering provid=
ed.
>         torture_shuffle_task_register(*tp);
>         return ret;
> --
> 2.40.1
>
