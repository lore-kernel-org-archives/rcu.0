Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC4C43334
	for <rcu@archiver.kernel.org>; Wed,  1 Jun 2022 20:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiFAUmn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFAUmk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 16:42:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3622656B
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 13:24:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f35so2039006qtb.11
        for <rcu@vger.kernel.org>; Wed, 01 Jun 2022 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvLvWgB14Ou3mGUr/2DxrQv3AuJh8V7Asy3ciiDV51Y=;
        b=kOdtS18Kv5nz87CsYZ9XBNrF+fZjkzFbiefudE+webORdnD7x4GFAwp0xW4ewuIOPo
         NKjnw1DY3WlUoKUYHWaUTgfVSyy15fy4Be2yXkdc06fbmd3PzCIztSIpD41avk5BBd8D
         rQP3kIoW/I/VND6f8uwlSuiytpKPXxRebMR38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvLvWgB14Ou3mGUr/2DxrQv3AuJh8V7Asy3ciiDV51Y=;
        b=puFGtcmgYfDQ6U3/7whnu2hv7xk1dZmh3kPSv2n6vbnCyK0i6b+QM8rgrEurMtHXBV
         aosoMx4pqd+dMySwoHODI2QseCewXrPK00nvuBMMZ+YYMqLmXT/yjG8+ksFeu8b8EVQK
         N4+lnUa9EvqR3tFtgyiuMpUT+I7tQUZNoYAE1e0KNeLKy8KzFi3v4oHj6GpoKr9urdUW
         r6Eu0lYTDGo3khHrmcU8Jmwe/D9BD7r7KHXb1aniMKL15QCf6FgJxAnOBdDbs0HOmDab
         OwkJgAE2SkUutwdS/pEtXL+k+kOqdtaO7gAtAKMG0AYIxti2LIsg/rW1A5MFWJVEzP/t
         cVLw==
X-Gm-Message-State: AOAM531NNXNqlLAy7fkj+C9VPC1G+diwCIibyl+7eubfMNEV5MJoGDSp
        J/eSRppJdgBZdz8ym14x7ECFwLAHlzl8d1JC4Ocyx/TIbDTxDQ==
X-Google-Smtp-Source: ABdhPJzj81BOZk3P7xUgyIolnlSQ5urTgcMwM2OyD42G1vGDcOxHqfY9f6U4qjqMWCK4XVlL90PbsSlpNDzoTkQmF/8=
X-Received: by 2002:a02:3506:0:b0:328:9a29:678 with SMTP id
 k6-20020a023506000000b003289a290678mr958267jaa.33.1654110652792; Wed, 01 Jun
 2022 12:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org> <YoNl3o+JvDas5xxF@pc638.lan>
 <2f370485-915d-a6c9-8d82-d4f1bd200c9e@joelfernandes.org> <20220601141250.GA1288128@lothringen>
In-Reply-To: <20220601141250.GA1288128@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Jun 2022 15:10:41 -0400
Message-ID: <CAEXW_YQsd55QRgENGCOp0KbZyKi_DTh0mVso2SyuH6zMgCb0SQ@mail.gmail.com>
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 1, 2022 at 10:12 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Mon, May 30, 2022 at 10:54:26AM -0400, Joel Fernandes wrote:
> > >> +void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> > >> +{
> > >> +  struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> > >> +  struct rcu_lazy_pcp *rlp;
> > >> +
> > >> +  preempt_disable();
> > >> +        rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
> > >> +  preempt_enable();
> > >>
> > > Can we get rid of such explicit disabling/enabling preemption?
> >
> > Ok I'll try. Last I checked, something needs to disable preemption to
> > prevent warnings with sampling the current processor ID.
>
> raw_cpu_ptr()

Indeed, thanks!

 - Joel
