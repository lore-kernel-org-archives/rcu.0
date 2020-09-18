Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81019C43463
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D89420872
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrFbbBt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRTVM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTVM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 15:21:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4DC0613CE
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2020 12:21:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d19so3505759pld.0
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2020 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8jg3wEb1NvgDFOhn2Df3VYWw1IxYrBP36RODw9akKg=;
        b=BrFbbBt6GkUcziwd6+MFDUSrm+2lOqEUDUB036iGDk/1c2tqm0EDPPKKQyzKbWmeUR
         duKOR6RwaTxwTK8Kns9dyufORR+VP1W+Gf/gkO9umkmlJ47sELObWR0HuK0lorOFTIZ0
         EssJrQSM1teK6ueyn8MHkaLENOlciqG1rQzQhnWSTA+CmqCqB8MOVM5e5AO4Putcq0zv
         qznsJvLrcoaOmLlTowCV9Wv/HlcizX/2xlpznNZHEkdHKgGOJe+5eaLVXlDiUL8UHZJs
         LXMwNHs+s7FFi9XvG3OwAcbfTW/uja9av/5XJgnI6Hvw3ESo29tggN72Qb9iFvG+skmr
         BaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8jg3wEb1NvgDFOhn2Df3VYWw1IxYrBP36RODw9akKg=;
        b=HEbCYT9DXSDuX+9IU3ROUSBRktNLavNhrXkpoU3zM1zuu+QEDlOwHGdiVQTxU9LvCP
         ueGLzeRKbOCM6zpPQJczy+DWolLXRSsg/qq0Cz+eqXpwEc8/5IVT/x0baUcNT075ycD7
         IZoQn7gWID/Cb12zC2LsCxF7wwcs1LxVxkFXvLnh+RZ6nIe6W/QNeJLr4WLgi2c9PSYI
         BJa8oiQTKiCtVjiRGz311Y78oWqVIsbXlaoz26SBYwtxHXYf9mN2WthpVhbMbrl7iIvO
         WQPt5zA/jbF5Jtvf6zl0sS+dsI0h+kyPRkKKprnS+DCOEcopdk+PykHKTBE/8bSUqs8u
         04Aw==
X-Gm-Message-State: AOAM531ZQ3ojwvlMvCiSAORkZ4xl2yEEl7tqA0WR7n756MNUKx7l6CVO
        0QEg1AUs73fkuoASGkXtAh7NrGOYyzwNqLjkmzqZcA==
X-Google-Smtp-Source: ABdhPJwZ4epeV/+UZA0tq4cdhZ2Gpu6s88cRee3xsgPgUHxTjPd1BQnAQscX1SLefyB6gIX0CXdzGU6d7DLeTJApSnA=
X-Received: by 2002:a17:902:ed11:b029:d1:f385:f4e7 with SMTP id
 b17-20020a170902ed11b02900d1f385f4e7mr11647590pld.56.1600456868387; Fri, 18
 Sep 2020 12:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdm4AQhobdkKT08bjPGb15N58QN79XWxEaQt-P5Dk4+avQ@mail.gmail.com>
 <20200916213730.GE29330@paulmck-ThinkPad-P72> <20200917205844.GA1978@paulmck-ThinkPad-P72>
In-Reply-To: <20200917205844.GA1978@paulmck-ThinkPad-P72>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Sep 2020 12:20:57 -0700
Message-ID: <CAKwvOdnojrynmPHrK0MM0Xq1e8Ywk_3_=oehnJWZcFN8=HwsJg@mail.gmail.com>
Subject: Re: GPF from __srcu_read_lock() via drm_minor_acquire()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 17, 2020 at 1:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 02:37:30PM -0700, Paul E. McKenney wrote:
> > So here are a few questions that I would ask:
>
> Oh, and this one:
>
> 0.      Did someone call srcu_read_lock() before init_srcu_struct()
>         had been called on this srcu_struct structure?
>
>                                                         Thanx, Paul
>
> > 1.    Did the init_srcu_struct() for this srcu_struct report an error?
> >       (Though with current mainline, that memory-allocation failure
> >       would more likely have page-faulted in init_srcu_struct().)
> >
> > 2.    Has the srcu_struct in question already been passed to
> >       cleanup_srcu_struct()?
> >
> > 3.    Has the value of %fs been clobbered?  Though that seems
> >       unlikely given that it also happens on aarch64.  Plus, the
> >       smoking gun seems to me to be the zero value of %eax.
> >
> > 4.    If the above three questions fail to provide enlightenment,
> >       I suggest recording the ->sda value and adding debug checks
> >       to anything that can unmap memory...  And recording the value
> >       of ->sda somewhere to check to see if it is being changed (it
> >       should remain constant from init_srcu_struct()'s return through
> >       the corresponding call to cleanup_srcu_struct()).
> >
> > Please let me know how it goes!

Thanks for the tips Paul. I've copied your suggestions into the bug
report with additional suggestions for the reporters to collect more
info, particularly in the arm64 case.  I will update this thread once
we've resolved the report.
-- 
Thanks,
~Nick Desaulniers
