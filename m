Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E23ADB8F
	for <rcu@vger.kernel.org>; Thu, 14 May 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765606; cv=pass; b=asGFZgX/+RrjTCmz2UKlLaJx1QD8LGyaZ3SK+wWou+rrf9atR97RP8dX+E2IIxNyxmnBQNBnABuU5+BKo3qYmSiZKqgzwaCUt7+iG7KtcYgxs65zFAz0pM/ncCO+H3VcLEcvGx6V6oyFlFs0hy4PIX5fwb6v9Pfk+umX80D0RH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765606; c=relaxed/simple;
	bh=44S4IoVPLsIUunAXYYG8t+brQYZpYLHMTF00NpFotwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaRI92kACfmxGCGDJkKjNBc4zz4gOySV6A1OtYR9EOaxyqDi0eOoSD+DtfWo+HUYt3cUrA7KqzEZkbHj4mIyFU1uHNE1dR631ANVWIROBGW+MqkRto9DEXpWbwGcu8PrzFrEpn7P439W/eiCTI75pUQJR+roTqoqhkED3rwg0nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqqMGlx1; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqqMGlx1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba6485d219so52101565ad.3
        for <rcu@vger.kernel.org>; Thu, 14 May 2026 06:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778765602; cv=none;
        d=google.com; s=arc-20240605;
        b=WmkTAPY9/baF/mKn1FZz5YGPLwpMTgN+In51MGlG7+/TbYdSNBJwMG2S64AxcLRPQq
         qTu3QSS9M6KartRbTYR6ofvHwxAZHYj0Dm6rReoTNZyxAarvNBDmmYcLL2GkfOyo+uFm
         Zm/DHAlqhoxO7FTdTROxUSfQ+LPXVGge7KUEu10tRl+L9wuP5VefDnceJ4TPAJodaWJi
         GpxjcWYcUwnR4A4xu2csTMFC4LbTTAKZWpKW/YRBuSi4H10jQA8gG0XE1THGFCJVLmRN
         ilyGEjaMatIpJv9JizGMF6nCLA9scb60qCsA7qzkknGaNDfxg/hGlgqF2d0RS1kL7BbT
         ELGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1Xb4KJn83sRk5SX5DeqTxmiYllC5qz53j/utt/Wowhw=;
        fh=JO+K+/tQeHRYrZQ5vF6SY428u8/+wRtMVf2NRRzke3g=;
        b=FW+vZOsLegRHywVUZI07aNaWkbIPtKlO0s777X5g+T0IdAU/swHjB7Ekt+1dpvqECk
         iTJJB4ZEBaoHwuhwMRihmpR6TDS6u0gHPaVSwocW2qJeTRM+tbGtDGUBuMCFp+fZfHwG
         LlUrJz5oqPQmb/fkySlY/dXP2eJLYnNp0X9ZdhqOHCSgUZkltKPYVQPprmHykA5c1XYH
         lpnMxxoClyWppozzmcTFiyFiePndAXU9x2/W8HQCn0ucAMl9DfBzKrJDk343xVnBqiRb
         RsRuJ+4+U73m+K03+NN0j+wRHecWrKRXoshysMKb3sPatpmRCbanhKcp4KbJAsiQlT7h
         KPug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778765602; x=1779370402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xb4KJn83sRk5SX5DeqTxmiYllC5qz53j/utt/Wowhw=;
        b=PqqMGlx1JK67XA+fcbU+MZBFylMQd8xtrmFw6ndIic+OEfxIvAblHEo+bCfuZoTqEC
         5wNsWrT1PWR5Iggi9zsQiJynHNSU/Q/PLkzUBs8PrEc+zb/jQlmYGLxUh6yT1EyhrS/w
         QSM2dw6wyT45YvkYY4POxZNJtqmhbC8kcXEkV6LfOxHi7k9/Ez2giqaO07yKlN1smbVu
         HMA69Ovpe1xP9eIeT+1PdqaXBvajTE/68PoWCoVV37Pqc8VNCUCE8ZFHeM5V73/awuyB
         jIohij4u+dgu/pFMnNT4MDDJBlZHuu38WaQPmBjkcwxq9++grnv6//H1lGuH0uamEU3Y
         wC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765602; x=1779370402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xb4KJn83sRk5SX5DeqTxmiYllC5qz53j/utt/Wowhw=;
        b=Q2nCkBjs+rT2YGtNUxWgM0s8KtTE7xnCVfqvP4jX4olfju72R39t29SbGDoOKLo8F0
         1Eu0WSs3mObMcEtzH4DfXeE5lmc/ApKl18NKT0Vk6vKLLVvru/m8EQrwnOCrW41hR/mY
         p4BLXAL5dU/CQOVVYwylExam22rrhOQe4zs0Ce6Tqdn90W78kbk6otykYh85FiROULnR
         4jBzj/LKuL/sevBpj8O9m328il8mTMEdzdITAXCioUW6Zq4cMwL/o29XmdlGjAH//Nhl
         8xBicrQVzI5czTLv14US47zv5xyQi5mRrXTvae8dztCZTWPNFXx5qIkIJNrVnYVRtKpg
         We6A==
