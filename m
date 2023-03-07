Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC72C678DB
	for <rcu@archiver.kernel.org>; Tue,  7 Mar 2023 04:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCGElM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Mar 2023 23:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCGElL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Mar 2023 23:41:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47E4D28B
        for <rcu@vger.kernel.org>; Mon,  6 Mar 2023 20:41:06 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c19so13161858qtn.13
        for <rcu@vger.kernel.org>; Mon, 06 Mar 2023 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678164066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qCv0iSiDbulB3jzvpmB167Z8m74Zqa23My4mYkvzyo=;
        b=S+rOnczXhLL9hE9rWM5bJcmXbRaGW8LpzeTlsjlV03Z0jmx2sQfUV+kF00XNjUt5wH
         6Cs5BUZuT1e98XhM/8m002/XCEHzsVp44foblf5fMcwmCWGKdEpQvIVkujMONEHe17K7
         PU1+WwbldpzODroLSAvd7Hf5iSlbFwJDFrICE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678164066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qCv0iSiDbulB3jzvpmB167Z8m74Zqa23My4mYkvzyo=;
        b=mxcP+ATnvvVJGsP5+i+QoqUmc+mBk8iU1tsd5JDMVBXEIYqLLAM8izyMMdC93qbhOI
         B/BQIs10UUny6iDqXGYjeVpxeEu3a+dD0LPN5K64PhYOVL2C0L8Cp5GoSibr9Y5QZPGu
         sgfU3nIbl0I9/xLQOzPCH2l/kMxxu/a3FBEudtLMgNvIa9qKu+eUwU2gMoLomM4pA7Sk
         k7cC7TT1qyVqKKnyfE0g7+lYV9Bu4f+HBQByMY54QytOuPMFvGsDLehBSw0Ixe5PHTcH
         owF9/lGxgKHwWpZOFbi426IHp5K/Ecmq7Huz0OWhzeVb5L4GyeQKi74ImNDBIMEfIMQ6
         uVIQ==
X-Gm-Message-State: AO0yUKXZDnJ1efmWCwDBdnokxFt7ARSmZLgqjrv1QNOEo2yQABhbe0on
        3Dw5Q2MLrXhz0ybrV2DEcInccbUSxMGWjNKhMoc=
X-Google-Smtp-Source: AK7set/m+GjYlO4eJ5CADhlKuHFblpQi2qfdmAnotXKArwTXo5PkuuUzwPyTXGJB/ugAPVwxTCwSlQ==
X-Received: by 2002:ac8:5904:0:b0:3b8:6ae7:1757 with SMTP id 4-20020ac85904000000b003b86ae71757mr22229123qty.38.1678164065780;
        Mon, 06 Mar 2023 20:41:05 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m19-20020a05622a055300b003b2957fb45bsm9103897qtx.8.2023.03.06.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 20:41:05 -0800 (PST)
Date:   Tue, 7 Mar 2023 04:41:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
Message-ID: <20230307044104.GA3532764@google.com>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
 <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
 <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
 <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 06, 2023 at 07:23:23PM -0800, Joe Perches wrote:
> On Mon, 2023-03-06 at 22:10 -0500, Joel Fernandes wrote:
> > On Mon, Mar 6, 2023 at 10:08 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > > > Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> > > > error-prone. However, till all users are converted, we would like to introduce
> > > > checkpatch errors for new patches submitted.
> > > > 
> > > > This patch adds support for the same. Tested with a trial patch.
> > > > 
> > > > For now, we are only considering usages that don't have compound
> > > > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> > > > This is sufficient as such usages are unlikely.
> > > > 
> > > > Once all users are converted and we remove the old API, we can also revert this
> > > > checkpatch patch then.
> > > 
> > > I think this should be added to the deprecated_apis hash instead
> > > 
> > > our %deprecated_apis = (
> > >         "synchronize_rcu_bh"                    => "synchronize_rcu",
> > >         "synchronize_rcu_bh_expedited"          => "synchronize_rcu_expedited",
> > >         "call_rcu_bh"                           => "call_rcu",
> > >         "rcu_barrier_bh"                        => "rcu_barrier",
> > >         "synchronize_sched"                     => "synchronize_rcu",
> > >         "synchronize_sched_expedited"           => "synchronize_rcu_expedited",
> > >         "call_rcu_sched"                        => "call_rcu",
> > >         "rcu_barrier_sched"                     => "rcu_barrier",
> > >         "get_state_synchronize_sched"           => "get_state_synchronize_rcu",
> > >         "cond_synchronize_sched"                => "cond_synchronize_rcu",
> > >         "kmap"                                  => "kmap_local_page",
> > >         "kunmap"                                => "kunmap_local",
> > >         "kmap_atomic"                           => "kmap_local_page",
> > >         "kunmap_atomic"                         => "kunmap_local",
> > > );
> > 
> > This is not an API name change though, it is a "number of arguments"
> > or argument list change. Is there a different way to do it?
> 
> Ah, no, not really.
> 
> btw: I don't see a single use of this call without a comma in the tree.
> 

Did you look for kvfree_rcu? It is either kvfree_rcu() or kfree_rcu().

thanks,

 - Joel

