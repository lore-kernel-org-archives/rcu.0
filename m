Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3328C0650E
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9972B2184C
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZpEsgT+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCPZe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:25:34 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43291 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCPZd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Jul 2019 11:25:33 -0400
Received: by mail-lf1-f45.google.com with SMTP id j29so2062833lfk.10
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=I/c5HihCeotN2O3oVC5mmxpOtkJanQDMyVLAnhOc8wA=;
        b=ZpEsgT+gm5aPMqVD7tSzyuPt2RZrMtKgjx5lOSiyt28+JPMlWcxv/kKtsvtR4MJxt/
         /S8XxvcDQ+qJqkAV5YOdmNf64KNIyIyNKcF0MiSBJ1D0KUUFLwg4T4dpTcvUSZyqenKt
         j9jWyH9vqZ5cYW9F4g1KIi7xKsGjQxC2QEKME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I/c5HihCeotN2O3oVC5mmxpOtkJanQDMyVLAnhOc8wA=;
        b=YCSVFCxXQ25QGNkwrA0EPMyAJCmgaZaR+sIieDZab8bhNxZBYidlw8d9rsLaEQFwm5
         z41rzKEMSKbhGzHiQa7lM/EVChCBDyqN/bw2j/0PQBzJL4Ky7sssW69+xhktWXPvYKJc
         YXyzcWQb3+T9IBXUu5jnmcGl69Ji/yWEW6UrmcWQG0OiEV0SQgVsrcnSaTz/rWAveqpV
         sBcGegIzEw6xjl5L5J3Phj1MWBxyyqZeNpRxKk1MTC8XYdOv2wOc4XyZXVa4ptQ23N1i
         3AIhiqvN2eiP0oiRBu6IzstbxQPWCXaJTLkLlbISHaESgBqgM6rAIvqz2eGMKJ4wV3yQ
         aUPQ==
X-Gm-Message-State: APjAAAXHpWuWVMpLKqKkv+01Ur6C5oHY6prSVuNMSjQPVA5QEFyjtc/H
        XMcfLz7VrzTfj5i1wXRl3jxuNiKEeea1tjrL06b+Sw==
X-Google-Smtp-Source: APXvYqyyMmvd8FJOXVdEO830nF/7bZvxJwGcnIhPGo9PPvtGS8mO4h1NgREAIRf/6shQWOyQEJ8vR10W2FiIb++MyRM=
X-Received: by 2002:a19:8c06:: with SMTP id o6mr18292483lfd.176.1562167531652;
 Wed, 03 Jul 2019 08:25:31 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 3 Jul 2019 11:25:20 -0400
Message-ID: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
Subject: Normal RCU grace period can be stalled for long because need-resched
 flags not set?
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi!
I am measuring performance of the RCU consolidated vs RCU before the
consolidation of flavors happened (just for fun and may be to talk
about in a presentation).

What I did is I limited the readers/writers in rcuperf to run on all
but one CPU. And then on that one CPU, I had a thread doing a
preempt-disable + busy-wait + preempt_enable in a loop.

I was hoping the preempt disable busy-wait thread would stall the
regular readers, and it did.
But what I noticed is that grace periods take 100-200 milliseconds to
finish instead of the busy-wait time of 5-10 ms that I set. On closer
examination, it looks like even though the preempt_enable happens in
my loop, the need-resched flag is not set even though the grace period
is long over due. So the thread does not reschedule.

For now, in my test I am just setting the need-resched flag manual
after a busy wait.

But I was thinking, can this really happen in real life? So, say a CPU
is doing a lot of work in preempt_disable but is diligent enough to
check need-resched flag periodically. I believe some spin-on-owner
type locking primitives do this.

Even though the thread is stalling the grace period, it has no clue
because no one told it that a GP is in progress that is being held up.
The tick interrupt for that thread returns rcu_need_deferred_qs()
returns false during the preempt disable section. Can we do better for
such usecases, such as even sending an IPI to the CPUs holding the
Grace period? Or even upgrading the grace period to an expedited one
if need be?

Expedited grace periods did not have such issues. However I did notice
that sometimes the Grace period would end not within 1 busy-wait
duration but within 2. The distribution was strongly bi-modal to
1*busy-wait and 2*busy-wait durations for expedited tests. (This
expedited test actually happened by accident, because the
preempt-disable in my loop was delaying init enough that the whole
test was running during init during which synchronize_rcu is upgraded
to expedited).

I am sorry if this is not a realistic real-life problem, but more a
"doctor it hurts if I do this" problem as Steven once said ;-)

I'll keep poking ;-)

 J.
