Return-Path: <SRS0=nLJu=VQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402A9C7618F
	for <rcu@archiver.kernel.org>; Fri, 19 Jul 2019 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F304D20665
	for <rcu@archiver.kernel.org>; Fri, 19 Jul 2019 00:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XUpdAcDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGSAxG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:53:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39364 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAxG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jul 2019 20:53:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so20491739lfa.6
        for <rcu@vger.kernel.org>; Thu, 18 Jul 2019 17:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8L65F9AQGJRzB3szm9mqAdZSenP8LnqkTdF8dSw5FI=;
        b=XUpdAcDe2vJdXVzv1xf3m2JRca5f/a5HLfbekG0XZhNANeKcbX9jBKx5PB4EW4VAvd
         oBYSrrNtboa6iSG5PAh1OxnqPKpEGyOS3O2MR4QHHZvC/EfGGPpFyNJiHw93lOUXB23F
         rB6R67fgB2OGcKOdQ0qqQ9Rq+IUcT/U10UZvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8L65F9AQGJRzB3szm9mqAdZSenP8LnqkTdF8dSw5FI=;
        b=AwdbJdApZXJ21ID3EkxoIlYLCbcNdiNtcaumYcwB0AaW2v7ktRuvfqrUKEOdgg0D/I
         iz6lvgXcLHF7vCiJReZBTAxiLhuIUzftXcBZbVh9XtrpHQjDP83ClXpD9HA7Cc4dmi6v
         GJ5Ur1jGrHRjNqZ1rGOoIf23F6EE0snqHHP8+HhLl8UbSJrtxIoG766/5K/nZF+cmY/e
         FA7Ak2CPnZyu8OPk2JDUDLUxrSyXxYTWGsFSrzryqr0xBXXV+FgNKGFVJw1JLKqSoOr5
         e/LK9rlIvRNUlPjgnxBsi4qXWfLrxkoS2ADpseO1QNYG5nG0ZXkRvZLeL8UUhqMPCUaa
         tcSA==
X-Gm-Message-State: APjAAAVMwRfU3nUOzgV6uR/yrUoMhMzsDUTNriC6iKFOjRqWWBgZkMAF
        WAYigFQZiWvw/rl8K38uQTHebWPmdPXxtS8w03k=
X-Google-Smtp-Source: APXvYqxpvLN/gPfkb8t+MjnOCRt5mQiOz1c97gvHcz1OEntDBN567HK03KCzI6OapCKpAibKK/LWLkN+xFnG+zEXpao=
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr22285509lfg.160.1563497584456;
 Thu, 18 Jul 2019 17:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190711164818.GA260447@google.com> <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com> <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
In-Reply-To: <20190719003942.GA28226@X58A-UD3R>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Jul 2019 20:52:52 -0400
Message-ID: <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
[snip]
> > - There is a bug in the CPU stopper machinery itself preventing it
> > from scheduling the stopper on Y. Even though Y is not holding up the
> > grace period.
>
> Or any thread on Y is busy with preemption/irq disabled preventing the
> stopper from being scheduled on Y.
>
> Or something is stuck in ttwu() to wake up the stopper on Y due to any
> scheduler locks such as pi_lock or rq->lock or something.
>
> I think what you mentioned can happen easily.
>
> Basically we would need information about preemption/irq disabled
> sections on Y and scheduler's current activity on every cpu at that time.

I think all that's needed is an NMI backtrace on all CPUs. An ARM we
don't have NMI solutions and only IPI or interrupt based backtrace
works which should at least catch and the preempt disable and softirq
disable cases.

But yeah I don't see why just the stacks of those CPUs that are
blocking the CPU X would not suffice for the trivial cases where a
piece of misbehaving code disable interrupts / preemption and
prevented the stopper thread from executing.

May be once the test case is ready (no rush!) , then it will be more
clear what can help.

J.
