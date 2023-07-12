Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE85BEB64DA
	for <rcu@archiver.kernel.org>; Wed, 12 Jul 2023 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjGLVVR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGLVVP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Jul 2023 17:21:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F432100
        for <rcu@vger.kernel.org>; Wed, 12 Jul 2023 14:21:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso76819175e9.1
        for <rcu@vger.kernel.org>; Wed, 12 Jul 2023 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689196868; x=1691788868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
        b=riVOxBRsNlbit4Y503zwT+PkVQPKGT/R2DE0Ewx9khEJPZrhlAKOZKDrQOUSfw1Cpd
         FjziADc8hAjUgHBvF3g18IW0jau1z9D/EJxtH9rWZiJVC3mL7PVmHS+GKfsIY8OQO8RW
         sQt9fkLpMyKgk8utotrNJjM84rCa0Zz8GcEqKhFTJPIlKgoLY09856Cu4Y7288qQZils
         nCWHVmCPjm2nzvydu5jBuaZB9oL1tuEP+i0FqezV9AwoYDoElW1VogVbj2cZZvb6Rq/C
         TozA28S0bwWVhE8m5Qx4F9rhIHR+Amb8eas94sO7h08yeNW10vPOZQ9cENTT9C07EOWm
         rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196868; x=1691788868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
        b=HCnYManDsaoqxYD/inMwEsI3vi7aXMtuAiKqO7MR4KiNo2eGdz01gFjwNYoc1aEGbq
         21Z8cGvvVK5ILVzwr2iwcjrkCMi3LXeSpzXY0rUEVVoZlkRoKarsk7C/FacXB/OZjFDj
         VLBp8SM2hydH81ZEeYkyx/VkvvOOY7Qr8NCJRvEaAUqE9TQhD0B3N+zxwvzaOTK35hOp
         /OS4kSJ+WUoZlgFvcKMJ9F939hWuMsUkdIYVbbDylLQzYIs/vETRkLboO06INmffn3QM
         IH7Mt7lSEFUCYOI4JXh49nJmS8IAgU+u/V46Zqo1KsBTsjp+0Wfu5oxRlJlRsLGIYRej
         YEQg==
X-Gm-Message-State: ABy/qLa+ct4ZTSaEV7FIw4J59vha+w3oDBAc1AllJ7JSrPyQiRdD0dlT
        cMs7hBuBaxYoXk4f9ZdepnHKcqOp340cQHjkx8ZBTQ==
X-Google-Smtp-Source: APBJJlF02gY8bEC0+lYROMVW41NJjfAkJDC91HvoX0ewa2c+XazwQOw0ZGwvXcadoBMYjI5IXT+IOvbvZzU0knL3QpU=
X-Received: by 2002:a05:600c:2295:b0:3f8:facf:7626 with SMTP id
 21-20020a05600c229500b003f8facf7626mr17690397wmf.20.1689196867941; Wed, 12
 Jul 2023 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com> <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
In-Reply-To: <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Wed, 12 Jul 2023 14:20:56 -0700
Message-ID: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joel,
Thank you for the review!
> Actually even the original code is incorrect (the lockdep version)
> since preemptible() cannot be relied upon if CONFIG_PREEMPT_COUNT is
> not set. However, that's debug code. In this case, it is a real
> user (the fs code). In non-preemptible kernels, we are always in an
> RCU-sched section. So you can't really see if anyone called your code
> under rcu_read_lock(). The rcu_read_lock/unlock() would be getting
> NOOPed. In such a kernel, it will always tell your code it is in an
> RCU reader. That's not ideal for that erofs code?
>
> Also, per that erofs code:
>         /* Use (kthread_)work and sync decompression for atomic contexts only */
>         if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
>
> I guess you are also assuming that rcu_read_lock_any_held() tells you
> something about atomicity but strictly speaking, it doesn't because
> preemptible RCU readers are preemptible. You can't block but
> preemption is possible so it is not "atomic". Maybe you meant "cannot
> block"?
>
Yes, you are correct. For decompression erofs needs to grab pcluster mutex lock,
erofs wants to know if we can or cannot block to decide sync vs async
decompression.

Good point about !CONFIG_PREEMPT_COUNT. Yes, in that case erofs
will always do async decompression which is less than ideal. Maybe
erofs check can be modified to account for !CONFIG_PREEMPT_COUNT.

> As such this patch looks correct to me, one thing I noticed is that
> you can check rcu_is_watching() like the lockdep-enabled code does.
> That will tell you also if a reader-section is possible because in
> extended-quiescent-states, RCU readers should be non-existent or
> that's a bug.
>
Please correct me if I am wrong, reading from the comment in
kernel/rcu/update.c rcu_read_lock_held_common()
..
  * The reason for this is that RCU ignores CPUs that are
 * in such a section, considering these as in extended quiescent state,
 * so such a CPU is effectively never in an RCU read-side critical section
 * regardless of what RCU primitives it invokes.

It seems rcu will treat this as lock not held rather than a fact that
lock is not held. Is my understanding correct?
The reason I chose not to consult rcu_is_watching() in this version
is because check "sleeping function called from invalid context"
will still get triggered (please see kernel/sched/core.c __might_resched())
as it does not consult rcu_is_watching() instead looks at
rcu_preempt_depth() which will be non-zero if rcu_read_lock()
was called (only when CONFIG_PREEMPT_RCU is enabled).

> Could you also verify that this patch does not cause bloating of the
> kernel if lockdep is disabled?
>
Sure, I will do the comparison and send the details.

Thanks,
Sandeep.

> thanks,
>
>  - Joel
