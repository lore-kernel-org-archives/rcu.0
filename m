Return-Path: <SRS0=fEXk=3O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C5C2D0DB
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD3520716
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAYVlO convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Sat, 25 Jan 2020 16:41:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAYVlN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Jan 2020 16:41:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so6297639wrj.12
        for <rcu@vger.kernel.org>; Sat, 25 Jan 2020 13:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4Jsw+sl3rZeed96mR3AsM5sE56n8KXiFC5Ae1nN2OVo=;
        b=ng40OcniCX27gzMhbwnTdbxYJJ5VHciF4lOySNLpbK/3t3IzakY3nF0nzR+wljcKBT
         Vpmm8HqB+nc8wlQlD08MQa3/lPMhivc57fBdi5Rev7ZJZ8QjcN8rv2wy4O7w1T6BMb9v
         h96fqRLB3aAGzZ4Owha+BTy6yzHLOggu//H2rxbDYm6dKmuwHwpZnNj5F6ZFkGo480W3
         7wpXKv+SF1bM+l0HiEhd/I0tzfwOh3TqUP3NPD74QpXYSPiyrjgx4gH9zzbscCP1EoK8
         +p7aK07BPaIR2RGPIhrRqxYANXYVwihm364gxPhVTdFtdtLyWHG1vAakUlAo0uifGN3Q
         9gow==
X-Gm-Message-State: APjAAAXorCkJ6q3HyHqsRptHzStLz1P53Fe4PIq+LgilRSp880qDBr6n
        8AgOMxjgAU1wbRShq7ITjxsguw==
X-Google-Smtp-Source: APXvYqzTlqw+XUJ74D6yIeyAQeh7UV2lyORpCkFnwkDDWbE38nkVreN+6thxGMbX5/U37+CUG7Hiiw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr11369912wrl.190.1579988471090;
        Sat, 25 Jan 2020 13:41:11 -0800 (PST)
Received: from ?IPv6:2a00:20:4003:d1ed:ce46:92a4:be2:c2c2? ([2a00:20:4003:d1ed:ce46:92a4:be2:c2c2])
        by smtp.gmail.com with ESMTPSA id g79sm11149436wme.17.2020.01.25.13.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 13:41:10 -0800 (PST)
Date:   Sat, 25 Jan 2020 22:41:06 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
To:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com, oleg@redhat.com,
        paulmck@kernel.org
CC:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On January 24, 2020 5:59:08 AM GMT+01:00, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>This patch fixes the following sparse errors by annotating the
>sighand_struct with __rcu
>
>kernel/fork.c:1511:9: error: incompatible types in comparison
>expression
>kernel/exit.c:100:19: error: incompatible types in comparison
>expression
>kernel/signal.c:1370:27: error: incompatible types in comparison
>expression
>
>This fix introduces the following sparse error in signal.c due to
>checking the sighand pointer without rcu primitives:
>
>kernel/signal.c:1386:21: error: incompatible types in comparison
>expression
>
>This new sparse error is also fixed in this patch.
>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>---
> include/linux/sched.h | 2 +-
> kernel/signal.c       | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/sched.h b/include/linux/sched.h
>index b511e178a89f..7a351360ad54 100644
>--- a/include/linux/sched.h
>+++ b/include/linux/sched.h
>@@ -918,7 +918,7 @@ struct task_struct {
> 
> 	/* Signal handlers: */
> 	struct signal_struct		*signal;
>-	struct sighand_struct		*sighand;
>+	struct sighand_struct __rcu		*sighand;
> 	sigset_t			blocked;
> 	sigset_t			real_blocked;
> 	/* Restored if set_restore_sigmask() was used: */
>diff --git a/kernel/signal.c b/kernel/signal.c
>index bcd46f547db3..9ad8dea93dbb 100644
>--- a/kernel/signal.c
>+++ b/kernel/signal.c
>@@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct
>task_struct *tsk,
> 		 * must see ->sighand == NULL.
> 		 */
> 		spin_lock_irqsave(&sighand->siglock, *flags);
>-		if (likely(sighand == tsk->sighand))
>+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> 			break;
> 		spin_unlock_irqrestore(&sighand->siglock, *flags);
> 	}

If Paul is happy with this and nobody wants to take it I'll pick this up.

Thanks!
Christian
