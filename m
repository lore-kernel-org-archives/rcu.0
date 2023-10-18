Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6CCDB483
	for <rcu@archiver.kernel.org>; Wed, 18 Oct 2023 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbjJROex (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjJROeY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Oct 2023 10:34:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F804681
        for <rcu@vger.kernel.org>; Wed, 18 Oct 2023 07:32:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso71476071fa.2
        for <rcu@vger.kernel.org>; Wed, 18 Oct 2023 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697639555; x=1698244355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrViw8EcPVAfO6aNLjjt2oTpTxgN2CS759uONYxwgI4=;
        b=KILze/neQr3IJu0UagVJuF2dBE/rPc2lx+55r0iNexoLXEG7M4UhYG4TQjR54G6nz/
         Vi2aYHdNS8pVDaXUJ+vWVHNP5Yeo0dQ3x+F19S4CJYX7hJMlxI8hM3V92D9oeDU5qvyz
         HecSl73k+/cdXEnq2ppsmQKAiBsENabDoIXBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639555; x=1698244355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrViw8EcPVAfO6aNLjjt2oTpTxgN2CS759uONYxwgI4=;
        b=d7pZmlEM3h4pwb1GZ5xXkU65RVKi2P8E2buhHQ7/J58Jtxe1FdcbI5TlFsrv4OFR+a
         3e7UV5HEnDEChBcJ3luvqXPIPloqAk2Mt4756gkoE2vxIv/Emsd4UELVRyMbdf0IpFmJ
         HYbfDjxFzYF2+uh3MX4AaSWWOzHwy1ko+MV1AfOdQZEm9JNbr6UYOAax6UdJBoUBnvb2
         M49HJfIclO96ZvRzSnUElP5rgKarxKTvzwBMUqRjb4uHY/CCuAy+nmMsG4bq1xfbSMh/
         eXYLJpuS5IVGP/90Rc2YpzhLlWTehgbBM5tZOyqMdMxEdo7A3qJDcAbAHRrpZWBLcDxi
         Q2Fw==
X-Gm-Message-State: AOJu0Yw0V/4zWVtnzysETRAGcJsp2NKBmrVzPkXVjrRoSV3jx5bGhx7/
        85RfvXGuYB/jdck4Oz02H4sdK1rFT/TgCbOtrGAznQ==
X-Google-Smtp-Source: AGHT+IEhBZkHoObeKA6gBsXSZrhq4Ye8cUfsfIyb4HEkD0Ex39NGlK1sSNdjvlW2RTMMwJOqTCUfhIWLbDTdbYVXTYw=
X-Received: by 2002:a05:651c:504:b0:2c5:cf0:74e9 with SMTP id
 o4-20020a05651c050400b002c50cf074e9mr4295422ljp.14.1697639554674; Wed, 18 Oct
 2023 07:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231016173004.14148-1-urezki@gmail.com> <CAEXW_YRfuXqnBFN=DpOLio74j8fX3eEDSFCH8LXyavuHDdYysA@mail.gmail.com>
 <ZS6U5SgvGcmdE_DA@pc636>
In-Reply-To: <ZS6U5SgvGcmdE_DA@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Oct 2023 10:32:22 -0400
Message-ID: <CAEXW_YT5+ginWcAM-Bxk7tDcGxOgn-6cuTamBJOzr8ta6_jf+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 17, 2023 at 10:06=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com=
> wrote:
[...]
> > > +
> > > +       /* Finally. */
> > > +       complete(&rs->completion);
> > > +}
> > > +
> > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > +{
> > > +       struct llist_node *done, *rcu, *next;
> > > +
> > > +       done =3D llist_del_all(&sr.done);
> > > +       if (!done)
> > > +               return;
> > > +
> > > +       llist_for_each_safe(rcu, next, done)
> > > +               rcu_sr_normal_complete(rcu);
> > > +}
> > [...]
> > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > +{
> > > +       atomic_inc(&sr.active);
> > > +       if (llist_add((struct llist_node *) &rs->head, &sr.curr))
> > > +               /* Set the tail. Only first and one user can do that.=
 */
> > > +               WRITE_ONCE(sr.curr_tail, (struct llist_node *) &rs->h=
ead);
> > > +       atomic_dec(&sr.active);
> >
> > Here there is no memory ordering provided by the atomic ops. Is that re=
ally Ok?
> >
> This needs to be reworked since there is no ordering guaranteed. I think
> there is a version of "atomic_inc_something" that guarantees it?

Yeah there is atomic_fetch_{inc,dec}{_acquire,_release}()

Or:
  atomic_inc(&sr.active);
  smp_mb__after_atomic();

  smp_mb__before_atomic();
  atomic_dec(&sr.active);

?

That's probably better because we don't need ordering before the inc
or after the dec, AFAICS.

I am actually a bit surprised there is no atomic_inc_acquire() yet. :-)

Thanks.
