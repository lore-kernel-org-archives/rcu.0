Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A3C48BE4
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EDF20644
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QWWe0qbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfF0Rql (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33898 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0Rql (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so2170544lfa.1
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6W2K1b/3xwaEs6Qc9I8DS4+zNASP1N/uvlbH7rl76E=;
        b=QWWe0qbfaNHsWfqWaCYdMOBPZHNLceVVMR6vo2C0NhBVUEkOfYuBTroEj8kpUTMql1
         rXzc3hbrJRRsVASyBuBynXo0SCOy7RhsLn+Y3VerNa+90OQyEGkwypBsKGlss90teIQ1
         4Ymwesw1pbrDbXIg/UidFML1hwz2CZ6XGbKI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6W2K1b/3xwaEs6Qc9I8DS4+zNASP1N/uvlbH7rl76E=;
        b=R7uKefG0BG8HKM2CBjjzNPNni9WCK7RHGTM/ZJ3r323Pq5W09D+X7tUp3FV4g7aVqI
         5RBIKLiouvdvVRsj8Lwcu/s4FQ+IiORkgeh6IJspDQyKYsG5XyYxmYouE5nDE+GioPbO
         LL8EHgSICVlplNViRZfoB8uFqPbhYSgW4QdKL7vT7jdvwOXLb44DtUCnwA/QCpIVJdnB
         LAZGEzysWzc9quJVy+Qdzt6NFHnG01vePniuvF6m1TB6NONLBPnticgfS0R5lbFcwSNE
         uXlDXQTTp36Yjd56MZP8tEzXWcD/FaRA78eWr0VfRDZKVcK87U8UOlp8EYk1756f1EUG
         Bqnw==
X-Gm-Message-State: APjAAAW4O4WwehXLKt1VBxsGkjo/8z13yKdXx50ZB4kapUDNoda2xvEE
        cmSZ3tfEZskUZbdXFIMbaeqguvj189/xiQAvfN/I2g==
X-Google-Smtp-Source: APXvYqz9iEOx/i8x1nneYf64spCLIhIGQctI2cYF2AgnsIMMkq0ImZOf1fr5lkeGoyZnYomWg+JLp/yWoIKJfv8smD0=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr2596505lfy.191.1561657598836;
 Thu, 27 Jun 2019 10:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de> <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 13:46:27 -0400
Message-ID: <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > Sebastian it would be nice if possible to trace where the
> > > t->rcu_read_unlock_special is set for this scenario of calling
> > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > really because of an IPI. I guess we could also add additional RCU
> > > debug fields to task_struct (just for debugging) to see where there
> > > unlock_special is set.
> > >
> > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > machine with "threadirqs" and run into it?
> >
> > Do you want to send me a patch or should I send you my kvm image which
> > triggers the bug on boot?
>
> I could reproduce this as well just booting Linus tree with threadirqs
> command line and running rcutorture. In 15 seconds or so it locks
> up... gdb backtrace shows the recursive lock:

Sorry that got badly wrapped, so I pasted it here:
https://hastebin.com/ajivofomik.shell
