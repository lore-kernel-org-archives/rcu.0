Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC590C433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiELQdE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbiELQdD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 12:33:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B163537
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 09:33:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m23so7235711ljc.0
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOo09dhGk8rskBSDHqqTQOmoarLAEV7HKUbTO2PBarc=;
        b=ap3whFfmLpIHv+gMyyZ70VyhHFdosgQWbLgIwHxsB6eq0yWubHa5Li3VcQ8t4BTthb
         cppy7FeGfCqxfE0cPMRiMmk49285c1J/dA8Ri0Jz3wnnY89tMwmsr2MfOGOHICHFAaoR
         ulQK+r8AAxRuMt25EKqSbO7LkB5mD8Ky8i5fy8gBJez8YqU516dZfX9fLg5zAEu5nMM5
         4Lv6uFru7Pt8ddLlT/ULHFJJLkIELJ8YBIHGuEQnSqly4zLdG8f4yNfuIhLP/hxzlq2y
         W9B0dWRkh3E6TXUNfyAmPbO6atMtNRoDimT+053sfBYvOFxzjGqVEaOe6imSiJxo8NpE
         hhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOo09dhGk8rskBSDHqqTQOmoarLAEV7HKUbTO2PBarc=;
        b=ex114ZrEComHfv7jRubx+jly9+9+w2ThBE3WzVYjXsGkHV8zaNaM/8AEm95F5zfnDW
         ismdQ0XM4mARMRWGrokhR0OXUSRVVfthM6cqpr0ISlnNoZLXfVtLUTv27lKHo6h7NHgc
         UED23WH1SrQnoA29Wsgc1PJmkfawyGDEfrfZ4can0d0IVFlqhfmewJERKk6iUsnfwZDg
         UzPi0L4tPLRIsNgkzEPWXFNFv8AoXFnzAUG41e8kU/wz67pyj9/VXF9RPp1MJc+bBthQ
         pWjMVJRLBa4OScMzei0mb86CG/48C/J4aowZVPah3Ajg70znkBuba5kjupvduy0Uwg/x
         uB7Q==
X-Gm-Message-State: AOAM5330WGk6HhMJxGsjgzGkvA+kk0o9Ujjnp7KuBVbow4sjbW3KtQMp
        am6PsBIYTrR7h3dEREInG2I=
X-Google-Smtp-Source: ABdhPJwaZM3We/Dikx9leaCQtX9wI6KdbshtWWSDrSjaQS6MdMrK8I78dNYi8wyJ3KN7DTAZd616gA==
X-Received: by 2002:a2e:a585:0:b0:24f:528f:3621 with SMTP id m5-20020a2ea585000000b0024f528f3621mr522301ljp.416.1652373180673;
        Thu, 12 May 2022 09:33:00 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f8-20020ac24e48000000b0047255d210e5sm10301lfr.20.2022.05.12.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:33:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 12 May 2022 18:32:58 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Yn02uhvov7CDoKX7@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com>
 <Yn0bwhkdfPvbjIwK@pc638.lan>
 <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Thu, May 12, 2022 at 10:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > > > Never mind. I port it into 5.10
> > >
> > > Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> > > 5.10 , although that does not have the kfree changes, everything else is
> > > ditto.
> > > https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> > >
> > No problem. kfree_rcu two patches are not so important in this series.
> > So i have backported them into my 5.10 kernel because the latest kernel
> > is not so easy to up and run on my device :)
> 
> Actually I was going to write here, apparently some tests are showing
> kfree_rcu()->call_rcu_lazy() causing possible regression. So it is
> good to drop those for your initial testing!
> 
Yep, i dropped both. The one that make use of call_rcu_lazy() seems not
so important for kfree_rcu() because we do batch requests there anyway.
One thing that i would like to improve in kfree_rcu() is a better utilization
of page slots.

I will share my results either tomorrow or on Monday. I hope that is fine.

--
Uladzislau Rezki
