Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A733C433DF
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 00:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C62080D
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 00:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sUznsqUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgFQAYu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAYt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 20:24:49 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D7C061573
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 17:24:49 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x18so427198ilp.1
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=9t+OcUsAuFqxbOex792nZOgeMxXgWFpZ10m4KHTW/qM=;
        b=sUznsqUQoCIgeEeParAQPoxg6P5TXLIJfBXq3STx5HyTt7KX4TwgFzgpkwKvNt/UlS
         +b8yuSnOY2E5p1wWG5S+awWQQEjREaBymHh2YsQ3gH5TfgOme3fUo67XUUdc8Z52gaao
         C5D+mI40B6y0GKY31l9IT4KbRFZ5+pLztgvHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9t+OcUsAuFqxbOex792nZOgeMxXgWFpZ10m4KHTW/qM=;
        b=ONfZPXjKEa6SG5V71hUZJ7uckGupbE8bc1MDlqdkPoWwhITbdxKjVfuKNhbpkaONEC
         cPv0s+laa5H7dNudNy6jsUjIXLy7DQCdZS9+Y7MDwxzDIwEslD67dAPNCMqKPp9XFn2Q
         IYeiOX34QdeAJU7qINLDPzXQNqIDYA33eX0+eoYJnQGFpthcSiPrDlG2vurcwQVgtdL7
         8xik+kfMtIFHC3DWdSU/bba7vle/kiiJPkDt1Hxv0eEWsZ1O5vxqEbXoRV3ScODqsbf6
         v5M4JfCAGP+hoxyayceGCyuPhFns2j5LUDlkhPD9rUoEXEHzKd4YFjj7Kaam6AuVdbhA
         0OUw==
X-Gm-Message-State: AOAM530Y1ereb7H066wdOEf2eFswFfa3DTB1KXRrt/6bdCdMkYnfD99I
        mTFgjVEnX1aNEDvVVxxmAMi9LomdVlBIDl1Vr/jzqeOQGMw=
X-Google-Smtp-Source: ABdhPJy95t3jSo+EgvKKXU1GPJe34/UTQHMSON9ypMWvHqtydWuFxpSzR6ypsQj9O+mF/tLyX2pE71COvKm0sX7HkTo=
X-Received: by 2002:a05:6e02:12b3:: with SMTP id f19mr6215071ilr.13.1592353488632;
 Tue, 16 Jun 2020 17:24:48 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 16 Jun 2020 20:24:37 -0400
Message-ID: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
Subject: CPU trying to start a GP when no CBs were assigned new GP numbers
To:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
I am seeing something a bit strange with RCU where it is trying to
start a GP twice from a CPU even though no new CB was queued on that
CPU. It is quite possible that I'm missing something. Anyway, I wrote
a patch to add some tracing when CBs are queued into the segcb. I am
planning to post this trace patch later.

The trace in the link below shows CPU2 queuing around 5 CBs, which
then gets accelerated at 5.192123. The GP thread running on CPU3
starts a new GP. Now the CPU2 softirq runs again (roughly 1ms after
the previous acceleration). The softirq runs probably because the GP
thread is expecting a QS report from CPU 2.  When the CPU2's softirq
runs though, it does an acceleration again which triggers a second new
GP start. This seems a bit unnecessary AFAICS - because the need for
GP *832 was already recorded which is all CPU2 should really be caring
about right?

Here is the trace: https://pastebin.com/raw/AYGzu1g4

Thanks,

  - Joel
