Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4DEE14C3
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 02:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjIJC2z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 9 Sep 2023 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJC2z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 9 Sep 2023 22:28:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D41A5
        for <rcu@vger.kernel.org>; Sat,  9 Sep 2023 19:28:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so53866801fa.2
        for <rcu@vger.kernel.org>; Sat, 09 Sep 2023 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694312928; x=1694917728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/kUKNhyDJK5/xDsovBgzVcQg2ENaYPPQ1cqUkfTuSs=;
        b=dXfEFCThGC+BPfAEjpsUHWEV2Ckwj+tqEOZTHY35yyx0XBPTI4WNywAX2iR7AeH1ag
         MDhVzy2OJva/la4Sm0DU4rlSQJ380DzGDQDWsgGv6h57eKBRIxXWrSsmu1qt1UdycO9I
         S9rjYq6H5yORTPKNY9FQRd9zGF2uwewxV8h/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694312928; x=1694917728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/kUKNhyDJK5/xDsovBgzVcQg2ENaYPPQ1cqUkfTuSs=;
        b=bLydUhIO1N7QRKEvqiaIO2l9qbILkk1HEYasPyZ0CibJGV2/KqMvc4Je+v8093lQp+
         UgWht5YJfhDxw0jQQArm13BBtAPYsYadwzRgofNF7nRMtlaatW8+7LJi92vB1xs4wG4L
         hsUIwp0jJnskdFD8gJCnaecc/RpRi8FpIvrLGGhH/ZiTKAEo8x4TqpszTbf/kAVs61nV
         vPcqgQrpEn555By9mig+RdMf5kCPFdl4vHK9jAb970M0nMJAeCUCTYRtYiU5TzTh4L/m
         VKAazRhHS89ZkWMIrBzM0+e+He0+ZiXPfpFeBiIINT+f4PzaQEuasgd4N/sgyYhSlieY
         QHnw==
X-Gm-Message-State: AOJu0YyLDPq2SeKblD114rDpQztpXTK+yIRSlaQhiFl4hKzXANuoTWob
        jIhV1iv2EDyyvOpIa0iDAySdWg9XIYM72xCIdoEu1UsIC3lnt3uuj5o=
X-Google-Smtp-Source: AGHT+IE4i3AdzOYJyJ7uQOvp0Yf3qFbg2wdMeNurGuZnLuzdcPh0KrZqGRsbf1g7TN/iC8t01/TRCPLQPOaYzt6whHM=
X-Received: by 2002:a2e:9d19:0:b0:2bc:f41a:d9bc with SMTP id
 t25-20020a2e9d19000000b002bcf41ad9bcmr4664464lji.25.1694312927928; Sat, 09
 Sep 2023 19:28:47 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 9 Sep 2023 22:28:36 -0400
Message-ID: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
Subject: [BUG] NOHZ tick-stop error: local softirq work is pending
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul, Frederic, ever since this recent patch got merged into all
recent stables:
https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
 ..

.. I am seeing this happen a lot now causing rcutorture failures:
"NOHZ tick-stop error: local softirq work is pending"

It looks like the "tick-stop error" as local_bh_blocked always returns
false on !PREEMPT_RT, so that patch itself seems correct.

However, it appears the string in console-badness.sh is different:

console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
softirq work is pending, handler'

So the string in the script needs an update?

Also, considering that it is being grep -v'ed out, any background on
why this message is not bad and any history? Why is softirq work
pending when the tick is stopped?

thanks,

 - Joel
