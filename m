Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC4C83F14
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbjH3VPU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjH3VPU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 17:15:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8FCF3
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 14:14:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcc331f942so1384741fa.0
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693430002; x=1694034802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY7URIkYjAa6hii1lsMsDxwJkJeyWJi57od1/dC4yUQ=;
        b=gDg/76N/e/gcIrll7UiEmeKXWSCXmXZz3hzkO7w+yB/J4P8PSjM98LaqWvI4khN1HL
         hfbqKnbmPArPxyTQ5hVtkOMRFOkIcuvE2gWkypeXDAQEe7iQCMLRLdSCrKI0nzAzRtVG
         CWn95A2lRfIBrGAkpNe2YhU9E7xySPSJJZiRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430002; x=1694034802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY7URIkYjAa6hii1lsMsDxwJkJeyWJi57od1/dC4yUQ=;
        b=QW1Ii32BlHyzljPPVgreQJwBj0lD1Mf0XGbQZ2QKMx445ecQzPmBoaMZplvXjYWRW7
         aybaLBGX1BnEffdETEViyefmCnVicumhKs2nnhYNTBRYCfbTxsqkvQlzyB89o+NGJpkD
         JOZQdZ/3GRUoDvIosbqLoX57z4NjDVnIvrzjC2DVN//Jevh8+uExTtPfsDbSz9K+f+mj
         10SYLLZk842jBTmMapmsuIMvzi89BSTn+0bpdKNA6ad3GQlLpCxl4BrD+NR9gvp61wEu
         hlXZW6K+mPhLmI5KeGFZMm199+9m6lJfPyXNfmfAC2PaEjX6dI3pQZtEWitgxlyhlM8j
         RY2A==
X-Gm-Message-State: AOJu0YwSztBcG/oWXhOnvvI1GusgS1VjbDFxTkbrqaWn/c5mvT2C9gM0
        eP2jmSGZLZqElrAJhhnj6cUu4k3Tk6zQ0QLKH5WLXQ==
X-Google-Smtp-Source: AGHT+IGq2luy7KEgQ/NwcveOKBmXPoSNX0r81/OelxAZbI1Ln1ZbRcykJQOAk1LkuTBHQEhYqu/O+srsajWB1sTL3P4=
X-Received: by 2002:a05:651c:10b0:b0:2bc:c655:6f8f with SMTP id
 k16-20020a05651c10b000b002bcc6556f8fmr274175ljn.10.1693430002171; Wed, 30 Aug
 2023 14:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-4-joel@joelfernandes.org> <ZO3OIBYSYx/jBv7s@lothringen>
In-Reply-To: <ZO3OIBYSYx/jBv7s@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 17:13:13 -0400
Message-ID: <CAEXW_YSfJHt+hUYzPWs4BAvi0JL2UzHzLxKwb3=aRt9V7aQ4QQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tree/nocb: Adjust RCU_NOCB_WAKE_* macros from
 weaker to stronger
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 29, 2023 at 6:53=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Sat, Jul 29, 2023 at 02:27:33PM +0000, Joel Fernandes (Google) wrote:
> > This is needed to make the next patch work correctly as we rely on the
> > strength of the wakeup when comparing deferred-wakeup types across
> > different CPUs.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 192536916f9a..0f40a9c2b78d 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -288,8 +288,8 @@ struct rcu_data {
> >
> >  /* Values for nocb_defer_wakeup field in struct rcu_data. */
> >  #define RCU_NOCB_WAKE_NOT    0
> > -#define RCU_NOCB_WAKE_BYPASS 1
> > -#define RCU_NOCB_WAKE_LAZY   2
> > +#define RCU_NOCB_WAKE_LAZY   1
> > +#define RCU_NOCB_WAKE_BYPASS 2
> >  #define RCU_NOCB_WAKE                3
> >  #define RCU_NOCB_WAKE_FORCE  4
>
> Good change but make sure to audit all the occurences of
> RCU_NOCB_WAKE_LAZY and RCU_NOCB_WAKE_BYPASS. For example this breaks
> do_nocb_deferred_wakeup_timer() that will now ignore RCU_NOCB_WAKE_LAZY
> timers.
>

Ah I did do an audit, but missed this one. So then I think
do_nocb_deferred_wakeup_timer() should pass the weakest one
(RCU_NOCB_WAKE_LAZY) to do_nocb_deferred_wakeup_common().

Thanks a lot Frederic! I will take a deeper dive into this and author
users of RCU_NOCB_WAKE* and repost soon.

 - Joel
