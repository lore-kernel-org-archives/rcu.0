Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F8C433EF
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 22:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiEaWof (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346421AbiEaWof (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 18:44:35 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE6950036
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 15:44:34 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r3so13751ilt.8
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CI77RSSrJf3ZdZduHXrhwEN7s4hJuydE+fW3Lkm7gtU=;
        b=ZbukYwanCxAyR/YoeygmlC99PdXOL3gARDBKchHTAth00ZlorqmRk3Flhqkz19dsR8
         FohlNbfZLMLFu7dX/xBqEQExMwS2+ov3LzOTidpeNzKxpbs77n9uyTrti47qbKaD4Knk
         Td75r0OWgMYBTzrGWhbCb3L+mwBTr4N+QVAH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CI77RSSrJf3ZdZduHXrhwEN7s4hJuydE+fW3Lkm7gtU=;
        b=voJ5deX2revnEc9xKyRTSe0wOD2mL08bidtSS3Vq7fhL2DCf7GrAmEMbnrIiUfQicq
         +N/gNBux34IBOS9if5XRpgNbbbEbB3rnKtG6f9yv5Ai4mmrTszULakfhO7Z797Qyvv0Z
         MOT7sk+J2kn+psZ2uDPE86LYtaiWagmSTou6bN824vK2avv+UZFapU+gWZSL2b7Q0a/x
         0leRYWFIfd4Fu9IEODK06i/AMZfcTOA0B35zk35Mr4Kd7ABqurSQ995gf+48ObHwzqzq
         BnvYmXfMqW+7lEzcPUo2WuIoL5+MCQ184MxI7umAttZQfh+7aDLWXwna0IJ0+kahEcQx
         E4eA==
X-Gm-Message-State: AOAM531PuDdnalQwFoekOXtiZlpIzry1Pg2VLVWZA05lPAAcC0ecmmHz
        lgwCpm7yyLnp2aa4BJtbUniSzdvPyRlYyvYrO0RnXw==
X-Google-Smtp-Source: ABdhPJyHrTvC0+qt1DDvNMn/iu0VyzrVSO6DWwzdQFlS3SCzqQ2vzVy8nzrzEzcUIlMoGLHYwrIttGQuF4DZlCngBCI=
X-Received: by 2002:a05:6e02:1b0d:b0:2d1:ce6b:df4c with SMTP id
 i13-20020a056e021b0d00b002d1ce6bdf4cmr19381369ilv.109.1654037073291; Tue, 31
 May 2022 15:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <YpFawyhgLCj1+X1A@google.com> <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org> <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org> <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org> <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpZjxKX5sNwl9wMK@google.com> <20220531192532.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpaIqxdiOH8eGZXC@google.com>
In-Reply-To: <YpaIqxdiOH8eGZXC@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 31 May 2022 18:44:23 -0400
Message-ID: <CAEXW_YSk=o=D1NmWGAHmztvpPf+megQGRa4VsPxtZbhJp=t3Mg@mail.gmail.com>
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 31, 2022 at 5:29 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, May 31, 2022 at 12:25:32PM -0700, Paul E. McKenney wrote:
> > On Tue, May 31, 2022 at 06:51:48PM +0000, Joel Fernandes wrote:
> > > On Tue, May 31, 2022 at 09:45:34AM -0700, Paul E. McKenney wrote:
> >
> > [ . . . ]
> >
> > > > Here is hoping!
> > > >
> > > > After all, if you thought that taking care of applications that need
> > > > expediting of grace periods is scary, well, now...
> > >
> > > Haha... my fear is I don't know all the applications requiring expedited GP
> > > and I keep getting surprised by new RCU usages that pop up in the system, or
> > > new systems.
> > >
> > > For one, a number of tools and processes, use ftrace directly in the system,
> > > and it may not be practical to chase down every tool. Some of them start
> > > tracing randomly in the system. Handling it in-kernel itself would be best if
> > > possible.
> >
> > Shouldn't it be possible to hook into the kernel code that runs when
> > the sysfs tracing files are updated?  As in, why not both?  ;-)
>
> Yes, Point taken on this, let us do both solutions.

It appears Paul has handled both hotplug and rcu_barrier ordering
issues for bypass lists, so this makes it an obvious choice to solve
those problems... :-)

Thanks,

 - Joel
