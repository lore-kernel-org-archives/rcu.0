Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FDC433EF
	for <rcu@archiver.kernel.org>; Mon, 24 Jan 2022 22:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379921AbiAXWH5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351331AbiAXVhL (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 24 Jan 2022 16:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643060228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=Ve3W8+6Mzqn6Lq/rdu0AJT17g1Z5Wu6+RJaFH3Juv5K4sQhNCYiGVHoCmqy40DXUg7tx92
        NWgVHyFzamc7yhlOK+PlKaN9lekER+7neGH40ThKwD1jkGm3RFFIEwZ4aizlAiVySyfC3T
        JOLl0sK1jg8bAQSf9+Z0Bd3HMweHgrY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-P9gNns4MNgaC3tj1OUYNJg-1; Mon, 24 Jan 2022 16:37:06 -0500
X-MC-Unique: P9gNns4MNgaC3tj1OUYNJg-1
Received: by mail-qk1-f198.google.com with SMTP id d11-20020a37680b000000b0047d87e46f4aso3801566qkc.11
        for <rcu@vger.kernel.org>; Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=kz89cdOUvajvlaU8ms0albq39pceDFVFxXVuUJUcho2YgTCOBuu4fCvL+l7HYD7Rje
         DsImvRPNlleQAKphKhkmUegYHddlEU5WytDTQROPNi9iVtZbyysbiynNtAV9g8PM+h05
         5D8l9LIFLarPWbmx7gj161TrOMUtQzAOTXf1rlcI3S9YEREvMdSCOPpQWEBYZ8a60EAa
         S9e/yaTrSoceryLHaL0nA7RDNBtYt40+7mUmKMPXcHaGtUZlyS3OsuTPjUoxziLy7I6N
         +srAcCP4p4Ql4AymQ9agTVGTPXS7QMYB4bIlQH2/otPaWA8wfGd9oqTjra/ll1ent93u
         qryA==
X-Gm-Message-State: AOAM532DYHMU79HXWIoTVgMI3y+yx9LrMv2kG6IEu8iillsLa1rd6K0Z
        EJvH0Oz2X0DLjjcyrDHlLbmd/EqBOygApVm+jcLtydRcQxEAe+MH/5fD+aTdh5la4uYpvpv/Dmb
        hNWEhtAx+TcmXXY+1i2HoCwCsTKz/
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160150qtx.470.1643060226384;
        Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxENcHQBykB+R71peyKNCWZlQR8fLwfIUcwHCuHFtkiFmn2NGP2p8g1zWvx7XU2anZ1AcJ8P5lqh/+uhv6oDxE=
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160117qtx.470.1643060225927;
 Mon, 24 Jan 2022 13:37:05 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com> <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 16:36:55 -0500
Message-ID: <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     paulmck@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > >
> > > > > > I see also:
> > > > > >
> > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > >
> > > > >
> > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > >
> > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > --- a/include/linux/srcutree.h
> > > > > +++ b/include/linux/srcutree.h
> > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > >  #ifdef MODULE
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >         is_static struct srcu_struct name;                              \
> > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > >  #else
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >
> > > >
> > > > I tried it and yes it will fix the issue and introduce another one
> > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > unused ("-Wunused-const-variable").
> > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > not sure if this is the right fix?
> > >
> > > it is obviously unused, but it has something to do with
> > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > suppose, srcu tries to access it to find whatever needs to be
> > > registered?
> >
> > Sorry, but if this is true then it can't be declared as static... and
> > we are at the beginning again.
>
> Welcome to my world!!!  ;-)
>
> More seriously, thank you for chasing this down.  But would it work to
> add a declaration just before?
>

only if I add an "extern" in front of the declaration before, so it looks like:

extern struct srcu_struct * const __srcu_struct_##name;

(compile and sparse tested only)

- Alex

