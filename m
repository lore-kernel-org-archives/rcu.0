Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EE7C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366E020782
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrvH7ImV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHYQsr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:48:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51581 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgHYQsr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 12:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598374125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSmmLdkc7RSVC8EfmtZm/2Ty1INyRIvxtQ55lfyUZGw=;
        b=RrvH7ImVtpnVZnhkNZUJ7sDX73vQlKEUxwdaNKL4Ix/2hJwFJoBeRonG+G5ll+zkxQtXJC
        D2g6+fwJVbdIAcBz50mhEylKY+v8njwNjF4MVgwB9DH+LhxSzLQUC2koLw12bFpJVXYsJM
        j8QL6xPqFXyrTk28qxEoVqzoPaz67yQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-MOD8Bnw8Noe34pPPCrjqDQ-1; Tue, 25 Aug 2020 12:48:41 -0400
X-MC-Unique: MOD8Bnw8Noe34pPPCrjqDQ-1
Received: by mail-lj1-f199.google.com with SMTP id h5so3946203ljj.10
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 09:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSmmLdkc7RSVC8EfmtZm/2Ty1INyRIvxtQ55lfyUZGw=;
        b=idQkxEyFrPH8Dtvg42HfuHDd1CJSt60mQ0hDumhcB/oLBpmioXOthctuuWJi/4Y4M2
         bML9fSNus8H5bTpa2doHTumkgAYdXWJv9bnIGOhR2TTK8ZhhuafdiCt9zjTZMCt4YD4n
         WvwvrLjRPPOBLz5JnpNlwTESF97nwhoPSRdjZ7f7Vw5jL8jWo5G5HDBvdU1g5TRwbb2f
         GRsFFNC2b1Tm25E2D2pqtZUSqbaGkmGVundKKQyelKhaNyzUAg1a6ju+JfL4NAeCV8Fr
         PH20YoQIWU1thklwSQeTG+WRfBXn8c5NxciysO0ukojdEPoy4KtCJkFRQF0+gLKZ4nnN
         gP0w==
X-Gm-Message-State: AOAM532/cnShpzaEyWjI4d49R4Ua2DWwzm+9TBb1sI5CpVF6kymAWrBS
        VL6YOMkdZMk6lxT/3L11J3kXvqe5ETaJeSTJEb1JwbKzInnbmFLu4zYqEQC1GfKVq54pZulSmkX
        apVKw2gzAbeTcCQeKo1m5WiQr04N0
X-Received: by 2002:a2e:8798:: with SMTP id n24mr4759266lji.217.1598374119640;
        Tue, 25 Aug 2020 09:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMsrVlgwrlencGw12QSrptvlcPe/P14ZKF5kt9y0nhGDvkfTqXv7bs70IR+paKpdK/SGRrAV22j+fEJU6X5AE=
X-Received: by 2002:a2e:8798:: with SMTP id n24mr4759256lji.217.1598374119424;
 Tue, 25 Aug 2020 09:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-2-omosnace@redhat.com>
 <CAEjxPJ5vPX1bp6kq_H4pU1bg2=NERt1_irdzMpdJ7R_Jfb3Q4g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5vPX1bp6kq_H4pU1bg2=NERt1_irdzMpdJ7R_Jfb3Q4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Aug 2020 18:48:28 +0200
Message-ID: <CAFqZXNvfpT6th=0bgCvhFFaxX-ss3=A1gPPjaBzXeYHs=ahdLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selinux: simplify away security_policydb_len()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 25, 2020 at 6:03 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Remove the security_policydb_len() calls from sel_open_policy() and
> > instead update the inode size from the size returned from
> > security_read_policy().
> >
> > Since after this change security_policydb_len() is only called from
> > security_load_policy(), remove it entirely and just open-code it there.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 8381614627569..ec4570d6c38f7 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3915,7 +3899,10 @@ int security_read_policy(struct selinux_state *state,
> >         if (!selinux_initialized(state))
> >                 return -EINVAL;
> >
> > -       *len = security_policydb_len(state);
> > +       rcu_read_lock();
> > +       policy = rcu_dereference(state->policy);
> > +       *len = policy->policydb.len;
> > +       rcu_read_unlock();
> >
> >         *data = vmalloc_user(*len);
> >         if (!*data)
>
> We don't actually need to take rcu_read_lock() here at all, and can
> use rcu_dereference_check(..., 1) or rcu_deference_protected() because
> the fsi->mutex is held.  We should also fix the code immediately below
> this diff context to not double dereference the policy pointer and
> just reuse the already dereferenced pointer (also not requiring
> rcu_read_lock).

OK, I'll fix this up to just fetch the pointer as you suggest (and
adapt the corresponding hunks in the other patches).

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

