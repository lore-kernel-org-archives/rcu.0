Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543D6C6FD19
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 04:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCPEQz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPEQx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 00:16:53 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6EBAB093
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 21:16:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z83so469275ybb.2
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHbcdUicUjbi8KR/m+/4TmqyAHSqQeOMUiRGySIU9BQ=;
        b=l2bm8SADDpl8FwWiWI1+QSr47QYr/QoZMySI7WR+fxIMtdzno508VGTM0zxqRRNya0
         bD+6kcaTOGH+Ya1syAzCrmE9TT76mZ30nOR/iTsJX33hykbJxX4jev8j5gOLGmRpNvrE
         sjx4zxWsZYYvAysW8vyyn3YMWbRMmym6F8b9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHbcdUicUjbi8KR/m+/4TmqyAHSqQeOMUiRGySIU9BQ=;
        b=ok4AzXNU50OzEymah6GDarUcHO0TMgoqy+LfWvFoZeeTvFYCvhnmLgu5lhJ10+hQ6y
         +aINFXlQXXonO7kFsyniuwQPyCvEaZiQ+oAjJRq6vUYf/u2lEUCbPzoppq0xm6sMn2cp
         4CsrIP/JE9RHyF9SS4T+34+EB+YmktKb1cKh69+9HDNgTJAIH71eLT3YqFrUZF7V0v2n
         fL9D90osMeNwwCv8kGlu/Wcsh3nHmsYpNp0HJKsWnnyGhM7BPngKV3gmVLKtQ/bjOffc
         knhH5lPR2veLeJJL3FlqpTTXcOiIlcabYnHThu0EP51Oid6jMmG/kwL/Lh4rQrOCB0+I
         Jmfg==
X-Gm-Message-State: AO0yUKWTRyw0s3LYcBhvmg2pjAWYomcv0jX1iA38KIXafMTvP0vrUHBi
        3Q2u5mqc7r7eei+Pie2p0FSKSCHgq0om5PmlK634Kw==
X-Google-Smtp-Source: AK7set+695oeOtFXArCWwu0RyLTOg+QDTyLxpsLt6vmfW6C2axZADbShGl29nN1/4n9CuPjTlBJ+kyXMCScZ0U8GcOk=
X-Received: by 2002:a25:9292:0:b0:b3a:e877:3290 with SMTP id
 y18-20020a259292000000b00b3ae8773290mr8840567ybl.2.1678940210630; Wed, 15 Mar
 2023 21:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636> <20230315183648.5164af0f@gandalf.local.home>
 <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk> <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
 <20230315222323.7afe82e7@gandalf.local.home> <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
In-Reply-To: <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 00:16:39 -0400
Message-ID: <CAEXW_YRr_fpkNAF8dFHLt0vGjYeksS+ObUPGgEUJimGpsASKcQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 15, 2023 at 11:44=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Mar 15, 2023 at 10:23:23PM -0400, Steven Rostedt wrote:
> > On Wed, 15 Mar 2023 17:37:30 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > >
> > > That does work, and I am guessing that the size increase is not a big
> > > problem for you there.
> >
> > Well, I was fine with it as long as it stayed in the headers, where
> > ugliness is warmly welcomed. Just ask all the #ifdefs.
> >
> > >
> > > > That's a cop out, just removing the one case you care about. Fact i=
s
> > > > the naming is awful, and the 1/2 argument thing is making it worse.
> > > > If a big change is warranted, why not do it right and ACTUALLY
> > > > get it right?
> > >
> > > You both do realize that the kvfree_rcu_mightsleep() definition is
> > > already in mainline, right?
> > >
> > > Anyway, to sum up, kvfree_rcu_mightsleep()--or whatever the entire
> > > community eventually decides to name it--can do any of the following:
> > >
> > > 1.  Put the pointer into an already allocated array of pointers.
> > >
> > > 2.  Allocate a new array of pointers, have the allocation succeed
> > >     without sleeping, then put the pointer into an already allocated
> > >     array of pointers.
> > >
> > > 3.  Allocate a new array of pointers, have the allocation succeed
> > >     after sleeping, then put the pointer into an already allocated
> > >     array of pointers.
> > >
> > > 4.  Attempt to allocate a new array of pointers, have the allocation
> > >     fail (presumably after sleeping), then invoke synchronize_rcu()
> > >     directly.
> > >
> > > Too much fun!  ;-)
> > >
> >
> >   kvfree_rcu_kitchen_sink() ?
> >
> >   kvfree_rcu_goldie_locks()?
> >
> > I honestly like the name "headless" as that perfectly describes the
> > difference between kvfree_rcu(arg1, arg2) and kvfree_rcu(arg1).
> >
> > Whereas mightsleep() is confusing to me because it doesn't tell me why
> > kvfree_rcu() has two args and kvfree_rcu_mightsleep() has only one.
> > Usually, code that has two sleep variants is about limiting the
> > functionality of the atomic friendly one.
>
>         kvfree_rcu_alloc_head()?
>         kvfree_rcu_dynhead()?
>         kvfree_rcu_gearhead()?
>         kvfree_rcu_radiohead()?
>         kvfree_rcu_getahead()?
>
> I don't know about you guys, but to me, kvfree_rcu_mightsleep() is
> sounding better and better by comparison...

Indeed, and one could argue that "headless" sounds like something out
of a horror movie ;-). Which of course does match the situation when
the API is applied incorrectly.

 - Joel
