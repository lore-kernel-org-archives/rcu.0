Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF25C433FE
	for <rcu@archiver.kernel.org>; Sat, 29 Oct 2022 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2Nb0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Oct 2022 09:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2NbZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Oct 2022 09:31:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5703DBDF
        for <rcu@vger.kernel.org>; Sat, 29 Oct 2022 06:31:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v27so11611961eda.1
        for <rcu@vger.kernel.org>; Sat, 29 Oct 2022 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2c4zOpFPU7Fj7fSnkokCJ5cgtQZamEl4/ckihkqxdg=;
        b=guOF+KRUfO2jIMkNmcsWZt0V1qSdphz/s+ep6QkB4OmTkjf9xRsz59bI20Q0juOQEd
         SD2kcYJ3gchvzgQyADVeu5u5c6UbZf0WXIpYK3blhMRTyiSGIko4GFYfYZl8wrGw2afv
         M44AoSeWZXJ7fQx8wp1FxcsK4hxaEGqcZrGZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2c4zOpFPU7Fj7fSnkokCJ5cgtQZamEl4/ckihkqxdg=;
        b=yNGV0CwA21ePcimmlSpEJEnLIWvqtIEkUnCECu0p5QnIscU72JApk5JVHG7nsqdnY+
         qo3/N1GRBkje6UfGI9eDO2nSkc4ZfdOUOpu/E9oEZlUrwnieawtejr9vM5ybQlzwARUF
         tvUD+wc9GddRmOb8kDfu08OAEH4CqK1oNe3ywI8uVjJ3tKV9D6zdRmgN/7gKgdzZI2Xz
         1zNNT+1w1kYkgcwutG4s0eXqyTJTne4Xu7GBkeOU4v3JuDG6dEgjUQf99fRmkw8xIJkA
         Ra5JoM0eHjkVDq1i/bxph9vMplxRW5Fk1ZczwtH7kV9meDkYSkXPqPEdfJbdDWnkduz0
         4XxQ==
X-Gm-Message-State: ACrzQf1Yz/MPEfNz5S6Odo8HD1Ylo0CrosraPWRnkMBcNxBWIKBvEv2R
        pHtAdzOdmVtJ9WvG/1q+NRUldrJ2ACPjD5pisE8paBmIF4w=
X-Google-Smtp-Source: AMsMyM5O6N8LOAdxsWmcrYQ/8JYKcf9D+mw6ft1pvLqxKo3lCrzd6MBsvGoRIu/QG/L/J5WBH32qeG3UJ4KVpLeC3SQ=
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id
 es6-20020a056402380600b00450bad88cd5mr4479230edb.305.1667050282944; Sat, 29
 Oct 2022 06:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org>
In-Reply-To: <20221029132856.3752018-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 29 Oct 2022 09:31:12 -0400
Message-ID: <CAEXW_YRbi5yhVnVXunM0MrxJbFLaM9OtoT=8gw7hkm+r2+D_FA@mail.gmail.com>
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

Yuck. I forgot to add last_gp_seq to the comments. Will await feedback
before re-spin.

 - Joel


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
