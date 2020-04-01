Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E3C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E503320776
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HNzzw9Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgDALOU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:14:20 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43591 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDALOU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 07:14:20 -0400
Received: by mail-qv1-f65.google.com with SMTP id c28so12542121qvb.10
        for <rcu@vger.kernel.org>; Wed, 01 Apr 2020 04:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=REvRlMsgOFQJ9DS0ybL5YKksbNDmarWybGdwWM9qPnk=;
        b=HNzzw9AaCQ2wwQWAa0QLGm1wy1QVSKRCSBySoKmb2rMhRPe7fw8yp5rojv1+R67vwd
         mrvN59w7uBr5hvzP6/oiUAJXkOOzBJ+jPRrbYADHvviK2BKuK0Kl1CP9WCJ2UWy28/hv
         FLbFHdmysoM+MqglbwbHDD2nJOHHieBl/r5YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=REvRlMsgOFQJ9DS0ybL5YKksbNDmarWybGdwWM9qPnk=;
        b=IR3sOYD9R1jRms58fL3gCrquJyTh1o/TZG7CTTI7u+BUqhoTfQKRHiM6N5WxftEC4o
         HhQ3ScusmXgx3D4xC2sL9g0C6jG21zpS05Sr96LkgmA1OeeCV6uNQngg4Au5nlccwFXV
         rfQMY28Y7dqX2R/91oShadcct60hT1bK0xUeNwEHEPT1ksk7YkPeTvz50Q0eqYg6nAT9
         M4nEvKaJ97fMJyfyGjfal3IVyAumBf9HWbFGlAaMMal0CdVdv70IqwSipnrADy2KazjK
         8Yf1AZgrzIK7BUfAg6m7u74dbdvDk0FQ/dz+hUOkiCmpQGpnAwbjbDdDO7vqANH0rTRr
         VF9A==
X-Gm-Message-State: ANhLgQ37G3uO69fxwNz1GaLdrk4ga8fF/zWW2BcolRLGEbUETXPZ4lcw
        LjlujElPtzn88nbIJcspaUNhR6TK1SCJUQ==
X-Google-Smtp-Source: ADFU+vuCUAGZq2gqDB6jJznSAaDSUjP0vDL5D2UyWjb9Esjqm9GhJmnPiu8pzprY98apoTIb7BHcvw==
X-Received: by 2002:a05:6214:7e6:: with SMTP id bp6mr21108393qvb.47.1585739659151;
        Wed, 01 Apr 2020 04:14:19 -0700 (PDT)
Received: from ?IPv6:2600:1003:b867:fb88:f93f:7d9f:f5a9:d91e? ([2600:1003:b867:fb88:f93f:7d9f:f5a9:d91e])
        by smtp.gmail.com with ESMTPSA id e2sm619784qkg.77.2020.04.01.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 04:14:18 -0700 (PDT)
