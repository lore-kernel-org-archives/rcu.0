Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DBC4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 01:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiLaBm1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 20:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiLaBm0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 20:42:26 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE0E0FD
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 17:42:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e13so21060197ljn.0
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvu5rK255mNjHpR8OA2QmBKKNteL/lda4a09qaxqAIs=;
        b=WbxA8oCfzl+Nh4hDbaDwiWKdCEDXlNIpZC+LBQfkIFUIerknwQfYjzBkGHtjdgua7E
         GozyU9w9Yd+22Hz55XVdc9Kph46CCiZ+UPyCEdf5OYN03P2pJ4/hIIsxxzmsSsLqQeTf
         HlNFnmGEruJ0rba6XvlR1yIMW68y8+IalI7Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvu5rK255mNjHpR8OA2QmBKKNteL/lda4a09qaxqAIs=;
        b=btC51NyMyAtE2J6wPTk6uPvu/NWc82n6sfdG+DAqAdiWZ17n7DzP/EDeVxhug6qYvP
         /lablhs5UbvTE0VBEmUF9pf5B0FJDNkQfbmOOvfBo3ueX3zW3uFxCyJ8L1CVU4hFgydj
         mSlbM5Ywg6Wlak/UHvrSfdFKHoaCkJO2UjJ0YOh03r9Xex4rscZkE0WuEkc6r1n5HAbg
         NevSH9/ZdCj+9velrAcSFB61hoV/EBnOqcHn4O1C5R2wkSRIDY+ou2dhhPo82M+XPB4Y
         wmzwk80IL20RiMtLreFgYUr+vBCB59prTTR4XreFVmMT5Z9J0S73yrmVpIdFxnZTMDXz
         q4uw==
X-Gm-Message-State: AFqh2kpWfIC+LyIJt/SUH2aBl5LPhwV2MkEIRgG4fdCAiaLZJ5GkXpUg
        IS4dVWrVPpTD85vPSy1XNoTFcf4bBudbm8C6BFiAl4J8ofEmn9PAlWY=
X-Google-Smtp-Source: AMrXdXs1IPw5lolMqqsKOo+WHQX6BEI08axReuQEnMkkz3ufOYVvIPQApLmdiX8aGMchH4OlsdHRqUgCkRi5EM1ZCMg=
X-Received: by 2002:a2e:3215:0:b0:27f:b98c:7a0e with SMTP id
 y21-20020a2e3215000000b0027fb98c7a0emr1757969ljy.356.1672450943405; Fri, 30
 Dec 2022 17:42:23 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Dec 2022 20:42:24 -0500
Message-ID: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
Subject: RCU stalls with TREE07 on v6.0 kernel
To:     rcu <rcu@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

I have been firefighting a hang on 6.0.y stable kernels with
rcutorture. It happens mostly consistently when TREE07 is shutting
down.

It appears that the RCU torture threads are attempted to stop but the
shutdown thread, but are constantly awakened by a timer softirq
handler in ksoftirqd context. When they wake up, they immediately goto
sleep in uninterruptible state until the next time a timer handler
wakes them up. It appears the timer softirq is long enough to cause
RCU stalls and I see it calling 100s of timer function handlers
(call_timer_fn).

I am doing some more investigation with trace_printk(s):
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b

Regarding the timer handlers, I was wondering if it is possible that a
large number of timer handlers constantly queued can cause RCU stalls
due to the timer softirq taking a very long time. That certainly
appears to be the case here. Shouldn't the timer softirq also do
rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
many of them?

Here is a full log with trace dump if you anyone wants to take a look:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
And the res directory:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/

Any thoughts on any patches 6.0 might be missing?

Meanwhile, debug here continues... thanks,

 - Joel
