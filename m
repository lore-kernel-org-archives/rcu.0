Return-Path: <SRS0=OE3B=2P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63BC2D0C8
	for <rcu@archiver.kernel.org>; Wed, 25 Dec 2019 22:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28481207FF
	for <rcu@archiver.kernel.org>; Wed, 25 Dec 2019 22:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="stBC+9jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLYWlP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Dec 2019 17:41:15 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34638 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLYWlP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Dec 2019 17:41:15 -0500
Received: by mail-qt1-f180.google.com with SMTP id 5so21061210qtz.1
        for <rcu@vger.kernel.org>; Wed, 25 Dec 2019 14:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/zvShOnUWZHTnNQagIRqPrbLozhAeH/F2o+ttK+nFHQ=;
        b=stBC+9jYlDDn2fF6OmABBPTirefCfbbPAbPPsKRYwOw8TkRsH432NacDi3GxAToKb0
         PX0aAiqzx8Ys2Np7gqMNQwMyeiMoY/Q7TcN7Xht1nvbQbF4V9obggoZ4K9nRegXps1Fx
         QMQSI9lN+uhWOuktSvF+qtj8NeEjlOJyvPTWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/zvShOnUWZHTnNQagIRqPrbLozhAeH/F2o+ttK+nFHQ=;
        b=joHsbD4CsxRynqL9MsITlogYp4UZCXYsHJti17cugYGKE6TzRjIH+PfQLtTC6ukG5z
         NqmJP88f/FGNKW0pxKn5Yd0/QMGTl8cXov0mtSEFv5VcMfbGqWcMmBOR2K6U26n5LIk9
         5idjbfT4uJJsGb1PXf38PXbwH2Ve+jpzEaIbLB5zc0G/g2fIOTS6xBPPR8NbJZia/7kP
         0akgC351991HZYlBcQstuOWCvxrusMM/KCf/s/z4ca5nASuY16q5z3RP71PBkOfO8D0H
         isWVKBhJQiai2XexanVzTDVYYirP5/sHEUf1X0ElH1OVp3e7RkLbrAWNiyfyt+0VKMs3
         HvdA==
X-Gm-Message-State: APjAAAX+zRmc1iliG4Cm7no+Dh/+zzFcFh1ErLBB5QoGLlDlNntd0KWf
        XHlpTgGcXkSVrEk5gxv7PVWLNxSaGa8vG40c6uVGHA==
X-Google-Smtp-Source: APXvYqzDzP69N0TbIRiNeqzK6U3ggzbxi4eYGaZxjWpzjKzuGt2Hw1YK/Ksr3GgMuQhzvpX7S9yyLGODzfNm6lV4sOo=
X-Received: by 2002:ac8:3703:: with SMTP id o3mr31921220qtb.208.1577313674604;
 Wed, 25 Dec 2019 14:41:14 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 25 Dec 2019 17:41:04 -0500
Message-ID: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
Subject: RCU ideas discussed at LPC
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,
We were discussing some ideas on facebook so I wanted to just post
them here as well. This is in the context of the RCU section of RT MC
https://www.youtube.com/watch?v=bpyFQJV5gCI

Detecting high kfree_rcu() load
----------
You mentioned about this. As I understand it, we did the kfree_rcu()
batching to let the system not do anything RCU related until a batch
has filled up enough or a timeout has occurred. This makes the GP
thread and the system do less work.
The problem you are raising in our facebook thread is, that during
heavy load the "batch" can be large and be dumped into call_rcu()
eventually. Wouldn't this be better handled generically within
call_rcu() itself, for the benefit of other non-kfree_rcu workloads?
That is if a large number of callbacks is dumped, then try to end the
GP more quickly. This likely doesn't need a signal from kfree_rcu()
since call_rcu() knows that it is being hammered.

Detecting recursive call_rcu() within call_rcu()
---------
We could use a per-cpu variable to detect a scenario like this, though
I am not sure if preemption during call_rcu() itself would cause false
positives.

All rcuogp and rcuop threads tied to a house keeping CPU
---
In LPC you mentioned about the problem of OOM if all rcuo* threads
including the GP one are not able to keep up with heavy load. On
Facebook I had proposed something like this: What about making the
affinity setting to be a "soft affinity", that is respect it always
expect in the uncommon case. In the uncommon case of heavy load, let
the threads run wherever to prevent OOM. Sure that might make the
system a little more disruptive, but if we are approaching OOM we have
bigger problems right?

Peter mentioned about rcuogp0 should have slightly higher prio than rcuop0
---------
You mentioned this is something to look into but not sure if we looked
into it yet.

A "heavy" call_rcu() caller using synchronize_rcu() if too many
callbacks are dumped
---------
How about doing this kind of call_rcu() to synchronize_rcu()
transition automatically if the context allows it? I.e. Detect the
context and if sleeping is allowed, then wait for the grace period
synchronously in call_rcu(). Not sure about deadlocks and the like
from this kind of waiting and have to think more.

is square root of N number of rcuogp0 threads - the right optimization?
---------
The question raised was can we do with fewer threads, or even just
one? You mentioned the square root might not be the right choice. How
do we test how well the system is doing. Are you running rcutorture
with a certain tree configuration and monitor memory footprint /
performance?

BTW, I have 2 interns working on RCU (Amol and Madupharna also on CC).
They were selected among several others as a part of the
LinuxFoundation mentorship program. They are familiar with RCU. I have
asked them to look at some RCU-list work and RCU sparse work. However,
I can also have them look into a few other things as time permits and
depending on what interests them.

Thanks, Merry Christmas!

 - Joel