Date:   Wed, 01 Apr 2020 07:14:16 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200401072359.GC22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org> <20200331145806.GB236678@google.com> <20200331153450.GM30449@dhcp22.suse.cz> <20200331160117.GA170994@google.com> <20200401072359.GC22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free memory pattern
To:     Michal Hocko <mhocko@kernel.org>
CC:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
From:   joel@joelfernandes.org
Message-ID: <30295C90-34DB-469C-9DCD-55DB91938BA9@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On April 1, 2020 3:23:59 AM EDT, Michal Hocko <mhocko@kernel=2Eorg> wrote:
>On Tue 31-03-20 12:01:17, Joel Fernandes wrote:
>> On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
>> > On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
>> > [=2E=2E=2E]
>> > > > diff --git a/kernel/rcu/tree=2Ec b/kernel/rcu/tree=2Ec
>> > > > index 4be763355c9fb=2E=2E965deefffdd58 100644
>> > > > --- a/kernel/rcu/tree=2Ec
>> > > > +++ b/kernel/rcu/tree=2Ec
>> > > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head
>*attach_rcu_head_to_object(void *obj)
>> > > > =20
>> > > >  	if (!ptr)
>> > > >  		ptr =3D kmalloc(sizeof(unsigned long *) +
>> > > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
>> > > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
>> > >=20
>> > > Just to add, the main requirements here are:
>> > > 1=2E Allocation should be bounded in time=2E
>> > > 2=2E Allocation should try hard (possibly tapping into reserves)
>> > > 3=2E Sleeping is Ok but should not affect the time bound=2E
>> >=20
>> >=20
>> > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
>> > memory reserves regarless of the sleeping status=2E
>> >=20
>> > Using __GFP_MEMALLOC is quite dangerous because it can deplete
>_all_ the
>> > memory=2E What does prevent the above code path to do that?
>
>Neil has provided a nice explanation down the email thread=2E But let me
>clarify few things here=2E
>
>> Can you suggest what prevents other users of GFP_MEMALLOC from doing
>that
>> also?=20
>
>There is no explicit mechanism which is indeed unfortunate=2E The only
>user real user of the flag is Swap over NFS AFAIK=2E I have never dared
>to
>look into details on how the complete reserves depletion is prevented=2E
>Mel would be much better fit here=2E
>
>> That's the whole point of having a reserve, in normal usage no one
>will
>> use it, but some times you need to use it=2E Keep in mind this is not a
>common
>> case in this code here, this is triggered only if earlier allocation
>attempts
>> failed=2E Only *then* we try with GFP_MEMALLOC with promises to free
>additional
>> memory soon=2E
>
>You are right that this is the usecase for the flag=2E But this should be
>done with an extreme care because the core MM relies on those reserves
>so any other users should better make sure they do not consume a lot
>from reserves as well=2E=20
>

Understood and agreed=2E

>> > If a partial access to reserves is sufficient then why the existing
>> > modifiers (mentioned above are not sufficient?
>>=20
>> The point with using GFP_MEMALLOC is it is useful for situations
>where you
>> are about to free memory and needed some memory temporarily, to free
>that=2E It
>> depletes it a bit temporarily to free even more=2E Is that not the
>point of
>> PF_MEMALLOC?
>> * %__GFP_MEMALLOC allows access to all memory=2E This should only be
>used when
>>  * the caller guarantees the allocation will allow more memory to be
>freed
>>  * very shortly e=2Eg=2E process exiting or swapping=2E Users either sh=
ould
>>  * be the MM or co-ordinating closely with the VM (e=2Eg=2E swap over
>NFS)=2E
>>=20
>> I was just recommending usage of this flag here because it fits the
>> requirement of allocating some memory to free some memory=2E I am also
>Ok with
>> GFP_ATOMIC with the GFP_NOWARN removed, if you are Ok with that=2E
>
>Maybe we need to refine this documentation to be more explicit about an
>extreme care to be taken when using the flag=2E
>
>diff --git a/include/linux/gfp=2Eh b/include/linux/gfp=2Eh
>index e5b817cb86e7=2E=2Ee436a7e28392 100644
>--- a/include/linux/gfp=2Eh
>+++ b/include/linux/gfp=2Eh
>@@ -110,6 +110,9 @@ struct vm_area_struct;
>* the caller guarantees the allocation will allow more memory to be
>freed
>  * very shortly e=2Eg=2E process exiting or swapping=2E Users either sho=
uld
> * be the MM or co-ordinating closely with the VM (e=2Eg=2E swap over NFS=
)=2E
>+ * Users of this flag have to be extremely careful to not deplete the
>reserve
>+ * completely and implement a throttling mechanism which controls the
>consumption
>+ * based on the amount of freed memory=2E
>  *
>* %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency
>reserves=2E
> * This takes precedence over the %__GFP_MEMALLOC flag if both are set=2E

I am in support of this documentation patch=2E I would say "consumption of=
 the reserve"=2E

Thanks,

- Joel

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
