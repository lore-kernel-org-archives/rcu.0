Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35502C1975A
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E692073E
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P43FjTKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCQWbD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:31:03 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43281 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCQWbD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Mar 2020 18:31:03 -0400
Received: by mail-il1-f194.google.com with SMTP id d14so21241998ilq.10
        for <rcu@vger.kernel.org>; Tue, 17 Mar 2020 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cy9EBkEXP8mKrE1tWYDArUinNkiiQlqPyNhgotiBbRw=;
        b=P43FjTKd0T5/YQKdtaWgVoXEy18bxKaNnuX61RCQVAyMX08mal/nWxiOX2rnGI6+2E
         ifMLGV9Oksz8dDkoimFarqdH3u8NJ+kAxWi+Q78yMyMdBe9XZmcoHxlPBLbrUI+qubCa
         7qAFN3+PC1lrCarn3nDKpSq7KaXkpKMx17E/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cy9EBkEXP8mKrE1tWYDArUinNkiiQlqPyNhgotiBbRw=;
        b=kp7jIaijchFCql3E5Z0rB/NGA6GnpN7nzQESQdXdCrYC3ScwYjNEJQ7OrM7XWbe6vc
         FPObzTwHbHy+abm1hGBv3it7RgwV/jOFqpsx+/16C3XTub0O8eSwQo7FcfjCjegCPvyV
         76Jzg7wxWNaiUkp0GcXOsIVO79QTtboc+QB52M23+cFemypwnmqUFohoFUTm9tGxwUla
         wEiAPqV6hia6bAXCISE8Gz4VX1dnnR05nHph4QF9kx8UwVVpPhyzUZi+qaWaV+y/9Es8
         xusbvsAgzqO5Ol1BgKGMvV/cUYLMLdXlb1x29p7ueSqgYHwR1n7J0DC8jKdD0pF/DZ1M
         naEg==
X-Gm-Message-State: ANhLgQ2g9v2irvV2q3EuvOupsKgROxfk4uVtuLuoRX9V4GaBfy2k2O6F
        xZD+ShYVv48iIEsVSyh7+R4/X/OKi5nvklJ6FLNJRg==
X-Google-Smtp-Source: ADFU+vsmPWAvveep930fw52ooTIuIXySJT8RDOWRG06Ck9aFoHf6+/7B/JRHemPQPS76anrITG9rAdvoDIUnoN5PR+Y=
X-Received: by 2002:a92:8f53:: with SMTP id j80mr1106826ild.171.1584484262823;
 Tue, 17 Mar 2020 15:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200316163228.62068-1-joel@joelfernandes.org>
 <20200317210822.GM3199@paulmck-ThinkPad-P72> <20200317214502.GA29184@paulmck-ThinkPad-P72>
In-Reply-To: <20200317214502.GA29184@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Mar 2020 18:30:51 -0400
Message-ID: <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com>
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object
 allocation size
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 17, 2020 at 5:45 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google) wrote=
:
> > > This allows us to increase memory pressure dynamically using a new
> > > rcuperf boot command line parameter called 'rcumult'.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Applied for testing and review, thank you!
>
> But testing did not go far:
>
> kernel/rcu/tree.c: In function =E2=80=98kfree_rcu_shrink_count=E2=80=99:
> kernel/rcu/tree.c:3120:16: warning: unused variable =E2=80=98flags=E2=80=
=99 [-Wunused-variable]
>   unsigned long flags, count =3D 0;

I fixed the warning already but did not resend since it was just the
one unused variable warning. The patches are otherwise good to apply.
Sorry, and I can resend it soon if you are not reapplying right now.

thanks,

 - Joel
