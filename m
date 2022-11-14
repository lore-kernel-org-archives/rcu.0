Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D0C43217
	for <rcu@archiver.kernel.org>; Mon, 14 Nov 2022 20:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiKNUtc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiKNUta (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Nov 2022 15:49:30 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F114D37
        for <rcu@vger.kernel.org>; Mon, 14 Nov 2022 12:49:28 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id b124so12738363oia.4
        for <rcu@vger.kernel.org>; Mon, 14 Nov 2022 12:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djl0XmORaZL+Gpq8/2lQj5Dmlf4jedemzkPfgf8P7zQ=;
        b=OscSJZXxPu6SpAKJjf2q66p77wEQHJXMboa1NHWz4RGthX+TzzkjTt2Ckf2TDG7mqy
         O3r+9S3Lkgk6CWZd3NEDbnfK9NfkeOGfdmvDsvKK772t9Txw2REBwPEkNVBcOwVJGJie
         X4Qt4ec1ZXTWRNPBrB/HgYFQdR28WYFf85LsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djl0XmORaZL+Gpq8/2lQj5Dmlf4jedemzkPfgf8P7zQ=;
        b=BP/vrmqPjZv4i8/q7jQwF/kROCujGI/yVz+O+4A6MYTLmaZyIKAAlOCd6ifG5ZLxVM
         Tsrssc4pI/a5lDuqzOvHPqx50axiDR+H0y/lphw5uLHqOP6ddx/V1v18rph6aIj8+pFO
         unQ/kB/ze5WnY3xW1lKMbmeunvDTq6eV88ry85MQyoJPA6FDL3zlua5HBztCRo5SUIos
         K44Udc++q3IOE5BbNBKq/BJ21KYshle3vO4nqNNMuGt3nEuv5LsczmYUUNe/d8Hk4nFV
         KEa9QDw7OCR94BTDET6Cq3llVnAzRgKERPrU/rNOKDs353guL1gjztNbi1BdRLzKNiDZ
         yxFA==
X-Gm-Message-State: ANoB5pnv7WTyD7T+vn8KM6Tko/QKcpTX1Mq9Vvjy1mjmK5Rs6AhI9gOQ
        nBKW9Dg8B+M1+0gz7KzZ917KQJTZxS38AnnTuSrSLg==
X-Google-Smtp-Source: AA0mqf6vzg26c6wnapkyVVbCirYl9ufS3U4mko+2qtX4BvjRr8WDgw8FyKZW2tl+LJphXEmAOaBS2qpsPmfD2b1pgMY=
X-Received: by 2002:a54:4090:0:b0:35a:ff1:bf0d with SMTP id
 i16-20020a544090000000b0035a0ff1bf0dmr6466069oii.115.1668458967989; Mon, 14
 Nov 2022 12:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636> <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan> <Y22ry4Q2OY2zovco@google.com> <Y3Iyka86FlUh9D1P@pc636>
In-Reply-To: <Y3Iyka86FlUh9D1P@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 14 Nov 2022 15:49:16 -0500
Message-ID: <CAEXW_YR8ycdF0Y80p2qKXQm3Qc+XA441jQZ3uiHk=TbaXngNkQ@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 14, 2022 at 7:20 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > > Hi,
> > > >
> > > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
> > > >
> > > > > > On ChromeOS, using this with the increased timeout, we see that=
 we
> > > > > almost always
> > > > > > never need to initiate a new grace period. Testing also shows t=
his frees
> > > > > large
> > > > > > amounts of unreclaimed memory, under intense kfree_rcu() pressu=
re.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > > v1->v2: Same logic but use polled grace periods instead of samp=
ling
> > > > > gp_seq.
> > > > > >
> > > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > >
> > > > > >  /**
> > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RC=
U grace
> > > > > period
> > > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling o=
f monitor
> > > > > work.
> > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a gr=
ace period
> > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting=
 for a
> > > > > grace period
> > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting f=
or a
> > > > > grace period
> > > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > >       raw_spinlock_t lock;
> > > > > >       struct delayed_work monitor_work;
> > > > > > +     unsigned long gp_snap;
> > > > > >       bool initialized;
> > > > > >       int count;
> > > > > >
> > > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfre=
e_rcu_cpu
> > > > > *krcp)
> > > > > >                       mod_delayed_work(system_wq, &krcp->monito=
r_work,
> > > > > delay);
> > > > > >               return;
> > > > > >       }
> > > > > > +     krcp->gp_snap =3D get_state_synchronize_rcu();
> > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay)=
;
> > > > > >  }
> > > > > >
> > > > > How do you guarantee a full grace period for objects which procee=
d
> > > > > to be placed into an input stream that is not yet detached?
> > > >
> > > >
> > > > Just replying from phone as I=E2=80=99m OOO today.
> > > >
> > > > Hmm, so you=E2=80=99re saying that objects can be queued after the =
delayed work has
> > > > been queued, but processed when the delayed work is run? I=E2=80=99=
m looking at
> > > > this code after few years so I may have missed something.
> > > >
> > > > That=E2=80=99s a good point and I think I missed that. I think your=
 version did too
> > > > but I=E2=80=99ll have to double check.
> > > >
> > > > The fix then is to sample the clock for the latest object queued, n=
ot for
> > > > when the delayed work is queued.
> > > >
> > > The patch i sent gurantee it. Just in case see v2:
> >
> > You are right and thank you! CBs can be queued while the monitor timer =
is in
> > progress. So we need to sample unconditionally. I think my approach is =
still
> > better since I take advantage of multiple seconds (I update snapshot on=
 every
> > CB queue monitor and sample in the monitor handler).
> >
> > Whereas your patch is snapshotting before queuing the regular work and =
when
> > the work is executed (This is a much shorter duration and I bet you wou=
ld be
> > blocking in cond_synchronize..() more often).
> >
> There is a performance test that measures a taken time and memory
> footprint, so you can do a quick comparison. A "rcutorture" can be
> run with various parameters to figure out if a patch that is in question
> makes any difference.

Yes sure, I am doing a run now with my patch. However, I have a
question -- why do you feel blocking in the kworker is not an issue?
You are taking a snapshot before queuing the normal kwork and then
reading the snapshot when the normal kwork runs. Considering it is a
high priority queue, the delay between when you are taking the
snapshot, and reading it is likely small so there is a bigger chance
of blocking in cond_synchronize_rcu(). Did I miss something?

> Usually i run it as:
>
> <snip>
> #! /usr/bin/env bash
>
> LOOPS=3D10
>
> for (( i=3D0; i<$LOOPS; i++ )); do
>         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --tort=
ure rcuscale --allcpus --duration 1 \
>         --kconfig CONFIG_NR_CPUS=3D64 \
>         --kconfig CONFIG_RCU_NOCB_CPU=3Dy \
>         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy \
>         --kconfig CONFIG_RCU_LAZY=3Dn \
>         --bootargs "rcuscale.kfree_rcu_test=3D1 rcuscale.kfree_nthreads=
=3D16 rcuscale.holdoff=3D20 rcuscale.kfree_loops=3D10000 torture.disable_on=
off_at_boot" --trust-make
>         echo "Done $i"
> done

Sounds good, thanks.

> <snip>
>
> just run it from your linux sandbox.

Ok, will do.

 - Joel