X-Forwarded-Encrypted: i=1; AFNElJ/nXtwiPLPRqawEfi5wkwc0Kol3dMfEbFPaFVcIzFrCyappkrPQpdTvqHIwbOWp8u0e9sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxF32M1IQKKyNyEgv0EF+x/3wAb1ktye7hQpodhl9l+murUpeb
	Lxbe3cPEw0qHEnrXbdnSHT2Z74ogdddA1fttR5H6bEIniM0r6DeQbeKvZQSLzKGmUPQY41DRH97
	qfyUsCIamXP8INB+V4hy/lR/t3H1zVjw=
X-Gm-Gg: Acq92OEHzPJRDyN/vXDzuaVJ3Aap8G5pYqiAzyZdeDoIsFMg07/lSd79mCdcc6P6aq2
	7Fi/XYIJ/sFsO3dEcnB5nyoCcWtoL2yz1plHW9yba+3yxOgCiNvU6rjicJBsf+8f04uK1uMC4d4
	hPDwYfHZa21Qrimgf7lJFfCEuhfeY+NIFMCXTk4pS6DE0W9uYDwud4tahFxMfJFpTkND2su1vd+
	oR+57ofl8ockULcJBSfG4IOv+0JeJpQz1V7mb8+sMpdM18rx8vqvumvVLHj43clhnjlSV2U25B2
	ixFRfS2Thz9WAjawS3fpEybMnQglvkJd9wq/JwiYGl2z7HRLY+lToVo=
X-Received: by 2002:a17:902:ebd2:b0:2bd:4d97:b5bb with SMTP id
 d9443c01a7336-2bd4d97b7e6mr52074505ad.12.1778765602088; Thu, 14 May 2026
 06:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511175448.153326-1-urezki@gmail.com> <20260511175448.153326-2-urezki@gmail.com>
In-Reply-To: <20260511175448.153326-2-urezki@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 14 May 2026 21:33:10 +0800
X-Gm-Features: AVHnY4IEHMH1ZnBVIrckozp-Hi97mxUwd4aDOs1tpgD--Cnw_BpcX7xQk1IizEE
Message-ID: <CALm+0cVY4izVdUDVdqVCfGgREMbHcyeDryYwYp_gsHevt4t8_w@mail.gmail.com>
Subject: Re: [PATCH -next v1 01/12] rcutorture: Fully test lazy RCU
To: "Paul E . McKenney" <paulmck@kernel.org>, qiang.zhang@linux.dev
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> could delay the start of an RCU grace period for a full stutter period,
> which defaults to only three seconds.
>
> This commit therefore reverts the call_rcu_hurry() instances
> back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> queues a workqueue handler just before the call to stutter_wait() in
> rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> which motivates any lingering lazy callbacks, thus avoiding the splat.
>
> Questions for review:
>
> 1.      Should we avoid queueing work for RCU implementations not
>         supporting lazy callbacks?

Hello, Paul

maybe we can do this:

rcu_ops = {
         ...
         .support_lazy = IS_ENABLED(CONFIG_RCU_LAZY),
};

and

if (cur_ops->support_lazy )
        queue_work(..., &lazy_work);

