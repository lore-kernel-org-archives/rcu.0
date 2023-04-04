Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BDC76196
	for <rcu@archiver.kernel.org>; Tue,  4 Apr 2023 01:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjDDBQm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjDDBQk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Apr 2023 21:16:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6163A90
        for <rcu@vger.kernel.org>; Mon,  3 Apr 2023 18:16:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k17so36956715ybm.11
        for <rcu@vger.kernel.org>; Mon, 03 Apr 2023 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680570998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGiaFksFSaheeSde0BsYTvnZXngn5YeoDcWA6oijxt8=;
        b=t8qU/g36MbxLbPDs4ovoSBWkfgEBYQsmo/Ey66cg9lK/ctcGz2JTsub5bp+p1Z8UKD
         t5BguesPm9phjiPnPDGW2MZhO20R6cJf4JOZpk8p1KkRhPnrp5ObFWWzmCoSYZktljwe
         SCY644kOkNA+AAoYKMxlOhmzDfiWhb8Ir8AXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGiaFksFSaheeSde0BsYTvnZXngn5YeoDcWA6oijxt8=;
        b=NkUM/8S7efn+UpLPg2ghFIkWk1kHylOt5/NNPVglTPpywoRNz9trdRPr8CV+yFWwbj
         QRkAxDa1mYKIaclxHJ8cG/BzthwQL8fhUD71uQEdgic/fIO1WWU6c3a98Ir6xcK923+b
         yMkse/2dZunfCWkwltfx2CcY7QZwqB3QrmKZwO2IVTJfNUQDXU20ca47pKYVsacdfTDq
         BtGJ1N86C9ZQxvliMV7D/2wS3x/s1IJHTc4+JT0rcGMgUgwQ5KWQ5WLNmzKJC7Axtyn6
         Ku76f21FXPD+wOX6VaUg22+aLkk26/5bbGXHVT0sMdHpqInKYJT6VobNCDThud5rAplg
         hNrw==
X-Gm-Message-State: AAQBX9fX4qJmmFHUm3gHJ/WMYIAm6BaxZcWDRNfmxuWcSVOrSX1YWz+5
        syTbHLZhEHhokmDA9OkNABWQ+2rY21fNngLavsy4dw==
X-Google-Smtp-Source: AKy350bn07AV9D6vzgoHHOHGQCkZq7RhOd3FLHXIkNjToKXXsAd+R2CJjiGmdTMfIBeybUuPxhCBFlT7qckjdFRxhpU=
X-Received: by 2002:a25:d842:0:b0:b6a:2590:6c7f with SMTP id
 p63-20020a25d842000000b00b6a25906c7fmr663134ybg.2.1680570998340; Mon, 03 Apr
 2023 18:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-4-paulmck@kernel.org> <20230404003508.GA254019@google.com>
 <bad21a93-6d1d-4069-b84b-d3dc1a6cf456@paulmck-laptop>
In-Reply-To: <bad21a93-6d1d-4069-b84b-d3dc1a6cf456@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 3 Apr 2023 21:16:27 -0400
Message-ID: <CAEXW_YS-b-NyAQAR1kRy__QNo8sjHc0oYavLGqGbjitQvU7OCg@mail.gmail.com>
Subject: Re: [PATCH rcu 04/20] srcu: Begin offloading srcu_struct fields to srcu_update
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 3, 2023 at 9:06=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
[..]
> > In other words, if init_srcu_struct_nodes() returns false, then passing=
 along
> > the return value of init_srcu_struct_nodes() back to the caller of
> > init_srcu_struct_fields() depends on whether is_static =3D true or fals=
e. That
> > seems a bit wrong to me, init_srcu_struct_fields() should always return
> > -ENOMEM  when init_srcu_struct_nodes() fails to allocate memory IMHO, w=
hether
> > is_static is true or not.
> >
> > Sorry if I missed something subtle, and if the code is correct to begin=
 with.
> > Also I feel the return paths could be made better to also fix the above=
 issue
> > I mentioned. How about the following diff on top of the series, would i=
t
> > work?
>
> Your restructuring looks like an excellent step forward, but given the la=
te
> date, it might be best to avoid being in a rush.
>
> I -could- make the following small patch:
>
>         if (READ_ONCE(ssp->srcu_sup->srcu_size_state) =3D=3D SRCU_SIZE_SM=
ALL && SRCU_SIZING_IS_INIT()) {
>                 if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
>                         if (!ssp->srcu_sup->sda_is_static) {
>                                 free_percpu(ssp->sda);
>                                 ssp->sda =3D NULL;
>                                 kfree(ssp->srcu_sup);
>                         }
>                         return -ENOMEM;
>                 } else {
>                         WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_S=
IZE_BIG);
>                 }
>         }
>
> Except that this is a pre-existing bug that as far as we know no one
> is hitting, so the risk doesn't seem to stack up.  After all, if you
> are hitting memory exhaustion at boot or on module load, this bug is
> probably the least of your problems.  Even this fix looks to be v6.5
> material to me.
>
> So would you be willing to send a patch like the above that fixes the
> bug, and another like you have below to get a better error-path
> structure?  No hurry, the end of this month is perfectly fine.

Yes, I am happy to send patches along these lines by the end of the
month. I will make a note to do so.

> And again, good catch!

Thanks!

- Joel
