Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AFFC3DA7D
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 23:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiLaXKv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 18:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiLaXKu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 18:10:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A972C7
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 15:10:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so36721116lfb.1
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOW3tt/2SsOpKZK2d/vDrt1RGpWtKJ4l1BkGt0vJpcc=;
        b=lcp++zvjuO9FLDk3y04zGkPba5NflUQWhUHzptssvwerEGEqvEhp6BCdTXkiJFEujt
         Y/a9JbOJtlhEQl8VlyvVecbeNf0Ujni/8kzn1mfVurE5zSoJoJmg+WRaV7l2M+4mY5HY
         5SeEQWDFadsIQGX6qaVhBb3/xCBXPQJtk2uVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOW3tt/2SsOpKZK2d/vDrt1RGpWtKJ4l1BkGt0vJpcc=;
        b=PHGveVcl2RsNF08Zagn6yAPJtQwGf+m5FgqelEfBpknOwddJP/tT4ndWFehAOi8V8Y
         xp34XL4vWSuDiQWQv35iqtNhIava/BDZnxHLCPSorZUkfo3to9i7DP0pi9ISKD3//lW8
         hxZZ7HXyI6JKlC8tdHAyuwYptLcP3BSTLUuXUY6DZbO18dzheyXNGF9zOwBa/gTrOaoQ
         2LMtw3ERjfAn4fdb8bI/R1/8mkhQT9AXMterHUETIUaac0RU+0EFdzg3yqxmfPrw8Abo
         0e2VkbFEGcilRuRbf5UU2TOCRuQ5Ts3f42nRFsyYU8bjz5goRIs7VXHcBPCh6vFRr7Kc
         +qcQ==
X-Gm-Message-State: AFqh2kpWQAl93l1/az7DBPTMMg9s2loxtbuTyaW9gms57QBgiYrDKZkn
        2qIKN+IiEU6n7SoXHvyMWP6a8Qd0TOgG1VVUeiQXgA==
X-Google-Smtp-Source: AMrXdXvVhPlj+0X1qR+PXI54Mu40t+gMN0SY9NhSP4U88rj6FxhGp6Y1We8JywEQn7baoQ5Y+fSTuewcSsbu2ADNH5Y=
X-Received: by 2002:ac2:5985:0:b0:4ca:fa1b:ebc7 with SMTP id
 w5-20020ac25985000000b004cafa1bebc7mr1101323lfn.169.1672528246659; Sat, 31
 Dec 2022 15:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
 <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT9dAUc69igExbL0OC4C_Re58uvQ=oa3s2CQZ_xbefMQQ@mail.gmail.com>
In-Reply-To: <CAEXW_YT9dAUc69igExbL0OC4C_Re58uvQ=oa3s2CQZ_xbefMQQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 18:10:40 -0500
Message-ID: <CAEXW_YTwH-XyxWq3gNRo-xBxPEH-gYLjQt+aGp81TFGwuYsGtA@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 4:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sat, Dec 31, 2022 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > Hmmm...  Some of the tasks run at relatively high priority.  Maybe they
> > need to de-prioritize themselves before looping waiting to be stopped.
> > These loops look like this:
> >
> >         while (!kthread_should_stop()) {
> >                 torture_shutdown_absorb("rcu_torture_boost");
> >                 schedule_timeout_uninterruptible(1);
> >         }
>
> Yes, it appears this tight loop is live locked with the timer softirq.
> I am trying a run with higher timeout to see if it helps.
>
> >
> > Or it might be something else...
>
> I see that kthread_should_stop() returns false, but
> torture_must_stop_irq() returns true in the tight while loop mentioned
> above. So it seems like the shutdown notifier triggered first. I am
> seeing various "is stopping" messages. However I see no "End-test"
> messages, which means I think the torture_shutdown_hook() never ran
> properly, or something. Anyway now I am doing heavy tracing in
> rcu_torture_cleanup() to see what it is upto. My suspicion is it did
> not even call torture_stop_kthread() and we are stuck without the
> kthreads being stopped.

Now all tests pass always if I do the following change in torture_stopping():

- schedule_timeout_uninterruptible(1);
+ schedule_timeout_uninterruptible(50);

Current theory is, the timer softirq preempts the cleanup thread
before it can call kthread_stop().

Anyway, let me know if this is an acceptable change (or not). I think
checking for shutdown state 20 times per seconds instead of 1000 times
per second is kind of reasonable.

thanks,

 - Joel