>
> 2.      Should we avoid queueing work in kernels built with
>         CONFIG_RCU_LAZY=y, but that were not booted with the
>         rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
>         this requires some ugliness to access this parameter, and must
>         also handle Tiny RCU.)
>
> 3.      Does the rcu_torture_ops structure need a ->call_hurry() field,
>         and if so, why?  If not, why not?
>
> 4.      Your additional questions here!
>
> Reported-by: Saravana Kannan <saravanak@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5f2848b828dc..91ba3160ba6a 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -572,7 +572,7 @@ static unsigned long rcu_no_completed(void)
>
>  static void rcu_torture_deferred_free(struct rcu_torture *p)
>  {
> -       call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
> +       call_rcu(&p->rtort_rcu, rcu_torture_cb);
>  }
>
>  static void rcu_sync_torture_init(void)
> @@ -619,7 +619,7 @@ static struct rcu_torture_ops rcu_ops = {
>         .poll_gp_state_exp      = poll_state_synchronize_rcu,
>         .cond_sync_exp          = cond_synchronize_rcu_expedited,
>         .cond_sync_exp_full     = cond_synchronize_rcu_expedited_full,
> -       .call                   = call_rcu_hurry,
> +       .call                   = call_rcu,
>         .cb_barrier             = rcu_barrier,
>         .fqs                    = rcu_force_quiescent_state,
>         .gp_kthread_dbg         = show_rcu_gp_kthreads,
> @@ -1145,7 +1145,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
>
>  static void synchronize_rcu_mult_test(void)
>  {
> -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
> +       synchronize_rcu_mult(call_rcu_tasks, call_rcu);
>  }
>
>  static struct rcu_torture_ops tasks_ops = {
> @@ -1631,6 +1631,17 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
>                 cpus_read_unlock();
>  }
>
> +/*
> + * Do an rcu_barrier() to motivate lazy callbacks during a stutter
> + * pause.  Without this, we can get false-positives rtort_pipe_count
> + * splats.
> + */
> +static void rcu_torture_writer_work(struct work_struct *work)
> +{
> +       if (cur_ops->cb_barrier)
> +               cur_ops->cb_barrier();
> +}
> +
>  /*
>   * RCU torture writer kthread.  Repeatedly substitutes a new structure
>   * for that pointed to by rcu_torture_current, freeing the old structure
> @@ -1651,6 +1662,7 @@ rcu_torture_writer(void *arg)
>         int i;
>         int idx;
>         unsigned long j;
> +       struct work_struct lazy_work;
>         int oldnice = task_nice(current);
>         struct rcu_gp_oldstate *rgo = NULL;
>         int rgo_size = 0;
> @@ -1667,6 +1679,7 @@ rcu_torture_writer(void *arg)
>                 stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
>                               HZ * (stall_cpu_repeat + 1);
>         VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> +       INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
>         if (!can_expedite)
>                 pr_alert("%s" TORTURE_FLAG
>                          " GP expediting controlled from boot/sysfs for %s.\n",
> @@ -1895,6 +1908,8 @@ rcu_torture_writer(void *arg)
>                                        !rcu_gp_is_normal();
>                 }
>                 rcu_torture_writer_state = RTWS_STUTTER;
> +               if (IS_ENABLED(CONFIG_RCU_LAZY))
> +                       queue_work(system_percpu_wq, &lazy_work);


When the task ends, the lazy_work should be cancel and destroy:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f593f8b794dd..5adf537ab410 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1682,7 +1682,6 @@ rcu_torture_writer(void *arg)
stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
HZ * (stall_cpu_repeat + 1);
VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
- INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
if (!can_expedite)
pr_alert("%s" TORTURE_FLAG
" GP expediting controlled from boot/sysfs for %s.\n",
@@ -1719,6 +1718,8 @@ rcu_torture_writer(void *arg)
pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
torture_type, jiffies - j);

+ INIT_WORK_ONSTACK(&lazy_work, rcu_torture_writer_work);
+
do {
rcu_torture_writer_state = RTWS_FIXED_DELAY;
torture_hrtimeout_us(500, 1000, &rand);
@@ -1943,6 +1944,9 @@ rcu_torture_writer(void *arg)
pr_alert("%s" TORTURE_FLAG
" Dynamic grace-period expediting was disabled.\n",
torture_type);
+ if (IS_ENABLED(CONFIG_RCU_LAZY))
+ cancel_work_sync(&lazy_work);
+ destroy_work_on_stack(&lazy_work);
kfree(ulo);
kfree(rgo);
rcu_torture_writer_state = RTWS_STOPPING;

Thanks
Zqiang


>                 stutter_waited = stutter_wait("rcu_torture_writer");
>                 if (stutter_waited &&
>                     !atomic_read(&rcu_fwd_cb_nodelay) &&
> --
> 2.47.3
>
>
