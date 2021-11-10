Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA2C433F5
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982E061056
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJM1C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKJM1B (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 10 Nov 2021 07:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636547054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDBntIPO0wEoyBMfZ3tKBmUSJOmiLOto35nSfxuOJEs=;
        b=GYBHO6qpJ0YrPDlPW29uoRWCQz9pObGi2wszkqpV+BZ3SHNwOZ1TWufbf/3f7i5C+KCQ1c
        k0y8i/ySattqTqcXolADS0eMTiap36hkHOuLVi4Is3ElEPeywgh1TwlCLtyqhlf9ju9AzI
        8TgPybafqdsb5AEnb3KsaHZlKuBZZi8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-dvvrPlodO7qkL6OCgvUWqw-1; Wed, 10 Nov 2021 07:24:13 -0500
X-MC-Unique: dvvrPlodO7qkL6OCgvUWqw-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso2179078edc.9
        for <rcu@vger.kernel.org>; Wed, 10 Nov 2021 04:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDBntIPO0wEoyBMfZ3tKBmUSJOmiLOto35nSfxuOJEs=;
        b=wb4vcDsYmBZgvhfsQEQoXWOJpZDhmKx1M6EeAVJ6ov72DNg3a9XF6WySJw3IieswGS
         utyVPbzGv/qc6/16T3sp/LQK4BPNDf4nW8nNt8nYHBSh6lq2V2ghV7PekFkbiDI95ZNO
         iBEMgGdYIv1sx0w+oOrIPvjs01q7cUzSYox8UF+wKgjBP8ZR+7Xw9iquQLKVdwaH1zrq
         acrLbjiTzli3bJdVKkS1dWd0oiNiCNQIzlRRxv48n+FPodA4FGzS2ECJHH+o4NdOadzQ
         KfBJGZ9Ct/fVFq704d0IpjbDPX9s8N890JGPikwnfeXu2YFSDYz2HuTaZdIEIuL88LUF
         3Ieg==
X-Gm-Message-State: AOAM533vJJQYqxVtV7/HMrRmSETlMSbyRgrUE2gLJgW5TNlPEcmcgaMo
        cVK7dHOZmnNOuG/2Bksm2LApzxJBLSmd4J2TpEkmlCep/aCpfBd7uegNp/z72N5mgTIcN/WHpE9
        ghtJfYhC7w8Q9wFiwJg9r3/8n3Gkt
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr7151095edw.234.1636547052007;
        Wed, 10 Nov 2021 04:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvQZi7oZ2z9bC/JYOu9H4TrVq1eS5IwH5H6fTg9dND+AsPWxxwXyOJG9Z7kIckaODRizhj4jbDyTXNStSHfaU=
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr7151063edw.234.1636547051834;
 Wed, 10 Nov 2021 04:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20211109174602.407644-1-wander@redhat.com> <20211109203715.GW641268@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211109203715.GW641268@paulmck-ThinkPad-P17-Gen-1>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 10 Nov 2021 09:24:00 -0300
Message-ID: <CAAq0SUms6+ZMhk4WV0bJY-zCwSBS5xHOSLMgywDEUmb_pSB1nA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Avoid soft lockup during cpu stall
To:     paulmck@kernel.org
Cc:     wander@redhat.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:TORTURE-TEST MODULES" <linux-kernel@vger.kernel.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 9, 2021 at 5:47 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Nov 09, 2021 at 02:46:02PM -0300, wander@redhat.com wrote:
> > From: Wander Lairson Costa <wander@redhat.com>
> >
> > If we use the module stall_cpu option, we may get a soft lockup warning
> > if we also don't pass the stall_cpu_block option.
> >
> > We introduce the stall_no_softlockup option to avoid a soft lockup on
> > cpu stall even if we don't use the stall_cpu_block option.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> This looks plausible to me, though it would be good to hear others'
> thoughts.  In the meantime, could you please forward-port this to
> the "dev" branch of the -rcu tree?
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
>
>                                                         Thanx, Paul
>

Thank you for the feedback. I just sent a v2 against that applies to
the aforementioned branch.

Cheers,
Wander

[snip]

