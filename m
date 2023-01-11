Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3160C46467
	for <rcu@archiver.kernel.org>; Wed, 11 Jan 2023 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAKOoF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Jan 2023 09:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjAKOnv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Jan 2023 09:43:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8B2D1
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 06:43:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so23824742lfb.13
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ZUfxLtIiOnVrvMcb+ThhoaPRzZmZBsJui0v7FIoz5M=;
        b=RHv3FypXIhYMmqsD5JIcUeN9uT11r7gFT+QEXTRsM5aCk/6yVnxqqqZ4jqvi66a5IQ
         GbJ8Rp+gFgDLVfdTDj4MEP41JLwAukQxQvC158Z6FpAeDHxV6m8AtcJIwRGisMYZEUTz
         k75g+VtNFCD2PQOj57NGzY+1PIbNJYz66XozY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZUfxLtIiOnVrvMcb+ThhoaPRzZmZBsJui0v7FIoz5M=;
        b=Y6SLmqNMyvhnDpBkGzd+wz3eXgyzO3DE6pespi/Hg0tSXXHelS9FU4VMxpWntTKcq1
         3XLV6nVh847Vbyh84WbA6YK50Vy2yJdWmqlKQYhTdmetEd6iMr3epWoNgNOy83AVduyT
         tn7F2rdDJ5YsYXTQ8OGeeh91rhbCLNHgzntcs8xXHpAekmauwplnUJLfV/u0ZOA5V2bD
         A/itSQrzOsqP3jQ5J5GmjEH/icPHHNi8WqL0y0fRh8dSvUwIRWKA3nQmioAhp6SDAlSz
         EDrhdZNZaXX/faMO2S/CYG7Fwq3dMHqwWj/Yk24djhdwMv9/O3KPzamqNOU250Vj3Aat
         SKRw==
X-Gm-Message-State: AFqh2krgfzSb3l9NLq4YDAxAf6jspBxKX6Zaoq8XAc8kFaqfG9jWK0Kc
        1ngcL1OiWvCmJHdg0rme0+77M1IgBZfkiLb0Ec+dog==
X-Google-Smtp-Source: AMrXdXtc0yiR0uWurfegKHD7ZovezSP+0/6Bj8oAX7lK/sPBj9q8AJ7KjIWfMBWYJ/agnbAqJZG5eK3ydH33NZo5CIk=
X-Received: by 2002:a19:f607:0:b0:4cc:598c:41bd with SMTP id
 x7-20020a19f607000000b004cc598c41bdmr1033221lfe.468.1673448227877; Wed, 11
 Jan 2023 06:43:47 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Jan 2023 14:43:36 +0000
Message-ID: <CAEXW_YRfDB8Pqf1ppagF=s-Ks=2DBYb=iVtdHdFSz+F36weBqg@mail.gmail.com>
Subject: LSFMMBPF proposal [General/MM]: SRCU: a case study in memory ordering
To:     lsf-pc@lists.linux-foundation.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-mm <linux-mm@kvack.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Title: SRCU: a case study in memory ordering

Description:
Memory ordering guarantees are the backbone of SRCU, an important RCU
synchronization mechanism in the kernel. Can we use the Linux kernel
memory model to understand complex concurrent code better?

In this talk, we will go over:
- SRCU internals overview and why it works
- Discuss in detail, all the 8 or so memory barriers in SRCU and why
they are needed.
- Comparable access patterns to each barrier (LB, MP etc)
- Linux kernel memory model (LKMM) experiments on studying effects of
each memory barrier, along with execution candidate graphs generated
by herd7.
- Possible formal methods / models.
- Discuss both correctness and forward progress issues tackled by
these memory barriers.

(Resending as my previous email got messed up by mail client, thanks).

- Joel
