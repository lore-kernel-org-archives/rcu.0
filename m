Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF191C4332F
	for <rcu@archiver.kernel.org>; Tue,  7 Nov 2023 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjKGP0M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Nov 2023 10:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjKGPZ6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Nov 2023 10:25:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006B19AD
        for <rcu@vger.kernel.org>; Tue,  7 Nov 2023 07:19:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso7297923a12.1
        for <rcu@vger.kernel.org>; Tue, 07 Nov 2023 07:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699370381; x=1699975181; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUQ7zaVTAL9ODcOX3aIqq8of7HLt5g3GUMKTwpQi1rk=;
        b=U7mRXPZ5MEX1zNW5dCC2pC5tMausbDFWPVS/duCZakTPsphTKZr9GLiSc2R0XXTFbF
         7Ng7brPg5oXc/gm8REZwV3qTbbPTC3p/Jq1R4uqp4qRV1iDNzsvBEMOUKXUPNm+c6FQZ
         o+ynQsLR7LCKNdiZYfJzcFiJQUceOFbRDvIVWVlf0L2jurbLzRDM17BGtnr2DEE3DnmC
         HJp3nxU8HIF3oEM8drpTZtk95v1UfPGAAMyO58TCehin5L1zO+AtluQu6pChw+q/U+Hu
         moqvgAOrKrxDgUhw4J8rYI5nGrVSgUmVzfRNq5rDvi2BuxO5lq+wY5ypiGHZbeUqA/0n
         cIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370381; x=1699975181;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUQ7zaVTAL9ODcOX3aIqq8of7HLt5g3GUMKTwpQi1rk=;
        b=WfrV7Amgj5/b2ABgxvpgXb9hSKDcOeLSGPDL2dQhI6UDzcThlCkyzLIpfzODIoxoMi
         n4dNY1pw988F+4P9Khc4Xvh8Xn/gxrCoRKdg/s1sCjUMvxkaXUcnJP/ML8ccHrOuesXu
         mxEFNgy+CbMjMYu81U/1i+tDQmqnRT10/qnjObNCURDy8K/bQCPGUACJGifS+1Q1uquY
         e7eP9TfYN0AJAOIPFYfqfDDegmoLeZhxlm9yRRBWMsUtKcR/zcMiMibu9j+xXyIEhzIJ
         lB5H6/Yytv9CeBQLmzWDP/Pa4bazjlGnJi5KPaf8I6019N8P5mzsf0MbqtStwvipWVxg
         l++A==
X-Gm-Message-State: AOJu0YzpGsgmVcZVAajmJPFFr+MQEkb7wD0+YZlmN1Z6R+HXxT/NCXAD
        13uA+wERlefUIcd4pYdaARASHneHTrZyIIslFSfRcKgy
X-Google-Smtp-Source: AGHT+IHJIJi18yl/uya2scqNtYUCyP4H8IJCmaV3eT5wfENTfqDl/R+5ieh21F411yRLoe0RFWJOxw==
X-Received: by 2002:a17:906:4fd0:b0:9a5:874a:9745 with SMTP id i16-20020a1709064fd000b009a5874a9745mr18208242ejw.26.1699370381197;
        Tue, 07 Nov 2023 07:19:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906410f00b009b957d5237asm1146237ejk.80.2023.11.07.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:19:41 -0800 (PST)
Date:   Tue, 7 Nov 2023 18:19:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Subject: [bug report] rcu: Restrict access to RCU CPU stall notifiers
Message-ID: <5da8a140-8988-43e6-a2c9-31534b90ec01@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul E. McKenney,

The patch 7939f0d7b28c: "rcu: Restrict access to RCU CPU stall
notifiers" from Nov 1, 2023 (linux-next), leads to the following
Smatch static checker warning:

	kernel/rcu/rcutorture.c:2502 rcu_torture_stall()
	error: uninitialized symbol 'ret'.

kernel/rcu/rcutorture.c
    2446 static int rcu_torture_stall(void *args)
    2447 {
    2448         int idx;
    2449         int ret;
    2450         unsigned long stop_at;
    2451 
    2452         VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
    2453         if (rcu_cpu_stall_notifiers) {
    2454                 ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
    2455                 if (ret)
    2456                         pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
    2457                                 __func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");

ret is only initialized if rcu_cpu_stall_notifiers is true.

    2458         }
    2459         if (stall_cpu_holdoff > 0) {
    2460                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
    2461                 schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
    2462                 VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
    2463         }
    2464         if (!kthread_should_stop() && stall_gp_kthread > 0) {
    2465                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin GP stall");
    2466                 rcu_gp_set_torture_wait(stall_gp_kthread * HZ);
    2467                 for (idx = 0; idx < stall_gp_kthread + 2; idx++) {
    2468                         if (kthread_should_stop())
    2469                                 break;
    2470                         schedule_timeout_uninterruptible(HZ);
    2471                 }
    2472         }
    2473         if (!kthread_should_stop() && stall_cpu > 0) {
    2474                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin CPU stall");
    2475                 stop_at = ktime_get_seconds() + stall_cpu;
    2476                 /* RCU CPU stall is expected behavior in following code. */
    2477                 idx = cur_ops->readlock();
    2478                 if (stall_cpu_irqsoff)
    2479                         local_irq_disable();
    2480                 else if (!stall_cpu_block)
    2481                         preempt_disable();
    2482                 pr_alert("%s start on CPU %d.\n",
    2483                           __func__, raw_smp_processor_id());
    2484                 while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
    2485                                     stop_at))
    2486                         if (stall_cpu_block) {
    2487 #ifdef CONFIG_PREEMPTION
    2488                                 preempt_schedule();
    2489 #else
    2490                                 schedule_timeout_uninterruptible(HZ);
    2491 #endif
    2492                         } else if (stall_no_softlockup) {
    2493                                 touch_softlockup_watchdog();
    2494                         }
    2495                 if (stall_cpu_irqsoff)
    2496                         local_irq_enable();
    2497                 else if (!stall_cpu_block)
    2498                         preempt_enable();
    2499                 cur_ops->readunlock(idx);
    2500         }
    2501         pr_alert("%s end.\n", __func__);
--> 2502         if (!ret) {

Uninitialized here

    2503                 if (rcu_cpu_stall_notifiers) {

But maybe we can just reverse the tests or delete one of the conditions?

    2504                         ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
    2505                         if (ret)
    2506                                 pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
    2507                 }
    2508         }
    2509         torture_shutdown_absorb("rcu_torture_stall");
    2510         while (!kthread_should_stop())
    2511                 schedule_timeout_interruptible(10 * HZ);
    2512         return 0;
    2513 }

regards,
dan carpenter
