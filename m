Return-Path: <SRS0=SMg2=VP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6859C76195
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B02184E
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 16:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yl42423+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGRQQG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:16:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46365 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRQQF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jul 2019 12:16:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so15344496lfh.13
        for <rcu@vger.kernel.org>; Thu, 18 Jul 2019 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcUjT0W7KZXLkur2UXUjc33cVy9DWOd5ZbJ4nex9bqo=;
        b=yl42423+ShMJNj0qJ6yfAuBSR0MXnGVaDILz9UQlWPSYEdTrOp+3pnad7KPBf60BH6
         fppJeMupie5K3dihgf9R+Qi+xJDWJugRkkO7KTci5nIcqaqe15xdJpCdgNxr57Dew51u
         6QeJ1kp0ZdPv6HtKQpWz4c+KXoxXD8vMf66j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcUjT0W7KZXLkur2UXUjc33cVy9DWOd5ZbJ4nex9bqo=;
        b=ix112QcGrLjBKEql1kVZipCxMqDn9Qnj2MVuMClwNbPL3cO/qZiSKDXN04aVL9bKQ0
         +dN+IZT+HRF0MXuBX2SB5IEdz4PHOixOFAkicHYXHExu5FShmiTPfjdR19jwCK06UZp7
         ZtB4clPWCf8fDKgKwnk07gDVEhu7Ygzscfefq+Fonczujio1HTAhSJt39Qqv6CXtkZvo
         sTOT3t9seaRrzAkkmrTANsa4FbIG4I/Atd/YdjFEJ8NIAH38OAYKLPxYQJjurYy4kT9n
         vY4zwG5cb7cdzCwqeWnjln9JitrU8KgSmcRyw6K08ktVzA8aZ/+9znDT3zI+eamglftx
         0y5A==
X-Gm-Message-State: APjAAAWvXIVZOsQgqahAnPNjtN2T7+hAhvzxWFStsIcidOaE76FJpSEk
        PuUsLlGvzyT04jTfkiDIhCA/jA4UXYnPyrnxqtU=
X-Google-Smtp-Source: APXvYqwwm1e2Odt7yODnCqh+OqI4eqB7zWbv4IcCiwZAUNYcYVmuBPI5wLuDkuEy011/XOFOy46UYf0YQsQ6Jh8rsmU=
X-Received: by 2002:a19:c503:: with SMTP id w3mr19091061lfe.139.1563466563806;
 Thu, 18 Jul 2019 09:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190711130849.GA212044@google.com> <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com> <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com> <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
In-Reply-To: <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Jul 2019 12:15:51 -0400
Message-ID: <CAEXW_YTsNNySKbDU12ZeidXQ0GrWqaTKbVUym3kFfnKeV44Tug@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 18, 2019 at 12:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Trimming the list a bit to keep my noise level low,
>
> On Sat, Jul 13, 2019 at 1:41 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> [snip]
> > > It still feels like you guys are hyperfocusing on this one particular
> > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > >
> > > Thanks for the hints, we'll do that.
> > >
> > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > What information will you need?  How can you best get that information
> > > > without excessive numbers of over-and-back interactions with the guy
> > > > reporting the bug?  As part of this last question, what information is
> > > > normally supplied with the bug?  Alternatively, what information are
> > > > bug reporters normally expected to provide when asked?
> > >
> > > I suppose I could dig out some of our Android bug reports of the past where
> > > there were RCU issues but if there's any fires you are currently fighting do
> > > send it our way as debugging homework ;-)
> >
> >   Suppose that you were getting RCU CPU stall
> > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > Of course, this really means that some other CPU/task is holding up
> > multi_cpu_stop() without also blocking the current grace period.
> >
>
> So I took a shot at this trying to learn how CPU stoppers work in
> relation to this problem.
>
> I am assuming here say CPU X has entered MULTI_STOP_DISABLE_IRQ state
> in multi_cpu_stop() but another CPU Y has not yet entered this state.
> So CPU X is stalling RCU but it is really because of CPU Y. Now in the
> problem statement, you mentioned CPU Y is not holding up the grace
> period, which means Y doesn't have any of IRQ, BH or preemption
> disabled ; but is still somehow stalling RCU indirectly by troubling
> X.
>
> This can only happen if :
> - CPU Y has a thread executing on it that is higher priority than CPU
> X's stopper thread which prevents it from getting scheduled. - but the

Sorry, here I meant "higher priority than CPU Y's stopper thread".
