Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C49C6FD1D
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCPCNl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 22:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPCNk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 22:13:40 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE7712BEA
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 19:13:38 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i6so271064ybu.8
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678932818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCy5+wdKr/ZIcPH0tDGCasT0orFUXhJOEBbDaN8BA2k=;
        b=xiSnNeo2IJcQFWasCoR2qmUMJttoysSro33rDg+1ahnGYFXf+8k+l3zyo87+Mu4wSP
         enZ8V8/AWghf+yelUIPrT/VyqoCJmj1GGx2aoQIOE4WDE7ASTamCE2fUqckkYHIsvYko
         TOT78SIaceO4o6xczw21S/PVdA5+mMNWRJSs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678932818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCy5+wdKr/ZIcPH0tDGCasT0orFUXhJOEBbDaN8BA2k=;
        b=pn738GwXY2LhozaWvq52VXXvuivLV0966N/Qf3mZ7eN47X++qw2za718f+HUMfvyd0
         JlFnvifYUxN6w3ZkYPQTEtjgKcJ+L7x4HRXuK2izUhmcTvHGMIVWC/EjwCz6EkVCIYnO
         ey0jNZ9OWUPVb1mmfB4hmXgcXFcaQbT17y7AundNVGXImhyFmW8dXg0eQO40KuoTgwcI
         KEFGJqS6SZCeopcEOygDlWgYAQdPmLq2VVuNTgGXfE6pr/9IfzT7JUXSOIB9lhZarlCu
         xbHvNRbKIWlHaRpvig64FWcHkaPD7J4qqKI5lJtdBWqFW2Cuwq/nAHLtG3qqMvX6RnCA
         gPRQ==
X-Gm-Message-State: AO0yUKX0B+7TdUQsTZSa6V7WABmR1vYqFJLNFrE2ghdO619TvOeuqPmc
        Ega6MPx2k9TEcCs7pJmXtdhmLhxW4Xjdz3t8VabDxw==
X-Google-Smtp-Source: AK7set8uaXAOg6Hy5/gMomrBAZEQ24Eom6ZvDn6yyuS0Db9jaNzgb9PsaId0gWCHByfLM20kXf0vToXJhRDhxw/o7mg=
X-Received: by 2002:a25:9292:0:b0:b3a:e877:3290 with SMTP id
 y18-20020a259292000000b00b3ae8773290mr8687446ybl.2.1678932817925; Wed, 15 Mar
 2023 19:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home> <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home> <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
 <20230315182628.39329315@gandalf.local.home>
In-Reply-To: <20230315182628.39329315@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 22:13:26 -0400
Message-ID: <CAEXW_YSMr7b4K11T6kjThG8-DyxNiJMU3LOo-SwQ+Ev8h9taMw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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

Hey Steve,

On Wed, Mar 15, 2023 at 6:26=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
[...]
> > Also "mightsleep" means just that -- *might*.  That covers the fact
> > that sleeping may not happen ;-).
>
> Yes, and even though you are doubtful of it not ever having a non-sleep
> implementation, there is still a chance that there might be something
> someday.

Perhaps if it never sleeps, then we would introduce back the
single-arg kvfree_rcu() and delete the kvfree_rcu_mightsleep()` at
that point, since it would not serve any purpose.

> > This is just my opinion and I will defer to Uladzislau, Paul and you
> > on how to proceed. Another option is "cansleep" which has the same
> > number of characters as headless. I don't believe expecting users to
> > read comments is practical, since we did already have comments and
> > there was a bug in the usage that triggered this whole series.
>
> The point of "headless" is that is the rational for this version of
> kvfree_rcu(). It doesn't have a head. That's an API name that users care
> about.
>
> Why not call it kvfree_rcu_alloc() ? It allocates right?

Sure, but one can say now that allocating is an implementation detail? ;-)

Also, it may sound strange to have 'free' and 'alloc' in the same name.

> We have might_sleep() in lots of places. In fact, the default is things
> might sleep. We don't need to call it out. That's what the might_sleep()
> call is for. Usually it's the non sleep version that is special.
>
> We could call the normal kvfree_rcu() "kvfree_rcu_inatomic()" ;-)

Heh, I actually like 'inatomic' alot ;-)

> But I guess that would be a bigger change.
>

True.

thanks,

 - Joel
