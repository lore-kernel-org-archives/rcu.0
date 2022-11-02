Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED13C41535
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 16:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiKBQNK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiKBQMH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 12:12:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001772D1CC
        for <rcu@vger.kernel.org>; Wed,  2 Nov 2022 09:11:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a13so27253412edj.0
        for <rcu@vger.kernel.org>; Wed, 02 Nov 2022 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nx0A3jt4d916p+0TTWB9Cat4g/h93+jjZlEFabh3r4=;
        b=CrA9D4GdoDlJzsilzh/L+NKrb9G4nTE4mc75ivd5A3e+iwv2LTp555SfYctr+aqF+8
         7sOxRfi4LB67FD1k0bi7t0W0oZ+7UgeHMTU6UMTnSYBMY26D1mmlmt9bY5sw2OOcYq24
         ib+hWhijSZLMMpQKpZ1+7sp4fBht3oTXoP0ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nx0A3jt4d916p+0TTWB9Cat4g/h93+jjZlEFabh3r4=;
        b=vN6Mwe2IzymhPzhcGSvsm/P22KtoD8awVBcErVkKvQb6RPJ8GYS6f++pjbCvSyLSPc
         pbESzPJAPA2smrB1ja23Pgz4evsRsRKSdvY/nM+LcjNk6Qt5sXQccl332pAAwj3dEgEA
         h3wBgLb0z9PH7ma3Mzvl65p0omAvQfbZoSFd6VDo687tIZiMCnZ2gtbdxgGo9PV058Nt
         6/3Quhtq8Dq3T2fBx3oUUv/fGzEkSRM4/wrcybAXqEL8VbS+cdjM7iNDo+hK8hdMFRua
         pNNSDtTN5RX4qzHFeVQZI3bWhNqbawEtqbwHxadKUnJdz133kkZZvn09Rt1TWeP7U+6E
         y2hg==
X-Gm-Message-State: ACrzQf23QJp3dxN8YCNLnePLtOaoLxD//xEqqFRc2/5l5NFswO/BnMDJ
        OI/Tp9wioemMnjxLCRr5ZJCW1MFHipcqURE+fOEf3bt0QpA=
X-Google-Smtp-Source: AMsMyM5B7tk4hRliW0OLIl6wvvEuEO2HgVMMq3tZe1CHgaJTrdsnjRs6aEFfvnALtydwBc7jERWdcYNrs4p7j6TDjfE=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr24730606edv.232.1667405496949; Wed, 02
 Nov 2022 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org>
In-Reply-To: <20221029132856.3752018-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Nov 2022 12:11:24 -0400
Message-ID: <CAEXW_YRZ-0LP5Y=sWREkLzPTiAJZTPrSm9YGfg6eqmD5XhwQTA@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 29, 2022 at 9:29 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> On ChromeOS, I am (almost) always seeing the optimization trigger.
> Tested boot up and trace_printk'ing how often it triggers.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 591187b6352e..3e4c50b9fd33 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
>
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
>   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
>         struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>         raw_spinlock_t lock;
>         struct delayed_work monitor_work;
> +       struct rcu_data *rdp;
> +       unsigned long last_gp_seq;
>         bool initialized;
>         int count;
>
> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>                         mod_delayed_work(system_wq, &krcp->monitor_work, delay);
>                 return;
>         }
> +       krcp->last_gp_seq = krcp->rdp->gp_seq;

TODO: As Paul pointed out today in a meeting, we can't just sample
rdp->gp_seq directly as it can jump forward quickly from out-of-date
to non-out-of-date. Such GP can happen before a grace period actually
elapses. Boom!

He did make me feel better though that it is something easy to miss,
and to audit the current code about.

 - Joel



 - Joel



>         queue_delayed_work(system_wq, &krcp->monitor_work, delay);
>  }
>
> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
>                         // be that the work is in the pending state when
>                         // channels have been detached following by each
>                         // other.
> -                       queue_rcu_work(system_wq, &krwp->rcu_work);
> +                       //
> +                       // NOTE about gp_seq wrap: In case of gp_seq overflow,
> +                       // it is possible for rdp->gp_seq to be less than
> +                       // krcp->last_gp_seq even though a GP might be over. In
> +                       // this rare case, we would just have one extra GP.
> +                       if (krcp->last_gp_seq &&
> +                           rcu_seq_completed_gp(krcp->last_gp_seq, krcp->rdp->gp_seq)) {
> +                               queue_work(system_wq, &krwp->rcu_work.work);
> +                       } else {
> +                               queue_rcu_work(system_wq, &krwp->rcu_work);
> +                       }
>                 }
>         }
>
> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
>         for_each_possible_cpu(cpu) {
>                 struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>
> +               krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> +               krcp->last_gp_seq = 0;
>                 for (i = 0; i < KFREE_N_BATCHES; i++) {
>                         INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>                         krcp->krw_arr[i].krcp = krcp;
> --
> 2.38.1.273.g43a17bfeac-goog
>
