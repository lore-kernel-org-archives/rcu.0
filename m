Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653DC7619A
	for <rcu@archiver.kernel.org>; Wed, 12 Apr 2023 05:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDLFJd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFJd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Apr 2023 01:09:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4825A1996;
        Tue, 11 Apr 2023 22:09:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g3so11562529pja.2;
        Tue, 11 Apr 2023 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681276172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it0Wi4L0e7s40uaIIiJKd4300bUDmSUf9yApkSgXnos=;
        b=QXkgNXxWy7yAf0sAx+it64ZTfgE7av1zC231AuReQ+ZPxHIJ8XlLaVrY33VKKm9slK
         eWKwb7wx596Sy+wyPffsiAhHLmF96j8WeqrsnqmZJuDa3Shxbvlqe3e2cWE0/3Xul7vO
         wYW4JFCkkfRSFqfmL6e4BfgLISd0o3HOjKXVT1KBFBuCB5FY17zqBVHkJpUWMRZbfcVZ
         LLpbjDYX3Zx5qubqTCMXTz9GvMi5qtOAy6XLL9FEhLqIbGMD0Smc2ODJOEUdAnKtWMmI
         8iM4LYlqk39UU6ITk5zrWmssJ146t4wL1cv9yToGNFTRF7ULLtUsUbx6g5LUgNuzODUf
         wCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it0Wi4L0e7s40uaIIiJKd4300bUDmSUf9yApkSgXnos=;
        b=htyBcOozPXpOn1edrqC8NalLtYSJ31LSr01IdyX01vjM77AmJv2+foWqHqn6z3y4Xm
         1uMTqIbFy6sBkgr+S4441FB0I+aWIenhU16mWKd0+gyJZEGQoUXwrIlZP//gntLKFFvx
         Q4jVKtYQveJdl36T2qSks6HyF+KR7mdQpktT1wy+hsh2ENftpyTBGaa/Fi0hOHHtqr2b
         7/WlBhycYZyfco2Aj2iv+W/w5em+f9XJTG2QqSQl+LO3OIEOxD2d8eHhbYU1Q09KdjJM
         qYaaCfizR8ptoadtd0w7WVjvHLBOJCVGhzORDluti1i8mZDkUqlJ8SEdJ00Yf5pWP/fh
         Q9sQ==
X-Gm-Message-State: AAQBX9fyVPwaPOE/lfb3jop3V0kvsFTVDqv2bzcLzksvINcZFhw+9FkT
        2MzQJa9h2bP2bRBkcy5zNYFwNS05MUJi1xuwNjY=
X-Google-Smtp-Source: AKy350Z8WsgewvwVo7a8JR1Ze2cFwFEdFkHf4g9Cp3x4uRa80pOAGrglJJ5aK4yANIb56cXjB/tkbF0q6fX0E1kWOe8=
X-Received: by 2002:a17:902:988f:b0:1a1:ffc0:8b9e with SMTP id
 s15-20020a170902988f00b001a1ffc08b9emr4359639plp.4.1681276171666; Tue, 11 Apr
 2023 22:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <1681264483-5208-1-git-send-email-zhouzhouyi@gmail.com> <0e334497-fbc1-49f7-87ef-8dbf6d25d6a7@paulmck-laptop>
In-Reply-To: <0e334497-fbc1-49f7-87ef-8dbf6d25d6a7@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 12 Apr 2023 13:09:20 +0800
Message-ID: <CAABZP2w8Dg5LrsSvMdYp36n_fhj2fF7qTM5CFnFAh1VJKN+HFA@mail.gmail.com>
Subject: Re: [PATCH] rcu/torture replace wait_event with wait_event_interruptible
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 12, 2023 at 12:54=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Apr 12, 2023 at 09:54:43AM +0800, zhouzhouyi@gmail.com wrote:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> > if kfree_loops is too big. Replace wait_event with wait_event_interrupt=
ible
> > to avoid false positive.
> >
> > Tested in the PPC VM of Open Source Lab of Oregon State University.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >  kernel/rcu/rcuscale.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 91fb5905a008..b37eec94957c 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
> >  static int
> >  kfree_scale_shutdown(void *arg)
> >  {
> > -     wait_event(shutdown_wq,
> > +     wait_event_interruptible(shutdown_wq,
>
> Good catch!!!
>
> Would wait_event_idle() work in this case?  The _interruptible()
> variant indicates that wakeups due to things like POSIX signals is
> permitted.
Thank Paul for your guidance and encouragement!
I will perform a new round of rcu torture test, after this is done, I
will resend the modified version.

Thanks ;-)
Zhouyi
>
>                                                         Thanx, Paul
>
> >                  atomic_read(&n_kfree_scale_thread_ended) >=3D kfree_nr=
ealthreads);
> >
> >       smp_mb(); /* Wake before output. */
> > --
> > 2.34.1
> >
